module mux2(x,y,sel,q);

//port declaration
input[15 : 0] x,y;
input sel;
output[15 : 0] q;

//wire declaration
wire [15 : 0 ] q;

//contents of the module
assign q = sel ? y : x ;

endmodule