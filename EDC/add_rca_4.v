module add_rca_4(c_out, sum, a, b, c_in);

//PORT DECLARATION
	output 			c_out;
	output[3:0]		sum;
	input[3:0]		a,b;
	input			c_in;

//WIRE DECLARATION
	wire c_in2, c_in3, c_in4;

//ALGORITHM
	add_full	M1(c_in2, sum[0], a[0], b[0], c_in);
	add_full	M2(c_in3, sum[1], a[1], b[1], c_in2);
	add_full	M3(c_in4, sum[2], a[2], b[2], c_in3);
	add_full	M4(c_out, sum[3], a[3], b[3], c_in4);

endmodule