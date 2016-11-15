module FIFO_I2C_Buffer(
	input  wire			clk,
	input  wire			reset,
	input  wire			enable,
	inout  wire			i2c_sda,
	output wire			i2c_scl,				
	output wire [15:0] 	accX,
	output wire [15:0] 	accY,
	output wire [15:0] 	accZ,
	output wire [15:0] 	gyroX,
	output wire [15:0] 	gyroY,
	output wire [15:0] 	gyroZ,
	output wire   		valid,	
	output wire [5:0]  stateout			
);

	localparam 	Addr_AccX_MSB = 7'h3B;
	localparam 	Addr_AccX_LSB = 7'h3C;
	localparam 	Addr_AccY_MSB = 7'h3D;
	localparam 	Addr_AccY_LSB = 7'h3E;
	localparam 	Addr_AccZ_MSB = 7'h3F;
	localparam 	Addr_AccZ_LSB = 7'h40;
	localparam 	Addr_GyroX_MSB = 7'h43;
	localparam 	Addr_GyroX_LSB = 7'h44;
	localparam 	Addr_GyroY_MSB = 7'h45;
	localparam 	Addr_GyroY_LSB = 7'h46;
	localparam 	Addr_GyroZ_MSB = 7'h47;
	localparam 	Addr_GyroZ_LSB = 7'h48;
	localparam  Addr_MPU_Init  = 7'h6b;

	localparam Data_Write_Init = 8'h00;

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


	reg [15:0]  	saved_accX;
	reg [15:0]		saved_accY;
	reg [15:0]		saved_accZ;
	reg [15:0]    	saved_gyroX;
	reg [15:0]		saved_gyroY;
	reg [15:0]		saved_gyroZ;
	
	reg [15:0]  	FaccX;
	reg [15:0]		FaccY;
	reg [15:0]		FaccZ;
	reg [15:0]    	FgyroX;
	reg [15:0]		FgyroY;
	reg [15:0]		FgyroZ;

	reg 		trig;
	reg 		rw;
	reg [7:0]	DataIn;
	reg [7:0]	AddressIn;
	reg 		ack;
	reg [7:0]	DataOut;
	reg [7:0]	StateOut;
	reg [7:0]	AddressOut;
	reg 		scl;
	reg 		sda;
	reg 		val;
	reg [5:0]	state;

	I2C_controller M1(
		.CLK_50_MHz(clk), 
		.ResetN(trig),
		.SCL(scl),
		.SDA(sda),
		.Read_WriteN(rw),
		.DataIn(DataIn), 
		.AddressIn(AddressIn),
		.Ack(ack),
		.DataOut(DataOut),
		.StateOut(StateOut),
		.RegisterAddressOut(AddressOut)
	);

	assign i2c_sda = sda;
	assign i2c_scl = scl;
	assign valid = val;
	assign accX = FaccX;
	assign accY = FaccY; 
	assign accZ = FaccZ;
	assign gyroX = FgyroX;
	assign gyroY = FgyroY;
	assign gyroZ = FgyroZ;
	assign stateout = state;

always @(posedge clk)
begin
	if(reset == 1 || enable == 0)
	begin
		trig <= 0;
		state <= STATE_IDLE;
		AddressIn <= 8'h00;
		val <= 0;
	end

	case(state)
		STATE_IDLE:
		begin
			if(!(enable == 1 && reset == 0))
			begin 
				state <= STATE_IDLE;
			end
			else begin
				state <= STATE_START;
				AddressIn <= Addr_MPU_Init;
				DataIn <= Data_Write_Init;
				trig <= 0;
				rw <= 0;
				val <= 0;
			end
		end

		STATE_START :
		begin
			trig <= 1;
			if(ack == 0)
			begin
				state <= STATE_READ_ACC_X_MSB;
				rw <= 0;
				trig <= 0;
			end
			else begin
				state <= STATE_IDLE;
			end
		end

		//READ ACC X

		STATE_READ_ACC_X_MSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_ACC_X_LSB;
				saved_accX <= 16'h00 | (DataOut << 8);
				trig <= 0;
				AddressIn <= Addr_AccX_LSB;

			end
			else begin
				state <= STATE_IDLE;
			end
		end

		STATE_READ_ACC_X_LSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_ACC_Y_MSB;
				saved_accX <= saved_accX | DataOut;
				trig <= 0;
				AddressIn <= Addr_AccY_MSB;
			end
			else begin
				state <= STATE_IDLE;
			end
		end		

		//READ ACC Y

		STATE_READ_ACC_Y_MSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_ACC_Y_LSB;
				saved_accY <= 16'h00 | (DataOut << 8);
				trig <= 0;
				AddressIn <= Addr_AccY_LSB;

			end
			else begin
				state <= STATE_IDLE;
			end
		end

		STATE_READ_ACC_Y_LSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_ACC_Z_MSB;
				saved_accY <= saved_accY | DataOut;
				trig <= 0;
				AddressIn <= Addr_AccZ_MSB;
			end
			else begin
				state <= STATE_IDLE;
			end
		end		

		//READ ACC Z

		STATE_READ_ACC_Z_MSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_ACC_Z_LSB;
				saved_accZ <= 16'h00 | (DataOut << 8);
				trig <= 0;
				AddressIn <= Addr_AccZ_LSB;

			end
			else begin
				state <= STATE_IDLE;
			end
		end

		STATE_READ_ACC_Z_LSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_GYRO_X_MSB;
				saved_accZ <= saved_accZ | DataOut;
				trig <= 0;
				AddressIn <= Addr_GyroX_MSB;
			end
			else begin
				state <= STATE_IDLE;
			end
		end		


		//READ GYRO X

		STATE_READ_GYRO_X_MSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_GYRO_X_LSB;
				saved_gyroX <= 16'h00 | (DataOut << 8);
				trig <= 0;
				AddressIn <= Addr_GyroX_LSB;

			end
			else begin
				state <= STATE_IDLE;
			end
		end

		STATE_READ_GYRO_X_LSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_GYRO_Y_MSB;
				saved_gyroX <= saved_gyroX | DataOut;
				trig <= 0;
				AddressIn <= Addr_GyroY_MSB;
			end
			else begin
				state <= STATE_IDLE;
			end
		end		

		//READ GYRO Y

		STATE_READ_GYRO_Y_MSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_GYRO_Y_LSB;
				saved_gyroY <= 16'h00 | (DataOut << 8);
				trig <= 0;
				AddressIn <= Addr_GyroY_LSB;

			end
			else begin
				state <= STATE_IDLE;
			end
		end

		STATE_READ_GYRO_Y_LSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_GYRO_Z_MSB;
				saved_gyroY <= saved_gyroY | DataOut;
				trig <= 0;
				AddressIn <= Addr_GyroZ_MSB;
			end
			else begin
				state <= STATE_IDLE;
			end
		end		

		//READ GYRO Z

		STATE_READ_GYRO_Z_MSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_READ_GYRO_Z_LSB;
				saved_gyroZ <= 16'h00 | (DataOut << 8);
				trig <= 0;
				AddressIn <= Addr_GyroZ_LSB;

			end
			else begin
				state <= STATE_IDLE;
			end
		end

		STATE_READ_GYRO_Z_LSB:
		begin
			trig <= 1;

			if(ack == 0 )
			begin
				state <= STATE_FINISH;
				saved_gyroZ <= saved_gyroZ | DataOut;
				trig <= 0;
				AddressIn <= Addr_AccX_MSB;
			end
			else begin
				state <= STATE_IDLE;
			end
		end		

		STATE_FINISH:
		begin
			val <= 1;
			FaccX <= saved_accX;
			FaccY <= saved_accY;
			FaccZ <= saved_accZ;
			FgyroX <= saved_gyroX;
			FgyroY <= saved_gyroY;
			FgyroZ <= saved_gyroZ;
			
			state <= STATE_READ_ACC_X_MSB;
		end
	endcase
end

endmodule