{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    program.utils.enable = lib.mkEnableOption "Enable utility programs";
  };

  config = lib.mkIf config.program.utils.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      nh
      unzip
      tokei
      pamixer
      pavucontrol
      upower
      ngrok
      wf-recorder

      (writers.writeRustBin "colors" {} (builtins.readFile ../customScripts/colors.rs))
      (writers.writeRustBin "timestamp" {} (builtins.readFile ../customScripts/timestamp.rs))
    ];
    # Enable the uinput module
    boot.kernelModules = ["uinput"];

    # Enable uinput
    hardware.uinput.enable = true;

    # Set up udev rules for uinput
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    # Ensure the uinput group exists
    users.groups.uinput = {};

    # Add the Kanata service user to necessary groups
    systemd.services.kanata-internalKeyboard.serviceConfig = {
      SupplementaryGroups = [
        "input"
        "uinput"
      ];
    };

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            # Replace the paths below with the appropriate device paths for your setup.
            # Use `ls /dev/input/by-path/` to find your keyboard devices.
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
            "/dev/input/by-path/pci-0000:00:14.0-usb-0:1:1.2-event-kbd"
            "/dev/input/by-path/pci-0000:00:14.0-usb-0:2:1.0-event-kbd"
            "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:1:1.2-event-kbd"
            "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:2:1.0-event-kbd"
            "/dev/input/by-id/usb-Genius_Wireless_Device-if02-event-kbd"
          ];
          extraDefCfg = ''
            process-unmapped-keys no
            concurrent-tap-hold yes
          '';
          config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )
            (defchordsv2
              (w e) esc 50 all-released (extend)
              (i o) bspc 50 all-released (extend)
              (x c) tab 50 all-released (extend)
              (, .) ret 50 all-released (extend)
            )

            (deftemplate charmod (char mod)
              (switch
                ((key-timing 3 less-than 375)) $char break
                () (tap-hold-release-timeout 200 500 $char $mod $char) break
              )
            )

            (defvirtualkeys
              shift (multi (layer-switch main) lsft)
              clear (multi (layer-switch main) (on-press release-virtualkey shift))
            )

            (deflayermap (main)
              lctl @super
              lmet @control
              a (t! charmod a lmet)
              s (t! charmod s lalt)
              d (t! charmod d lsft)
              f (t! charmod f lctl)
              j (t! charmod j rctl)
              k (t! charmod k rsft)
              l (t! charmod l lalt)
              ; (t! charmod ; rmet)
              z (t! charmod z (layer-while-held fumbol))
              x (t! charmod x ralt)
              v (t! charmod v lmet)
              m (t! charmod m rmet)
              . (t! charmod . ralt)
              / (t! charmod / (layer-while-held fumbol))
              spc (switch
                ((key-timing 1 less-than 200)) _ break
                () (tap-hold-release-timeout 200 500 spc (multi (layer-switch extend) (on-release tap-virtualkey clear)) spc) break
              )
              caps @caps
            )

            (deflayermap (extend)
              e (layer-switch fumbol)
              r (on-press press-virtualkey shift)
              y ins
              u home
              i up
              o end
              p pgup
              a lmet
              s lalt
              d lsft
              f lctl
            ;;g comp ;; Enable if not MacOS.
              h esc
              j left
              k down
              l rght
              ; pgdn
              z mute
              x vold
              c volu
              v (tap-hold-release 200 200 pp lmet)
              n tab
              m bspc
              , spc
              . del
              / ret
            )

            (deflayermap (fumbol)
              q f1
              w f2
              e f3
              r f4
              t f5
              y f6
              u f7
              i f8
              o f9
              p f10
              [ f11
              ] f12
              \ f13
              a (t! charmod 1 lmet)
              s (t! charmod 2 lalt)
              d (t! charmod 3 lsft)
              f (t! charmod 4 lctl)
              g 5
              h 6
              j (t! charmod 7 rctl)
              k (t! charmod 8 rsft)
              l (t! charmod 9 lalt)
              ; (t! charmod 0 rmet)
              z lsgt
              x (t! charmod ` ralt)
              c -
              v (t! charmod = lmet)
              b f11
              n f12
              m (t! charmod ' rmet)
              , [
              . (t! charmod ] ralt)
              / \
            )
            (deflayer nomods
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

            (deffakekeys
              to-base (layer-switch main)
            )

            (defalias
              caps (tap-hold 200 200 esc (layer-while-held arrows))
              super lmet
              control lctl
            )
            (deflayer arrows
              grv  C-1  C-2    C-3    C-4    C-5    C-6    C-7    C-8    C-9    C-0    -    =    bspc
              tab  C-q    C-w    C-e    C-r    C-t    C-y    C-u    C-i    C-o    C-p    [    ]    \
              _    C-a    C-s    C-d    C-f    C-g    left down up right     ;    '    ret
              lsft C-z    C-x    C-c    C-v    C-b    C-n    C-m    ,    .    C-/    rsft
              lmet lctl lalt           C-spc            ralt rmet rctl
            )
          '';
        };
      };
    };
  };
}
