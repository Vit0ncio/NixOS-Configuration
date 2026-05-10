# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
	config,
	pkgs,
	...
}:

{
	imports = [ # Include the results of the hardware scan.
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
        };
        zsh = {
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
    };

  	hardware = {
        nvidia = {
            modesetting = {
                enable = true;
            };
            open = false;
            nvidiaSettings = true;
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

  	# Define a user account. Don't forget to set a password with ‘passwd’.
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
                    libreoffice
                    vscodium
                    zed-editor
                    protonup-qt
                    protontricks
                    obs-studio
                    logseq
                    kdePackages.kate
                ];
            };
        };
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

  	# List packages installed in system profile. To search, run:
  	# $ nix search wget
    environment = {
        systemPackages = with pkgs; [
            wget
            neovim
            git
            zip
            unzip
            wine
            fuse
            glib
            nixd
            nil
        ];
    };

  	system = {
       stateVersion = "25.11";
    };
}
