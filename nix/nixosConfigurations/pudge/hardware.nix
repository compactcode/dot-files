# CPU: Intel N100
# GPU: Intel UHD Graphics
# Motherboard: LarkBox X 2023
{
  boot = {
    initrd = {
      availableKernelModules = ["ahci" "sd_mod" "uas" "usb_storage" "usbhid" "xhci_pci"];
    };

    # enable virtualization
    kernelModules = ["kvm-intel"];
  };

  # TODO: Move this somewhere else.
  fileSystems = {
    "/mnt/nas/config" = {
      device = "192.168.1.200:/mnt/storage/config";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    "/mnt/nas/media" = {
      device = "192.168.1.200:/mnt/storage/media";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };

  hardware = {
    # enable amd microcode updates
    cpu.intel.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  networking = {
    # enable the wireless card
    wireless = {
      enable = true;
      # allow dynamic network selection
      userControlled.enable = true;
    };
  };
}