module det(
input wire clk,
input wire [9:0] val,
output wire [4:0] square,
output wire [1:0] div,
output [9:0] valout
);


parameter SIZE = 10;
reg array[SIZE-1:0];
integer i;
always @(array); 
    begin
	array =  val
       i=SIZE;
       while (i>0 && !array[i]) i=i-1;
	square = i;
    end
div[1] = array[i+1];
div[0] = array[i+2];
square = i;
valout = (val << i)
endmodule
