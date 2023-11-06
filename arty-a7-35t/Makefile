
# vivado

PROJECT  := rio
TOP      := rio
PART     := xc7a35ticsg324-1l
VERILOGS := blink.v rio.v

all: build/$(PROJECT).bit


$(PROJECT).tcl: pins.xdc $(VERILOGS)
	@echo "set outputDir ./build" > $(PROJECT).tcl
	@echo "file mkdir \$$outputDir" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@for VAR in $?; do echo $$VAR | grep -s -q "\.v$$" && echo "read_verilog $$VAR" >> $(PROJECT).tcl; done
	@echo "read_xdc pins.xdc" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "synth_design -top $(TOP) -part $(PART)" >> $(PROJECT).tcl
	@echo "write_checkpoint -force \$$outputDir/post_synth.dcp" >> $(PROJECT).tcl
	@echo "report_timing_summary -file \$$outputDir/post_synth_timing_summary.rpt" >> $(PROJECT).tcl
	@echo "report_utilization -file \$$outputDir/post_synth_util.rpt" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "opt_design" >> $(PROJECT).tcl
	@echo "place_design" >> $(PROJECT).tcl
	@echo "report_clock_utilization -file \$$outputDir/clock_util.rpt" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "write_checkpoint -force \$$outputDir/post_place.dcp" >> $(PROJECT).tcl
	@echo "report_utilization -file \$$outputDir/post_place_util.rpt" >> $(PROJECT).tcl
	@echo "report_timing_summary -file \$$outputDir/post_place_timing_summary.rpt" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "route_design" >> $(PROJECT).tcl
	@echo "write_checkpoint -force \$$outputDir/post_route.dcp" >> $(PROJECT).tcl
	@echo "report_route_status -file \$$outputDir/post_route_status.rpt" >> $(PROJECT).tcl
	@echo "report_timing_summary -file \$$outputDir/post_route_timing_summary.rpt" >> $(PROJECT).tcl
	@echo "report_power -file \$$outputDir/post_route_power.rpt" >> $(PROJECT).tcl
	@echo "report_drc -file \$$outputDir/post_imp_drc.rpt" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "write_verilog -force \$$outputDir/impl_netlist.v -mode timesim -sdf_anno true" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "write_bitstream -force \$$outputDir/$(PROJECT).bit" >> $(PROJECT).tcl
	@echo "" >> $(PROJECT).tcl
	@echo "exit" >> $(PROJECT).tcl


build/$(PROJECT).bit: $(PROJECT).tcl
	vivado -mode batch -source $(PROJECT).tcl

clean:
	rm -rf build $(PROJECT).tcl vivado.jou vivado.log .Xil

xc3sprog: build/$(PROJECT).bit
	xc3sprog -c nexys4 build/$(PROJECT).bit

load: build/$(PROJECT).bit
	openFPGALoader -b arty -f build/$(PROJECT).bit

