
PROJECT  := rio
TOP      := rio
PART     := LCMXO2-7000HC-5TG144C
VERILOGS := blink.v rio.v

all: build/$(PROJECT)_build.bit

$(PROJECT).tcl: $(VERILOGS)
	@echo "prj_project new -name $(PROJECT) -impl build -dev $(PART) -lpf pins.lpf" > $(PROJECT).tcl
	@for VAR in $?; do echo $$VAR | grep -s -q "\.v$$" && echo "prj_src add $$VAR" >> $(PROJECT).tcl; done
	@echo "prj_impl option top $(TOP)" >> $(PROJECT).tcl
	@echo "prj_project save" >> $(PROJECT).tcl
	@echo "prj_project close" >> $(PROJECT).tcl

syn.tcl: $(PROJECT).tcl
	@echo "prj_project open $(PROJECT).ldf" >> syn.tcl
	@echo "prj_run Synthesis -impl build" >> syn.tcl
	@echo "prj_run Translate -impl build" >> syn.tcl
	@echo "prj_run Map -impl build" >> syn.tcl
	@echo "prj_run PAR -impl build" >> syn.tcl
	@echo "prj_run PAR -impl build -task PARTrace" >> syn.tcl
	@echo "prj_run Export -impl build -task Bitgen" >> syn.tcl
	@echo "prj_project close" >> syn.tcl

$(PROJECT).ldf: syn.tcl
	diamondc $(PROJECT).tcl

build/$(PROJECT)_build.bit: $(PROJECT).ldf
	diamondc syn.tcl

clean:
	rm -rf build $(PROJECT).ldf $(PROJECT).tcl syn.tcl *.sty
