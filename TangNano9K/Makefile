
FAMILY=GW1N-9C
DEVICE=GW1NR-LV9QN88PC6/I5

all: rio.fs

rio.json: expansion_shiftreg.v debouncer.v blink.v rio.v
	yosys -q -l yosys.log -p 'synth_gowin -noalu -nowidelut -top rio -json rio.json' expansion_shiftreg.v debouncer.v blink.v rio.v

rio_pnr.json: rio.json pins.cst
	nextpnr-gowin --seed 0 --json rio.json --write rio_pnr.json --freq 27.0 --enable-globals --enable-auto-longwires --device ${DEVICE} --cst pins.cst

rio.fs: rio_pnr.json
	gowin_pack -d ${FAMILY} -o rio.fs rio_pnr.json

load: rio.fs
	openFPGALoader -b tangnano9k rio.fs -f


clean:
	rm -rf rio.fs rio.json rio_pnr.json

testb:
	iverilog -Wall -o testb.out testb.v expansion_shiftreg.v debouncer.v blink.v rio.v
	vvp testb.out
	gtkwave testb.vcd

gowin_build: impl/pnr/project.fs

impl/pnr/project.fs: rio.tcl pins.cst expansion_shiftreg.v debouncer.v blink.v rio.v
	gw_sh rio.tcl

gowin_load: impl/pnr/project.fs
	openFPGALoader -b tangnano9k impl/pnr/project.fs -f
