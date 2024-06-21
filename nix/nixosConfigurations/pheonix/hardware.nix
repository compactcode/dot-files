# CPU: AMD Ryzen 5900X
# GPU: AMD Radeon 6700XT
# Motherboard: Gigabyte B550I AORUS PRO AX
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
      availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
    };

    # load the GPU early in the book process
    kernelModules = ["amdgpu"];
  };

  hardware = {
    # enable amd microcode updates
    cpu.amd.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # prevent pci devices (nvme) waking the system out of sleep
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
  '';
}
