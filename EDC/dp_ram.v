`timescale 1ns / 1ps

module dp_ram(
    input                         i_clk,
    input                         i_a_wr,
    input  [P_LOG2_RAM_DEPTH-1:0] i_a_addr,
    input          [P_DATA_W-1:0] i_a_data,
    output reg     [P_DATA_W-1:0] o_a_data,
    input                         i_b_wr,
    input  [P_LOG2_RAM_DEPTH-1:0] i_b_addr,
    input          [P_DATA_W-1:0] i_b_data,
    output reg     [P_DATA_W-1:0] o_b_data
    );

   function integer log2;
      input [31:0] value;
      begin
	 value = value-1;
	 for (log2=0; value>0; log2=log2+1)
	   value = value>>1;
      end
   endfunction

   parameter P_DATA_W    = 640;
   parameter P_LOG2_RAM_DEPTH = 9;
   
   reg [P_DATA_W-1:0] mem [0:2**P_LOG2_RAM_DEPTH-1];
   
   // Port A
   always @(posedge i_clk) 
   begin
      o_a_data         <= mem[i_a_addr];
      if(i_a_wr) begin
         o_a_data      <= i_a_data;
         mem[i_a_addr] <= i_a_data;
      end
   end
 
   // Port B
   always @(posedge i_clk) 
   begin
      o_b_data         <= mem[i_b_addr];
      if(i_b_wr) begin
         o_b_data      <= i_b_data;
         mem[i_b_addr] <= i_b_data;
      end
   end
   
   /*
   always @(*)
   begin
      o_a_data         <= mem[i_a_addr];
      o_b_data         <= mem[i_b_addr];
   end
   */
endmodule