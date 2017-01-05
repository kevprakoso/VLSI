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
<<<<<<< HEAD
	array =  val;
       i=SIZE;
       while (i>0 && !array[i]) i=i-1;
	square = i;
=======
	 array[i] =  val;
       i = SIZE;
       while (i>0 && !array[i]) 
		 begin
			i = i-1;
			square <= i;
		 end
		 
>>>>>>> 19b7839044ae775fdbebce016009648f6e5899c3
    end
	 
always @*
begin
	div[1] <= array[i+1];
	div[0] <= array[i+2];
	square = i;
	valout = (val << i);
end

endmodule
