
all: rio.bit

rio-modules.v: debouncer.v blink.v rio.v
	cat debouncer.v blink.v rio.v > rio-modules.v

rio.ngc: rio-modules.v
	echo 'run -ifn rio-modules.v -ifmt Verilog -ofn rio.ngc -top rio -p xc3s250e-4-vq100 -opt_mode Speed -opt_level 1' | xst

rio.ngd: rio.ngc pins.ucf
	ngdbuild -p xc3s250e-4-vq100 -uc pins.ucf rio.ngc

rio.ncd: rio.ngd
	map -detail -pr b rio.ngd

parout.ncd: rio.ncd rio.pcf
	par -w rio.ncd parout.ncd rio.pcf

rio.bit: parout.ncd rio.pcf
	bitgen -w -g StartUpClk:CClk -g CRC:Enable parout.ncd rio.bit rio.pcf

clean:
	rm -rf rio.ngc rio.ngd rio.ncd parout.ncd rio.bit

load: rio.bit
	openFPGALoader -v -c usb-blaster rio.bit

