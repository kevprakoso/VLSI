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

sqr sqra(
.clk(clk),
.val(da),
.square(sqra)
);

sqr sqrb(
.clk(clk),
.val(db),
.square(sqrb)
);

sqr sqrc(
.clk(clk),
.val(dc),
.square(sqrc)
);

sqr sqrd(
.clk(clk),
.val(dd),
.square(sqrd)
);

sqr sqre(
.clk(clk),
.val(de),
.square(sqre)
);

sqr sqrf(
.clk(clk),
.val(df),
.square(sqrf)
);

sqr sqrg(
.clk(clk),
.val(dg),
.square(sqrg)
);

sqr sqrh(
.clk(clk),
.val(dh),
.square(sqrh)
);

sqr sqri(
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

always@ (posedge clk)
begin
  magnitude <= mag;  
end  

endmodule
