locals {
  startup_script = join("\n", compact([
    var.tailscale_auth_key != "" ? templatefile("${path.module}/tailscale.sh.tpl", {
      tailscale_auth_key = var.tailscale_auth_key
    }) : "",
    lookup(var.extra_metadata, "startup-script", "")
  ]))
}
