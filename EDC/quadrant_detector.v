module quadrant_detector (x1,y1,s1,s2,s3,x,y);

//PORT DECLARATION
	input s1,s2,s3;
	input [15 : 0] x,y;
	output [15 : 0] x1,y1;

//WIRE DECLARATION
	wire [15 : 0] 	a,b,neg_a, neg_b;
	wire 			c_out_a, c_out_b;


//ALGORITHM 
	
	mux2 	mux_1(x,y,s1,a);
	mux2 	mux_2(y,x,s1,b);
	
	neg 	M1(c_out_a, neg_a, a);
	neg 	M2(c_out_b, neg_b, b);

	mux2 	mux_x1(a,neg_a,s2,x1);
	mux2 	mux_x2(b,neg_b,s3,y1);

endmodule