
FAMILY=GW2AR-18C
DEVICE=GW2AR-LV18QN88C8/I7

all: impl/pnr/project.fs

clean:
	rm -rf impl/pnr/project.fs

load: gowin_load

gowin_build: impl/pnr/project.fs

impl/pnr/project.fs: rio.tcl pins.cst blink.v rio.v
	gw_sh rio.tcl

gowin_load: impl/pnr/project.fs
	openFPGALoader -b tangnano20k impl/pnr/project.fs -f
