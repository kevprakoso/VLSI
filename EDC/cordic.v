


// `define VALID_FLAG


// `define DEGREE_8_8
`define RADIAN_16


`define XY_BITS    16


`define THETA_BITS 16


`define ITERATIONS 16
`define ITERATION_BITS 4  // 2^ITERATION_BITS = ITERATIONS


//`define ITERATE
`define PIPELINE
//`define COMBINATORIAL


`define VECTOR     // computes the arctan and square root
// `define ROTATE    // computes sin cos



`define CORDIC_GAIN 17'd53955
`define CORDIC_1 17'd19896        // CORDIC inverse




`ifdef PIPELINE
`define GENERATE_LOOP
`endif
`ifdef COMBINATORIAL
`define GENERATE_LOOP
`endif



module signed_shifter (
  input wire [`ITERATION_BITS-1:0] i,
  input wire signed [`XY_BITS:0] D,
  output reg signed [`XY_BITS:0] Q );
  integer j;
  always @ * begin
    Q = D;
    for(j=0;j<i;j=j+1) Q = (Q >> 1) | (D[`XY_BITS] << `XY_BITS);
  end
endmodule

module rotator (
  input wire clk,
  input wire rst,
`ifdef ITERATE
  input wire init,
  input wire [`ITERATION_BITS:0] iteration,
  input wire signed [`THETA_BITS:0] tangle,
`endif
  input wire signed  [`XY_BITS:0]    x_i,
  input wire signed  [`XY_BITS:0]    y_i,
  input wire signed  [`THETA_BITS:0] z_i,
  output wire signed [`XY_BITS:0]    x_o,
  output wire signed [`XY_BITS:0]    y_o,
  output wire signed [`THETA_BITS:0] z_o
  );
  
`ifdef GENERATE_LOOP
  parameter integer iteration = 0;
  parameter signed [`THETA_BITS:0] tangle = 0;
`endif
  reg signed [`XY_BITS:0] x_1;
  reg signed [`XY_BITS:0] y_1;
  reg signed [`THETA_BITS:0] z_1;
  wire signed [`XY_BITS:0] x_i_shifted;
  wire signed [`XY_BITS:0] y_i_shifted;
  signed_shifter x_shifter(iteration,x_i,x_i_shifted);
  signed_shifter y_shifter(iteration,y_i,y_i_shifted);
`ifdef COMBINATORIAL
  always @ *
`endif
`ifdef ITERATE
  always @ (posedge clk)
`endif
`ifdef PIPELINE
  always @ (posedge clk)
`endif
    if (rst) begin
      x_1 <= 0;
      y_1 <= 0;
      z_1 <= 0;
    end else begin
`ifdef ITERATE
      if (init) begin
        x_1 <= x_i;
        y_1 <= y_i;
        z_1 <= z_i;
      end else
`endif
`ifdef ROTATE
      if (z_i < 0) begin
`endif
`ifdef VECTOR
      if (y_i > 0) begin
`endif
        x_1 <= x_i + y_i_shifted; //shifter(y_1,i); //(y_1 >> i);
        y_1 <= y_i - x_i_shifted; //shifter(x_1,i); //(x_1 >> i);
        z_1 <= z_i + tangle;
      end else begin
        x_1 <= x_i - y_i_shifted; //shifter(y_1,i); //(y_1 >> i);
        y_1 <= y_i + x_i_shifted; //shifter(x_1,i); //(x_1 >> i);
        z_1 <= z_i - tangle;
      end
    end
  assign x_o = x_1;
  assign y_o = y_1;
  assign z_o = z_1;
endmodule
/*                 
                     CORDIC
                     
*/
module cordic (
  input wire clk,
  input wire rst,
`ifdef ITERATE
  input wire init,
`endif
  input wire signed [`XY_BITS:0]    x_i,
  input wire signed [`XY_BITS:0]    y_i,
  input wire signed [`THETA_BITS:0] theta_i,
  
  output wire signed [`XY_BITS:0]    x_o,
  output wire signed [`XY_BITS:0]    y_o,
  output wire signed [`THETA_BITS:0] theta_o
`ifdef VALID_FLAG
  ,input wire valid_in, output wire valid_out
`endif  
);

`ifdef RADIAN_16
/*
  arctan table in radian format  16 bit + sign bit.
*/
function [`THETA_BITS:0] tanangle;
  input [3:0] i;
  begin
    case (i)
    4'b0000: tanangle = 17'd25735 ;   //  1/1
    4'b0001: tanangle = 17'd15192;    //  1/2
    4'b0010: tanangle = 17'd8027;     //  1/4
    4'b0011: tanangle = 17'd4075;     //  1/8
    4'b0100: tanangle = 17'd2045;     //  1/16
    4'b0101: tanangle = 17'd1024;     //  1/32
    4'b0110: tanangle = 17'd512;      //  1/64
    4'b0111: tanangle = 17'd256;      //  1/128
    4'b1000: tanangle = 17'd128;      //  1/256
    4'b1001: tanangle = 17'd64;       //  1/512
    4'b1010: tanangle = 17'd32;       //  1/1024
    4'b1011: tanangle = 17'd16;       //  1/2048
    4'b1100: tanangle = 17'd8;        //  1/4096
    4'b1101: tanangle = 17'd4;        //  1/8192
    4'b1110: tanangle = 17'd2;        //  1/16k
    4'b1111: tanangle = 17'd1;        //  1/32k
    endcase
  end
endfunction
`endif
`ifdef DEGREE_8_8
/*
   arctan table in degree U(8,8) format 16 bits + sign bit
*/
function [`THETA_BITS:0] tanangle;
  input [3:0] i;
  begin
    case (i)
    0: tanangle = 17'd11520;  // theta = 45.000000
    1: tanangle = 17'd6800;   // theta = 22.500000
    2: tanangle = 17'd3593;   // theta = 11.250000
    3: tanangle = 17'd1824;   // theta = 5.625000
    4: tanangle = 17'd915;    // theta = 2.812500
    5: tanangle = 17'd458;    // theta = 1.406250
    6: tanangle = 17'd229;    // theta = 0.703125
    7: tanangle = 17'd114;    // theta = 0.351562
    8: tanangle = 17'd57;     // theta = 0.175781
    9: tanangle = 17'd28;     // theta = 0.087891
    10: tanangle = 17'd14;    // theta = 0.043945
    11: tanangle = 17'd7;     // theta = 0.021973
    12: tanangle = 17'd3;     // theta = 0.010986
    13: tanangle = 17'd1;     // theta = 0.005493
    14: tanangle = 17'd0;     // theta = 0.002747
    15: tanangle = 17'd0;     // theta = 0.001373
    endcase
  end
endfunction
`endif

`ifdef GENERATE_LOOP
  wire signed [`XY_BITS:0] x [`ITERATIONS-1:0];
  wire signed [`XY_BITS:0] y [`ITERATIONS-1:0];
  wire signed [`THETA_BITS:0] z [`ITERATIONS-1:0];
  assign x[0] = x_i;
  assign y[0] = y_i;
  assign z[0] = theta_i;
  assign x_o = x[`ITERATIONS-1];
  assign y_o = y[`ITERATIONS-1];
  assign theta_o = z[`ITERATIONS-1];
`endif // GENERATE_LOOP

`ifdef VALID_FLAG
  wire [`ITERATIONS-1:0] v;
  assign valid_out v[`ITERATIONS-1];
always @ (posedge clk or posedge rst)
  if (rst) v <= 0;
  else begin
         v <= v << 1;
         v[0] <= valid_in;
       end
`endif

`ifdef GENERATE_LOOP
genvar i;
generate for(i=0;i<`ITERATIONS-1;i=i+1) begin
  rotator U (clk,rst,x[i],y[i],z[i],x[i+1],y[i+1],z[i+1]);
  defparam U.iteration = i;
  defparam U.tangle = tanangle(i);
end 
endgenerate
`endif

`ifdef ITERATE
  reg [`ITERATION_BITS:0] iteration;
  wire signed [`XY_BITS:0] x,y,z;
  assign x = init ? x_i : x_o;
  assign y = init ? y_i : y_o;
  assign z = init ? theta_i : theta_o;
  always @ (posedge clk or posedge init)
    if (init) iteration <= 0;
    else iteration <= iteration + 1;
  rotator U (clk,rst,init,iteration,tanangle(iteration),x,y,z,x_o,y_o,theta_o);
`endif
endmodule


