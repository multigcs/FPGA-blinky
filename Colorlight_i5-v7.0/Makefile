
PROJECT  := rio
TOP      := rio
FAMILY   := ecp5
TYPE     := 25k
PACKAGE  := CABGA381
VERILOGS := pll.v blink.v rio.v

all: $(PROJECT).bit

$(PROJECT).json: $(VERILOGS)
	yosys -q -l yosys.log -p 'synth_${FAMILY} -top $(TOP) -json $(PROJECT).json' $(VERILOGS)

$(PROJECT).config: $(PROJECT).json pins.lpf
	nextpnr-${FAMILY} -q -l nextpnr.log --${TYPE} --package ${PACKAGE} --json $(PROJECT).json --lpf pins.lpf --textcfg $(PROJECT).config
	@echo ""
	@grep -B 1 "%$$" nextpnr.log
	@echo ""

$(PROJECT).bit: $(PROJECT).config
	ecppack --svf $(PROJECT).svf $(PROJECT).config $(PROJECT).bit

$(PROJECT).svf: $(PROJECT).bit

clean:
	rm -rf $(PROJECT).bit $(PROJECT).svf $(PROJECT).config $(PROJECT).json yosys.log nextpnr.log

check:
	verilator --top-module $(PROJECT) --lint-only -Wall *.v

sim: $(VERILOGS)
	verilator --cc --exe --build -j 0 -Wall --top-module $(PROJECT) sim_main.cpp $(VERILOGS)

tinyprog: $(PROJECT).bit
	tinyprog -p $(PROJECT).bit

load: $(PROJECT).bit
	 openFPGALoader -b ice40_generic $(PROJECT).bit

