
`define ROW_DIV 134
`define COL_DIV 70

module calculateScaleStep(
input wire [11:0]	rows,
input wire [11:0]    cols,
output reg [4:0]	step
);

reg [5:0] a;
reg [5:0] b;
reg [5:0] min;

always@ (rows or cols)
begin
  a = rows/`ROW_DIV;
  b = cols/`COL_DIV;
  if (a < b)
    min = a;
  else
    min = b;
    
    if (min>=1 && min <1.25)
        step <= 1;
    else if (min>=1.25 && min<1.56)
        step <= 2;
    else if (min>=1.56 && min<1.95)
        step <= 3;
    else if (min>=1.95 && min<2.44)
        step <= 4;
    else if (min>2.44 && min<3.05)
        step <= 5;
    else if (min>3.05 && min<3.81)
        step <= 6;
    else if (min>3.81 && min<4.77)
        step <= 7;
    else if (min>4.77 && min<5.96)
        step <= 8;
    else if (min>5.96 && min<7.46)
        step <= 9;
    else if (min>7.46 && min<9.33)
        step <= 10;
    else if (min>9.33 && min<11.66)
        step <= 11;
    else if (min>11.66 && min<14.58)
        step <= 12;
    else if (min>14.58 && min<18.23)
        step <= 13;
    else if (min>18.23 && min<22.79)
        step <= 14;
    else if (min>22.79 && min<28.5)
        step <= 15;
    else if (min>28.5 && min<35.63)
        step <= 16;
    else
        step <= 17;        
    end


endmodule

