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
                ];
            };
        };

        nix-ld = {
            enable = true;
        };

        firefox = {
            enable = true;
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
        };

        gamemode = {
            enable = true;
        };

        dconf = {
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
        kernelPackages = pkgs.linuxPackages_latest;
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
                    obs-studio
                    zapzap
                    alacritty
                    fastfetch
                    libreoffice
                    vscodium
                    zed-editor
                    kdePackages.kate
                    protonup-qt
                    protontricks
                    logseq
                    nerd-fonts.jetbrains-mono
                    inter
                    papirus-nord
                    bibata-cursors
                    spotdl
                    p7zip
                ];
            };
        };
    };

    fonts = {
        packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
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
