
FAMILY  := ecp5
TYPE    := 25k
PACKAGE := CABGA381

all: rio.bit

rio.json: pll.v blink.v rio.v
	yosys -q -l yosys.log -p 'synth_${FAMILY} -top rio -json rio.json' pll.v blink.v rio.v

rio.config: rio.json pins.lpf
	nextpnr-${FAMILY} -q -l nextpnr.log --${TYPE} --package ${PACKAGE} --json rio.json --lpf pins.lpf --textcfg rio.config
	@echo ""
	@grep -B 1 "%$$" nextpnr.log
	@echo ""

rio.bit: rio.config
	ecppack --svf rio.svf rio.config rio.bit

rio.svf: rio.bit

clean:
	rm -rf rio.bit rio.svf rio.config rio.json yosys.log nextpnr.log

check:
	verilator --top-module rio --lint-only -Wall *.v

sim: pll.v blink.v rio.v
	verilator --cc --exe --build -j 0 -Wall --top-module rio sim_main.cpp pll.v blink.v rio.v

tinyprog: rio.bit
	tinyprog -p rio.bit

load: rio.bit
	 openFPGALoader -b ice40_generic rio.bit

