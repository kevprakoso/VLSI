module shift_reg (output [15:0] d_out,input [15:0] d_in,input clk);
  parameter stages = 17;
//input [15:0] d_in;

//output[15:0] d_out;
reg [15:0] sreg1;
reg [15:0] sreg2;
reg [15:0] sreg3;
reg [15:0] sreg4;
reg [15:0] sreg5;
reg [15:0] sreg6;
reg [15:0] sreg7;
reg [15:0] sreg8;
reg [15:0] sreg9;
reg [15:0] sreg10;
reg [15:0] sreg11;
reg [15:0] sreg12;
reg [15:0] sreg13;
reg [15:0] sreg14;
reg [15:0] sreg15;
reg [15:0] sreg16;
reg [15:0] sreg17;
always @ (posedge clk) 
begin
sreg1 <= d_in;
sreg2 <= sreg1;
sreg3 <= sreg2;
sreg4 <= sreg3;
sreg5 <= sreg4;
sreg6 <= sreg5;
sreg7 <= sreg6;
sreg8 <= sreg7;
sreg9 <= sreg8;
sreg10 <= sreg9;
sreg11 <= sreg10;
sreg12 <= sreg11;
sreg13 <= sreg12;
sreg14 <= sreg13;
sreg15 <= sreg14;
sreg16 <= sreg15;
sreg17 <= sreg16;






end

assign d_out = sreg17;
endmodule
