// -------------------------------------------------------------
// 
// File Name: C:\Users\Kevin Shidqi Prakoso\Documents\VLSI\HDLCoder\codegen\getHistogram\hdlsrc\getHistogram_fixpt_enb_bypass.v
// Created: 2016-12-05 13:26:29
// 
// Generated by MATLAB 9.0, MATLAB Coder 3.1 and HDL Coder 3.8
// 
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: getHistogram_fixpt_enb_bypass
// Source Path: 
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module getHistogram_fixpt_enb_bypass
          (
           clk_1,
           reset_1,
           clk_enable_1,
           clk_enable_2
          );


  input   clk_1;
  input   reset_1;
  input   clk_enable_1;
  output  clk_enable_2;


  reg  clk_enable_3;
  reg  ctr0_out;
  reg  ctr1_out;
  reg  ctr2_out;
  reg  ctr3_out;
  reg  ctr4_out;
  reg  ctr5_out;
  reg  ctr6_out;
  reg  ctr7_out;
  reg  ctr8_out;
  reg  ctr9_out;
  reg  ctr10_out;
  reg  ctr11_out;
  reg  ctr12_out;
  reg  ctr13_out;
  reg  ctr14_out;
  reg  ctr15_out;
  reg  ctr16_out;
  reg  ctr17_out;
  reg  ctr18_out;
  reg  ctr19_out;
  reg  ctr20_out;
  reg  ctr21_out;
  reg  ctr22_out;
  reg  ctr23_out;
  reg  ctr24_out;
  reg  ctr25_out;
  reg  ctr26_out;
  reg  ctr27_out;
  reg  ctr28_out;
  reg  ctr29_out;
  reg  ctr30_out;
  reg  ctr31_out;
  reg  ctr32_out;
  reg  ctr33_out;
  reg  ctr34_out;
  reg  ctr35_out;
  reg  ctr36_out;
  reg  ctr37_out;
  reg  ctr38_out;
  reg  ctr39_out;
  reg  ctr40_out;
  reg  ctr41_out;
  reg  ctr42_out;
  reg  ctr43_out;
  reg  ctr44_out;
  reg  ctr45_out;
  reg  ctr46_out;
  reg  ctr47_out;
  reg  ctr48_out;
  reg  ctr49_out;
  reg  ctr50_out;
  reg  ctr51_out;
  reg  ctr52_out;
  reg  ctr53_out;
  reg  ctr54_out;
  reg  ctr55_out;
  reg  ctr56_out;
  reg  ctr57_out;
  reg  ctr58_out;
  reg  ctr59_out;
  reg  ctr60_out;
  reg  ctr61_out;
  reg  ctr62_out;
  wire ctrstate_out;
  reg  bypass_out;
  wire clk_enable_4;


  always @(posedge clk_1 or posedge reset_1)
    begin : c
      if (reset_1) begin
        ctr0_out <= 1'b0;
      end
      else begin
        ctr0_out <= clk_enable_3 && clk_enable_1;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_1
      if (reset_1) begin
        ctr1_out <= 1'b0;
      end
      else begin
        ctr1_out <= ctr0_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_2
      if (reset_1) begin
        ctr2_out <= 1'b0;
      end
      else begin
        ctr2_out <= ctr1_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_3
      if (reset_1) begin
        ctr3_out <= 1'b0;
      end
      else begin
        ctr3_out <= ctr2_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_4
      if (reset_1) begin
        ctr4_out <= 1'b0;
      end
      else begin
        ctr4_out <= ctr3_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_5
      if (reset_1) begin
        ctr5_out <= 1'b0;
      end
      else begin
        ctr5_out <= ctr4_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_6
      if (reset_1) begin
        ctr6_out <= 1'b0;
      end
      else begin
        ctr6_out <= ctr5_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_7
      if (reset_1) begin
        ctr7_out <= 1'b0;
      end
      else begin
        ctr7_out <= ctr6_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_8
      if (reset_1) begin
        ctr8_out <= 1'b0;
      end
      else begin
        ctr8_out <= ctr7_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_9
      if (reset_1) begin
        ctr9_out <= 1'b0;
      end
      else begin
        ctr9_out <= ctr8_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_10
      if (reset_1) begin
        ctr10_out <= 1'b0;
      end
      else begin
        ctr10_out <= ctr9_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_11
      if (reset_1) begin
        ctr11_out <= 1'b0;
      end
      else begin
        ctr11_out <= ctr10_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_12
      if (reset_1) begin
        ctr12_out <= 1'b0;
      end
      else begin
        ctr12_out <= ctr11_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_13
      if (reset_1) begin
        ctr13_out <= 1'b0;
      end
      else begin
        ctr13_out <= ctr12_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_14
      if (reset_1) begin
        ctr14_out <= 1'b0;
      end
      else begin
        ctr14_out <= ctr13_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_15
      if (reset_1) begin
        ctr15_out <= 1'b0;
      end
      else begin
        ctr15_out <= ctr14_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_16
      if (reset_1) begin
        ctr16_out <= 1'b0;
      end
      else begin
        ctr16_out <= ctr15_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_17
      if (reset_1) begin
        ctr17_out <= 1'b0;
      end
      else begin
        ctr17_out <= ctr16_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_18
      if (reset_1) begin
        ctr18_out <= 1'b0;
      end
      else begin
        ctr18_out <= ctr17_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_19
      if (reset_1) begin
        ctr19_out <= 1'b0;
      end
      else begin
        ctr19_out <= ctr18_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_20
      if (reset_1) begin
        ctr20_out <= 1'b0;
      end
      else begin
        ctr20_out <= ctr19_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_21
      if (reset_1) begin
        ctr21_out <= 1'b0;
      end
      else begin
        ctr21_out <= ctr20_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_22
      if (reset_1) begin
        ctr22_out <= 1'b0;
      end
      else begin
        ctr22_out <= ctr21_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_23
      if (reset_1) begin
        ctr23_out <= 1'b0;
      end
      else begin
        ctr23_out <= ctr22_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_24
      if (reset_1) begin
        ctr24_out <= 1'b0;
      end
      else begin
        ctr24_out <= ctr23_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_25
      if (reset_1) begin
        ctr25_out <= 1'b0;
      end
      else begin
        ctr25_out <= ctr24_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_26
      if (reset_1) begin
        ctr26_out <= 1'b0;
      end
      else begin
        ctr26_out <= ctr25_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_27
      if (reset_1) begin
        ctr27_out <= 1'b0;
      end
      else begin
        ctr27_out <= ctr26_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_28
      if (reset_1) begin
        ctr28_out <= 1'b0;
      end
      else begin
        ctr28_out <= ctr27_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_29
      if (reset_1) begin
        ctr29_out <= 1'b0;
      end
      else begin
        ctr29_out <= ctr28_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_30
      if (reset_1) begin
        ctr30_out <= 1'b0;
      end
      else begin
        ctr30_out <= ctr29_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_31
      if (reset_1) begin
        ctr31_out <= 1'b0;
      end
      else begin
        ctr31_out <= ctr30_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_32
      if (reset_1) begin
        ctr32_out <= 1'b0;
      end
      else begin
        ctr32_out <= ctr31_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_33
      if (reset_1) begin
        ctr33_out <= 1'b0;
      end
      else begin
        ctr33_out <= ctr32_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_34
      if (reset_1) begin
        ctr34_out <= 1'b0;
      end
      else begin
        ctr34_out <= ctr33_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_35
      if (reset_1) begin
        ctr35_out <= 1'b0;
      end
      else begin
        ctr35_out <= ctr34_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_36
      if (reset_1) begin
        ctr36_out <= 1'b0;
      end
      else begin
        ctr36_out <= ctr35_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_37
      if (reset_1) begin
        ctr37_out <= 1'b0;
      end
      else begin
        ctr37_out <= ctr36_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_38
      if (reset_1) begin
        ctr38_out <= 1'b0;
      end
      else begin
        ctr38_out <= ctr37_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_39
      if (reset_1) begin
        ctr39_out <= 1'b0;
      end
      else begin
        ctr39_out <= ctr38_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_40
      if (reset_1) begin
        ctr40_out <= 1'b0;
      end
      else begin
        ctr40_out <= ctr39_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_41
      if (reset_1) begin
        ctr41_out <= 1'b0;
      end
      else begin
        ctr41_out <= ctr40_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_42
      if (reset_1) begin
        ctr42_out <= 1'b0;
      end
      else begin
        ctr42_out <= ctr41_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_43
      if (reset_1) begin
        ctr43_out <= 1'b0;
      end
      else begin
        ctr43_out <= ctr42_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_44
      if (reset_1) begin
        ctr44_out <= 1'b0;
      end
      else begin
        ctr44_out <= ctr43_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_45
      if (reset_1) begin
        ctr45_out <= 1'b0;
      end
      else begin
        ctr45_out <= ctr44_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_46
      if (reset_1) begin
        ctr46_out <= 1'b0;
      end
      else begin
        ctr46_out <= ctr45_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_47
      if (reset_1) begin
        ctr47_out <= 1'b0;
      end
      else begin
        ctr47_out <= ctr46_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_48
      if (reset_1) begin
        ctr48_out <= 1'b0;
      end
      else begin
        ctr48_out <= ctr47_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_49
      if (reset_1) begin
        ctr49_out <= 1'b0;
      end
      else begin
        ctr49_out <= ctr48_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_50
      if (reset_1) begin
        ctr50_out <= 1'b0;
      end
      else begin
        ctr50_out <= ctr49_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_51
      if (reset_1) begin
        ctr51_out <= 1'b0;
      end
      else begin
        ctr51_out <= ctr50_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_52
      if (reset_1) begin
        ctr52_out <= 1'b0;
      end
      else begin
        ctr52_out <= ctr51_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_53
      if (reset_1) begin
        ctr53_out <= 1'b0;
      end
      else begin
        ctr53_out <= ctr52_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_54
      if (reset_1) begin
        ctr54_out <= 1'b0;
      end
      else begin
        ctr54_out <= ctr53_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_55
      if (reset_1) begin
        ctr55_out <= 1'b0;
      end
      else begin
        ctr55_out <= ctr54_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_56
      if (reset_1) begin
        ctr56_out <= 1'b0;
      end
      else begin
        ctr56_out <= ctr55_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_57
      if (reset_1) begin
        ctr57_out <= 1'b0;
      end
      else begin
        ctr57_out <= ctr56_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_58
      if (reset_1) begin
        ctr58_out <= 1'b0;
      end
      else begin
        ctr58_out <= ctr57_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_59
      if (reset_1) begin
        ctr59_out <= 1'b0;
      end
      else begin
        ctr59_out <= ctr58_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_60
      if (reset_1) begin
        ctr60_out <= 1'b0;
      end
      else begin
        ctr60_out <= ctr59_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_61
      if (reset_1) begin
        ctr61_out <= 1'b0;
      end
      else begin
        ctr61_out <= ctr60_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_62
      if (reset_1) begin
        ctr62_out <= 1'b0;
      end
      else begin
        ctr62_out <= ctr61_out;
      end
    end

  assign ctrstate_out = (clk_enable_3 == 1 ? !clk_enable_1 : ctr62_out);

  always @(posedge clk_1 or posedge reset_1)
    begin : c_63
      if (reset_1) begin
        clk_enable_3 <= 1'b1;
      end
      else begin
        clk_enable_3 <= ctrstate_out;
      end
    end

  always @(posedge clk_1 or posedge reset_1)
    begin : c_64
      if (reset_1) begin
        bypass_out <= 1'b0;
      end
      else begin
        if (clk_enable_3) begin
          bypass_out <= clk_enable_1;
        end
      end
    end

  assign clk_enable_4 = (clk_enable_3 == 1 ? clk_enable_1 : bypass_out);

  assign clk_enable_2 = clk_enable_4;

endmodule  // getHistogram_fixpt_enb_bypass

