
sudo qemu-system-x86_64 -m 2048 -hda qcow2.img -enable-kvm -smp 2 -net nic -net user,hostfwd=tcp::2222-:22

sudo qemu-system-x86_64 -m 2048 -hda qcow2.img  -enable-kvm -smp 4 -net nic -net user,hostfwd=tcp::2222-:22

sudo qemu-system-x86_64 -m 4096 -hda qcow2.img  -enable-kvm -smp 2 -net nic -net user,hostfwd=tcp::2222-:22

sudo qemu-system-x86_64 -m 4096 -hda qcow2.img  -enable-kvm -smp 4 -net nic -net user,hostfwd=tcp::2222-:22



sudo qemu-system-x86_64 -m 2048 -hda raw.img  -enable-kvm -smp 2 -net nic -net user,hostfwd=tcp::2222-:22

sudo qemu-system-x86_64 -m 2048 -hda raw.img  -enable-kvm -smp 4 -net nic -net user,hostfwd=tcp::2222-:22

sudo qemu-system-x86_64 -m 4096 -hda raw.img  -enable-kvm -smp 2 -net nic -net user,hostfwd=tcp::2222-:22

sudo qemu-system-x86_64 -m 4096 -hda raw.img   -enable-kvm -smp 4 -net nic -net user,hostfwd=tcp::2222-:22
