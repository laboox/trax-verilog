module set_dir(
input[3:0] tile,
input color, // 1 = White,  0 = Black
output reg left, up, right, down
);

	always@(*)begin
		left = 0;
		up = 0;
		right = 0;
		down = 0;
		if(color)begin  /// choice for white
			if((tile == 4'b0000) || (tile[3] == 1'b1)) begin
				left = 1'b1;
				up = 1'b1;
				right = 1'b1;
				down = 1'b1;
			end
			
			if(tile == 4'd1)begin
				left = 1'b1;
				up = 1'b0;
				right = 1'b0;
				down = 1'b1;
			end
			
			if(tile == 4'd2)begin
				left = 1'b0;
				up = 1'b1;
				right = 1'b1;
				down = 1'b0;
			end
			
			if(tile == 4'd3)begin
				left = 1'b0;
				up = 1'b1;
				right = 1'b0;
				down = 1'b1;
			end
			
			if(tile == 4'd4)begin
				left = 1'b1;
				up = 1'b0;
				right = 1'b1;
				down = 1'b0;
			end
			
			if(tile == 4'd5)begin
				left = 1'b1;
				up = 1'b1;
				right = 1'b0;
				down = 1'b0;
			end
			
			if(tile == 4'd6)begin
				left = 1'b0;
				up = 1'b0;
				right = 1'b1;
				down = 1'b1;
			end
			
		end
		
		else begin  // choice for black
			if((tile == 4'b0000) || (tile[3] == 1'b1)) begin
				left = 1'b1;
				up = 1'b1;
				right = 1'b1;
				down = 1'b1;
			end
			
			if(tile == 4'd1)begin
				left = 1'b0;
				up = 1'b1;
				right = 1'b1;
				down = 1'b0;
			end
			
			if(tile == 4'd2)begin
				left = 1'b1;
				up = 1'b0;
				right = 1'b0;
				down = 1'b1;
			end
			
			if(tile == 4'd3)begin
				left = 1'b1;
				up = 1'b0;
				right = 1'b1;
				down = 1'b0;
			end
			
			if(tile == 4'd4)begin
				left = 1'b0;
				up = 1'b1;
				right = 1'b0;
				down = 1'b1;
			end
			
			if(tile == 4'd5)begin
				left = 1'b0;
				up = 1'b0;
				right = 1'b1;
				down = 1'b1;
			end
			
			if(tile == 4'd6)begin
				left = 1'b1;
				up = 1'b1;
				right = 1'b0;
				down = 1'b0;
			end
		end
		
	end

endmodule

