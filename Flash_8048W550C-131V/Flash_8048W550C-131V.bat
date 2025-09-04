@echo off
set /p comport="Enter the Com port (eg 3) your CYD is connected to: "
esptool.exe --chip esp32s3 --port "com"%comport% --baud 921600  --before default_reset --after hard_reset write_flash  -z --flash_mode dio --flash_freq 80m --flash_size 16MB 0x0 CYC.ino.bootloader.bin 0x8000 CYC.ino.partitions.bin 0xe000 boot_app0.bin 0x10000 CYC.ino.bin 

mklittlefs.exe -c data -p 256 -b 4096 -s 524288 littlefs.bin 
esptool.exe --chip esp32s3 --port "com"%comport% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 3538944 littlefs.bin 
pause
