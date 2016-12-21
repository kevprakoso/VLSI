module magtan (
	input clk;
	input rst;
  	input wire [15:0] dx,
  	input wire [15:0] dy,
  	output reg [15:0] magnitude,
 	output reg [3:0] tan
);
real tan20, tan40, tan60, tan80;
tan20 = 0.3640; //=-tan160
tan40 = 0.8391; //=-tan140
tan60 = 1.7321; //=-tan120
tan80 = 5.6713; //=-tan100
reg[15:0] mag;
reg[15:0] dx1, dy1;
wire neg;
if (rst = 1)
begin
magnitude <= 0;
tan <=0;
end else
begin
  always @(posedge clk) begin
    	if(dx[15]='1')
		dx1 = ~dx;
		else dx1 = dx;
    	if(dy[15]='1')
		dy1 = ~dy;
		else dy1 = dy;
	mag = dx1 + dy1;
	 
  
  end
always @* begin
    	if(dx[15]=dy[15])
		neg <= 0;
		else neg <= 0;

  
  end
always @(posedge clk) begin
	if (neg = 0)begin
		if (dy < tan20*dx)
		tan = 4'b0000;
		else
		if ((dy > tan20*dx) & (dy < tan40*dx))
		tan = 4'b0001;
		else
		if ((dy > tan40*dx) & (dy < tan60*dx))
		tan = 4'b0010;
		else
		if ((dy > tan60*dx) & (dy < tan80*dx))
		tan = 4'b0011;
		else tan = 4'b1000;
	end else
	begin
		if (dy < tan20*dx)
		tan = 4'b0100;
		else
		if ((dy > tan20*dx) & (dy < tan40*dx))
		tan = 4'b0101;
		else
		if ((dy > tan40*dx) & (dy < tan60*dx))
		tan = 4'b0110;
		else
		if ((dy > tan60*dx) & (dy < tan80*dx))
		tan = 4'b0111;
		else tan = 4'b1000; 
	end    	
end

end
endmodule

