module neg(c_out, out,  in);
//PORT DECLARATION
	output[15:0] 	out;
	input[15:0]		in;
	output			c_out;

	
	
//WIRE DECLARATION
	wire[15:0]		neg_in;

//ALGORITHM

	assign neg_in = ~in;
	add_rca_16	M1(c_out, out,  neg_in, 16'b1, 1'b0 );


endmodule