module det(
input wire clk,
input wire [9:0] val,
output reg [4:0] square,
output reg [1:0] div,
output reg [9:0] valout
);


parameter SIZE = 10;
reg array[SIZE-1:0];
integer i;
reg[4:0] temp;
always @(array)
    begin
	 array[i] =  val;
       i = SIZE;
       while (i>0 && !array[i]) 
		 begin
			i = i-1;
			square <= i;
		 end
		 
    end
	 
always @*
begin
	div[1] <= array[i+1];
	div[0] <= array[i+2];
	square = i;
	valout = (val << i);
end

endmodule
