prj_project new -name rio -impl build -dev LCMXO2-7000HC-5TG144C -lpf pins.lpf
prj_src add debouncer.v
prj_src add blink.v
prj_src add rio.v
prj_impl option top rio
prj_project save
prj_project close
