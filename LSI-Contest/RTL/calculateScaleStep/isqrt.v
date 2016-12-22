module isqrt(
input wire clk,
input wire [7:0] dx,
input wire [7:0] dy,
output reg [7:0] magnitude
)

reg [15:0] m;
reg [15:0] res;
reg [15:0] bit;
reg [15:0] temp;

always@(posedge clk)
begin
	m = (dx*dx) + (dy*dy);
	res = 0;
	bit = 1 << 14;
	
	while (bit > num)
		bit = bit >> 2;
		
	while (bit != 0)
	begin
		if (num >= res + bit)
		begin
			num = num - res + bit;
			res = (res >> 1) + bit;
		end
		else
		begin
			res = res >> 1;
			bit = bit >> 2;
		end
	end
	magnitude <= m;
end

endmodule
	
		
		
	
	