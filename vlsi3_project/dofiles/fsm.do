vsim -gui work.fsm
add wave -position insertpoint  \
sim:/fsm/clk \
sim:/fsm/rst \
sim:/fsm/en \
sim:/fsm/enable_key \
sim:/fsm/enable_data \
sim:/fsm/init_mem \
sim:/fsm/init_key \
sim:/fsm/init_data \
sim:/fsm/round \
sim:/fsm/mem_pos \
sim:/fsm/done \
sim:/fsm/state
force -freeze sim:/fsm/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/fsm/rst 0 0
force -freeze sim:/fsm/en 1 0
force -freeze sim:/fsm/enable_key 1 0
force -freeze sim:/fsm/enable_data 1 0
run
run
run
force -freeze sim:/fsm/en 0 0
force -freeze sim:/fsm/enable_key 1 0
force -freeze sim:/fsm/enable_data 1 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/fsm/en 1 0
run
force -freeze sim:/fsm/enable_data 0 0
run
run
run
force -freeze sim:/fsm/rst 1 0
run
force -freeze sim:/fsm/rst 0 0
run
