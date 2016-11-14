`timescale 1ns / 1ps

module draw_lines(
      // 
      input                                      i_clk,
      input                                      i_reset,
      input                    [P_X_COORD_W-1:0] i_x0,
      input                    [P_X_COORD_W-1:0] i_x1,
      input                    [P_Y_COORD_W-1:0] i_y0,
      input                    [P_Y_COORD_W-1:0] i_y1,
      input                                      i_clear_buffer,
      input                                      i_load_fifo,
      output                                     o_waiting,
      output                                     o_fifo_full,
      // VGA 
      input                    [P_X_COORD_W-1:0] i_hcounter,
      input                    [P_Y_COORD_W-1:0] i_vcounter,
      output                                     o_pixel_on
    );
    
    // Parameter
    parameter P_X_COORD_W = 11;
    parameter P_Y_COORD_W = 11;
    parameter P_SCREEN_W = 640;
    parameter P_SCREEN_H = 480;
    parameter P_DATA_W = 1;
    parameter P_LOG2_RAM_DEPTH = 19;
    
    // Local parameter
    localparam STATE__WAITING = 0;
    localparam STATE__CLEAR   = 1;
    localparam STATE__LOAD    = 2;
    localparam STATE__DRAW    = 3;
    
    // State registers
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    // Screen buffer control and data signals
    wire [P_LOG2_RAM_DEPTH-1:0] clear_addr;
    wire [P_LOG2_RAM_DEPTH-1:0] bres_addr;
    reg  [P_LOG2_RAM_DEPTH-1:0] buffer_addr;
    wire clear_wr;
    wire bres_wr;
    reg  buffer_wr;
    wire [P_DATA_W-1:0] clear_data;
    wire [P_DATA_W-1:0] bres_data;
    reg  [P_DATA_W-1:0] buffer_data;
    
    // Bresenham control signals
    wire                   bres_waiting;
    wire                   load_vals;
    wire [P_X_COORD_W-1:0] fifo_x0;
    wire [P_X_COORD_W-1:0] fifo_x1;
    wire [P_Y_COORD_W-1:0] fifo_y0;
    wire [P_Y_COORD_W-1:0] fifo_y1;
    
    // Bresenham coordinates
    wire     [P_X_COORD_W-1:0] x_val;
    wire     [P_Y_COORD_W-1:0] y_val;
    
    // Counter reset signal
    wire counter_reset;
    
    // FIFO control signals
    wire fifo_empty;
    wire fifo_full;
    assign o_fifo_full = fifo_full;
    
    // Generate output waiting status signal
    assign o_waiting  = (curr_state == STATE__WAITING) ? 1'b1 : 1'b0;

    ////////////////////////
    // Input buffer FIFOs //
    ////////////////////////
    fifo x0_in_buffer (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_data(i_x0), 
		.i_read(load_vals), 
		.i_write(i_load_fifo), 
		.o_data(fifo_x0), 
		.o_empty(fifo_empty), 
		.o_full(fifo_full)
	 );

    fifo x1_in_buffer (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_data(i_x1), 
		.i_read(load_vals), 
		.i_write(i_load_fifo), 
		.o_data(fifo_x1), 
		.o_empty(), 
		.o_full()
	 );

    fifo y0_in_buffer (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_data(i_y0), 
		.i_read(load_vals), 
		.i_write(i_load_fifo), 
		.o_data(fifo_y0), 
		.o_empty(), 
		.o_full()
	 );

    fifo y1_in_buffer (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_data(i_y1), 
		.i_read(load_vals), 
		.i_write(i_load_fifo), 
		.o_data(fifo_y1), 
		.o_empty(), 
		.o_full()
	 );
    
    ///////////////////////////
    // Control state machine //
    ///////////////////////////
    // Change state
    always @(posedge i_clk) 
    begin
      if (i_reset) begin
         curr_state <= STATE__WAITING;
      end else begin
         curr_state <= next_state;
      end
    end

   // Next state logic
   always @(curr_state, i_clear_buffer, clear_addr, bres_waiting, fifo_empty)
   begin
      next_state = curr_state;
      case(curr_state)
         STATE__WAITING : begin
            if (i_clear_buffer == 1'b1) begin
               next_state = STATE__CLEAR;
            end
         end
         STATE__CLEAR : begin
            if (clear_addr == P_SCREEN_W*P_SCREEN_H) begin
               next_state = STATE__LOAD;
            end
         end
         STATE__LOAD : begin
            next_state = STATE__DRAW;
         end
         STATE__DRAW : begin
            if (bres_waiting && fifo_empty) begin
               next_state = STATE__WAITING;
            end else if (~fifo_empty && bres_waiting) begin
               next_state = STATE__LOAD;
            end
         end
      endcase
   end
   
   //////////////////
   // Line drawing //
   //////////////////
	bresenham bres (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_x0(fifo_x0),//i_x0), 
		.i_x1(fifo_x1),//i_x1), 
		.i_y0(fifo_y0),//i_y0), 
		.i_y1(fifo_y1),//i_y1), 
		.i_load_vals(load_vals), 
      .o_x_val(x_val),
      .o_y_val(y_val),
		.o_vals_rdy(bres_wr),
      .o_waiting(bres_waiting)
	);
   
   assign load_vals = (curr_state == STATE__LOAD) ? 1'b1 : 1'b0;

   ///////////////////
   // Screen buffer //
   ///////////////////
   // Implement screen buffer in dual port RAM
   //   One port used by VGA interface, one port used by Bresenham and clear
   dp_ram #(
      .P_DATA_W(P_DATA_W),
      .P_LOG2_RAM_DEPTH(P_LOG2_RAM_DEPTH)
      
      ) screen_buffer (
         .i_clk(i_clk),
         .i_a_wr(buffer_wr),
         .i_a_addr(buffer_addr),
         .i_a_data(buffer_data),
         .o_a_data(),
         .i_b_wr(1'b0),
         .i_b_addr(P_SCREEN_W*i_vcounter+i_hcounter),
         .i_b_data(0),
         .o_b_data(o_pixel_on)
    );
   
   // Generate RAM control signals   
   assign bres_addr  = P_SCREEN_W*y_val+x_val;
   assign bres_data  = 1;
   assign clear_wr   = (curr_state == STATE__CLEAR) ? 1'b1 : 1'b0;
   assign clear_data = 0;
   
   always @(bres_addr, clear_addr, 
            bres_wr, clear_wr, 
            bres_data, clear_data, 
            curr_state)
   begin
      case (curr_state)
         STATE__CLEAR : begin
            buffer_wr   = clear_wr;
            buffer_addr = clear_addr;
            buffer_data = clear_data;
         end
         STATE__DRAW : begin
            buffer_wr   = bres_wr;
            buffer_addr = bres_addr;
            buffer_data = bres_data;
         end
         default : begin
            buffer_wr   = 1'b0;
            buffer_addr = 0;
            buffer_data = 0;
         end
      endcase
   end

   // Counter for clear address
   counter #(.P_COUNT_W(P_LOG2_RAM_DEPTH)) 
      counter (
         .i_clk(i_clk),
         .i_reset(counter_reset),
         .o_count(clear_addr)
	);
   
   // Reset the counter when not in clear state
   assign counter_reset = i_reset | ((curr_state == STATE__CLEAR) ? 1'b0 : 1'b1);

endmodule
