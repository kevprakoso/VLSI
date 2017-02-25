module sqr(
input wire clk,
input wire [9:0] val,
output reg [16:0] square
);

reg [16:0] mask;
reg [16:0] factorsum;
reg [16:0] sum;
reg [16:0] temp;


always@(posedge clk)
begin
	mask = 1;
	factorsum = val;
	sum = 0;
	
	while ((val > mask) || (val == mask))
	begin
		if ((val & mask) == mask)
		  begin
			 sum = sum + factorsum;
			end
		factorsum = factorsum + factorsum;
		mask = mask + mask;
	end
	
end

always@*
begin
  if ((temp-sum)== 0)
	  begin
   	  square <= sum; 	  
 	    temp = sum;	   
 	  end 
 	else
   	temp = sum;
end
endmodule
	
		
