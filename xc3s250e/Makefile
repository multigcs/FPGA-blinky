
PROJECT  := rio
TOP      := rio
PART     := xc3s250e-4-vq100
VERILOGS := blink.v rio.v

all: $(PROJECT).bit

$(PROJECT)-modules.v: $(VERILOGS)
	cat $(VERILOGS) > $(PROJECT)-modules.v

$(PROJECT).ngc: $(PROJECT)-modules.v
	echo 'run -ifn $(PROJECT)-modules.v -ifmt Verilog -ofn $(PROJECT).ngc -top $(TOP) -p $(PART) -opt_mode Speed -opt_level 1' | xst

$(PROJECT).ngd: $(PROJECT).ngc pins.ucf
	ngdbuild -p $(PART) -uc pins.ucf $(PROJECT).ngc

$(PROJECT).ncd: $(PROJECT).ngd
	map -detail -pr b $(PROJECT).ngd

parout.ncd: $(PROJECT).ncd $(PROJECT).pcf
	par -w $(PROJECT).ncd parout.ncd $(PROJECT).pcf

$(PROJECT).bit: parout.ncd $(PROJECT).pcf
	bitgen -w -g StartUpClk:CClk -g CRC:Enable parout.ncd $(PROJECT).bit $(PROJECT).pcf

clean:
	rm -rf $(PROJECT).ngc $(PROJECT).ngd $(PROJECT).ncd parout.ncd $(PROJECT).bit _xmsgs/ netlist.lst parout.* parout_pad.* $(PROJECT)-modules.v $(PROJECT).pcf $(PROJECT).bgn $(PROJECT).bld
	rm -rf $(PROJECT)_bitgen.xwbt $(PROJECT)_map.xrpt $(PROJECT)_ngdbuild.xrpt $(PROJECT)_par.xrpt $(PROJECT)_summary.xml $(PROJECT)_usage.xml usage_statistics_webtalk.html webtalk.log
	rm -rf $(PROJECT).drc $(PROJECT).map $(PROJECT).mrp $(PROJECT).ngm $(PROJECT).ngc_xst.xrpt $(PROJECT).pcf xst/ xlnx_auto_0_xdb/


load: $(PROJECT).bit
	openFPGALoader -v -c usb-blaster $(PROJECT).bit



