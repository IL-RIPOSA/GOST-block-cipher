vsim -gui work.gost_cipher_fun
add wave -position insertpoint  \
sim:/gost_cipher_fun/clk \
sim:/gost_cipher_fun/finish \
sim:/gost_cipher_fun/sel_sig \
sim:/gost_cipher_fun/k_i \
sim:/gost_cipher_fun/inp \
sim:/gost_cipher_fun/final \
sim:/gost_cipher_fun/reg \
sim:/gost_cipher_fun/fin \
sim:/gost_cipher_fun/fout \
sim:/gost_cipher_fun/reg_out
force -freeze sim:/gost_cipher_fun/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/gost_cipher_fun/finish 0 0
force -freeze sim:/gost_cipher_fun/sel_sig 1 0
force -freeze sim:/gost_cipher_fun/k_i 00010000000000010000000000000001 0
force -freeze sim:/gost_cipher_fun/inp 0000000000000000000000000000000000000001000000010001000000010001 0
run
force -freeze sim:/gost_cipher_fun/sel_sig 0 0
force -freeze sim:/gost_cipher_fun/k_i 00000000000000000000000000000001 0
run
force -freeze sim:/gost_cipher_fun/k_i 00000000000000000000000000000010 0
run
force -freeze sim:/gost_cipher_fun/finish 1 0
run
run
force -freeze sim:/gost_cipher_fun/finish 0 0
run