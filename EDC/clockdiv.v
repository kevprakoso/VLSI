module clockdiv(
	input wire reset,
	input wire clk_in,
	output reg clk_out
);

	parameter RATIO = 1000;
	reg count;

	always @(posedge clk_in)
	begin
		if(reset==0) begin
			clk_out <= 0;
			count <=0;
		end 
		else begin
			if(count==RATIO/2) begin
				clk_out <= - clk_out;
				count <= 0;
			end
			else begin
				count = count + 1;
			end
		end
	end
endmodule