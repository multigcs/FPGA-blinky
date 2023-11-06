prj_project open rio.ldf
prj_run Synthesis -impl build
prj_run Translate -impl build
prj_run Map -impl build
prj_run PAR -impl build
prj_run PAR -impl build -task PARTrace
prj_run Export -impl build -task Bitgen
prj_project close
