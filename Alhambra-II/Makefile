
PROJECT  := rio
TOP      := rio
FAMILY   := ice40
TYPE     := hx4k
PACKAGE  := tq144
VERILOGS := blink.v rio.v

all: $(PROJECT).bin

$(PROJECT).json: $(VERILOGS)
	yosys -q -l yosys.log -p 'synth_${FAMILY} -top $(TOP) -json $(PROJECT).json' $(VERILOGS)

$(PROJECT).asc: $(PROJECT).json pins.pcf
	nextpnr-${FAMILY} -q -l nextpnr.log --${TYPE} --package ${PACKAGE} --json $(PROJECT).json --pcf pins.pcf --asc $(PROJECT).asc
	@echo ""
	@grep -B 1 "%$$" nextpnr.log
	@echo ""

$(PROJECT).bin: $(PROJECT).asc
	icepack $(PROJECT).asc $(PROJECT).bin

clean:
	rm -rf $(PROJECT).bin $(PROJECT).asc $(PROJECT).json yosys.log nextpnr.log

check:
	verilator --top-module $(PROJECT) --lint-only -Wall *.v

sim: $(VERILOGS)
	verilator --cc --exe --build -j 0 -Wall --top-module $(PROJECT) sim_main.cpp $(VERILOGS)

tinyprog: $(PROJECT).bin
	tinyprog -p $(PROJECT).bin

load: $(PROJECT).bin
	 openFPGALoader -b ice40_generic $(PROJECT).bin

