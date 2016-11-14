`timescale 1ns / 1ps

module bresenham(
      input                        i_clk,
      input                        i_reset,
      input      [P_X_COORD_W-1:0] i_x0,
      input      [P_X_COORD_W-1:0] i_x1,
      input      [P_Y_COORD_W-1:0] i_y0,
      input      [P_Y_COORD_W-1:0] i_y1,
      input                        i_load_vals,
      output reg [P_X_COORD_W-1:0] o_x_val,
      output reg [P_Y_COORD_W-1:0] o_y_val,
      output                       o_vals_rdy,
      output                       o_waiting
    );
    
   // Parameters
   parameter  P_X_COORD_W                 = 11;
   parameter  P_Y_COORD_W                 = 11;

   // Local parameters
   localparam P_ERROR_W                   = (P_X_COORD_W>P_Y_COORD_W) ? P_X_COORD_W : P_Y_COORD_W;
   localparam STATE__WAITING              = 0;
   localparam STATE__SETUP_IS_STEEP       = 1;
   localparam STATE__SETUP_REV_COORDS     = 2;
   localparam STATE__SETUP_ERROR_AND_STEP = 3;
   localparam STATE__DRAWING              = 4;

   // State variables
   reg                    [2:0] curr_state, next_state;
   
   // X and Y registers 
   reg signed [P_X_COORD_W-1:0] x, x0, x1;
   reg signed [P_Y_COORD_W-1:0] y, y0, y1;
   // X and Y change registers
   reg signed [P_X_COORD_W-1:0] delta_x;
   reg signed [P_X_COORD_W-1:0] delta_y;
   // Error register
   reg signed   [P_ERROR_W-1:0] error;
   // Step value for Y coordinate of line
   reg signed             [1:0] ystep;
   // Control signals
   reg                          steep;
   reg                          vals_rdy;
   reg                          waiting;

   // Assign output control signals
   assign o_vals_rdy   = vals_rdy;
   assign o_waiting    = (curr_state == STATE__WAITING) ? 1'b1 : 1'b0;

   // Generate output values
   always @(posedge i_clk)
   begin
      if (i_reset) begin
         x              <= 'b0;
         x0             <= 'b0;
         x1             <= 'b0;
         y              <= 'b0;
         y0             <= 'b0;
         y1             <= 'b0;
         error          <= 'b0;
         curr_state     <= STATE__WAITING;
      end else begin
         vals_rdy       <= 0;
         x0             <= x0;
         x1             <= x1;
         y0             <= y0;
         y1             <= y1;
         error          <= error;
         curr_state     <= next_state;

         case (curr_state)
            STATE__WAITING : begin
               // Load input coordinates into registers
               if (i_load_vals) begin
                  x0    <= i_x0;
                  x1    <= i_x1;
                  y0    <= i_y0;
                  y1    <= i_y1;
                  error <= 'b0;
               end
            end
            STATE__SETUP_IS_STEEP : begin
               // Determine if the slope of the line is steep 
               //  (i.e. abs(slope) > 1)
               if (y1 > y0) begin
                  if (x1 > x0) begin 
                     steep <= (y1-y0) > (x1-x0);
                  end else begin
                     steep <= (y1-y0) > (x0-x1);
                  end
               end else begin
                  if (x1 > x0) begin 
                     steep <= (y0-y1) > (x1-x0);
                  end else begin
                     steep <= (y0-y1) > (x0-x1);
                  end
               end
            end
            STATE__SETUP_REV_COORDS : begin
               // Adjust the coordinates to draw line with
               // a slope that is positive and less than 1
               if (steep) begin
                  if (y0 > y1) begin
                     x0      <= y1;
                     x1      <= y0;
                     y0      <= x1;
                     y1      <= x0;
                     delta_x <= y0-y1;
                     delta_y <= (x1>x0 ? x1-x0 : x0-x1);
                  end else begin
                     x0      <= y0;
                     x1      <= y1;
                     y0      <= x0;
                     y1      <= x1;
                     delta_x <= y1-y0;
                     delta_y <= (x1>x0 ? x1-x0 : x0-x1);
                  end
               end else begin
                  if (x0 > x1) begin
                     x0      <= x1;
                     x1      <= x0;
                     y0      <= y1;
                     y1      <= y0;
                     delta_x <= x0-x1;
                     delta_y <= (y1>y0 ? y1-y0 : y0-y1);
                  end else begin
                     delta_x <= x1-x0;
                     delta_y <= (y1>y0 ? y1-y0 : y0-y1);
                  end
               end
            end
            STATE__SETUP_ERROR_AND_STEP : begin
               // Set up the error, step values and initial values of x,y
               error <= delta_x >>> 1;
               ystep <= (y0<y1 ? 1 : -1);
               x     <= x0;
               y     <= y0;
            end
            STATE__DRAWING : begin
               // Write coordinates to output
               if (steep) begin
                  o_x_val <= y;
                  o_y_val <= x;
               end else begin
                  o_x_val <= x;
                  o_y_val <= y;
               end
               
               x <= x+1;
               
               if (error-delta_y < 0) begin
                  error <= error-delta_y + delta_x;
                  y     <= y+ystep;
               end else begin
                  error <= error-delta_y;
               end
               
               vals_rdy <= 1;
            end
         endcase
      end
   end
   
   // Next state logic
   always @(curr_state, i_load_vals, x, x1)
   begin
      next_state = curr_state;
      case(curr_state)
         STATE__WAITING : begin
            if (i_load_vals) begin
               next_state = STATE__SETUP_IS_STEEP;
            end 
         end
         STATE__SETUP_IS_STEEP : begin
            next_state = STATE__SETUP_REV_COORDS;
         end
         STATE__SETUP_REV_COORDS : begin
            next_state = STATE__SETUP_ERROR_AND_STEP;
         end
         STATE__SETUP_ERROR_AND_STEP : begin
            next_state = STATE__DRAWING;
         end
         STATE__DRAWING : begin
            if (x == x1) begin
               next_state = STATE__WAITING;
            end 
         end         
      endcase
   end

endmodule
