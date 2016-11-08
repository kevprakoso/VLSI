
module i2c_master(
	input wire 			clk, 
	input wire 			reset,
	input wire 			start,
	input wire [6:0] 	addr,
	input wire [7:0] 	data,
	input wire  		rw,
	input wire			stop,
	inout reg 			i2c_sda,
	output reg [7:0]	data_out,
	output wire 		i2c_scl,
	output wire 		ready,
	output reg         fin_data
);

	localparam STATE_IDLE = 0;
	localparam STATE_START = 1;
	localparam STATE_ADDR = 2;
	localparam STATE_RW = 3;
	localparam STATE_WACK = 4;
	localparam STATE_DATA = 5;
	localparam STATE_STOP = 6;
	localparam STATE_WACK2 = 7;

	assign i2c_scl = (i2c_scl_enable == 0) ? 1 : -clk;
	assign ready = ((reset==0)&&(state==STATE_IDLE)) ? 1 : 0;

	reg [4:0] state;
	reg [4:0] count;
	reg i2c_scl_enable;
	reg [6:0] saved_addr;
	reg [7:0] saved_data;
	reg saved_rw;
	reg ack;
	reg data_buff;

	always @(negedge clk)
	begin
		if (reset == 1) begin
			i2c_scl_enable <= 0;
		end
		else begin
			if(state == STATE_IDLE || state == STATE_START || state == STATE_STOP ) begin
				i2c_scl_enable <= 0;
			end
			else begin
				i2c_scl_enable <= 1;
			end
		end
	end


	always @(posedge clk)
	begin
		if(reset == 1)
		begin
			state <= 0;
			i2c_sda <= 1;
			count <= 5'd0;
		end
		else 
		begin
			if(stop) state <= STATE_IDLE;
			case(state)
				STATE_IDLE:
				begin
					i2c_sda <= 1;
					if(start) begin 
						state <= STATE_START;
						saved_addr <= addr;
						saved_data <= data;
						saved_rw <= rw;
						fin_data <= 0;
					end
					else state <= STATE_IDLE;
				end

				STATE_START:
				begin
					i2c_sda <= 0;
					state <= STATE_ADDR;
					count<= 6;
				end

				STATE_ADDR:
				begin
					i2c_sda <= saved_addr[count];
					if(count==0) state<=STATE_RW;
					else count<=count-1;
				end

				STATE_RW:
				begin
					i2c_sda <= saved_rw;
					state <= STATE_WACK;
				end

				STATE_WACK:
				begin
					ack <= i2c_sda;
					if(ack) begin
						state <= STATE_DATA;
						count <= 7;
					end
					else state <= STATE_STOP;
				end

				STATE_DATA:
				begin
					if(saved_rw) begin
						i2c_sda <= saved_data[count];
						if(count==0) state <= STATE_WACK2;
						else count <= count - 1;
					end
					else begin
						data_buff <= i2c_sda;
						if(count==0) state <= STATE_WACK2;
						else count <= count - 1;
					end 

				end		

				STATE_WACK2:
				begin
					ack <= i2c_sda;
					if(ack) begin
						if(rw==0) data_out <= data_buff;
						fin_data <= 1;
						state <= STATE_STOP;
					end
					else begin
						state <= STATE_STOP;
						fin_data <= 0;
					end
				end		

				STATE_STOP:
				begin
					i2c_sda <= 1;
					state <= STATE_IDLE; 
				end
			endcase
		end
	end

endmodule
