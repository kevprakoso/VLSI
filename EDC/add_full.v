module add_full (c_out, sum, a, b, c_in);

//PORT DECLARATION
	output 		c_out, sum;
	input 		a,b,c_in;

//WIRE DECLARATION
	wire 		w1,w2,w3;

//ALGORITHM
	add_half 	M1(w2,w1,a,b);
	add_half 	M2(w3,sum,c_in,w1);
	or   		M3(c_out, w2, w3); 

endmodule