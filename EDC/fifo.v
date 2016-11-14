`timescale 1ns / 1ps

module fifo(
    input                 i_clk,
    input                 i_reset,
    input  [P_DATA_W-1:0] i_data,
    input                 i_read,
    input                 i_write,
    output [P_DATA_W-1:0] o_data,
    output                o_empty,
    output                o_full
    );

   // Parameters
   parameter  P_DATA_W = 11;
   parameter  P_ADDR_W = 8;
   localparam P_DEPTH  = (1 << P_ADDR_W);
   
   // Local signals
   reg  [P_ADDR_W-1:0] wr_addr;
   reg  [P_ADDR_W-1:0] rd_addr;
   reg  [P_DATA_W-1:0] output_data;
   wire [P_DATA_W-1:0] ram_data;
   reg  [P_ADDR_W-1:0] counter;
   
   // Status signals
   assign o_full  = (counter == (P_DEPTH-1));
   assign o_empty = (counter == 0);
   assign o_data  = ram_data;//output_data;
   
   // Write address
   always @(posedge i_clk)
   begin
      if (i_reset) begin
         wr_addr <= 0;
      end else if (i_write) begin
         wr_addr <= wr_addr+1;
      end
   end

   // Read address
   always @(posedge i_clk)
   begin
      if (i_reset) begin
         rd_addr <= 0;
      end else if (i_read) begin
         rd_addr <= rd_addr+1;
      end
   end

   // Track FIFO pointer location
   always @(posedge i_clk)
   begin
      if (i_reset) begin
         counter <= 0;
      end else if (i_read && !i_write) begin
         counter <= counter-1;
      end else if (i_write && !i_read) begin
         counter <= counter+1;
      end
   end

   // FIFO buffer
   dp_ram #(
      .P_DATA_W(P_DATA_W),
      .P_LOG2_RAM_DEPTH(P_ADDR_W)
      
      ) buffer (
         .i_clk(i_clk),
         .i_a_wr(i_write),
         .i_a_addr(wr_addr),
         .i_a_data(i_data),
         .o_a_data(),
         .i_b_wr(1'b0),
         .i_b_addr(rd_addr),
         .i_b_data(0),
         .o_b_data(ram_data)
    );

endmodule
