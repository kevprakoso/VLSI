module myfirst_niosii
(
CLOCK_50,
LED
);
input CLOCK_50;
output [7:0] LED;
DE2_115_SOPC DE2_115_SOPC_inst
(
.clk_clk (CLOCK_50),
//.out_port_from_the_pio_led (LED),
//.reset_n (1'b1)
);
endmodule