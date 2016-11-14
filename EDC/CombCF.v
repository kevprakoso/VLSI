module CombCF(input wire clk,
  input wire rst,
input wire signed [15:0]	gyroData_x,
input wire signed [15:0]	gyroData_y,
input wire signed [15:0]	gyroData_z,
  input wire signed [`XY_BITS:0]    x_i,
  input wire signed [`XY_BITS:0]    y_i,
  input wire signed [`XY_BITS:0]    z_i,
  input wire signed [`THETA_BITS:0] theta_i,
  
  output wire signed [`XY_BITS:0]    x_o1,
  output wire signed [`XY_BITS:0]    y_o1,
  output wire signed [`XY_BITS:0]    x_o2,
  output wire signed [`XY_BITS:0]    y_o2,
  output wire signed [`XY_BITS:0]    x_o3,
  output wire signed [`XY_BITS:0]    y_o3,
  output wire signed [`THETA_BITS:0] theta_o1,
  output wire signed [`THETA_BITS:0] theta_o2,
  output wire signed [`THETA_BITS:0] theta_o3,
  output wire signed [15:0] x_final,
  output wire signed [15:0] y_final,
  output wire signed [15:0] z_final,
  input wire valid_in, 
  output wire valid_out1,
  output wire valid_out2,
  output wire valid_out3,
output wire signed [15:0] x_gyro,
output wire signed [15:0] y_gyro,
output wire signed [15:0] z_gyro
);


CF X_Comp(
.clk(clk),
.rst(rst),
.gyroData_x(gyroData_x),
.x_i(y_i),
.y_i(z_i),
.theta_i(theta_i),
.x_o(x_o1),
.y_o(y_o1),
.theta_o(theta_o1),
.x_final(x_final),
.valid_in(valid_in),
.valid_out(valid_out1),
.x_gyro(x_gyro)


);

CF Y_Comp(
.clk(clk),
.rst(rst),
.gyroData_x(gyroData_y),
.x_i(x_i),
.y_i(z_i),
.theta_i(theta_i),
.x_o(x_o2),
.y_o(y_o2),
.theta_o(theta_o2),
.x_final(y_final),
.valid_in(valid_in),
.valid_out(valid_out2),
.x_gyro(y_gyro)


);

CF Z_Comp(
.clk(clk),
.rst(rst),
.gyroData_x(gyroData_z),
.x_i(x_i),
.y_i(y_i),
.theta_i(theta_i),
.x_o(x_o3),
.y_o(y_o3),
.theta_o(theta_o3),
.x_final(z_final),
.valid_in(valid_in),
.valid_out(valid_out3),
.x_gyro(z_gyro)


);

endmodule