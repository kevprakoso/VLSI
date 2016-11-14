`timescale 1ns / 1ps

module draw_lines_top(
    input clk,
    input [7:0] sw,
    input btns,
    input btnu,
    input btnl,
    input btnd,
    input btnr,
    output [7:0] seg,
    output [3:0] an,
    output [7:0] Led,
    output [2:0] vgaRed,
    output [2:0] vgaGreen,
    output [2:1] vgaBlue,
    output Hsync,
    output Vsync
    );

   // VGA
   wire        vga_clk;
   reg   [2:0] vga_red;
   reg   [2:0] vga_grn;
   reg   [1:0] vga_blu;
   wire [10:0] vga_hcounter;
   wire [10:0] vga_vcounter;
   wire        vga_blank;

   // Buttons
   wire        btns_debounce;
   wire        btns_pulse;
   wire        btnu_debounce;
   wire        btnu_pulse;   
   
   // Line drawing
   wire        pixel_on;

   // Button debounce
   button_debounce button_debounce_btns (
      .i_clk(clk),
      .i_button(btns),
      .o_button_state(btns_debounce)
      );      

   // Level to pulse
	level_to_pulse lvl_to_pulse_btns (
		.i_clk(clk), 
		.i_data(btns_debounce), 
		.o_pulse(btns_pulse),
		.reset()
	);

   // Button debounce
   button_debounce button_debounce_btnu (
      .i_clk(clk),
      .i_button(btnu),
      .o_button_state(btnu_debounce)
      );      

   // Level to pulse
	level_to_pulse lvl_to_pulse_btnu (
		.i_clk(clk), 
		.i_data(btnu_debounce), 
		.o_pulse(btnu_pulse),
		.reset()
	);

   // Button debounce
   button_debounce button_debounce_btnd (
      .i_clk(clk),
      .i_button(btnd),
      .o_button_state(btnd_debounce)
      );      

   // Level to pulse
	level_to_pulse lvl_to_pulse_btnd (
		.i_clk(clk), 
		.i_data(btnd_debounce), 
		.o_pulse(btnd_pulse),
		.reset()
	);
   
   // Line drawing module
	draw_lines#( 
      .P_X_COORD_W(11),
      .P_Y_COORD_W(11),
      .P_SCREEN_W(640),
      .P_SCREEN_H(480),
      .P_DATA_W(1),
      .P_LOG2_RAM_DEPTH(19)
      ) lines (
		.i_clk(clk), 
		.i_reset(btnu_pulse), 
		.i_x0(40*sw[3:0]), 
		.i_x1(100),//40*sw[3:0]), 
		.i_y0(30*sw[7:4]), 
		.i_y1(100), 
		.i_clear_buffer(btns_pulse), 
      .i_load_fifo(btnd_pulse),
      .o_waiting(),
      .o_fifo_full(),
		.i_hcounter(vga_hcounter), 
		.i_vcounter(vga_vcounter), 
		.o_pixel_on(pixel_on)
	);

  // VGA controller
  clk_divider #(4) vga_clk_div(
      .i_clk(clk),
      .o_clk(vga_clk)
    );

   vga_controller_640_60 vga_controller(
      .pixel_clk(vga_clk),
      .HS(Hsync),
      .VS(Vsync),
      .blank(vga_blank),
      .hcounter(vga_hcounter),
      .vcounter(vga_vcounter)
      );

    always @(vga_blank, pixel_on)
    begin
      if (vga_blank == 0) begin
         if (pixel_on == 1) begin
            vga_red = 3'b000;
            vga_grn = 3'b111;
            vga_blu = 2'b00;
         end else begin
            vga_red = 3'b000;
            vga_grn = 3'b000;
            vga_blu = 2'b00;
         end
      end else begin
         vga_red = 3'b000;
         vga_grn = 3'b000;
         vga_blu = 2'b00;
      end
    end

   assign vgaRed   = vga_red;
   assign vgaGreen = vga_grn;
   assign vgaBlue  = vga_blu;


endmodule
