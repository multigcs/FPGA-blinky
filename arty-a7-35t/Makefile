
all: build/rio.bit

build/rio.bit: rio.tcl pins.xdc blink.v rio.v
	vivado -mode batch -source rio.tcl

clean:
	rm -rf build

xc3sprog: build/rio.bit
	xc3sprog -c nexys4 build/rio.bit

load: build/rio.bit
	openFPGALoader -b arty -f build/rio.bit

