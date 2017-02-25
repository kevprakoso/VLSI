module root_sqr(
input wire clk,
input wire [16:0] sqrx,
input wire [16:0] sqry,
output reg [10:0] magnitude
);

reg [16:0] m;
reg [16:0] res;
reg [16:0] bit;
integer i = 0;

always@(posedge clk)
begin
	m = sqrx + sqry;
	res = 0;
	bit = 1 << 14;
	
	for (i = 0; i < 8; i = i + 1)
	begin
		if (bit > m)
			bit = bit >> 2;
	end

	
	for (i = 0; i < 8; i = i + 1)
	begin
		if (bit != 0)
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
	end
	magnitude <= res;
end

endmodule
	
		
		
	
	




