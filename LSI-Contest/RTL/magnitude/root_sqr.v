module root_sqr(
input wire clk,
input wire [16:0] sqrx,
input wire [16:0] sqry,
output reg [10:0] magnitude
);

reg [16:0] m;
reg [16:0] res;
reg [16:0] bit;


always@(posedge clk)
begin
	m = sqrx + sqry;
	res = 0;
	bit = 1 << 14;
	
	while (bit > m)
		bit = bit >> 2;

	while (bit != 0)
	begin
		if (m >= res + bit)
		begin
			m = m - (res + bit);
			res = res + (bit << 1);
		end
		else
		begin
			res = res >> 1;
			bit = bit >> 2;
		end
	end
	magnitude <= res;
end

endmodule
	
		
		
	
	




