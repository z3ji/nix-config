# This Nix expression enables Firefox and configures user profiles and default applications.
{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    librewolf
  ];

  # Enable Firefox and configure user profile
  programs.firefox = {
    enable = true;
    # User profile settings
    profiles.${config.home.username} = {
      bookmarks = {};
      # Extensions (uncomment and customise as needed)
      #extensions = with pkgs.inputs.firefox-addons; [
      #  ublock-origin
      #];
      settings = {
        # Firefox settings
        "dom.security.https_only_mode" = true;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "extensions.pocket.enabled" = false;
      };

      userChrome = ''
        /* Clean and tight extensions menu */
        #unified-extensions-panel #unified-extensions-view {
          width: 100% !important; /* For Firefox v115.x */
        }

        #unified-extensions-view {
          --uei-icon-size: 22px; /* Change icon size */
          --firefoxcss-number-of-extensions-in-a-row: 3; /* Increase to the number of icons you want in one row */
        }

        /* Hide unnecessary elements */
        #unified-extensions-view .panel-header,
        #unified-extensions-view .panel-header + toolbarseparator,
        #unified-extensions-view .panel-subview-body + toolbarseparator,
        #unified-extensions-view #unified-extensions-manage-extensions,
        #unified-extensions-view .unified-extensions-item-menu-button.subviewbutton,
        #unified-extensions-view .unified-extensions-item-action-button .unified-extensions-item-contents {
          display: none !important;
        }

        #unified-extensions-view .panel-subview-body {
          padding: 4px !important;
        }

        #unified-extensions-view .unified-extensions-item .unified-extensions-item-icon,
        #unified-extensions-view .unified-extensions-item .toolbarbutton-badge-stack {
          margin-inline-end: 0px !important;
        }

        /* Style extensions grid */
        #unified-extensions-view #overflowed-extensions-list,
        #unified-extensions-view #unified-extensions-area,
        #unified-extensions-view .unified-extensions-list {
          display: grid !important;
          grid-template-columns: repeat(var(--firefoxcss-number-of-extensions-in-a-row), auto);
          justify-items: left !important;
          align-items: left !important;
        }

        #unified-extensions-view .unified-extensions-list .unified-extensions-item,
        #unified-extensions-view .unified-extensions-list {
          max-width: max-content;
        }

        #unified-extensions-view #unified-extensions-area {
          padding-bottom: 3px !important;
          border-bottom: 1px solid #aeaeae33 !important;
        }

        /* Remove border top from extensions list */
        #unified-extensions-view .unified-extensions-list {
          /* border-top: 1px solid #aeaeae33 !important; */
        }

        /* Adjust margin for certain elements */
        #wrapper-edit-controls:is([place="palette"], [place="panel"]) > #edit-controls,
        #wrapper-zoom-controls:is([place="palette"], [place="panel"]) > #zoom-controls,
        :is(panelview, #widget-overflow-fixed-list) .toolbaritem-combined-buttons {
          margin: 0px !important;
        }
      '';
    };
  };

  home = {
    persistence = {
      # Not persisting is safer
      #"/persist/home/${config.home.username}".directories = [ ".mozilla/firefox" ];
    };
  };

  # Set Firefox as default application for various MIME types and URL schemes
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
