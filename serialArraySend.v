module serialArraySend(input clk, input reset, input [8*10 - 1:0] old_data ,input unsigned[5:0] count, 
				input start, input busy, output reg txdWrite, output reg [7:0] txdData, output arrayBusy);
	reg [3:0] state;
	assign arrayBusy = !(state==0);
	reg unsigned [6:0] curser;
	
	reg [7*32:0] data;
	
	always @(posedge clk) begin
		if(start)
			data <= old_data;
	end
	
	always @(posedge clk) begin
		if(clk==1) begin
			if(reset==1)
				state=0;
			txdWrite=0;
			case (state)
				0: begin curser=0; if(start==1) state=1;  end
				1: begin
						if(busy==0) begin state=2; end 
						else state=1; 
					end
				2: begin txdWrite=1; txdData=data[(8*(curser))+:8]; state=3; end
				3:	begin 
						if(curser<(count-1)) begin 
							curser=curser+1;
							state=1; 
						end 
						else state=0;
					end
			endcase
		end
	end
endmodule