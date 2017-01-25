module getHistogram
          (
  input wire clk,
  input wire   [13:0] magnitudes,  // ufix14_En7
  input wire   [13:0] angles_1,  // sfix14_En1  output  ce_out;
  input wire enable,
  output  reg [117:0] H  // sfix14_E1
  );
  
  reg [13:0] array [0:8];
  
  always @(posedge clk)
  begin
	 if (enable == 1'b1)
  	begin
  if ((0 < angles_1) && (angles_1 <= 20)) 
	begin
		array[0] <= array[0] + magnitudes;
	end
    else if ((20 < angles_1) && (angles_1 <= 40)) 
	begin
		array[1] <= array[1] + magnitudes;
	end
	else if ((40 < angles_1) && (angles_1 <= 60)) 
	begin
		array[2] <= array[2] + magnitudes;
	end
	else if ((60 < angles_1) && (angles_1 <= 80)) 
	begin
		array[3] <= array[3] + magnitudes;
	end
	else if ((80 < angles_1) && (angles_1 <= 100)) 
	begin
		array[4] <= array[4] + magnitudes;
	end
	else if ((100 < angles_1) && (angles_1 <= 120)) 
	begin
		array[5] <= array[5] + magnitudes;
	end
	else if ((120 < angles_1) && (angles_1 <= 140)) 
	begin
		array[6] <= array[6] + magnitudes;
	end
	else if ((140 < angles_1) && (angles_1 <= 160)) 
	begin
		array[7] <= array[7] + magnitudes;
	end
	else if ((160 < angles_1) && (angles_1 <= 180)) 
	begin
		array[8] <= array[8] + magnitudes;
	end
	H <= {array[8], array[7], array[6], array[5], array[4], array[3], array[2], array[1], array[0]};
	end
  else
  begin 	  
  	 H <= 117'b0;
  	 array[0] <= 13'b0;
  	 array[1] <= 13'b0;
	  array[2] <= 13'b0;
  	 array[3] <= 13'b0;
	  array[4] <= 13'b0;
	  array[5] <= 13'b0;
	  array[6] <= 13'b0;
	  array[7] <= 13'b0;
	  array[8] <= 13'b0;
 end	  
	
	
  end

	
endmodule