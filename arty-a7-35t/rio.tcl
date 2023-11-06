
set outputDir ./build
file mkdir $outputDir

read_verilog debouncer.v
read_verilog blink.v
read_verilog rio.v
read_xdc pins.xdc

synth_design -top rio -part xc7a35ticsg324-1l
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt

opt_design
place_design
report_clock_utilization -file $outputDir/clock_util.rpt

# Optionally run optimization if there are timing violations after placement
#if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
#    puts "Found setup timing violations => running physical optimization"
#    phys_opt_design
#}
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

route_design
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt

write_verilog -force $outputDir/impl_netlist.v -mode timesim -sdf_anno true

write_bitstream -force $outputDir/rio.bit

exit
