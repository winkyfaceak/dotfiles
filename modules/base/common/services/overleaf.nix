{
  config,
  lib,
  ...
}: let
  inherit (config.networking) domain;
in {
  config = lib.mkIf config.modules.services.overleaf.enable {
    modules.services.database = {
      mongodb.enable = true;
      redis.enable = true;
    };

    users.users.overleaf = {
      home = "/srv/storage/overleaf";
    };

    services.overleaf = {
      enable = true;

      hostname = "ltx.${domain}";

      settings = {
        WEB_HOST = "localhost";
        WEB_PORT = "3032";

        DATA_DIR = "/srv/storage/overleaf";

        OVERLEAF_APP_NAME = "iztex";
        OVERLEAF_NAV_TITLE = "iztex";
        OVERLEAF_ADMIN_EMAIL = "isabel@${domain}";
        OVERLEAF_STATUS_PAGE_URL = "status.${domain}";

        OVERLEAF_ALLOW_PUBLIC_ACCESS = "true";

        # SHARELATEX_MONGO_URL = "mongodb://127.0.0.1/overleaf";

        # redis
        OVERLEAF_REDIS_HOST = "localhost";
        OVERLEAF_REDIS_PORT = "6371";

        EMAIL_CONFIRMATION_DISABLED = "true";
        ENABLE_CRON_RESOURCE_DELETION = "false";
        ADMIN_PRIVILEGE_AVAILABLE = "true";
      };
    };
  };
}
