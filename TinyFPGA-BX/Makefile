
# TinyFPGA-BX
# yosys+nextpnr

PROJECT  := rio
TOP      := rio
FAMILY   := ice40
TYPE     := lp8k
PACKAGE  := cm81
VERILOGS := pll.v blink.v rio.v

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

tinyprog: $(PROJECT).bin
	tinyprog -p $(PROJECT).bin

load: $(PROJECT).bin
	 openFPGALoader -b ice40_generic $(PROJECT).bin

