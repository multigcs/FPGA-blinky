
FAMILY=GW2A-18C
DEVICE=GW2A-LV18PG256C8/I7

all: rio.fs

rio.json: quad_encoder.v joint_stepper.v joint_stepper_nf.v debouncer.v blink.v rio.v
	yosys -q -l yosys.log -p 'synth_gowin -noalu -nowidelut -top rio -json rio.json' quad_encoder.v joint_stepper.v joint_stepper_nf.v debouncer.v blink.v rio.v

rio_pnr.json: rio.json pins.cst
	nextpnr-gowin --seed 0 --json rio.json --write rio_pnr.json --freq 27.0 --enable-globals --enable-auto-longwires --device ${DEVICE} --cst pins.cst

rio.fs: rio_pnr.json
	gowin_pack -d ${FAMILY} -o rio.fs rio_pnr.json

load: rio.fs
	openFPGALoader -b tangprimer20k rio.fs -f


clean:
	rm -rf rio.fs rio.json rio_pnr.json

testb:
	iverilog -Wall -o testb.out testb.v quad_encoder.v joint_stepper.v joint_stepper_nf.v debouncer.v blink.v rio.v
	vvp testb.out
	gtkwave testb.vcd

gowin_build: impl/pnr/project.fs

impl/pnr/project.fs: rio.tcl pins.cst quad_encoder.v joint_stepper.v joint_stepper_nf.v debouncer.v blink.v rio.v
	gw_sh rio.tcl

gowin_load: impl/pnr/project.fs
	openFPGALoader -b tangprimer20k impl/pnr/project.fs -f
