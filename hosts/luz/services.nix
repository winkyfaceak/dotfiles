_: {
  modules.services = {
    nextcloud.enable = true;
    vscode-server.enable = false;
    miniflux.enable = false;
    matrix.enable = true;
    forgejo.enable = true;
    vaultwarden.enable = true;
    isabelroses-web.enable = false;
    wakapi.enable = true;
    nginx.enable = true;
    cloudflared.enable = false;
    headscale.enable = true;
    overleaf.enable = true;

    mailserver = {
      enable = true;
      rspamd-web.enable = false;
    };

    monitoring = {
      grafana.enable = true;
      prometheus.enable = true;
      loki.enable = true;
      uptime-kuma.enable = true;
    };

    database = {
      mysql.enable = false;
      mongodb.enable = true;
      postgresql.enable = true;
      redis.enable = true;
    };
  };
}
