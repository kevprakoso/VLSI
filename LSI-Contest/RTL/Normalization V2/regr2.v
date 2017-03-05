// Example 24b: N-bit register with reset and load
// Resets to initial value of lowest 2 bits
module regr2
#(parameter N = 4,
parameter BIT0 = 1,
parameter BIT1 = 1)
(input wire load ,
input wire clk ,
input wire reset ,
input wire [N-1:0] d ,
output reg [N-1:0] q
);
always @(posedge clk or posedge reset)
if(reset == 1)
 begin
 q[N-1:2] <= 0;
 q[0] <= BIT0;
 q[1] <= BIT1;
 end
else if(load == 1)
 q <= d;
endmodule 