#! /bin/bash

set -ex

# Install dependencies
apt-get update
apt-get install -y unzip curl gnupg apt-transport-https jq

# Install Vault
VAULT_VERSION="1.15.4"
cd /tmp
curl -sLo vault.zip "https://releases.hashicorp.com/vault/$${VAULT_VERSION}/vault_$${VAULT_VERSION}_linux_amd64.zip"
unzip vault.zip
mv vault /usr/local/bin/
chmod +x /usr/local/bin/vault

# Create Vault user and directories
useradd --system --home /etc/vault.d --shell /bin/false vault
mkdir -p /etc/vault.d /opt/vault/data
chown -R vault:vault /etc/vault.d /opt/vault

# Vault config for GCP KMS auto-unseal
cat <<EOF > /etc/vault.d/vault.hcl
ui = true

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "vault-1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

seal "gcpckms" {
  project     = "dotted-cedar-456503-e8"
  region      = "us-west1"
  key_ring    = "${key_ring_name}"
  crypto_key  = "${crypto_key_name}"
}

api_addr="http://$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip -H "Metadata-Flavor: Google"):8200"
cluster_addr="http://127.0.0.1:8201"
EOF

chown -R vault:vault /etc/vault.d

# Create systemd service
cat <<EOF > /etc/systemd/system/vault.service
[Unit]
Description=Vault service
Requires=network-online.target
After=network-online.target

[Service]
User=vault
Group=vault
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure
LimitNOFILE=65536
CapabilityBoundingSet=CAP_IPC_LOCK
AmbientCapabilities=CAP_IPC_LOCK

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Vault
systemctl daemon-reexec
systemctl enable vault
systemctl start vault

# Wait until Vault HTTP endpoint responds
echo "Waiting for Vault to start accepting connections..."
for i in {1..20}; do
  if curl -s http://127.0.0.1:8200/v1/sys/health >/dev/null 2>&1; then
    echo "Vault is up and responding"
    break
  else
    echo "Vault not ready yet (attempt $i), retrying..."
    sleep 2
  fi

  if [ "$i" -eq 20 ]; then
    echo "Vault did not become ready in time. Exiting."
    exit 1
  fi
done

export VAULT_ADDR="http://127.0.0.1:8200"
echo "Checking vault status"
if ! vault status | grep -q 'Initialized.*true'; then
  INIT_OUTPUT=$(vault operator init -format=json)
  echo "$${INIT_OUTPUT}" > /root/vault-init.json
  echo "Vault initialized. Unseal keys and root token saved to /root/vault-init.json"
else
  echo "Vault already initialized"
fi

