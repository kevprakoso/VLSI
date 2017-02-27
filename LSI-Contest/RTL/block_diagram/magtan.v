`define tan20 0.3640
`define tan40 0.8391
`define tan60 1.7321
`define tan80 5.6713

module magtan (
	 input clk,
	 input rst,
  	input wire [15:0] dx,
  	input wire [15:0] dy,
  	output reg [15:0] magnitude,
 	 output reg [3:0] tan
);


wire [15:0] mag;
reg [15:0] dx1, dy1;
reg [3:0] neg;
reg [25:0] dytan20;
reg [25:0] dytan40;
reg [25:0] dytan60;
reg [25:0] dytan80;
reg [25:0] dxshift7;
reg [27:0] dxshift10;


isqrt isqrt1(
		  .clk(clk),
		  .dx(dx),
		  .dy(dy),
		  .magnitude(mag)
		  );	  

always @(posedge clk)
begin
	
	dytan20 = (dy<<8) + (dy<<6) + (dy<<4) + (dy<<3) + (dy<<2) + (dy<<1) + dy;
	dytan40 = (dy<<7) + (dy<<4) + (dy<<3) + dy;
	dytan60 = (dy<<6) + (dy<<3) + (dy<<2);
	dytan80 = (dy<<7) + (dy<<5) + (dy<<4) + (dy<<2) + dy;
	dxshift7 = dx << 7;
	dxshift7 = dx << 10;
	
  if (rst == 1)
    begin
      magnitude <= 0;
      tan <=0;
    end
  else
    begin
   	if(dx[15] == 1'b1)
		  dx1 = ~dx;
		else 
		  dx1 = dx;
   	if(dy[15]== 1'b1)
		 dy1 = ~dy;
		else 
		  dy1 = dy;
	     magnitude <= mag;
		  
  end
  
	
	
	if (neg == 0)
	begin
		if (dytan20 < dxshift7)
		begin
			tan <= 4'b0000;
		end
		else
		if ((dytan20 > (dx<<7)) && (dytan40 < (dx<<7)))
		tan <= 4'b0001;
		else
		if ((dytan40 > (dx<<7)) && (dytan60 < (dx<<7)))
		tan <= 4'b0010;
		else
		if ((dytan60 > (dx<<7)) && (dytan80 < (dx<<10)))
		tan <= 4'b0011;
		else tan <= 4'b1000;
	end 
	else
	begin
		if (dytan20 < (dx<<7))
		tan <= 4'b0100;
		else
		if ((dytan20 > (dx<<7)) & (dytan40 < (dx<<7)))
		tan <= 4'b0101;
		else
		if ((dytan40 > (dx<<7)) & (dytan60 < (dx<<7)))
		tan <= 4'b0110;
		else
		if ((dytan60 > (dx<<7)) & (dytan80 < (dx<<10)))
		tan <= 4'b0111;
		else tan <= 4'b1000; 
	end    	
end

always @* 
begin
   	if(dx[15]==dy[15])
  		  neg <= 0;
		else 
		  neg <= 0;
end



endmodule

