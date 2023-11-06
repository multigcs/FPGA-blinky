
PROJECT  := rio
TOP      := rio
FAMILY   := GW2A-18C
DEVICE   := GW2A-LV18PG256C8/I7
VERILOGS := blink.v rio.v

all: $(PROJECT).fs

$(PROJECT).json: $(VERILOGS)
	yosys -q -l yosys.log -p 'synth_gowin -noalu -nowidelut -top $(PROJECT) -json $(PROJECT).json' $(VERILOGS)

$(PROJECT)_pnr.json: $(PROJECT).json pins.cst
	nextpnr-gowin --seed 0 --json $(PROJECT).json --write $(PROJECT)_pnr.json --freq 27.0 --enable-globals --enable-auto-longwires --device ${DEVICE} --cst pins.cst

$(PROJECT).fs: $(PROJECT)_pnr.json
	gowin_pack -d ${FAMILY} -o $(PROJECT).fs $(PROJECT)_pnr.json

load: $(PROJECT).fs
	openFPGALoader -b tangprimer20k $(PROJECT).fs -f


clean:
	rm -rf $(PROJECT).fs $(PROJECT).json $(PROJECT)_pnr.json $(PROJECT).tcl abc.history impl yosys.log

gowin_build: impl/pnr/project.fs

$(PROJECT).tcl: pins.cst $(VERILOGS)
	@echo "set_device -name $(FAMILY) $(DEVICE)" > $(PROJECT).tcl
	@for VAR in $?; do echo $$VAR | grep -s -q "\.v$$" && echo "add_file $$VAR" >> $(PROJECT).tcl; done
	@echo "add_file pins.cst" >> $(PROJECT).tcl
	@echo "set_option -top_module $(TOP)" >> $(PROJECT).tcl
	@echo "set_option -verilog_std v2001" >> $(PROJECT).tcl
	@echo "set_option -vhdl_std vhd2008" >> $(PROJECT).tcl
	@echo "set_option -use_sspi_as_gpio 1" >> $(PROJECT).tcl
	@echo "set_option -use_mspi_as_gpio 1" >> $(PROJECT).tcl
	@echo "set_option -use_done_as_gpio 1" >> $(PROJECT).tcl
	@echo "set_option -use_ready_as_gpio 1" >> $(PROJECT).tcl
	@echo "set_option -use_reconfign_as_gpio 1" >> $(PROJECT).tcl
	@echo "set_option -use_i2c_as_gpio 1" >> $(PROJECT).tcl
	@echo "run all" >> $(PROJECT).tcl

impl/pnr/project.fs: $(PROJECT).tcl
	gw_sh $(PROJECT).tcl

gowin_load: impl/pnr/project.fs
	openFPGALoader -b tangprimer20k impl/pnr/project.fs -f
