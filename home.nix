{
    pkgs,
    unstable,
    ...
}:

{
    home = {
        username = "vitor";
        homeDirectory = "/home/vitor";
        stateVersion = "26.05";

        packages = with pkgs; [
            vlc
            zapzap
            alacritty
            fastfetch
            libreoffice
            vscodium
            papirus-nord
            bibata-cursors
            p7zip
            obsidian
            discord
            kdePackages.kdenlive
            ares
            clonehero

            unstable.zed-editor
            unstable.protonup-qt
            unstable.protontricks
            unstable.logseq
            unstable.spotdl
            unstable.freetube
        ];
    };

    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;

            history = {
                size = 1000;
                path = "$HOME/.zsh_history";
                ignoreDups = true;
            };

            shellAliases = {
                update = "sudo /etc/nixos/update-system";
                rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
                ls = "eza --all --group-directories-first --icons=always";
            };

            oh-my-zsh = {
                enable = true;

                plugins = [
                    "git"
                ];

                theme = "robbyrussell";
            };
        };

        starship = {
            enable = true;

            settings = {
                add_newline = true;
                command_timeout = 1300;
                scan_timeout = 50;
                format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";

                character = {
                    success_symbol = "[](bold green) ";
                    error_symbol = "[✗](bold red) ";
                };
            };
        };

        neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
        };

        git = {
            enable = true;

            settings = {
                user = {
                    name = "Vitor Luis";
                    email = "vitorlgv@proton.me";
                };
            };
        };

        firefox = {
            enable = true;
            languagePacks = [ "pt-BR" ];

            policies = {
                browser.startup.homepage = "https://www.google.com/";
                privacy.resistFingerprinting = true;
                DisableTelemetry = true;
                ExtensionSettings = let
                    moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";

                in {
                    "*" = {
                        private_browsing = true;
                    };

                    "uBlock0@raymondhill.net" = {
                        install_url = moz "ublock-origin";
                        installation_mode = "force_installed";
                    };

                    "addon@darkreader.org" = {
                        install_url = moz "darkreader";
                        installation_mode = "force_installed";
                    };
                };
            };
        };

        alacritty = {
            enable = true;
            theme = "catppuccin_mocha";

            settings = {
                window = {
                    padding = {
                        x = 5;
                        y = 5;
                    };

                    dynamic_title = false;
                };

                font = {
                    normal = {
                        family = "JetBrainsMono Nerd Font";
                        style = "Regular";
                    };
                };
            };
        };
    };
}
