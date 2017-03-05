// Example 24d: Integer Square Root
module SQRT (
input wire clk ,
input wire clr ,
input wire go ,
input wire [15:0] sw ,
output wire done ,
output wire [9:0] root
);
wire lteflg, ald, sqld, dld, outld;
assign done = outld;
SQRTctrl sqrt1 (.clk(clk),
 .clr(clr),
 .lteflg(lteflg),
 .go(go),
 .ald(ald),
 .sqld(sqld),
 .dld(dld),
 .outld(outld)
);
SQRTpath sqrt2 (.clk(clk),
 .reset(clr),
 .ald(ald),
 .sqld(sqld),
 .dld(dld),
 .outld(outld),
 .sw(sw),
 .lteflg(lteflg),
 .root(root)
);
endmodule 