module getHistogram
          (
           clk,
           magnitudes,
           angles_1,
           enable,
           H_0,
           H_1,
           H_2,
           H_3,
           H_4,
           H_5,
           H_6,
           H_7,
           H_8
          );
		  
  input wire clk;
  input wire   [13:0] magnitudes;  // ufix14_En7
  input wire   [13:0] angles_1;  // sfix14_En1  output  ce_out;
  input wire enable;
  output  reg [13:0] H_0 =0 ;  // sfix14_E1
  output  reg [13:0] H_1;  // sfix14_E1
  output  reg [13:0] H_2;  // sfix14_E1
  output  reg [13:0] H_3;  // sfix14_E1
  output  reg [13:0] H_4;  // sfix14_E1
  output  reg [13:0] H_5;  // sfix14_E1
  output  reg [13:0] H_6;  // sfix14_E1
  output  reg [13:0] H_7;  // sfix14_E1
  output  reg [13:0] H_8;  // sfix14_E1
  
  
  always @(posedge clk)
  begin
	 if (enable == 1'b0)
  	begin
  	 H_0 <= 13'b0;
  	 H_1 <= 13'b0;
	  H_2 <= 13'b0;
  	 H_3 <= 13'b0;
	  H_4 <= 13'b0;
	  H_5 <= 13'b0;
	  H_6 <= 13'b0;
	  H_7 <= 13'b0;
	  H_8 <= 13'b0;
	 end	  
  else
  begin  
  if ((0 < angles_1) && (angles_1 <= 20)) 
	begin
		H_0 <= H_0 + magnitudes;
	end
    else if ((20 < angles_1) && (angles_1 <= 40)) 
	begin
		H_1 <= H_1 + magnitudes;
	end
	else if ((40 < angles_1) && (angles_1 <= 60)) 
	begin
		H_2 <= H_2 + magnitudes;
	end
	else if ((60 < angles_1) && (angles_1 <= 80)) 
	begin
		H_3 <= H_3 + magnitudes;
	end
	else if ((80 < angles_1) && (angles_1 <= 100)) 
	begin
		H_4 <= H_4 + magnitudes;
	end
	else if ((100 < angles_1) && (angles_1 <= 120)) 
	begin
		H_5 <= H_5 + magnitudes;
	end
	else if ((120 < angles_1) && (angles_1 <= 140)) 
	begin
		H_6 <= H_6 + magnitudes;
	end
	else if ((140 < angles_1) && (angles_1 <= 160)) 
	begin
		H_7 <= H_7 + magnitudes;
	end
	else if ((160 < angles_1) && (angles_1 <= 180)) 
	begin
		H_8 <= H_8 + magnitudes;
	end
	end
  end

endmodule