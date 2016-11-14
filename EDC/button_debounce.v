`timescale 1ns / 1ps

module button_debounce(
    input i_clk,
    input i_button,
    output o_button_state
    );
    parameter IS_ACTIVE_LEVEL = 1'b1;

	// Frequency of i_clk in Hz 
	// default: 100 MHz = 100000000 Hz
	parameter  P_CLK_FREQ = 100000000;

   reg button_state;
   reg clk_slow;
   reg [19:0] clk_counter = 1;

	// Convert input clock to 200 Hz clock 
	always @(posedge i_clk)
	begin
		if (clk_counter < (P_CLK_FREQ/(2*500))) begin
			clk_counter <= clk_counter+{19'b0, 1'b1};
		end else begin 
			clk_counter <= 1;
			clk_slow    <= ~clk_slow;
		end
	end
   
   // Sample push button
   always @(posedge clk_slow)
   begin
      button_state <= i_button;
   end

   assign o_button_state = button_state;

endmodule