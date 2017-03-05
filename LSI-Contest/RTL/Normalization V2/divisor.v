module divisor(
input wire clk,
input wire [15:0] mag,
output reg [3:0] steps 
);

reg [4:0] i;
reg [5:0] j;
reg [15:0] buff;
reg cek;



always @(posedge clk)
begin
	buff = mag;	
	cek = 1;
	j = 0;
	for(i=15;i!=0;i=i-1)
	begin
		if(cek == 1)
		begin
			if(buff[i]==1)
			begin
				j = i + 1;
				cek = 0;
			end
		end
	end
	
	if(j==0)
		j = 1;
	
	
	steps <= j-1;

end

endmodule