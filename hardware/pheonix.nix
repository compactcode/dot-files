{ pkgs, ... }:

# CPU: AMD Ryzen 5900X
# GPU: AMD Radeon 6700XT
# Motherboard: Gigabyte B550I AORUS PRO AX

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci" ];
    };

    # load the GPU early in the book process
    kernelModules = [ "amdgpu" ];
  };

  hardware = {
    # enable amd microcode updates
    cpu.amd.updateMicrocode = true;

    # enable nonfree firmware
    enableRedistributableFirmware = true;
  };

  # set a hostname
  networking.hostName = "pheonix";

  # the version this machine was created with
  system.stateVersion = "23.11";
}
