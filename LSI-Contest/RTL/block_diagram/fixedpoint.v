
`define Mul 32'b111111000000000000000000000000
//`define CORDIC_1 17'd19896    

module fixedpoint (
  input wire clk,
  input wire [31:0]  a,
  input wire [31:0]  b,
  output reg [31:0] c
  );
  
reg [31:0] d;  

always @(posedge clk)
  begin
    d <= a + `Mul;
    c <= d;
  end

endmodule