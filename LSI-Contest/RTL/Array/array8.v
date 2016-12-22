module array8 (
	input 			clk ,
	input 			reset,
	input 			en,
	input 			wr_en,
	input  [7:0] 	wr_data,
	input  [2:0]	wr_idx,
	input 			rd_en,
	input  [2:0]	rd_idx,
	output reg [7:0]	rd_data
);

	reg [7:0] buffer [0:7];
	reg 	  state;	
	reg	 	  i;

	localparam buff_0 = 236;
	localparam buff_1 = 175;
	localparam buff_2 = 85;
	localparam buff_3 = 13;
	localparam buff_4 = 120;
	localparam buff_5 = 46;
	localparam buff_6 = 13;
	localparam buff_7 = 99;

	localparam STATE_IDLE = 1;
	localparam STATE_ACTIVE = 0;

	always @(posedge clk)
	begin
		if(reset == 1 )
		begin
			rd_data <= 0;
			state <= STATE_IDLE;
		end
		else
		begin
			case(state)
				STATE_IDLE :
				begin
					if(en == 1 && reset == 0)
					begin
						buffer[0] <= buff_0[7:0];
						buffer[1] <= buff_1[7:0];
						buffer[2] <= buff_2[7:0];
						buffer[3] <= buff_3[7:0];
						buffer[4] <= buff_4[7:0];
						buffer[5] <= buff_5[7:0];
						buffer[6] <= buff_6[7:0];
						buffer[7] <= buff_7[7:0]; 
						state <= STATE_ACTIVE;
					end	
				end

				STATE_ACTIVE:
				begin
					if(wr_en == 1 && rd_en == 0)
					begin
						rd_data <= 0;	
						buffer[wr_idx] <= wr_data;	
					end
					else if(wr_en == 1 && rd_en == 1)
					begin
						rd_data <= buffer[rd_idx];	
						buffer[wr_idx] <= wr_data;
					end
					else if(wr_en == 0 && rd_en == 1)
					begin
						rd_data <= buffer[rd_idx];
					end
					else if(wr_en == 0 && rd_en == 0)
					begin
						rd_data <= 0;
					end
				end
			endcase

		end
	end

endmodule


