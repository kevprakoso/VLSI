module add_rca_16(c_out, sum, a, b, c_in);

//PORT DECLARATION
	output 			c_out;
	output[15:0]	sum;
	input			c_in;
	input[15:0]		a,b;

//WIRE DECLARATION
	wire 			c_in4, c_in8, c_in12, c_out;

//ALGORITHM
	add_rca_4 		M1(c_in4, sum[3:0], a[3:0], b[3:0], c_in);
	add_rca_4 		M2(c_in8, sum[7:4], a[7:4], b[7:4], c_in4);
	add_rca_4 		M3(c_in12, sum[11:8], a[11:8], b[11:8], c_in8);
	add_rca_4 		M4(c_out, sum[15:12], a[15:12], b[15:12], c_in12); 


endmodule