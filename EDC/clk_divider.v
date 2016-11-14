`timescale 1ns / 1ps

module clk_divider(
    input  i_clk,
    output o_clk
    );
    
   parameter P_DIV_FACTOR = 4;

   reg [27:0] clk_counter = 1;
   reg        tmp_clk = 0;

	// Convert 100 MHz input clock to 25MHz clock for display 
	always @(posedge i_clk)
	begin
      if (clk_counter < (P_DIV_FACTOR/2)) begin
			clk_counter <= clk_counter+{26'b0, 1'b1};
		end else begin 
			clk_counter <= 1;
			tmp_clk     <= ~tmp_clk;
		end
	end
   
   assign o_clk = tmp_clk;

endmodule

