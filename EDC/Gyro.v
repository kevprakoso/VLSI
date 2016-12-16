module gyro(raw_gyro, raw_data, clk, reset, en);

//PORT DECLARATION
	output [15 : 0 ] raw_gyro;
	input  [ 15 : 0] raw_data;
	input clk, reset, en;	

//REG DECLARATION
	

//WIRE DECLARATION
	wire [15 : 0] acc_out;
	wire c_out;
	wire [15 : 0] data_in;

//ALGORITHM
	add_rca_16	M1(c_out, acc_out,  raw_data, data_in, 1'b0 );
	flipflop	M2(data_in, raw_gyro, clk, reset, en);
	flipflop	M3(raw_gyro, acc_out, clk, reset, en);

endmodule