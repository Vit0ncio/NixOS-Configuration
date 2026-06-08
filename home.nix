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
            waybar
            wofi

            unstable.zed-editor
            unstable.protonup-qt
            unstable.protontricks
            # unstable.logseq
            unstable.spotdl
            unstable.freetube
        ];

        pointerCursor = {
            gtk.enable = true;
            name = "Bibata-Modern-Classic";
            size = 24;
            package = pkgs.bibata-cursors;
        };
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

        waybar = {
            enable = true;

            settings = {
                mainBar = {
                    layer = "top";
                    position = "top";
                    height = 36;

                    output = [
                        "HDMI-A-1"
                    ];

                    modules-left = [
                        "clock"
                    ];

                    modules-right = [
                        "temperature"
                        "pulseaudio"
                        "network"
                        "cpu"
                        "memory"
                    ];

                    "clock" = {
                        interval = 10;
                        format = " {:%H:%M}";
                        tooltip-format = "<tt><small>{calendar}</small></tt>";

                        calendar = {
                            mode = "year";
                            mode-mon-col = 3;
                            weeks-pos = "right";
                            on-scroll = 1;

                            format = {
                                months = "<span color='#ffead3'><b>{}</b></span>";
                                days = "<span color='#ecc6d9'><b>{}</b></span>";
                                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
                            };
                        };
                    };

                    "temperature" = {
                        interval = 5;
                        format = " {temperatureC}°C";
                    };


                    "pulseaudio" = {
                        format = " {volume}%";
                        on-click = "pavucontrol";
                    };

                    "network" = {
                        interval = 5;
                        interface = "enp3s0";
                        format = "󰣶 CONECTADO";
                        format-disconnected = "󰣷 DESCONECTADO";
                    };

                    "cpu" = {
                        interval = 5;
                        format = " {usage}%";
                    };

                    "memory" = {
                        interval = 5;
                        format = " {used:0.1f}G/{total:0.1f}G";
                    };
                };
            };

            style = ''
                * {
                    border: none;
                    border-radius: 0;
                    font-family: JetBrainsMono Nerd Font;
                    padding-left: 10px;
                    padding-right: 10px;
                }

                window#waybar {
                    background: #000000;
                    color: #FFFFFF;
                }
            '';
        };

        wofi = {
            enable = true;

            settings = {
                location = "center";
                allow_markup = true;
                width = 500;
            };

            style = ''
                * {
                    font-family: Inter;
                }

                window {
                    background-color: #000000;
                    color: #FFFFFF;
                }
            '';
        };
    };
}
