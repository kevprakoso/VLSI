module Normalize(
input wire clk,
input wire [9:0] d_1,
input wire [9:0] d_2,
input wire [9:0] d_3,
input wire [9:0] d_4, 
input wire [9:0] d_5,
input wire [9:0] d_6,
input wire [9:0] d_7, 
input wire [9:0] d_8,
input wire [9:0] d_9,
input wire [9:0] d_10,
input wire [9:0] d_11,
input wire [9:0] d_12,
input wire [9:0] d_13, 
input wire [9:0] d_14,
input wire [9:0] d_15,
input wire [9:0] d_16, 
input wire [9:0] d_17,
input wire [9:0] d_18,
input wire [9:0] d_19,
input wire [9:0] d_20,
input wire [9:0] d_21,
input wire [9:0] d_22, 
input wire [9:0] d_23,
input wire [9:0] d_24,
input wire [9:0] d_25, 
input wire [9:0] d_26,
input wire [9:0] d_27,
input wire [9:0] d_28,
input wire [9:0] d_29,
input wire [9:0] d_30,
input wire [9:0] d_31, 
input wire [9:0] d_32,
input wire [9:0] d_33,
input wire [9:0] d_34, 
input wire [9:0] d_35,
input wire [9:0] d_36, 
output reg [15:0] o_1,
output reg [15:0] o_2,
output reg [15:0] o_3,
output reg [15:0] o_4, 
output reg [15:0] o_5,
output reg [15:0] o_6,
output reg [15:0] o_7, 
output reg [15:0] o_8,
output reg [15:0] o_9,
output reg [15:0] o_10,
output reg [15:0] o_11,
output reg [15:0] o_12,
output reg [15:0] o_13, 
output reg [15:0] o_14,
output reg [15:0] o_15,
output reg [15:0] o_16, 
output reg [15:0] o_17,
output reg [15:0] o_18,
output reg [15:0] o_19,
output reg [15:0] o_20,
output reg [15:0] o_21,
output reg [15:0] o_22, 
output reg [15:0] o_23,
output reg [15:0] o_24,
output reg [15:0] o_25, 
output reg [15:0] o_26,
output reg [15:0] o_27,
output reg [15:0] o_28,
output reg [15:0] o_29,
output reg [15:0] o_30,
output reg [15:0] o_31, 
output reg [15:0] o_32,
output reg [15:0] o_33,
output reg [15:0] o_34, 
output reg [15:0] o_35,
output reg [15:0] o_36

);
/*
reg [15:0] o_1,o_2,o_3,o_4,o_5,o_6,o_7,o_8,o_9,
			o_10,o_11,o_12,o_13,o_14,o_15,o_16,o_17,o_18,
			o_19,o_20,o_21,o_22,o_23,o_24,o_25,o_26,o_27,
			o_28,o_29,o_30,o_31,o_32,o_33,o_34,o_35,o_36;
*/
wire [16:0] sqr_1,sqr_2,sqr_3,sqr_4,sqr_5,sqr_6,sqr_7,sqr_8,sqr_9,
			sqr_10,sqr_11,sqr_12,sqr_13,sqr_14,sqr_15,sqr_16,sqr_17,sqr_18,
			sqr_19,sqr_20,sqr_21,sqr_22,sqr_23,sqr_24,sqr_25,sqr_26,sqr_27,
			sqr_28,sqr_29,sqr_30,sqr_31,sqr_32,sqr_33,sqr_34,sqr_35,sqr_36;

wire [15:0] mags;
reg [3:0] step;

reg [4:0] i;
reg [5:0] j;
reg [15:0] buff;
reg cek;
/*
wire [16:0] m,m1,m2,m3,m4;
wire done;
wire [9:0] root;
*/

sqr sqr1(
.clk(clk),
.val(d_1),
.square(sqr_1)
);

sqr sqr2(
.clk(clk),
.val(d_2),
.square(sqr_2)
);

sqr sqr3(
.clk(clk),
.val(d_3),
.square(sqr_3)
);

sqr sqr4(
.clk(clk),
.val(d_4),
.square(sqr_4)
);

sqr sqr5(
.clk(clk),
.val(d_5),
.square(sqr_5)
);

sqr sqr6(
.clk(clk),
.val(d_6),
.square(sqr_6)
);

sqr sqr7(
.clk(clk),
.val(d_7),
.square(sqr_7)
);

sqr sqr8(
.clk(clk),
.val(d_8),
.square(sqr_8)
);

sqr sqr9(
.clk(clk),
.val(d_9),
.square(sqr_9)
);

sqr sqr10(
.clk(clk),
.val(d_10),
.square(sqr_10)
);

sqr sqr11(
.clk(clk),
.val(d_11),
.square(sqr_11)
);

sqr sqr12(
.clk(clk),
.val(d_12),
.square(sqr_12)
);

sqr sqr13(
.clk(clk),
.val(d_13),
.square(sqr_13)
);

sqr sqr14(
.clk(clk),
.val(d_14),
.square(sqr_14)
);

sqr sqr15(
.clk(clk),
.val(d_15),
.square(sqr_15)
);

sqr sqr16(
.clk(clk),
.val(d_16),
.square(sqr_16)
);

sqr sqr17(
.clk(clk),
.val(d_17),
.square(sqr_17)
);

sqr sqr18(
.clk(clk),
.val(d_18),
.square(sqr_18)
);

sqr sqr19(
.clk(clk),
.val(d_19),
.square(sqr_19)
);

sqr sqr20(
.clk(clk),
.val(d_20),
.square(sqr_20)
);

sqr sqr21(
.clk(clk),
.val(d_21),
.square(sqr_21)
);

sqr sqr22(
.clk(clk),
.val(d_22),
.square(sqr_22)
);

sqr sqr23(
.clk(clk),
.val(d_23),
.square(sqr_23)
);

sqr sqr24(
.clk(clk),
.val(d_24),
.square(sqr_24)
);

sqr sqr25(
.clk(clk),
.val(d_25),
.square(sqr_25)
);

sqr sqr26(
.clk(clk),
.val(d_26),
.square(sqr_26)
);

sqr sqr27(
.clk(clk),
.val(d_27),
.square(sqr_27)
);

sqr sqr28(
.clk(clk),
.val(d_28),
.square(sqr_28)
);

sqr sqr29(
.clk(clk),
.val(d_29),
.square(sqr_29)
);

sqr sqr30(
.clk(clk),
.val(d_30),
.square(sqr_30)
);

sqr sqr31(
.clk(clk),
.val(d_31),
.square(sqr_31)
);

sqr sqr32(
.clk(clk),
.val(d_32),
.square(sqr_32)
);

sqr sqr33(
.clk(clk),
.val(d_33),
.square(sqr_33)
);

sqr sqr34(
.clk(clk),
.val(d_34),
.square(sqr_34)
);

sqr sqr35(
.clk(clk),
.val(d_35),
.square(sqr_35)
);

sqr sqr36(
.clk(clk),
.val(d_36),
.square(sqr_36)
);


mag magnitude(
.clk(clk),
.sqr_1(sqr_1),
.sqr_2(sqr_2),
.sqr_3(sqr_3),
.sqr_4(sqr_4),
.sqr_5(sqr_5),
.sqr_6(sqr_6),
.sqr_7(sqr_7),
.sqr_8(sqr_8),
.sqr_9(sqr_9),
.sqr_10(sqr_10),
.sqr_11(sqr_11),
.sqr_12(sqr_12),
.sqr_13(sqr_13),
.sqr_14(sqr_14),
.sqr_15(sqr_15),
.sqr_16(sqr_16),
.sqr_17(sqr_17),
.sqr_18(sqr_18),
.sqr_19(sqr_19),
.sqr_20(sqr_20),
.sqr_21(sqr_21),
.sqr_22(sqr_22),
.sqr_23(sqr_23),
.sqr_24(sqr_24),
.sqr_25(sqr_25),
.sqr_26(sqr_26),
.sqr_27(sqr_27),
.sqr_28(sqr_28),
.sqr_29(sqr_29),
.sqr_30(sqr_30),
.sqr_31(sqr_31),
.sqr_32(sqr_32),
.sqr_33(sqr_33),
.sqr_34(sqr_34),
.sqr_35(sqr_35),
.sqr_36(sqr_36),
.magnitude(mags)

);
/*
divisor div(
.clk(clk),
.mag(mags),
.steps(step) 
);

SQRT roots(
.clk(clk) ,
.clr(0) ,
.go(1) ,
.sw(m) ,
.done(done) ,
.root(mags)
);
/*
	assign m1 = sqr_1 + sqr_2 + sqr_3 + sqr_4 + sqr_5 + sqr_6 + sqr_7 + sqr_8 + sqr_9 ; 
	assign m2 = sqr_10 + sqr_11 + sqr_12 + sqr_13 + sqr_14 + sqr_15 + sqr_16 + sqr_17 + sqr_18; 
	assign m3 = sqr_19 + sqr_20 + sqr_21 + sqr_22 + sqr_23 + sqr_24 + sqr_25 + sqr_26 + sqr_27; 
	assign m4 = sqr_28 + sqr_29 + sqr_30 + sqr_31 + sqr_32 + sqr_33 + sqr_34 + sqr_35 + sqr_36;
	assign m = m1 + m2 + m3 + m4;	
*/

always @(posedge clk)
begin
/*
	m1 = sqr_1 + sqr_2 + sqr_3 + sqr_4 + sqr_5 + sqr_6 + sqr_7 + sqr_8 + sqr_9 ; 
	m2 = sqr_10 + sqr_11 + sqr_12 + sqr_13 + sqr_14 + sqr_15 + sqr_16 + sqr_17 + sqr_18; 
	m3 = sqr_19 + sqr_20 + sqr_21 + sqr_22 + sqr_23 + sqr_24 + sqr_25 + sqr_26 + sqr_27; 
	m4 = sqr_28 + sqr_29 + sqr_30 + sqr_31 + sqr_32 + sqr_33 + sqr_34 + sqr_35 + sqr_36;
	m = m1 + m2 + m3 + m4;
*/
	buff = mags;	
	cek = 1;
	j = 0;
	for(i=15;i!=0;i=i-1)
	begin
		if(cek == 1)
		begin
			if(buff[i]==1)
			begin
				j = i + 1;
				cek = 0;
			end
		end
	end
	
	if(j==0)
		j = 1;
	
	
	step <= j-1;


 o_1 = (d_1<<8)>>step;
 o_2 = (d_2<<8)>>step;
 o_3 = (d_3<<8)>>step;
 o_4 = (d_4<<8)>>step;
 o_5 = (d_5<<8)>>step;
 o_6 = (d_6<<8)>>step;
 o_7 = (d_7<<8)>>step;
 o_8 = (d_8<<8)>>step;
 o_9 = (d_9<<8)>>step;
 o_10 = (d_10<<8)>>step;
 o_11 = (d_11<<8)>>step;
 o_12 = (d_12<<8)>>step;
 o_13 = (d_13<<8)>>step;
 o_14 = (d_14<<8)>>step;
 o_15 = (d_15<<8)>>step;
 o_16 = (d_16<<8)>>step;
 o_17 = (d_17<<8)>>step;
 o_18 = (d_18<<8)>>step;
 o_19 = (d_19<<8)>>step;
 o_20 = (d_20<<8)>>step;
 o_21 = (d_21<<8)>>step;
 o_22 = (d_22<<8)>>step;
 o_23 = (d_23<<8)>>step;
 o_24 = (d_24<<8)>>step;
 o_25 = (d_25<<8)>>step;
 o_26 = (d_26<<8)>>step;
 o_27 = (d_27<<8)>>step;
 o_28 = (d_28<<8)>>step;
 o_29 = (d_29<<8)>>step;
 o_30 = (d_30<<8)>>step;
 o_31 = (d_31<<8)>>step; 
 o_32 = (d_32<<8)>>step;
 o_33 = (d_33<<8)>>step;
 o_34 = (d_34<<8)>>step; 
 o_35 = (d_35<<8)>>step; 
 o_36 = (d_36<<8)>>step;


end
endmodule