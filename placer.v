module placer(input clk, reset, input [x_width:0] rel_x, rel_y, input[1:0] rel_type, input start, input [3:0] ram_data_read,
	output [depth+2:0] ram_address, output reg ram_write_en, output [3:0] ram_data_write, input ram_ready, output reg error, 
	output w_end, output reg [x_width:0] last_x, last_y, output reg[3:0] last_type, output[x_width:0] offset_x, offset_y, 
	output[x_width:0] max_offset_x, max_offset_y
	);
	
	parameter depth=19;
	parameter x_width=10;
	parameter y_width=x_width;
		
	assign offset_x = off_x;
	assign offset_y = off_y;
	assign max_offset_x = max_off_x;
	assign max_offset_y = max_off_y;
	
	assign w_end = (prev==14);
	
//	assign doresh = {up[2:0], down[2:0], left[2:0], right[2:0]};
	
	reg[3:0] prev, next;
	reg[3:0] up, down, left, right;
	reg up_l, down_l, left_l, right_l, last_x_l, last_y_l, last_t_l;
	
	reg unsigned[x_width:0] off_x, off_y;
	reg unsigned[x_width:0] max_off_x, max_off_y;
	
	reg minus_x, minus_y, plus_x, plus_y;
	reg[3:0] tile, tile_up, tile_down, tile_left, tile_right;
	
	always @(posedge clk) begin
		if(clk) begin
			if(reset) begin
				prev<=0;
				off_x=32;
				off_y=32;
				max_off_x=32;
				max_off_y=32;
				last_x<=32;
				last_y<=32;
			end else begin
				prev<=next;
			end
			if(minus_x==1)
				off_x = off_x - 1;
			if(minus_y==1)
				off_y = off_y - 1;
			if(plus_x==1)
				max_off_x = max_off_x + 1;
			if(plus_y==1)
				max_off_y = max_off_y + 1;
		end
		if(up_l)
			up<=ram_data_read;
		if(down_l)
			down<=ram_data_read;
		if(right_l)
			right<=ram_data_read;
		if(left_l)
			left<=ram_data_read;
		if(last_x_l)
			last_x <= off_x + rel_x;
		if(last_y_l)
			last_y <= off_y + rel_y;
		if(last_t_l)
			last_type <= tile;
	end
	
	always @(posedge clk) begin
		if(prev==10) begin
			tile=0;
			if(rel_type == 0) begin
				if(((tile_down | tile_left) | (tile_right | tile_up)) == 7) begin
				end
				else if(((tile_down | tile_left) | (tile_right | tile_up)) == 0) begin
					tile = 3;
				end
				else begin
					tile = ((tile_down | tile_left) | (tile_right | tile_up));
				end
			end
			else if(rel_type == 1) begin
				if(((tile_down | tile_left) | (tile_right | tile_up)) == 7) begin
				end
				
				else if(((tile_down | tile_left) | (tile_right | tile_up)) == 0) begin
					tile = 5;
				end
				
				else begin
					tile = ((tile_down | tile_left) | (tile_right | tile_up));
				end
			end
			if(rel_type == 2) begin
				if(((tile_down | tile_left) | (tile_right | tile_up)) == 3) begin
				end
				
				else if(((tile_down | tile_left) | (tile_right | tile_up)) == 0) begin
				end
				
				else begin
					tile = ((tile_down | tile_left) | (tile_right | tile_up));
				end
			end
		end
	end	
	
	always @(*) begin
		next = prev;
		//w_end = 0;
		//error = 0;
		minus_x=0;
		minus_y=0;
		plus_x=0;
		plus_y=0;
		ram_write_en=0;
		//ram_address=0;
		tile_down=0;
		tile_left=0;
		tile_right=0;
		tile_up=0;
		{up_l, down_l, left_l, right_l} = 4'b0;
		last_x_l=0;
		last_y_l=0;
		last_t_l=0;
		case (prev)
		0: begin
				if(start) next=1;
				else next = 0;
			end
		1: begin
				error=1'b0;
				//ram_address[x_width:0]=rel_x+off_x;
				//ram_address[2+depth:x_width+1] = rel_y+off_y-1;
				next =2;
				error=0;
			end
		2: begin
				//up=ram_data_read;
				up_l=1;
				next = 3;
			end
		3: begin
				//ram_address[x_width:0]=rel_x+off_x;
				//ram_address[2+depth:x_width+1] = rel_y+off_y+1;
				next=4;
			end
		4: begin
				//down=ram_data_read;
				down_l=1;
				next = 5;
			end
		5: begin
				//ram_address[x_width:0]=rel_x+off_x+1;
				//ram_address[2+depth:x_width+1] = rel_y+off_y;
				next=6;
			end
		6: begin
				//right = ram_data_read;
				right_l=1;
				next = 7;
			end
		7: begin
				//ram_address[x_width:0]=rel_x+off_x-1;
				//ram_address[2+depth:x_width+1] = rel_y+off_y;
				next=8;
			end
		8: begin
				//left=ram_data_read;
				left_l=1;
				next = 9;
			end
		9: begin
				next=10;
			end
		10: begin
				//tile=0;
				if(rel_type == 0) begin
					if((down == 1) || (down == 4) || (down == 6))
						tile_down = 4;
					else if(down != 0)
						tile_down = 3;		
					
					if((up == 2) || (up == 4) || (up == 5))
						tile_up=4;
					else if(up != 0)
						tile_up = 3;
					
					if((right == 2) || (right == 3) || (right == 6))
						tile_right=3;
					else if(right != 0)
						tile_right = 4;
						
					if((left == 1) || (left == 3) || (left == 5))
						tile_left=3;
					else if(left != 0)
						tile_left = 4;
					
					if(((tile_down | tile_left) | (tile_right | tile_up)) == 7) begin
						error = 1;
						next = 0;
					end
					
					else if(((tile_down | tile_left) | (tile_right | tile_up)) == 0) begin
						//tile = 3;
						next = 11;
					end
					
					else begin
						//tile = ((tile_down | tile_left) | (tile_right | tile_up));
						next = 11;
					end
				end
				else if(rel_type == 1) begin
					if((down == 1) || (down == 4) || (down == 6))
						tile_down = 5;
					else if(down != 0)
						tile_down = 6;
					
					if((up == 2) || (up == 4) || (up == 5))
						tile_up=6;
					else if(up != 0)
						tile_up = 5;
					
					if((right == 2) || (right == 3) || (right == 6))
						tile_right=5;
					else if(right != 0)
						tile_right = 6;
						
					if((left == 1) || (left == 3) || (left == 5))
						tile_left=6;
					else if(left != 0)
						tile_left = 5;
					
					if(((tile_down | tile_left) | (tile_right | tile_up)) == 7) begin
						error = 1;
						next = 0;
					end
					
					else if(((tile_down | tile_left) | (tile_right | tile_up)) == 0) begin
						next = 11;
						//tile = 5;
					end
					
					else begin
						//tile = ((tile_down | tile_left) | (tile_right | tile_up));
						next = 11;
					end
				end
				if(rel_type == 2) begin
					if((down == 1) || (down == 4) || (down == 6))
						tile_down = 2;
					else if(down != 0)
						tile_down = 1;
					
					if((up == 2) || (up == 4) || (up == 5))
						tile_up=1;
					else if(up != 0)
						tile_up = 2;
					
					if((right == 2) || (right == 3) || (right == 6))
						tile_right=1;
					else if(right != 0)
						tile_right = 2;
						
					if((left == 1) || (left == 3) || (left == 5))
						tile_left=2;
					else if(left != 0)
						tile_left = 1;
					
					if(((tile_down | tile_left) | (tile_right | tile_up)) == 3) begin
						error = 1;
						next = 0;
					end
					
					else if(((tile_down | tile_left) | (tile_right | tile_up)) == 0) begin
						error = 1;
						next = 0;
					end
					
					else begin
						//tile = ((tile_down | tile_left) | (tile_right | tile_up));
						next = 11;
					end
				end
			end
			11: begin
				//ram_address = (rel_x+off_x)+((rel_y+off_y)<<x_width);
				//last_x=(rel_x+off_x);
				//last_y=(rel_y+off_y);
				//ram_address[x_width:0]=rel_x+off_x+0;
				//ram_address[2+depth:x_width+1] = rel_y+off_y+0;
				//ram_address[depth+2:0] = {last_y, last_x};
				//ram_write_en=1;
				//last_type = tile;
				last_x_l=1;
				last_y_l=1;
				last_t_l = 1;
				next=12;
			end
			12: begin
				ram_write_en=1;
				next=15;
			end
			15: begin
				if(ram_ready==0)
					next=15;
				else
					next=13;
			end
			13: begin
				if(rel_x==0) minus_x=1;
				if(rel_y==0) minus_y=1;
				if(max_off_x==last_x) plus_x=1;
				if(max_off_y==last_y) plus_y=1;
				next=14;
			end
			14: begin
				next = 0;
				//w_end = 1;
			end
		endcase
	end
	assign ram_address[x_width:0] = ((prev==5)||(prev==6))?(off_x+rel_x+1):((prev==7)||(prev==8))?(off_x+rel_x-1):off_x+rel_x;
	assign ram_address[2+depth:x_width+1] = ((prev==1)||(prev==2))?(off_y+rel_y-1):((prev==3)||(prev==4))?(off_y+rel_y+1):off_y+rel_y;
	assign ram_data_write = tile;
endmodule