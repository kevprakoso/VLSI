`timescale 1ns / 1ps

module CF(gyroData_x,gyroData_y,gyroData_z,
			 x_accel_data,y_accel_data,z_accel_data,
			 clk,
			 RST,
			 x_final,y_final,z_final
    );
	 
input signed [19:0] gyroData_x,gyroData_y,gyroData_z;//read from gyro
input  [9:0] x_accel_data,y_accel_data,z_accel_data;//read from accelerometer
input RST;

output [15:0] x_final,y_final,z_final; //x_final=final degree of x axis

wire signed [19:0] gyroData_x,gyroData_y,gyroData_z;//gyro
wire  [9:0] x_accel_data,y_accel_data,z_accel_data;//acc, 10th bit sign, rest is magnitude
wire [15:0] x_out,y_out,z_out;//arctan results, internal
reg rdy_acc;

wire rdy_x,rdy_y,rdy_z;
reg signed [19:0] x_gyro1;
reg signed [19:0] x_gyro,y_gyro,z_gyro;//DEGREE from gyro,internal
reg [23:0] x_acc,y_acc,z_acc;//DEGREE from acc, internal
reg  [15:0] x_final,y_final,z_final;

wire slow_clk;


CF_slowclk slowclk (
			.clk(clk),
			.RST(RST),
			.slow_clk(slow_clk)
);



always @ (posedge slow_clk ) begin

	if (gyroData_x[19]==1'b1) begin
		if (x_gyro >= (x_gyro - gyroData_x[9:0])) begin
			x_gyro <= x_gyro - gyroData_x[9:0];
			end
		else begin
			x_gyro <= 20'd360 - (gyroData_x[9:0] - x_gyro);
			end
	
	end else begin
	if (x_gyro <= 20'd360) begin
	x_gyro <= x_gyro + gyroData_x[9:0];
	end else begin
	x_gyro <= x_gyro - 20'd360;
	end
	end

end

arctan x_cc (
	.x_in(({{y_accel_data[7:2],2'b00}*8'b10100100})>>1),//164 == 10100100
	.y_in(({{z_accel_data[7:2],2'b00}*8'b10100100})>>1),//x and y format 1QN =>XX.XXXXXXXXXXXXXX
	.phase_out(x_out),//out format 2QN =>XXX.XXXXXXXXXXXXX
	.rdy(rdy_x),
	.clk(slow_clk)
);

arctan y_cc (
	.x_in(({{z_accel_data[7:2],2'b00}*8'b10100100})>>1),//x and y format 1QN =>XX.XXXXXXXXXXXXXX
	.y_in(({{x_accel_data[7:2],2'b00}*8'b10100100})>>1),//
	.phase_out(y_out),//out format 2QN =>XXX.XXXXXXXXXXXXX
	.rdy(rdy_y),
	.clk(slow_clk)
);

arctan z_cc (
	.x_in(({{x_accel_data[7:2],2'b00}*8'b10100100})>>1),//x and y format 1QN =>XX.XXXXXXXXXXXXXX
	.y_in(({{y_accel_data[7:2],2'b00}*8'b10100100})>>1),//
	.phase_out(z_out),//out format 2QN =>XXX.XXXXXXXXXXXXX
	.rdy(rdy_z),
	.clk(slow_clk)
);

function reg inbetween(input [7:0] low, value, high); 
begin
  inbetween = value >= low && value <= high;
end
endfunction


always @ (posedge slow_clk) begin
	//Convert to 360 degree
//	if (rdy_x==1'b1 && rdy_y==1'b1 && rdy_z==1'b1) begin
	case (1)
				inbetween(0,x_out,11): x_acc<=16'd5;
				inbetween(12,x_out,22): x_acc<=16'd10;
				inbetween(22,x_out,33): x_acc<=16'd15;
				inbetween(33,x_out,44): x_acc<=16'd20;
				inbetween(44,x_out,55): x_acc<=16'd25;
				inbetween(55,x_out,66): x_acc<=16'd30;
				inbetween(66,x_out,44): x_acc<=16'd35;
				inbetween(77,x_out,88): x_acc<=16'd40;
				inbetween(88,x_out,99): x_acc<=16'd45;
				inbetween(99,x_out,111): x_acc<=16'd50;
				inbetween(111,x_out,122): x_acc<=16'd55;
				inbetween(122,x_out,133): x_acc<=16'd60;
				inbetween(133,x_out,144): x_acc<=16'd65;
				inbetween(144,x_out,155): x_acc<=16'd70;
				inbetween(155,x_out,166): x_acc<=16'd75;
				inbetween(166,x_out,177): x_acc<=16'd80;
				inbetween(177,x_out,188): x_acc<=16'd85;
				inbetween(188,x_out,201): x_acc<=16'd90;
				default:x_acc<=16'd0;
endcase
end
	
	always @ (posedge slow_clk) begin
	//Convert to 360 degree
//	if (rdy_x==1'b1 && rdy_y==1'b1 && rdy_z==1'b1) begin
	case (1)
				inbetween(0,y_out,11): y_acc<=16'd5;
				inbetween(12,y_out,22): y_acc<=16'd10;
				inbetween(22,y_out,33): y_acc<=16'd15;
				inbetween(33,y_out,44): y_acc<=16'd20;
				inbetween(44,y_out,55): y_acc<=16'd25;
				inbetween(55,y_out,66): y_acc<=16'd30;
				inbetween(66,y_out,44): y_acc<=16'd35;
				inbetween(77,y_out,88): y_acc<=16'd40;
				inbetween(88,y_out,99): y_acc<=16'd45;
				inbetween(99,y_out,111): y_acc<=16'd50;
				inbetween(111,y_out,122): y_acc<=16'd55;
				inbetween(122,y_out,133): y_acc<=16'd60;
				inbetween(133,y_out,144): y_acc<=16'd65;
				inbetween(144,y_out,155): y_acc<=16'd70;
				inbetween(155,y_out,166): y_acc<=16'd75;
				inbetween(166,y_out,177): y_acc<=16'd80;
				inbetween(177,y_out,188): y_acc<=16'd85;
				inbetween(188,y_out,201): y_acc<=16'd90;
				default:y_acc<=16'd0;
endcase
end

always @ (posedge slow_clk) begin
	//Convert to 360 degree
//	if (rdy_x==1'b1 && rdy_y==1'b1 && rdy_z==1'b1) begin
	case (1)
				inbetween(0,z_out,11): z_acc<=16'd5;
				inbetween(12,z_out,22): z_acc<=16'd10;
				inbetween(22,z_out,33): z_acc<=16'd15;
				inbetween(33,z_out,44): z_acc<=16'd20;
				inbetween(44,z_out,55): z_acc<=16'd25;
				inbetween(55,z_out,66): z_acc<=16'd30;
				inbetween(66,z_out,44): z_acc<=16'd35;
				inbetween(77,z_out,88): z_acc<=16'd40;
				inbetween(88,z_out,99): z_acc<=16'd45;
				inbetween(99,z_out,111): z_acc<=16'd50;
				inbetween(111,z_out,122): z_acc<=16'd55;
				inbetween(122,z_out,133): z_acc<=16'd60;
				inbetween(133,z_out,144): z_acc<=16'd65;
				inbetween(144,z_out,155): z_acc<=16'd70;
				inbetween(155,z_out,166): z_acc<=16'd75;
				inbetween(166,z_out,177): z_acc<=16'd80;
				inbetween(177,z_out,188): z_acc<=16'd85;
				inbetween(188,z_out,201): z_acc<=16'd90;
				default:z_acc<=16'd0;
endcase
end
	
	always @ (posedge clk) begin

	x_final <= x_accel_data[8:0];//
	y_final <= y_accel_data[8:0];// x/y/z_final=0.96875*gyro+0.03125*acc
	z_final <= z_accel_data[8:0];//


end


endmodule
