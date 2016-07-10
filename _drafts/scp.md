## Copy files using SCP

scp local/path/to/file/ user@ip_address:remote/path/to/file

When logged into remote computer

scp local/path/to/file user@ip_address:remote/path/to/file

Examples

From Mac to RPi
scp /Users/shankar/Desktop/n64/Super\ Mario\ 64\ \(USA\).n64 pi@192.168.1.177:~/RetroPie/roms/n64

From RPi while logged in with SSH to mac
scp pi_temp.sh shankar@192.168.1.222:~/Desktop