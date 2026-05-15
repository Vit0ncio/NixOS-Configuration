{
	config,
	pkgs,
	unstable,
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
                ];
            };
        };

        obs-studio = {
            enable = true;

            package = (
                unstable.obs-studio.override {
                    cudaSupport = true;
                }
            );

            plugins = with unstable.obs-studio-plugins; [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
                obs-gstreamer
                obs-vkcapture
            ];
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

                      # My own additions
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

                      # Required
                      glib
                      gtk2

                      # Inspired by steam
                      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
                      networkmanager
                      vulkan-loader
                      libgbm
                      libdrm
                      libxcrypt
                      coreutils
                      pciutils
                      zenity
                      # glibc_multi.bin # Seems to cause issue in ARM

                      # # Without these it silently fails
                      xorg.libXinerama
                      xorg.libXcursor
                      xorg.libXrender
                      xorg.libXScrnSaver
                      xorg.libXi
                      xorg.libSM
                      xorg.libICE
                      nspr
                      nss
                      cups
                      libcap
                      SDL2
                      libusb1
                      dbus-glib
                      ffmpeg
                      # Only libraries are needed from those two
                      libudev0-shim

                      # needed to run unity
                      gtk3
                      icu
                      libnotify
                      gsettings-desktop-schemas
                      # https://github.com/NixOS/nixpkgs/issues/72282
                      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
                      # log in /home/leo/.config/unity3d/Editor.log
                      # it will segfault when opening files if you don’t do:
                      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
                      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed

                      # Verified games requirements
                      xorg.libXt
                      xorg.libXmu
                      libogg
                      libvorbis
                      SDL
                      SDL2_image
                      glew110
                      libidn
                      tbb

                      # Other things from runtime
                      flac
                      freeglut
                      libjpeg
                      libpng
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
                      # ...
                      # Some more libraries that I needed to run programs
                      pango
                      cairo
                      atk
                      gdk-pixbuf
                      fontconfig
                      freetype
                      dbus
                      alsa-lib
                      expat
                      # for blender
                      libxkbcommon

                      libxcrypt-legacy # For natron
                      libGLU # For natron

                      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
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
              "browser.startup.homepage" = "https://www.google.com/";
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
                        install_url       = moz "ublock-origin";
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

            gamescopeSession = {
                enable = true;
            };
        };

        zsh = {
            enable = true;
        };

        starship = {
            enable = true;
        };

        hyprland = {
            enable = true;
            withUWSM = true;
            xwayland = {
                enable = true;
            };

            package = unstable.hyprland;
            portalPackage = unstable.xdg-desktop-portal-hyprland;
        };

        gamemode = {
            enable = true;
        };

        dconf = {
            enable = true;
        };
        
        gamescope = {
            enable = true;
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
                enable = false;
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
                    vscodium
                    zed-editor
                    kdePackages.kate
                    protonup-qt
                    protontricks
                    logseq
                    papirus-nord
                    bibata-cursors
                    spotdl
                    p7zip
                    freetube
                    obsidian
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
            neovim
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
            hyphenDicts.pt_BR
        ];

        sessionVariables = {
            NIXOS_OZONE_WL = "1";
            __GL_GSYNC_ALLOWED = "0";
            __GL_VRR_ALLOWED = "0";
        };
    };

  	system = {
       stateVersion = "25.11";
    };
}

