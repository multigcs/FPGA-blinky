
# MAX 10 - 10M08SAE144C8G
# quartus

PROJECT  := rio
TOP      := rio
PART      := 10M08SAE144C8G
FAMILY    := "MAX 10"
VERILOGS  := blink.v rio.v

QC   = quartus_sh
QP   = quartus_pgm
QM   = quartus_map
QF   = quartus_fit
QA   = quartus_asm
QS   = quartus_sta
ECHO = echo
Q   ?= @

STAMP = echo done >

QCFLAGS = --flow compile
QPFLAGS =
QMFLAGS = --read_settings_files=on $(addprefix --source=,$(VERILOGS))
QFFLAGS = --part=$(PART) --read_settings_files=on

ASIGN = $(PROJECT).qsf $(PROJECT).qpf

all: $(PROJECT)

map: smart.log $(PROJECT).map.rpt
fit: smart.log $(PROJECT).fit.rpt
asm: smart.log $(PROJECT).asm.rpt
sta: smart.log $(PROJECT).sta.rpt
smart: smart.log

$(ASIGN):
	$(Q)$(ECHO) "Generating asignment files."
	$(QC) --prepare -f $(FAMILY) -t $(TOP) $(PROJECT)
	echo >> $(PROJECT).qsf
	echo "set_global_assignment -name NUM_PARALLEL_PROCESSORS 2" >> $(PROJECT).qsf
	cat pins.qdf >> $(PROJECT).qsf
	touch $(PROJECT).sdc

smart.log: $(ASIGN)
	$(Q)$(ECHO) "Generating smart.log."
	$(QC) --determine_smart_action $(PROJECT) > smart.log

$(PROJECT): $(PROJECT).pof $(PROJECT).sta.rpt

$(PROJECT).pof: smart.log $(PROJECT).asm.rpt

$(PROJECT).map.rpt: map.chg $(VERILOGS)
	$(QM) $(QMFLAGS) $(PROJECT)
	$(STAMP) fit.chg

$(PROJECT).fit.rpt: fit.chg $(PROJECT).map.rpt
	$(QF) $(QFFLAGS) $(PROJECT)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(PROJECT).asm.rpt: smart.log asm.chg $(PROJECT).fit.rpt
	$(QA) $(PROJECT)

$(PROJECT).sta.rpt: sta.chg $(PROJECT).fit.rpt
	$(QS) $(PROJECT)

map.chg:
	$(STAMP) map.chg
fit.chg:
	$(STAMP) fit.chg
sta.chg:
	$(STAMP) sta.chg
asm.chg:
	$(STAMP) asm.chg

clean:
	$(Q)$(ECHO) "Cleaning."
	rm -rf db incremental_db
	rm -f smart.log *.rpt *.sof *.pof *.chg *.qsf *.qpf *.summary *.smsg *.pin *.jdi *.sld *.sdc

load: prog
prog: $(PROJECT).pof
	$(Q)$(ECHO) "Programming."
	$(QP) --no_banner --mode=jtag -o "P;$(PROJECT).pof"

