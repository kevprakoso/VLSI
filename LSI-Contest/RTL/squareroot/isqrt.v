module isqrt(
input wire clk,
input wire [9:0] dx,
input wire [9:0] dy, 
output reg [10:0] magnitude
);
  

wire [16:0] sqrx1, sqry1, mag;


sqr sqrx(
.clk(clk),
.val(dx),
.square(sqrx1)
);

sqr sqry(
.clk(clk),
.val(dy),
.square(sqry1)
);

root_sqr root(
.clk(clk),
.sqrx(sqrx1),
.sqry(sqry1),
.magnitude(mag)
);

always@ (posedge clk)
begin
  magnitude <= mag;  
end  

endmodule

