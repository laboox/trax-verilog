module set_tile_force_move(
input[3:0] left, down, right, up, tile,
output reg[3:0] tile_out,
output reg error
);
	
	always@(*) begin
		tile_out = 4'b0000;
		error = 0;
		if((left == 1 || left == 3 || left == 5) && (up == 2 || up == 4 || up == 5) && (right == 2 || right == 3 || right == 6))
			error = 1;
		else if((up == 2 || up == 4 || up == 5) && (right == 2 || right == 3 || right == 6) && (down == 1 || down == 4 || down == 6))
			error = 1;
		else if((right == 2 || right == 3 || right == 6) && (down == 1 || down == 4 || down == 6) && (left == 1 || left == 3 || left == 5))
			error = 1;
		else if((down == 1 || down == 4 || down == 6) && (left == 1 || left == 3 || left == 5) && (up == 2 || up == 4 || up == 5))
			error = 1;
		else if ((left == 2 || left == 4 || left == 6) && (up == 1 || up == 3 || up == 6) && (right == 1 || right == 4 || right == 5))
			error = 1;
		else if ((up == 1 || up == 3 || up == 6) && (right == 1 || right == 4 || right == 5) && (down == 2 || down == 3 || down == 5))
			error = 1;
		else if ((right == 1 || right == 4 || right == 5) && (down == 2 || down == 3 || down == 5) && (left == 2 || left == 4 || left == 6))
			error = 1;
		else if ((down == 2 || down == 3 || down == 5) && (left == 2 || left == 4 || left == 6) && (up == 1 || up == 3 || up == 6))
			error = 1;
				
		if(tile == 4'b0000) begin	
			if(error == 0) begin
				if((left == 1 || left == 3 || left == 5) && (down == 1 || down == 4 || down == 6))
					tile_out = 2;
				else if((left == 2 || left == 4 || left == 6) && (down == 2 || down == 3 || down == 5))
					tile_out = 1;
				else if((left == 1 || left == 3 || left == 5) && (up == 2 || up == 4 || up == 5))
					tile_out = 6;
				else if((left == 2 || left == 4 || left == 6) && (up == 1 || up == 3 || up == 6))
					tile_out = 5;
				else if((up == 2 || up == 4 || up == 5) && (right == 6 || right == 3 || right == 2))
					tile_out = 1;
				else if((up == 1 || up == 3 || up == 6) && (right == 1 || right == 4 || right == 5))
					tile_out = 2;
				else if((right == 6 || right == 3 || right == 2) && (down == 1 || down == 4 || down == 6))
					tile_out = 5;
				else if((right == 1 || right == 4 || right == 5) && (down == 2 || down == 3 || down == 5))
					tile_out = 6;
				else if((left == 1 || left == 3 || left == 5) && (right == 2 || right == 3 || right == 6))
					tile_out = 3;
				else if((left == 2 || left == 4 || left == 6) && (right == 1 || right == 4 || right == 5))
					tile_out = 4;
				else if((down == 1 || down == 4 || down == 6) && (up == 2 || up == 4 || up == 5))
					tile_out = 4;
				else if((down == 2 || down == 3 || down == 5) && (up == 1 || up == 3 || up == 6))
					tile_out = 3;	
			end
		end
		else begin
			tile_out = tile;
		end
	
	end

endmodule