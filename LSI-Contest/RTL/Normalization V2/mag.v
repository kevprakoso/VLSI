module mag (
input wire clk,
input wire [16:0] sqr_1,
input wire [16:0] sqr_2,
input wire [16:0] sqr_3,
input wire [16:0] sqr_4, 
input wire [16:0] sqr_5,
input wire [16:0] sqr_6,
input wire [16:0] sqr_7, 
input wire [16:0] sqr_8,
input wire [16:0] sqr_9,
input wire [16:0] sqr_10,
input wire [16:0] sqr_11,
input wire [16:0] sqr_12,
input wire [16:0] sqr_13, 
input wire [16:0] sqr_14,
input wire [16:0] sqr_15,
input wire [16:0] sqr_16, 
input wire [16:0] sqr_17,
input wire [16:0] sqr_18,
input wire [16:0] sqr_19,
input wire [16:0] sqr_20,
input wire [16:0] sqr_21,
input wire [16:0] sqr_22, 
input wire [16:0] sqr_23,
input wire [16:0] sqr_24,
input wire [16:0] sqr_25, 
input wire [16:0] sqr_26,
input wire [16:0] sqr_27,
input wire [16:0] sqr_28,
input wire [16:0] sqr_29,
input wire [16:0] sqr_30,
input wire [16:0] sqr_31, 
input wire [16:0] sqr_32,
input wire [16:0] sqr_33,
input wire [16:0] sqr_34, 
input wire [16:0] sqr_35,
input wire [16:0] sqr_36, 
output wire [15:0] magnitude

);


wire [16:0] m,m1,m2,m3,m4;
wire done;
wire [9:0] root;

SQRT roots(
.clk(clk) ,
.clr(0) ,
.go(1) ,
.sw(m) ,
.done(done) ,
.root(magnitude)
);

	assign m1 = sqr_1 + sqr_2 + sqr_3 + sqr_4 + sqr_5 + sqr_6 + sqr_7 + sqr_8 + sqr_9 ; 
	assign m2 = sqr_10 + sqr_11 + sqr_12 + sqr_13 + sqr_14 + sqr_15 + sqr_16 + sqr_17 + sqr_18; 
	assign m3 = sqr_19 + sqr_20 + sqr_21 + sqr_22 + sqr_23 + sqr_24 + sqr_25 + sqr_26 + sqr_27; 
	assign m4 = sqr_28 + sqr_29 + sqr_30 + sqr_31 + sqr_32 + sqr_33 + sqr_34 + sqr_35 + sqr_36;
	assign m = m1 + m2 + m3 + m4;	


/*
always@(posedge clk)
begin
	
	m1 = sqr_1 + sqr_2 + sqr_3 + sqr_4 + sqr_5 + sqr_6 + sqr_7 + sqr_8 + sqr_9 ; 
	m2 = sqr_10 + sqr_11 + sqr_12 + sqr_13 + sqr_14 + sqr_15 + sqr_16 + sqr_17 + sqr_18; 
	m3 = sqr_19 + sqr_20 + sqr_21 + sqr_22 + sqr_23 + sqr_24 + sqr_25 + sqr_26 + sqr_27; 
	m4 = sqr_28 + sqr_29 + sqr_30 + sqr_31 + sqr_32 + sqr_33 + sqr_34 + sqr_35 + sqr_36;
	m = m1 + m2 + m3 + m4;	
	
	if(done)
		magnitude <= root;
end
*/
endmodule