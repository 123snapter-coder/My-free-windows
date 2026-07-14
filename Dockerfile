# Start with a Linux base that has web tools
FROM debian:latest

# Install the engine needed to run virtual machines
RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    curl \
    wget \
    &> /dev/null

# FIXED LINE: This adds a "User-Agent" header to trick the server into thinking it's a web browser
RUN wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -O /windows.iso "https://microsoft.com"

# Create a blank virtual hard drive for your C: Drive
RUN qemu-img create -f qcow2 /win-disk.qcow2 20G

# Command to start the Windows installation machine out of code
CMD qemu-system-x86_64 -m 2048 -smp 2 -boot d -cdrom /windows.iso -hda /win-disk.qcow2 -vnc :0

