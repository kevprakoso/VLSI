module root_norm(
input wire clk,
input wire [16:0] sqra,
input wire [16:0] sqrb,
input wire [16:0] sqrc,
input wire [16:0] sqrd,
input wire [16:0] sqre,
input wire [16:0] sqrf,
input wire [16:0] sqrg,
input wire [16:0] sqrh,
input wire [16:0] sqri,
output reg [15:0] magnitude
);

reg [16:0] m;
reg [16:0] res;
reg [16:0] bit;


always@(posedge clk)
begin
	m = sqra + sqrb + sqrc + sqrd + sqre + sqrf + sqrg + sqrh + sqri;
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
	
		
		
	
	



