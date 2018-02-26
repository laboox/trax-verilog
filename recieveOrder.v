module recieveOrder(input [7:0] inData, input dataReady, output reg isWhite, input clk, 
	input reset, output reg [x_width:0] rel_x, rel_y, output reg [1:0] type, output w_end);
	reg [3:0] prev, next;
	parameter x_width=10;
	always @(posedge clk) begin
		//if(clk==1) begin
			if(reset==1)
				prev<=0;
			else
				prev<=next;
		//end
	end
	
	assign w_end = (prev==7)||(prev==8);
	//assign reset = (prev==0);
	
	always @(posedge clk) begin
		if(reset)
			next=0;
		case (prev)
			0: begin if(dataReady && inData==8'd45) next=1; end
			1: begin if(dataReady && inData==8'd87) begin isWhite=1; next=2; end 
				else if(dataReady && inData==8'd66) begin isWhite=0; next=2; end end
			2:	begin if(dataReady && inData==8'd10) next=8; end
			8: begin
				next = 3;
			end
			3: begin if(dataReady) begin rel_x=inData-8'd64; rel_y=0; next=4; end end
			4: begin
				if(dataReady) begin
					if(8'd64<=inData && inData<=8'd90) begin 
						rel_x=(rel_x)*8'd26 + (inData-8'd64); next=4; 
					end else begin 
						rel_y=inData-8'd48; next=5;
					end end
				end
			5: begin
				if(dataReady) begin
					if((8'd47<inData) && (inData<8'd58)) begin
						rel_y=(rel_y*8'd10) + (inData-8'd48); next=5;
					end
					else begin
						if(inData==8'd43)
							type=0; // +
						if(inData==8'd47)
							type=1; // /
						if(inData==8'd92)
							type=2; // \
						next=6;
					end
				end
				end
			6: begin 
					if(dataReady) begin
						if(inData==8'd10) next=7;
						else next=6;
					end
				end
			7: next=3;
		endcase
	end
	
endmodule