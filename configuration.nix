{
	config,
	pkgs,
	...
}:

{
	imports = [
	    ./hardware-configuration.nix
    ];

    programs = {
        appimage = {
            enable = true;
            binfmt = true;
            package = pkgs.appimage-run.override {
                extraPkgs = pkgs: [
                    pkgs.icu
                    pkgs.libxcrypt-legacy
                    pkgs.python312
                    pkgs.python312Packages.torch
                ];
            };
        };

        nix-ld = {
            enable = true;

            libraries = with pkgs; [
                # List by default
                zlib
                zstd
                stdenv.cc.cc
                curl
                openssl
                attr
                libssh
                bzip2
                libxml2
                acl
                libsodium
                util-linux
                xz
                systemd
                xorg.libXcomposite
                xorg.libXtst
                xorg.libXrandr
                xorg.libXext
                xorg.libX11
                xorg.libXfixes
                libGL
                libva
                pipewire
                xorg.libxcb
                xorg.libXdamage
                xorg.libxshmfence
                xorg.libXxf86vm
                libelf
                glib
                gtk2
                networkmanager
                vulkan-loader
                libgbm
                libdrm
                libxcrypt
                coreutils
                pciutils
                zenity
                xorg.libXinerama
                xorg.libXcursor
                xorg.libXrender
                xorg.libXScrnSaver
                xorg.libXi
                xorg.libSM
                xorg.libICE
                gnome2.GConf
                nspr
                nss
                cups
                libcap
                SDL2
                libusb1
                dbus-glib
                ffmpeg
                libudev0-shim
                gtk3
                icu
                libnotify
                gsettings-desktop-schemas
                xorg.libXt
                xorg.libXmu
                libogg
                libvorbis
                SDL
                SDL2_image
                glew110
                libidn
                tbb
                flac
                freeglut
                libjpeg
                libpng
                libpng12
                libsamplerate
                libmikmod
                libtheora
                libtiff
                pixman
                speex
                SDL_image
                SDL_ttf
                SDL_mixer
                SDL2_ttf
                SDL2_mixer
                libappindicator-gtk2
                libdbusmenu-gtk2
                libindicator-gtk2
                libcaca
                libcanberra
                libgcrypt
                libvpx
                librsvg
                xorg.libXft
                libvdpau
                pango
                cairo
                atk
                gdk-pixbuf
                fontconfig
                freetype
                dbus
                alsa-lib
                expat
                libxkbcommon
                libxcrypt-legacy
                libGLU
                fuse
                e2fsprogs
            ];
        };

        firefox = {
            enable = true;

            languagePacks = [
                "pt-BR"
            ];

            preferences = {
                "browser.startup.homepage" = "https://www.google.com";
                "privacy.resistFingerprinting" = true;
            };

            policies = {
                DisableTelemetry = true;
                ExtensionSettings = let
                    moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
                in {
                    "*" = {
                        installation_mode = "blocked";
                    };

                    "uBlock0@raymondhill.net" = {
                        install_url = moz "ublock-origin";
                        installation_mode = "force_installed";
                    };
                };
            };
        };

        steam = {
            enable = true;
            remotePlay = {
                openFirewall = true;
            };

            dedicatedServer = {
                openFirewall = true;
            };
        };

        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions = {
                enable = true;
            };

            syntaxHighlighting = {
                enable = true;
            };

            shellAliases = {
                update = "sudo ~/.local/bin/update-system";
                rebuild = "sudo nixos-rebuild switch";
            };

            histSize = 10000;
            histFile = "$HOME/.zsh_history";
            setOptions = [
                "HIST_IGNORE_ALL_DUPS"
            ];

            ohMyZsh = {
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
                    success_symbol = "[](bold green) ";
                    error_symbol = "[✗](bold red) ";
                };
            };
        };

        hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };

        gamemode = {
            enable = true;
        };

        dconf = {
            enable = true;
        };

        obs-studio = {
            enable = true;

            # optional Nvidia hardware acceleration
            package = (
                pkgs.obs-studio.override {
                    cudaSupport = true;
                }
            );

            plugins = with pkgs.obs-studio-plugins; [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
                obs-gstreamer
                obs-vkcapture
            ];
        };

        neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
        };
    };

    services = {
        flatpak = {
            enable = true;
        };

        xserver = {
            videoDrivers = [
                "nvidia"
            ];

            enable = true;
            xkb = {
                layout = "br";
                variant = "";
            };
        };

        displayManager = {
            sddm = {
                enable = true;
            };
        };

        desktopManager = {
            plasma6 = {
                enable = true;
            };
        };

        printing = {
            enable = true;
        };

        pipewire = {
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };

            pulse = {
                enable = true;
            };

            jack = {
                enable = true;
            };
        };

        pulseaudio = {
            enable = false;
        };

        fstrim = {
            enable = true;
            interval = "weekly";
        };

        fwupd = {
            enable = true;
        };
    };

  	hardware = {
        nvidia = {
            modesetting = {
                enable = true;
            };
            open = false;
            nvidiaSettings = true;
            powerManagement = {
                enable = true;
            };
        };
  	};

    nix = {
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            auto-optimise-store = true;
        };

        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 5d";
        };
    };

    boot = {
        loader = {
            grub = {
                enable = true;
                device = "/dev/sda";
                useOSProber = true;
            };
        };
        kernelPackages = pkgs.linuxPackages;
    };

    networking = {
        hostName = "nixos";
        wireless = {
            enable = false;
        };

        networkmanager = {
            enable = true;
        };
    };

    time = {
        timeZone = "America/Recife";
    };

    i18n = {
        defaultLocale = "pt_BR.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "pt_BR.UTF-8";
            LC_IDENTIFICATION = "pt_BR.UTF-8";
            LC_MEASUREMENT = "pt_BR.UTF-8";
            LC_MONETARY = "pt_BR.UTF-8";
            LC_NAME = "pt_BR.UTF-8";
            LC_NUMERIC = "pt_BR.UTF-8";
            LC_PAPER = "pt_BR.UTF-8";
            LC_TELEPHONE = "pt_BR.UTF-8";
            LC_TIME = "pt_BR.UTF-8";
        };
    };
    console = {
        keyMap = "br-abnt2";
    };

    security = {
        rtkit = {
            enable = true;
        };
    };

    users = {
        users = {
            vitor = {
                shell = pkgs.zsh;
                isNormalUser = true;
                description = "vitor";
                extraGroups = [
                    "networkmanager"
                    "wheel"
                ];

                packages = with pkgs; [
                    vlc
                    zapzap
                    alacritty
                    fastfetch
                    libreoffice-qt
                    kdePackages.kate
                    protonup-qt
                    protontricks
                    logseq
                    papirus-nord
                    bibata-cursors
                    spotdl
                    p7zip
                    freetube
                    zed-editor
                ];
            };
        };
    };

    fonts = {
        packages = with pkgs; [
            inter
            nerd-fonts.jetbrains-mono
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            liberation_ttf
        ];
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

    environment = {
        systemPackages = with pkgs; [
            (python3.withPackages (ps: with ps; [
                requests
                selenium
            ]))
            geckodriver
            wget
            zip
            unzip
            wine
            fuse
            glib
            nixd
            nil
            git
            btop
            pciutils
            usbutils
            killall
            hunspell
            hunspellDicts.pt_BR
        ];

        sessionVariables = {
            NIXOS_OZONE_WL = "1";
            WLR_NO_HARDWARE_CURSORS = "1";
            __GL_GSYNC_ALLOWED = "0";
            __GL_VRR_ALLOWED = "0";
        };
    };

  	system = {
       stateVersion = "25.11";
    };
}
