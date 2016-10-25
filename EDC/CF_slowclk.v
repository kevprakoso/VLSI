`timescale 1ns / 1ps

module CF_slowclk(
					clk,
					RST,
					slow_clk
    );

input clk, RST;
output slow_clk;

reg [25:0] count=26'b0;
reg slow_clk;


always @ (posedge clk or posedge RST)

	if (RST==1'b1) begin
	slow_clk <= 1'b0;
	count <= 26'b0;
	end else begin
		if (count==26'd10000000) begin
			slow_clk <= (~slow_clk);
			count <= 26'b0;
		end else begin
		count <= count +1'b1;
		end
	end

endmodule
