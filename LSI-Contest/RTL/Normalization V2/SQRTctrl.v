// Example 24c: Square root control
module SQRTctrl (
input wire clk ,
input wire clr ,
input wire lteflg ,
input wire go ,
output reg ald ,
output reg sqld ,
output reg dld ,
output reg outld
);
reg[1:0] present_state, next_state;
parameter start = 2'b00, test =2'b01, update = 2'b10,
 done = 2'b11; // states

// State registers
always @(posedge clk or posedge clr)
 begin
 if (clr == 1)
 present_state <= start;
 else
 present_state <= next_state;
 end
// C1 module
always @(*)
 begin
 case(present_state)
 start: if(go == 1)
 next_state = test;
 else
 next_state = start;
 test: if(lteflg == 1)
 next_state = update;
 else
 next_state = done;
 update: next_state = test;
 done: next_state = done;
default next_state = start;
 endcase
 end 

 // C2 module
always @(*)
 begin
 ald = 0; sqld = 0;
 dld = 0; outld = 0;
 case(present_state)
 start: ald = 1;
 test: ;
 update:
 begin
 sqld = 1; dld = 1;
 end
 done: outld = 1;
 default ;
 endcase
 end

endmodule 