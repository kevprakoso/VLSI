module FIFO_I2C_Buffer(
	input  wire			clk,
	input  wire			reset,
	input  wire			enable,
	inout  wire			i2c_sda,
	output wire			i2c_scl,				
	output reg [15:0] 	accX,
	output reg [15:0] 	accY,
	output reg [15:0] 	accZ,
	output reg [15:0] 	gyroX,
	output reg [15:0] 	gyroY,
	output reg [15:0] 	gyroZ,
	output reg   		valid				
);

	localparam 	Addr_AccX_MSB = 6'h3B;
	localparam 	Addr_AccX_LSB = 6'h3C;
	localparam 	Addr_AccY_MSB = 6'h3D;
	localparam 	Addr_AccY_LSB = 6'h3E;
	localparam 	Addr_AccZ_MSB = 6'h3F;
	localparam 	Addr_AccZ_LSB = 6'h40;
	localparam 	Addr_GyroX_MSB = 6'h43;
	localparam 	Addr_GyroX_LSB = 6'h44;
	localparam 	Addr_GyroY_MSB = 6'h45;
	localparam 	Addr_GyroY_LSB = 6'h46;
	localparam 	Addr_GyroZ_MSB = 6'h47;
	localparam 	Addr_GyroZ_LSB = 6'h48;

	localparam	STATE_IDLE 				= 0;
	localparam	STATE_START 			= 1;
	localparam	STATE_READ_ACC_X_MSB 	= 2;
	localparam	STATE_READ_ACC_Y_MSB 	= 3;
	localparam	STATE_READ_ACC_Z_MSB 	= 4;
	localparam	STATE_READ_GYRO_X_MSB 	= 5;
	localparam	STATE_READ_GYRO_Y_MSB 	= 6;
	localparam	STATE_READ_GYRO_Z_MSB 	= 7;
	localparam	STATE_FINISH 			= 8;
	localparam	STATE_READ_ACC_X_LSB 	= 9;
	localparam	STATE_READ_ACC_Y_LSB 	= 10;
	localparam	STATE_READ_ACC_Z_LSB 	= 11;
	localparam	STATE_READ_GYRO_X_LSB 	= 12;
	localparam	STATE_READ_GYRO_Y_LSB 	= 13;
	localparam	STATE_READ_GYRO_Z_LSB 	= 14;
	localparam	STATE_STOP				= 15;

	reg [5:0]		state;
	reg 			start;
	reg [6:0]		addr;
	reg [7:0]		data;
	reg 			rw;
	reg 			stop;
	wire			data_out;
	wire 			ready;
	wire			fin_data;
	wire			i2c_clk;
	reg     		saved_accX;
	reg 			saved_accY;
	reg 			saved_accZ;
	reg     		saved_gyroX;
	reg 			saved_gyroY;
	reg 			saved_gyroZ;

clockdiv M1(
	.reset(reset),
	.clk_in(clk),
	.clk_out(i2c_clk)
);	

i2c_master	M5(
	.clk(i2c_clk), 
	.reset(reset),
	.start(start),
	.addr(addr),
	.data(data),
	.rw(rw),
	.stop(stop),
	.i2c_sda(i2c_sda),
	.data_out(data_out),
	.i2c_scl(i2c_scl),
	.ready(ready),
	.fin_data(fin_data)
);

always @(posedge clk)
begin
	if(reset==1)
	begin
		state <= STATE_IDLE;
		valid <= 0;
	end
	else begin

		case(state)
			STATE_IDLE:
			begin
				if(enable==1) 
				begin
					rw <= 0;
					stop <= 0;
					valid <= 0;
					state<=STATE_START;
				end
				else state <= STATE_IDLE;
			end

			STATE_START:
			begin
				if(ready) 
				begin
					start <= 1;
					addr <= Addr_AccX_MSB;	
					state <= STATE_READ_ACC_X_MSB;
					
				end
				else state <= STATE_START;
			end

			STATE_READ_ACC_X_MSB:
			begin
				if(fin_data == 1)
				begin
					saved_accX <= 16'h00 | (data_out<<8);					
					addr <= Addr_AccX_LSB;
					stop <= 1;
					state <= STATE_READ_ACC_X_LSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_ACC_X_LSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_accX <= saved_accX | data_out;					
					addr <= Addr_AccY_MSB;
					stop <= 1;
					state <= STATE_READ_ACC_Y_MSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_ACC_Y_MSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_accY <= 16'h00 | (data_out<<8);					
					addr <= Addr_AccY_LSB;
					stop <= 1;
					state <= STATE_READ_ACC_Y_LSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_ACC_Y_LSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_accY <= saved_accY | data_out;					
					addr <= Addr_AccZ_MSB;
					stop <= 1;
					state <= STATE_READ_ACC_Z_MSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_ACC_Z_MSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_accZ <= 16'h00 | (data_out<<8);					
					addr <= Addr_AccZ_LSB;
					stop <= 1;
					state <= STATE_READ_ACC_Z_LSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_ACC_Z_LSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_accZ <= saved_accZ | data_out;					
					addr <= Addr_GyroX_MSB;
					stop <= 1;
					state <= STATE_READ_GYRO_X_MSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

/////////////////////////////////////////////////////////////////////
			STATE_READ_GYRO_X_MSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_gyroX <= 16'h00 | (data_out<<8);					
					addr <= Addr_GyroX_LSB;
					stop <= 1;
					state <= STATE_READ_ACC_X_LSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_GYRO_X_LSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_gyroX <= saved_gyroX | data_out;					
					addr <= Addr_GyroY_MSB;
					stop <= 1;
					state <= STATE_READ_GYRO_Y_MSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_GYRO_Y_MSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_gyroY <= 16'h00 | (data_out<<8);					
					addr <= Addr_GyroY_LSB;
					stop <= 1;
					state <= STATE_READ_GYRO_Y_LSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_GYRO_Y_LSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_gyroY <= saved_gyroY | data_out;					
					addr <= Addr_GyroZ_MSB;
					stop <= 1;
					state <= STATE_READ_GYRO_Z_MSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_GYRO_Z_MSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_gyroZ <= 16'h00 | (data_out<<8);					
					addr <= Addr_GyroZ_LSB;
					stop <= 1;
					state <= STATE_READ_GYRO_Z_LSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_READ_GYRO_Z_LSB:
			begin
				stop <= 0;
				if(fin_data == 1)
				begin
					saved_gyroZ <= saved_gyroZ | data_out;
					stop <= 1;					
					state <= STATE_READ_GYRO_X_MSB;
				end
				else begin
					if(ready) state <= STATE_START;
				end	
			end

			STATE_STOP:
			begin
				valid <= 1;
				accX <= saved_accX;
				accY <= saved_accY;
				accZ <= saved_accZ;
				gyroX <= saved_gyroX;
				gyroY <= saved_gyroY;
				gyroZ <= saved_gyroZ;
				state <= STATE_IDLE;
			end
		endcase
	end
end


endmodule