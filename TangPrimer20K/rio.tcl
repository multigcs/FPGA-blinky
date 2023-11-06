set_device -name GW2A-18C GW2A-LV18PG256C8/I7
add_file quad_encoder.v
add_file joint_stepper.v
add_file joint_stepper_nf.v
add_file debouncer.v
add_file blink.v
add_file rio.v
add_file pins.cst

set_option -top_module rio
set_option -verilog_std v2001
set_option -vhdl_std vhd2008
set_option -use_sspi_as_gpio 1
set_option -use_mspi_as_gpio 1
set_option -use_done_as_gpio 1
set_option -use_ready_as_gpio 1
set_option -use_reconfign_as_gpio 1
set_option -use_i2c_as_gpio 1

run all