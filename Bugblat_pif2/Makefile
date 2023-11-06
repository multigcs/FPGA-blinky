PROJECT = rio
TOP = rio
PART = LCMXO2-7000HC-5TG144C

all: build/rio_build.bit


$(PROJECT).tcl: blink.v $(PROJECT).v
	@echo "prj_project new -name $(PROJECT) -impl build -dev $(PART) -lpf pins.lpf" > $(PROJECT).tcl
	@for VAR in $?; do echo $$VAR | grep -s -q "\.v$$" && echo "prj_src add $$VAR" >> $(PROJECT).tcl; done
	@echo "prj_impl option top $(TOP)" >> $(PROJECT).tcl
	@echo "prj_project save" >> $(PROJECT).tcl
	@echo "prj_project close" >> $(PROJECT).tcl

$(PROJECT).ldf: $(PROJECT).tcl blink.v $(PROJECT).v
	diamondc $(PROJECT).tcl

build/$(PROJECT)_build.bit: $(PROJECT).ldf
	diamondc syn.tcl

clean:
	rm -rf build $(PROJECT).ldf $(PROJECT).tcl
