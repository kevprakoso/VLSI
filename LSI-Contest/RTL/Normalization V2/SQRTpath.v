// Example 24a: Square root datapath
module SQRTpath (
input wire clk ,
input wire reset ,
input wire ald ,
input wire sqld ,
input wire dld ,
input wire outld ,
input wire [15:0] sw ,
output reg lteflg ,
output wire [9:0] root
);
wire [15:0] a;
wire [15:0] sq, s;
wire [15:0] del, dp2;
wire [9:0] dm1;
assign s = sq + {8'b00000000, del}; // adder8
assign dp2 = del + 2; // plus2
assign dm1 = del[10:1] - 1; // minus1
always @(*)
begin
 if(sq <= {1'b0,a})
 lteflg <= 1;
 else
 lteflg <= 0;
end
regr2 #(
 .N(16),
 .BIT0(0),
 .BIT1(0))
aReg (.load(ald),
 .clk(clk),
 .reset(reset),
 .d(sw),
 .q(a)
);
regr2 #(
 .N(16),
 .BIT0(1),
 .BIT1(0))
sqReg (.load(sqld),
 .clk(clk),
 .reset(reset),
 .d(s),
 .q(sq)
); 

regr2 #(
 .N(16),
 .BIT0(1),
 .BIT1(1))
delReg (.load(dld),
 .clk(clk),
 .reset(reset),
 .d(dp2),
 .q(del)
);
regr2 #(
 .N(10),
 .BIT0(0),
 .BIT1(0))
outReg (.load(outld),
 .clk(clk),
 .reset(reset),
 .d(dm1),
 .q(root)
);
endmodule 