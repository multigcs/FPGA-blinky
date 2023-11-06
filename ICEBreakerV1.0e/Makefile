
FAMILY  := ice40
TYPE    := up5k
PACKAGE := sg48

all: rio.bin

rio.json: debouncer.v pll.v blink.v rio.v
	yosys -q -l yosys.log -p 'synth_${FAMILY} -dsp -top rio -json rio.json' debouncer.v pll.v blink.v rio.v

rio.asc: rio.json pins.pcf
	nextpnr-${FAMILY} -q -l nextpnr.log --${TYPE} --package ${PACKAGE} --json rio.json --pcf pins.pcf --asc rio.asc
	@echo ""
	@grep -B 1 "%$$" nextpnr.log
	@echo ""

rio.bin: rio.asc
	icepack rio.asc rio.bin

clean:
	rm -rf rio.bin rio.asc rio.json yosys.log nextpnr.log

check:
	verilator --top-module rio --lint-only -Wall *.v

sim: debouncer.v pll.v blink.v rio.v
	verilator --cc --exe --build -j 0 -Wall --top-module rio sim_main.cpp debouncer.v pll.v blink.v rio.v

tinyprog: rio.bin
	tinyprog -p rio.bin

load: rio.bin
	openFPGALoader -b ice40_generic rio.bin -f

