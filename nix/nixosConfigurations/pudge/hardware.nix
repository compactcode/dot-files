# CPU: Intel N100
# GPU: Intel UHD Graphics
# Motherboard: LarkBox X 2023
{
  boot = {
    # disable wifi and bluetooth
    blacklistedKernelModules = [
      "bluetooth"
      "btbcm"
      "btintel"
      "btmtk"
      "btrtl"
      "btusb"
      "iwlwifi"
    ];

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

  # enable microcode updates
  hardware.cpu.intel.updateMicrocode = true;
}
