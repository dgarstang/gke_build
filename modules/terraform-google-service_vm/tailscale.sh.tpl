# Install tailscale.
apt-get install apt-transport-https
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/xenial.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/xenial.list | sudo tee /etc/apt/sources.list.d/tailscale.list
apt-get update
apt-get install -y tailscale
sudo tailscale up --authkey ${tailscale_auth_key}
