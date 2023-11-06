### main ###
set_property LOC E3 [get_ports sysclk]
set_property IOSTANDARD LVCMOS33 [get_ports sysclk]
set_property PULLUP TRUE [get_ports sysclk]

### blink ###
set_property LOC T9 [get_ports BLINK_LED]
set_property IOSTANDARD LVCMOS33 [get_ports BLINK_LED]

### enable ###
set_property LOC N15 [get_ports ENA]
set_property IOSTANDARD LVCMOS33 [get_ports ENA]

### dout_bit ###
set_property LOC R17 [get_ports SPINDLE_ENABLE]
set_property IOSTANDARD LVCMOS33 [get_ports SPINDLE_ENABLE]
set_property LOC E7 [get_ports COOLANT]
set_property IOSTANDARD LVCMOS33 [get_ports COOLANT]

### interface_spislave ###
set_property LOC D13 [get_ports INTERFACE_SPI_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports INTERFACE_SPI_MOSI]
set_property LOC B18 [get_ports INTERFACE_SPI_MISO]
set_property IOSTANDARD LVCMOS33 [get_ports INTERFACE_SPI_MISO]
set_property LOC A18 [get_ports INTERFACE_SPI_SCK]
set_property IOSTANDARD LVCMOS33 [get_ports INTERFACE_SPI_SCK]
set_property LOC K16 [get_ports INTERFACE_SPI_SSEL]
set_property IOSTANDARD LVCMOS33 [get_ports INTERFACE_SPI_SSEL]

### joint_stepper ###
set_property LOC P14 [get_ports JOINT6_STEPPER_STP]
set_property IOSTANDARD LVCMOS33 [get_ports JOINT6_STEPPER_STP]
set_property LOC T14 [get_ports JOINT6_STEPPER_DIR]
set_property IOSTANDARD LVCMOS33 [get_ports JOINT6_STEPPER_DIR]
set_property LOC T11 [get_ports JOINT7_STEPPER_STP]
set_property IOSTANDARD LVCMOS33 [get_ports JOINT7_STEPPER_STP]
set_property LOC T15 [get_ports JOINT7_STEPPER_DIR]
set_property IOSTANDARD LVCMOS33 [get_ports JOINT7_STEPPER_DIR]
set_property LOC R12 [get_ports JOINT8_STEPPER_STP]
set_property IOSTANDARD LVCMOS33 [get_ports JOINT8_STEPPER_STP]
set_property LOC T16 [get_ports JOINT8_STEPPER_DIR]
set_property IOSTANDARD LVCMOS33 [get_ports JOINT8_STEPPER_DIR]

### din_bit ###
set_property LOC M16 [get_ports HOME_X]
set_property IOSTANDARD LVCMOS33 [get_ports HOME_X]
set_property PULLUP TRUE [get_ports HOME_X]
set_property LOC V17 [get_ports HOME_Y]
set_property IOSTANDARD LVCMOS33 [get_ports HOME_Y]
set_property PULLUP TRUE [get_ports HOME_Y]
set_property LOC U18 [get_ports HOME_Z]
set_property IOSTANDARD LVCMOS33 [get_ports HOME_Z]
set_property PULLUP TRUE [get_ports HOME_Z]
set_property LOC C2 [get_ports E_STOP]
set_property IOSTANDARD LVCMOS33 [get_ports E_STOP]
set_property PULLUP TRUE [get_ports E_STOP]
