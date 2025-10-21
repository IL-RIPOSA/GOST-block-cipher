vsim -gui work.ram
add wave -position insertpoint  \
sim:/ram/clk \
sim:/ram/user_key \
sim:/ram/init \
sim:/ram/new_key \
sim:/ram/enc_dec \
sim:/ram/adress \
sim:/ram/round_key \
sim:/ram/ksu 

force -freeze sim:/ram/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/ram/user_key 0000000000000000000000000000011100000000000000000000000000000110000000000000000000000000000001010000000000000000000000000000010000000000000000000000000000000011000000000000000000000000000000100000000000000000000000000000000100010000000000010000000000000001 0
force -freeze sim:/ram/init 1 0
force -freeze sim:/ram/new_key 1 0
force -freeze sim:/ram/enc_dec 0 0
run
force -freeze sim:/ram/adress 00001 0
force -freeze sim:/ram/init 0 0
run
force -freeze sim:/ram/adress 00010 0
run
force -freeze sim:/ram/adress 00011 0
run
force -freeze sim:/ram/adress 00100 0
run
force -freeze sim:/ram/adress 00101 0
run
force -freeze sim:/ram/adress 00110 0
run
force -freeze sim:/ram/adress 00111 0
run
force -freeze sim:/ram/adress 01000 0
run
force -freeze sim:/ram/adress 01001 0
run
force -freeze sim:/ram/adress 01010 0
run
force -freeze sim:/ram/adress 10110 0
run
force -freeze sim:/ram/adress 10111 0
run
force -freeze sim:/ram/adress 11000 0
run
force -freeze sim:/ram/adress 11001 0
run
force -freeze sim:/ram/adress 11010 0
run
force -freeze sim:/ram/adress 11011 0
run
force -freeze sim:/ram/adress 11100 0
run
force -freeze sim:/ram/adress 11101 0
run
force -freeze sim:/ram/adress 11110 0
run
force -freeze sim:/ram/adress 11111 0
run