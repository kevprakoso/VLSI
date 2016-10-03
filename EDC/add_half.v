module add_half(c_out, sum, a,b);
// PORT DECLARATION
	output sum, c_out;
	input a,b;

// ALGORITHM
	xor		M1(sum, a, b);
	and		M2( c_out, a, b);
	
endmodule