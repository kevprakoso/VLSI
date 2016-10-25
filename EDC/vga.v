module vga(
	input clock, 
	input i_R, 
	input i_G, 
	input i_B, 
	output o_R,
	output o_G,
	output o_B,
	output o_h_sync,
	output o_v_sync
	);

reg [0:9] pxl_row;
reg [0:9] pxl_col;

wire
	clock_25Mhz,
	h_sync,
	v_sync,
	video_on,
	video_on_v,
	video_on_h;
	
wire [0:9] h_count;
wire [0:9] v_count;	


parameter
	th 		  = 12'd800,
	thb1 	 = 12'd660,
	thb2 	 = 12'd756,
	thd 	  = 12'd640,
	tv 		  = 12'd525,
	tvb1 	 = 12'd494,
	tvb2 	 = 12'd495,
	tvd 	  = 12'd480;
	

	
assign video_on = video_on_h & video_on_v;

assign o_R = i_R & video_on;
assign o_G = i_R & video_on;
assign o_B = i_R & video_on;

assign o_h_sync = h_sync;
assign o_v_sync = v_sync;

always @(posedge clock)
  begin
    if (clock_25Mhz == 1'b0)
	     assign clock_25Mhz = 1'b1;
   	else
	     clock_25Mhz <= 1'b0;
	end	
	
always @(posedge clock_25Mhz)
	begin
		if (h_count == (th - 1))
			h_count <= { 16{1'b1} };
		else
			h_count <= h_count +1;
		
		if ((h_count <= thb2 - 1) && (h_count >= thb1 - 1))
			h_sync <= 1'b0;
		else
			h_sync <= 1'b1;
		
		if ((v_count >= tv - 1) && (h_count >= 699))
			v_count <= {16{1'b1}};
		else if (h_count == 699)
			v_count <= v_count + 1;
			
		if ((v_count <= thb2 - 1) && (v_count >= thb1 - 1))
			v_sync <= 1'b0;
		else
			v_sync <= 1'b1;
			
		if (h_count <= thd - 1)
		begin
			video_on_h <= 1'b1;
			pxl_col <= h_count;
		end
  		else
			video_on_h <= 1'b0;
			
		if (v_count <= thd - 1)
		begin
			video_on_v <= 1'b1;
			pxl_col <= v_count;
		end
		else
			video_on_v <= 1'b0;
	end
	
endmodule








// Adapted from: www.TinyVGA.com

/*
module top (
    input clk, // 50 MHz
    output [2:0] red,
    output [2:0] green,
    output [1:0] blue,
    output hsync, vsync
);

reg [11:0] hcount;  // VGA horizontal counter
reg [10:0] vcount;  // VGA vertical counter
reg [7:0] data;     // RGB data

wire hcount_ov, vcount_ov, video_active;

// VGA mode parameters
parameter
    hsync_end   = 12'd119,
    hdat_begin  = 12'd242,
    hdat_end    = 12'd1266,
    hpixel_end  = 12'd1345,
    vsync_end   = 11'd5,
    vdat_begin  = 11'd32,
    vdat_end    = 11'd632,
    vline_end   = 11'd665;

always @(posedge clk)
    if (hcount_ov)
        hcount <= 12'd0;
    else
        hcount <= hcount + 12'd1;
assign hcount_ov = hcount == hpixel_end;

always @(posedge clk)
    if (hcount_ov)
        if (vcount_ov)
            vcount <= 11'd0;
        else
            vcount <= vcount + 11'd1;
assign  vcount_ov = vcount == vline_end;

assign video_active = hdat_begin <= hcount && hcount < hdat_end &&
                      vdat_begin <= vcount && vcount < vdat_end;

assign hsync = hcount > hsync_end;
assign vsync = vcount > vsync_end;

assign red   = video_active ?  data[2:0] : 3'b0;
assign green = video_active ?  data[5:3] : 3'b0;
assign blue  = video_active ?  data[7:6] : 2'b0;

// generate "image"
always @(posedge clk)
    data <= vcount[7:0] ^ hcount[7:0];

endmodule


/*
// Pong VGA game
// (c) fpga4fun.com

module pong(clk, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B, quadA, quadB);
input clk;
output vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B;
input quadA, quadB;

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;

hvsync_generator syncgen(.clk(clk), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), 
  .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

/////////////////////////////////////////////////////////////////
reg [8:0] PaddlePosition;
reg [2:0] quadAr, quadBr;
always @(posedge clk) quadAr <= {quadAr[1:0], quadA};
always @(posedge clk) quadBr <= {quadBr[1:0], quadB};

always @(posedge clk)
if(quadAr[2] ^ quadAr[1] ^ quadBr[2] ^ quadBr[1])
begin
	if(quadAr[2] ^ quadBr[1])
	begin
		if(~&PaddlePosition)        // make sure the value doesn't overflow
			PaddlePosition <= PaddlePosition + 1;
	end
	else
	begin
		if(|PaddlePosition)        // make sure the value doesn't underflow
			PaddlePosition <= PaddlePosition - 1;
	end
end

/////////////////////////////////////////////////////////////////
reg [9:0] ballX;
reg [8:0] ballY;
reg ball_inX, ball_inY;

always @(posedge clk)
if(ball_inX==0) ball_inX <= (CounterX==ballX) & ball_inY; else ball_inX <= !(CounterX==ballX+16);

always @(posedge clk)
if(ball_inY==0) ball_inY <= (CounterY==ballY); else ball_inY <= !(CounterY==ballY+16);

wire ball = ball_inX & ball_inY;

/////////////////////////////////////////////////////////////////
wire border = (CounterX[9:3]==0) || (CounterX[9:3]==79) || (CounterY[8:3]==0) || (CounterY[8:3]==59);
wire paddle = (CounterX>=PaddlePosition+8) && (CounterX<=PaddlePosition+120) && (CounterY[8:4]==27);
wire BouncingObject = border | paddle; // active if the border or paddle is redrawing itself

reg ResetCollision;
always @(posedge clk) ResetCollision <= (CounterY==500) & (CounterX==0);  // active only once for every video frame

reg CollisionX1, CollisionX2, CollisionY1, CollisionY2;
always @(posedge clk) if(ResetCollision) CollisionX1<=0; else if(BouncingObject & (CounterX==ballX   ) & (CounterY==ballY+ 8)) CollisionX1<=1;
always @(posedge clk) if(ResetCollision) CollisionX2<=0; else if(BouncingObject & (CounterX==ballX+16) & (CounterY==ballY+ 8)) CollisionX2<=1;
always @(posedge clk) if(ResetCollision) CollisionY1<=0; else if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY   )) CollisionY1<=1;
always @(posedge clk) if(ResetCollision) CollisionY2<=0; else if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY+16)) CollisionY2<=1;

/////////////////////////////////////////////////////////////////
wire UpdateBallPosition = ResetCollision;  // update the ball position at the same time that we reset the collision detectors

reg ball_dirX, ball_dirY;
always @(posedge clk)
if(UpdateBallPosition)
begin
	if(~(CollisionX1 & CollisionX2))        // if collision on both X-sides, don't move in the X direction
	begin
		ballX <= ballX + (ball_dirX ? -1 : 1);
		if(CollisionX2) ball_dirX <= 1; else if(CollisionX1) ball_dirX <= 0;
	end

	if(~(CollisionY1 & CollisionY2))        // if collision on both Y-sides, don't move in the Y direction
	begin
		ballY <= ballY + (ball_dirY ? -1 : 1);
		if(CollisionY2) ball_dirY <= 1; else if(CollisionY1) ball_dirY <= 0;
	end
end 

/////////////////////////////////////////////////////////////////
wire R = BouncingObject | ball | (CounterX[3] ^ CounterY[3]);
wire G = BouncingObject | ball;
wire B = BouncingObject | ball;

reg vga_R, vga_G, vga_B;
always @(posedge clk)
begin
	vga_R <= R & inDisplayArea;
	vga_G <= G & inDisplayArea;
	vga_B <= B & inDisplayArea;
end

endmodule

*/