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
	
	if (m < 2)
	begin
		 //for (i = 0; i < 9; i++)
			  if (bit >= m)
					bit = bit >> 18;
	end
	else if (m >= 2 && m < 4)
	begin
		 //for (i = 0; i < 8; i++)
			  if (bit >= m)
					bit = bit >> 16;
	end
	else if (m >= 4 && m < 16)
	begin
		 //for (i = 0; i < 7; i++)
			  if (bit >= m)
					bit = bit >> 14;
	end
	else if (m >= 16 && m < 64)
	begin
		 //for (i = 0; i < 6; i++)
			  if (bit >= m)
					bit = bit >> 12;
	end
	else if (m >= 64 && m < 256)
	begin
		 //for (i = 0; i < 5; i++)
			  if (bit >= m)
					bit = bit >> 10;
	end
	else if (m >= 256 && m < 1024)
	begin
		// for (i = 0; i < 4; i++)
			  if (bit >= m)
					bit = bit >> 8;
	end
	else if (m >= 1024 && m < 4096)
	begin
		 //for (i = 0; i < 3; i++)
			  if (bit >= m)
					bit = bit >> 6;
	end
	else if (m >= 4096 && m < 16384)
	begin
		 //for (i = 0; i < 2; i++)
			  if (bit >= m)
					bit = bit >> 4;
	end
	else
		 if (bit >= m)
			  bit = bit >> 2;

	
	for (i = 0; i < 17; i = i + 1)
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
	
		
		
	
	




