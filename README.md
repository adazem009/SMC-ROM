# SMC-ROM
SMC Computer BIOS source code

### Building
1. Clone this repository:
```
git clone https://github.com/adazem009/SMC-ROM
cd SMC-ROM
```
2. Make sure `git` and `gcc` are installed (Debian, Ubuntu):
```
sudo apt-get install git gcc
```
3. Build:
```
make
```
The BIOS image will be saved in the `image` file. You can copy it and paste it to the `#BIOS` variable in SMC Computer.
