`timescale 1ns/1ns
module gyro(
input signed [15:0]	gyroData_x,
output reg signed [15:0]	x_gyro,
input wire		 clk,
input wire		 RST
);

//reg signed [15:0] x_gyro;
initial begin
x_gyro <= 16'd0;
end
//assign x_final = x_gyro;
always @ (posedge clk) begin


	if (gyroData_x[15]==1'b1) begin
		
		if (x_gyro >= (x_gyro - {8'd0,gyroData_x[7:0]})) begin
			 x_gyro <= x_gyro - {8'd0,gyroData_x[7:0]};
			end
		else begin
			 x_gyro <= 16'd360 - ({8'd0,gyroData_x[7:0]} - x_gyro);
			end
	
	end else begin
	if (x_gyro <= 16'd360) begin
	 x_gyro <= x_gyro + {8'd0,gyroData_x[7:0]};
	end else begin
	 x_gyro <= x_gyro - 16'd360;
	end
	end

end
endmodule
