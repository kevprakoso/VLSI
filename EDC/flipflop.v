module flipflop(Q, D, clk, reset, en);

//PORT DECLARATION
	output[15 : 0] 	Q;
	input[15 : 0] 	D;
	input clk,reset,en;

//WIRE DECLARATION
	
//REG DECLARATION
	reg [15 : 0] Q;

//ALGORITHM


	always @(posedge clk, posedge reset, negedge en)
	begin
		if (reset == 1'b1 || en == 1'b0)
			Q = 16'd0;
		else
			Q <= D;
	end
	
endmodule