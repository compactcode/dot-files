# CPU: Intel Core i7-8565U
# GPU: Nvidia Quadro P520
# Motherboard: ThinkPad P43s
{
  boot = {
    # disable nvidia gpu
    blacklistedKernelModules = ["nouveau" "nvidia" "nvidia_drm" "nvidia_modeset"];

    # disable nvidia gpu
    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    initrd = {
      availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
    };
  };

  hardware = {
    # enable bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    # enable microcode updates
    cpu.intel.updateMicrocode = true;
    # enable gpu acceleration
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services = {
    # periodic ssd maintenance
    fstrim.enable = true;
    # disable nvidia gpu
    udev.extraRules = ''
      # Remove NVIDIA USB xHCI Host Controller devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA USB Type-C UCSI devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA Audio devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA VGA/3D controller devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '';
  };
}
