vsim -gui work.final
add wave -position insertpoint  \
sim:/final/plaintxt \
sim:/final/enable_run \
sim:/final/mode \
sim:/final/en_new_data \
sim:/final/en_new_key \
sim:/final/userkey \
sim:/final/clk \
sim:/final/rst \
sim:/final/cvalid \
sim:/final/ciphertxt \
sim:/final/counter \
sim:/final/counter_ram \
sim:/final/roundkey \
sim:/final/start_key \
sim:/final/start_txt \
sim:/final/mem_start \
sim:/final/run_start \
sim:/final/en_key \
sim:/final/en_data \
sim:/final/done_sig \
sim:/final/test_val
force -freeze sim:/final/plaintxt 0000000000000000000000000000000000000001000000010001000000010001 0
force -freeze sim:/final/enable_run 1 0
force -freeze sim:/final/mode 1 0
force -freeze sim:/final/en_new_data 1 0
force -freeze sim:/final/en_new_key 1 0
force -freeze sim:/final/userkey 0000000000000000000000000000011100000000000000000000000000000110000000000000000000000000000001010000000000000000000000000000010000000000000000000000000000000011000000000000000000000000000000100000000000000000000000000000000100010000000000010000000000000001 0
force -freeze sim:/final/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/final/rst 0 0
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