resource "random_id" "keyring" {
  byte_length = 4
}

resource "google_service_account" "vault" {
  account_id   = "vaultsa"
  display_name = "Vault Service Account"
}

resource "google_kms_key_ring" "vault" {
  name     = "vault-keyring4-${random_id.keyring.id}"
  location = "us-west1"
}

resource "google_kms_crypto_key" "vault" {
  name            = "vault-key"
  key_ring        = google_kms_key_ring.vault.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "2592000s" # optional: 30 days
}

resource "google_kms_crypto_key_iam_member" "vault_sa" {
  crypto_key_id = google_kms_crypto_key.vault.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:vaultsa@dotted-cedar-456503-e8.iam.gserviceaccount.com"
  depends_on    = [google_service_account.vault]
}

# Corrected IAM Binding for Key Ring Viewer Permissions
resource "google_kms_key_ring_iam_member" "vault_sa_viewer" {
  key_ring_id = google_kms_key_ring.vault.id # Correct argument
  role        = "roles/cloudkms.viewer"
  member      = "serviceAccount:vaultsa@dotted-cedar-456503-e8.iam.gserviceaccount.com"
  depends_on  = [google_kms_crypto_key.vault, google_kms_crypto_key_iam_member.vault_sa]
}

