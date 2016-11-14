`define XY_BITS    16
`define THETA_BITS 16
module CF(input wire clk,
  input wire rst,
input wire signed [15:0]	gyroData_x,

  input wire signed [`XY_BITS:0]    x_i,
  input wire signed [`XY_BITS:0]    y_i,
  input wire signed [`THETA_BITS:0] theta_i,
  
  output wire signed [`XY_BITS:0]    x_o,
  output wire signed [`XY_BITS:0]    y_o,
  output wire signed [`THETA_BITS:0] theta_o,
  output reg signed [15:0] x_final
  ,input wire valid_in, output wire valid_out,
output wire signed [15:0] x_gyro
);
wire slow_clk;
wire signed [15:0] x_temp;

cordic x_cc (
	.x_i(x_i),//164 == 10100100
	.y_i(y_i),//x and y format 1QN =>XX.XXXXXXXXXXXXXX
	.theta_o(theta_o),//out format 2QN =>XXX.XXXXXXXXXXXXX
	.valid_out(valid_out),
	.clk(clk),
	.rst(rst),
	.theta_i(theta_i),
	.x_o(x_o),
	.y_o(y_o),
	.valid_in(valid_in)

);

CF_slowclk slowclk (
			.clk(clk),
			.RST(rst),
			.slow_clk(slow_clk)
);

gyro x_gy (
.gyroData_x(gyroData_x),
.x_gyro(x_temp),
.clk(clk),
.RST(rst)

);

shift_reg all_regs 
(
  .d_in (x_temp),  // bus [127:0]
  .d_out (x_gyro), // bus [127:0]
  .clk (clk)
);

always @ (posedge clk) begin
x_final <= ((theta_o[15:0] >> 6) + (theta_o[15:0] >> 7) + (x_gyro[15:0] >> 1) +(x_gyro[15:0] >> 2)+(x_gyro[15:0] >> 3)+(x_gyro[15:0] >> 4)+(x_gyro[15:0] >> 5)+(x_gyro[15:0] >> 6));
end

endmodule
