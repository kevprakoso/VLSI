module FIFO_I2C_Buffer(
	input  wire			CLK_50_MHz,
	input  wire			ResetN,
	inout  wire			SDA,
	output wire			SCL,				
	output wire [7:0] 	DataOut,
	output wire [7:0] 	DataOut2,
	output wire [7:0] 	DataOut3,
	output wire   		Ack,	
	output wire [7:0]  StateOut,	
	input  [7:0] AddressIn,
	input  [7:0] DataIn,
	input Read_WriteN,
	output wire [7:0] RegisterAddressOut
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

wire slow_clk;
wire reset;
reg [7:0]  	saved_accX;
reg [7:0]  	saved_accY;
reg [7:0]  	saved_accZ;
reg [7:0]  	saved_accXa;
reg [7:0]  	saved_accYa;
reg [7:0]  	saved_accZa;
reg [7:0]  	saved_gyX;
reg [7:0]  	saved_gyY;
reg [7:0]  	saved_gyZ;
reg [7:0]  	saved_gyXa;
reg [7:0]  	saved_gyYa;
reg [7:0]  	saved_gyZa;
wire trig;
reg [3:0]	state;
reg [6:0] adress_msb_x;
reg [7:0] data_buffer;
reg trigger;
wire [7:0] datainput;
reg [7:0] datainputbuffer;

assign datainput = datainputbuffer;
assign trig =trigger;
assign DataOut = saved_accXa;
assign DataOut2 = saved_accYa;
assign DataOut3 = saved_accZa;
assign reset = 0;
	I2C_controller M1(
		.CLK_50_MHz(CLK_50_MHz), 
		.ResetN(ResetN),
		.SCL(SCL),
		.SDA(SDA),
		.Read_WriteN(trig),
		.DataIn(DataIn), 
		.AddressIn(adress_msb_x),
		.Ack(Ack),
		.DataOut(data_buffer),
		.StateOut(StateOut),
		.RegisterAddressOut(RegisterAddressOut)
	);

clockdiv c1(
.clk(CLK_50_MHz),
.RST(reset),
.slow_clk(slow_clk)

);


always @(posedge slow_clk)

begin
	if(ResetN == 1 || Read_WriteN == 0)
	begin

		state <= STATE_IDLE;
		trigger <= 1;
	end
	case(state)
		STATE_IDLE:
		begin
			 begin
				state <= STATE_START;
				adress_msb_x <= Addr_MPU_Init;
				datainputbuffer <= Data_Write_Init;
				trigger <= 0;
				
			end
		end

		STATE_START :
		begin
			
			
			begin
				state <= STATE_READ_ACC_X_MSB;
				adress_msb_x <= Addr_AccX_MSB;
				saved_accX <= data_buffer;
				trigger <= 1;
				
			end
			
			end
			
		STATE_READ_ACC_X_MSB:
		begin
			
			
			begin
				state <= STATE_READ_ACC_Y_MSB;
				adress_msb_x <= Addr_AccY_MSB;
				saved_accY <= data_buffer;
				trigger <= 1;
				
			end
			
			end
		STATE_READ_ACC_Y_MSB:	
		begin
			
			
			begin
				state <= STATE_READ_ACC_Z_MSB;
				adress_msb_x <= Addr_AccZ_MSB;
				saved_accZ <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_ACC_Z_MSB:
		begin
			
			
			begin
				state <= STATE_READ_GYRO_X_MSB;
				adress_msb_x <= Addr_AccZ_LSB;
				saved_accZa <= data_buffer;
				trigger <= 1;
				
		end
			
		end
	
		STATE_READ_GYRO_X_MSB:
		begin
			
			
			begin
				state <= STATE_READ_GYRO_Y_MSB;
				adress_msb_x <= Addr_AccY_LSB;
				saved_accYa <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_GYRO_Y_MSB:
		begin
			
			
			begin
				state <= STATE_READ_GYRO_Z_MSB;
				adress_msb_x <= Addr_AccX_LSB;
				saved_accXa <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_GYRO_Z_MSB:
		begin
			
			
			begin
				state <= STATE_READ_ACC_X_LSB;
				adress_msb_x <= Addr_GyroX_MSB;
				saved_gyX <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_ACC_X_LSB:
		begin
			
			
			begin
				state <= STATE_READ_ACC_Y_LSB;
				adress_msb_x <= Addr_GyroX_LSB;
				saved_gyXa <= data_buffer;
				trigger <= 1;
				
		end
			
		end
	
		STATE_READ_ACC_Y_LSB:
		begin
			
			
			begin
				state <= STATE_READ_ACC_Z_LSB;
				adress_msb_x <= Addr_GyroY_MSB;
				saved_gyY <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_ACC_Z_LSB:
		
		begin
			
			
			begin
				state <= STATE_READ_GYRO_X_LSB;
				adress_msb_x <= Addr_GyroY_LSB;
				saved_gyYa <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_GYRO_X_LSB:
		
		begin
			
			
			begin
				state <= STATE_READ_GYRO_Y_LSB;
				adress_msb_x <= Addr_GyroZ_MSB;
				saved_gyZ <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
		STATE_READ_GYRO_Y_LSB:
		
		begin
			
			
			begin
				state <= STATE_START;
				adress_msb_x <= Addr_GyroZ_LSB;
				saved_gyZa <= data_buffer;
				trigger <= 1;
				
		end
			
		end
		
endcase
end
		
endmodule
