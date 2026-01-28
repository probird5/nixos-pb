# Firefox configuration with privacy hardening
{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.firefox = {
    enable = true;

    # Enterprise policies
    policies = {
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisableProfileImport = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      DisableSetDesktopBackground = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";

      # Install extensions via policy
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        # Multi-Account Containers
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        # 1Password
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      isDefault = true;

      # Search engines
      search = {
        force = true;
        default = "ddg";
        engines = {
          "bing".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ebay".metaData.hidden = true;
        };
      };

      # Privacy and security settings (from tonarchy user.js)
      settings = {
        # Startup
        "browser.startup.page" = 0;
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";

        # Geolocation
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;

        # Disable addon recommendations and discovery
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shopping.experience2023.enabled" = false;

        # Disable telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;

        # Disable studies and experiments
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # Disable crash reporting
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        # Disable captive portal and connectivity checks
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        # Disable safe browsing remote lookups
        "browser.safebrowsing.downloads.remote.enabled" = false;

        # Disable prefetching and prediction
        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;
        "network.http.speculative-parallel-limit" = 0;
        "browser.places.speculativeConnect.enabled" = false;

        # DNS and proxy
        "network.proxy.socks_remote_dns" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";

        # URL bar
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.fakespot.featureGate" = false;
        "browser.urlbar.mdn.featureGate" = false;
        "browser.urlbar.pocket.featureGate" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.urlbar.showSearchTerms.enabled" = false;

        # Disable form autofill
        "browser.formfill.enable" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;

        # Separate private search
        "browser.search.separatePrivateDefault" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;

        # Cache and sessions
        "browser.cache.disk.enable" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "media.memory_cache_max_size" = 65536;
        "browser.sessionstore.privacy_level" = 2;
        "toolkit.winRegisterApplicationRestart" = false;
        "browser.shell.shortcutFavicons" = false;

        # SSL/TLS security
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.OCSP.enabled" = 1;
        "security.OCSP.require" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.version.enable-deprecated" = false;

        # HTTPS-only mode
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;

        # Referer
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.referer.spoofSource" = false;

        # Multi-Account Containers (enabled for the extension)
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        # WebRTC
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.peerconnection.ice.default_address_only" = true;

        # Misc privacy
        "dom.disable_window_move_resize" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "devtools.debugger.remote-enabled" = false;
        "permissions.manager.defaultsUrl" = "";
        "network.IDN_show_punycode" = true;

        # PDF
        "pdfjs.disabled" = false;
        "pdfjs.enableScripting" = false;

        # Downloads
        "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.always_ask_before_handling_new_types" = true;

        # Extensions
        "extensions.enabledScopes" = 5;
        "extensions.postDownloadThirdPartyPrompt" = false;
        "extensions.blocklist.enabled" = true;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat-reporter.enabled" = false;
        "extensions.quarantinedDomains.enabled" = true;

        # Content blocking
        "browser.contentblocking.category" = "strict";
        "browser.tabs.searchclipboardfor.middleclick" = false;
        "browser.contentanalysis.enabled" = false;
        "browser.contentanalysis.default_result" = 0;
        "browser.contentanalysis.default_allow" = false;

        # Privacy sanitize
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown_v2.cache" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
        "privacy.clearSiteData.cache" = true;
        "privacy.clearSiteData.cookiesAndStorage" = false;
        "privacy.clearSiteData.historyFormDataAndDownloads" = true;
        "privacy.cpd.cache" = true;
        "privacy.clearHistory.cache" = true;
        "privacy.cpd.formdata" = true;
        "privacy.cpd.history" = true;
        "privacy.clearHistory.historyFormDataAndDownloads" = true;
        "privacy.cpd.cookies" = false;
        "privacy.cpd.sessions" = true;
        "privacy.cpd.offlineApps" = false;
        "privacy.clearHistory.cookiesAndStorage" = false;
        "privacy.sanitize.timeSpan" = 0;

        # Fingerprinting resistance
        "privacy.window.maxInnerWidth" = 1600;
        "privacy.window.maxInnerHeight" = 900;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "privacy.spoof_english" = 1;
        "browser.display.use_system_colors" = false;
        "widget.non-native-theme.use-theme-accent" = false;
        "widget.non-native-theme.enabled" = true;
        "privacy.firstparty.isolate" = false;

        # Windows/popups
        "browser.link.open_newwindow" = 3;
        "browser.link.open_newwindow.restriction" = 0;

        # Misc
        "browser.aboutConfig.showWarning" = false;
        "security.dialog_enable_delay" = 1000;
        "security.family_safety.mode" = 0;
        "network.dns.skipTRR-when-parental-control-enabled" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

        # Dark theme
        "layout.css.prefers-color-scheme.content-override" = 0;
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;

        # Hardware acceleration (fixes flickering on Wayland)
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.canvas.accelerated" = true;

        # Vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
      };
    };
  };
}
