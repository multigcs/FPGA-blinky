
# Olimex-ICE40HX8K-EVB
# yosys+nextpnr

PROJECT  := rio
TOP      := rio
FAMILY   := ice40
TYPE     := hx8k
PACKAGE  := cb132
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
	rm -rf $(PROJECT).bin $(PROJECT).asc $(PROJECT).json yosys.log nextpnr.log abc.history

load: $(PROJECT).bin
	 iceFUNprog $(PROJECT).bin
