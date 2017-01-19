module getHistogram_fixpt
          (
input wire	clk,
input wire	reset,
input wire	clk_enable,
input wire [13:0]	magnitudes,
input wire [3:0]	angles_1,
output wire ce_out,
output wire [13:0] H_0,
output wire [13:0] H_1,
output wire [13:0] H_2,
output wire [13:0] H_3,
output wire [13:0] H_4,
output wire [13:0] H_5,
output wire [13:0] H_6,
output wire [13:0] H_7,
output wire [13:0] H_8
          );		  
		  
