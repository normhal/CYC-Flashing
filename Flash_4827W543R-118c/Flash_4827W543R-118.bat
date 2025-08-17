@echo off
set /p comport="Enter the Com port (eg COM3) your CYD is connected to: "
esptool.exe --chip esp32s3 --port %comport% --baud 921600  --before default_reset --after hard_reset write_flash  -z --flash_mode dio --flash_freq 80m --flash_size 4MB 0x0 CYC.ino.bootloader.bin 0x8000 CYC.ino.partitions.bin 0xe000 boot_app0.bin 0x10000 CYC.ino.bin 

echo Press the space bar Now to load the LittleFS Files
pause

mklittlefs.exe -c data -p 256 -b 4096 -s 917504 littlefs.bin 
esptool.exe --chip esp32s3 --port %comport% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 3211264 littlefs.bin 
pause
