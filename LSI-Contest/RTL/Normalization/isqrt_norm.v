module nsqrt(
input wire clk,
input wire [9:0] da,
input wire [9:0] db,
input wire [9:0] dc,
input wire [9:0] dd, 
input wire [9:0] de,
input wire [9:0] df,
input wire [9:0] dg, 
input wire [9:0] dh,
input wire [9:0] di,  
output reg [10:0] magnitude
);
  

wire [10:0] mag;
wire [9:0] sqra, sqrb, sqrc, sqrd, sqre, sqrf, sqrg, sqrh, sqri;
wire [4:0] square;
wire [2:0] div;

sqr sqr1(
.clk(clk),
.val(da),
.square(sqra)
);

sqr sqr2(
.clk(clk),
.val(db),
.square(sqrb)
);

sqr sqr3(
.clk(clk),
.val(dc),
.square(sqrc)
);

sqr sqr4(
.clk(clk),
.val(dd),
.square(sqrd)
);

sqr sqr5(
.clk(clk),
.val(de),
.square(sqre)
);

sqr sqr6(
.clk(clk),
.val(df),
.square(sqrf)
);

sqr sqr7(
.clk(clk),
.val(dg),
.square(sqrg)
);

sqr sqr8(
.clk(clk),
.val(dh),
.square(sqrh)
);

sqr sqr9(
.clk(clk),
.val(di),
.square(sqri)
);

root_norm root(
.clk(clk),
.sqra(sqra),
.sqrb(sqrb),
.sqrc(sqrc),
.sqrd(sqrd),
.sqre(sqre),
.sqrf(sqrf),
.sqrg(sqrg),
.sqrh(sqrh),
.sqri(sqri),
.magnitude(mag)
);

det determine(
.clk(clk),
.val(mag),
.square(square),
.div(div)
);

always@ (posedge clk)
begin
  magnitude <= mag;  
end  

endmodule
