{ pkgs, ... }:

# CPU: Intel Core i7-8565U
# GPU: Nvidia Quadro P520
# Motherboard: ThinkPad P43s

{
  boot = {
    # Disable Nvidia GPU
    blacklistedKernelModules =
      [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

    # Disable Nvidia GPU
    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    initrd = {
      availableKernelModules =
        [ "ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci" ];

      luks.devices = {
        nixos-decrypted = {
          allowDiscards = true;
          device = "/dev/disk/by-uuid/faf3866c-2bdb-4b87-a9d0-96bb2271f294";
        };
      };
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/2FC2-5199";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/swap" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/05d71024-b0d0-4c88-879e-dc77b83bd527";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };
  };

  hardware = {
    # enable amd microcode updates
    cpu.intel.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # set a hostname
  networking.hostName = "prophet";

  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

  # set a swap file
  swapDevices = [{ device = "/swap/swapfile"; }];

  # the version this machine was created with
  system.stateVersion = "22.11";
}
