module level_to_pulse(i_clk, i_data, o_pulse);
   
   input  i_clk, i_data;
   output reg o_pulse;
   reg  [1:0]  state, next;

   // States
   parameter WAIT_LOW = 0; 
   parameter WAIT_HIGH = 1;
   parameter RISING = 2; // I've just seen a rising edge
   parameter PULSE = 3; // I'm in the process of generating a pulse

   // Reset or update the state on every clock
   always @ (posedge i_clk) 
     begin
        if (0)
          begin
             state <= WAIT_LOW;
             next <= WAIT_LOW;
             o_pulse = 0;
          end
        else
          state <= next;
     end

   // What to do in each state
   always @ (state or i_clk) begin 
      case (state)                       
        WAIT_LOW:
          begin
             if (i_clk == 1) 
               next = RISING;
          end
        RISING:
          begin
             o_pulse = 1; 
             next = PULSE;
          end
        PULSE:
          begin
             o_pulse = 0;
             if (i_clk == 0) 
               next = WAIT_LOW;
             else
               next = WAIT_HIGH;
          end
        WAIT_HIGH:
          if (i_clk == 0)
            next = WAIT_LOW;
      endcase // case (state)

   end

endmodule 