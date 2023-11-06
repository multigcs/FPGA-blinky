
PRODUCT   = rio
PART      = EP4CE6E22C8
FAMILY    = "Cyclone IV E"
BOARDFILE = pins.qdf
MOD       = rio

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
QMFLAGS = --read_settings_files=on $(addprefix --source=,$(SRCS))
QFFLAGS = --part=$(PART) --read_settings_files=on

SRCS = blink.v rio.v
ASIGN = $(PRODUCT).qsf $(PRODUCT).qpf

all: $(PRODUCT)

map: smart.log $(PRODUCT).map.rpt
fit: smart.log $(PRODUCT).fit.rpt
asm: smart.log $(PRODUCT).asm.rpt
sta: smart.log $(PRODUCT).sta.rpt
smart: smart.log

$(ASIGN):
	$(Q)$(ECHO) "Generating asignment files."
	$(QC) --prepare -f $(FAMILY) -t $(MOD) $(PRODUCT)
	echo >> $(PRODUCT).qsf
	cat $(BOARDFILE) >> $(PRODUCT).qsf

smart.log: $(ASIGN)
	$(Q)$(ECHO) "Generating smart.log."
	$(QC) --determine_smart_action $(PRODUCT) > smart.log

$(PRODUCT): smart.log $(PRODUCT).asm.rpt $(PRODUCT).sta.rpt

$(PRODUCT).map.rpt: map.chg $(SRCS)
	$(QM) $(QMFLAGS) $(PRODUCT)
	$(STAMP) fit.chg

$(PRODUCT).fit.rpt: fit.chg $(PRODUCT).map.rpt
	$(QF) $(QFFLAGS) $(PRODUCT)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(PRODUCT).asm.rpt: asm.chg $(PRODUCT).fit.rpt
	$(QA) $(PRODUCT)

$(PRODUCT).sta.rpt: sta.chg $(PRODUCT).fit.rpt
	$(QS) $(PRODUCT)

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
	rm -f smart.log *.rpt *.sof *.chg *.qsf *.qpf *.summary *.smsg *.pin *.jdi

load: prog
prog: $(PRODUCT).sof
	$(Q)$(ECHO) "Programming."
	$(QP) --no_banner --mode=jtag -o "P;$(PRODUCT).sof"

