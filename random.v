module random(input color, input [x_width:0] last_x, last_y, input clk, input reset, input [3:0] sram_data_in, input start, 
	output ready, output [depth+2:0] sram_addr
	, output [x_width:0] x, y, output [3:0] tile_type);

	parameter depth = 19,
	x_width = 10, 
	y_width = x_width;
	
	assign ready = (prev==20);
	//assign ready = 0;
	
	//assign doresh[11:0] = {left[2:0],up[2:0],right[2:0], down[2:0]};
	reg [x_width:0] center_x;
	reg [5:0] prev, next;
	reg [2:0] sel_mem_x;
	reg [2:0] sel_mem_y;
	reg [3:0] up, down, left, right, center, up_left, up_right, down_left, down_right;
	reg up_l, down_l, left_l, right_l, center_l, up_left_l, up_right_l, down_left_l, down_right_l, center_x_l, center_x_sel;
	
	wire[3:0] tile_out;
	wire [1:0] tile_out_pos;
	wire isEmpty;
	
	assign isEmpty = ((((up | down) | (left | right)) | ((center | up_left) | (up_right | down_left))) | down_right) == 4'b0;
	
	wire [x_width:0] c_x_m, c_x_p, c_y_m, c_y_p; 
	
	assign c_x_p = center_x+1;
	assign c_x_m = center_x-1;
	assign c_y_p = last_y+1;
	assign c_y_m = last_y-1;
	
	assign sram_addr[depth+2:x_width+1] = (sel_mem_y==1)? (c_y_m) : (sel_mem_y==2)? (c_y_p) : last_y ;
	assign sram_addr[x_width:0] = (sel_mem_x==1)? (c_x_m) : (sel_mem_x==2)? (c_x_p) : center_x ;
	
	//assign tile_out = 3;
	//assign tile_out_pos = 2;
	
	assign x = (isEmpty==1)? center_x : (tile_out_pos==2)?center_x+1:(tile_out_pos==0)?center_x-1:center_x;
	assign y = (isEmpty==1)? last_y : (tile_out_pos==1)?last_y-1:(tile_out_pos==3)?last_y+1:last_y;
	assign tile_type = (isEmpty==1)? 3 : tile_out;
	
	always @(posedge clk) begin
		if(reset) begin
			prev <= 0;
		end 
		else begin
			prev <= next;
		end
	end
	
	always@(posedge clk) begin 
		if(center_x_l == 1) begin
			if(center_x_sel == 0)
				center_x = last_x;
			else 
				center_x = center_x + 1;
		end
	end
	
	always @(posedge clk) begin
		if(up_l==1)
			up = sram_data_in;
		if(down_l==1)
			down = sram_data_in;
		if(left_l==1)
			left = sram_data_in;
		if(right_l==1)
			right = sram_data_in;
		if(center_l==1)
			center = sram_data_in;
		if(up_left_l == 1)
			up_left = sram_data_in;
		if(up_right_l == 1)
			up_right = sram_data_in;
		if(down_left_l == 1)
			down_left = sram_data_in;
		if(down_right_l == 1)
			down_right = sram_data_in;	
	end
	
	always@(*) begin
		next = 0;
		sel_mem_x = 0;
		sel_mem_y = 0;
		right_l =0;
		left_l =0;
		center_x_l = 0;
		center_x_sel = 0;
		up_l =0;
		down_l =0;
		center_l=0;
		down_left_l = 0;
		down_right_l = 0;
		up_left_l = 0;
		up_right_l = 0;
		case(prev) 
			0: begin
				center_x_l = 1;
				if(start==1)begin
					next = 21;
				end
				else
					next = 0;
			end
			
			21: begin 
				center_x_l = 1;
				next = 1;
			end
			
			1: begin 
				center_l = 1;
				next = 2;
	//			end
			end
			
			2: begin 
				sel_mem_x = 0;
				sel_mem_y = 1;
				next = 3;
			end
			
			3: begin 
				sel_mem_x = 0;
				sel_mem_y = 1;
				next = 4;
				up_l = 1;
			end
			
			4: begin 
				sel_mem_x = 1;
				sel_mem_y = 0;
				next = 5;
			end
			
			5: begin 
				sel_mem_x = 1;
				sel_mem_y = 0;
				next = 6;
				left_l = 1;
			end
			
			6: begin 
				sel_mem_x = 2;
				sel_mem_y = 0;
				next = 7;
			end

			7: begin 
				sel_mem_x = 2;
				sel_mem_y = 0;
				next = 8;
				right_l = 1;
			end
			
			8: begin 
				sel_mem_x = 0;
				sel_mem_y = 2;
				next = 9;
			end
			
			9: begin 
				sel_mem_x = 0;
				sel_mem_y = 2;
				next = 10;
				down_l = 1;
			end
			
			10: begin 
				sel_mem_x = 1;
				sel_mem_y = 1;
				next = 11;
			end
			
			11: begin 
				sel_mem_x = 1;
				sel_mem_y = 1;
				next = 12;
				up_left_l = 1;
			end
			
			12: begin 
				sel_mem_x = 2;
				sel_mem_y = 1;
				next = 13;
			end
			
			13: begin 
				sel_mem_x = 2;
				sel_mem_y = 1;
				next = 14;
				up_right_l = 1;
			end
			
			14: begin 
				sel_mem_x = 1;
				sel_mem_y = 2;
				next = 15;
			end
			
			15: begin 
				sel_mem_x = 1;
				sel_mem_y = 2;
				next = 16;
				down_left_l = 1;
			end
			
			16: begin 
				sel_mem_x = 2;
				sel_mem_y = 2;
				next = 17;
			end
			
			17: begin 
				sel_mem_x = 2;
				sel_mem_y = 2;
				next = 18;
				down_right_l = 1;
			end
			
			18: begin 
				// get tile output
				next = 28;
			end
			
			28: begin
				next=19;
			end
			
			19: begin 
			//	next = 20;
				if(tile_out==4'b0000 && ~isEmpty)
					next = 22;
				else
					next = 20;
			end
			20: begin
					next = 0;
			end
			
			22: begin 
				center_x_sel = 1;
				next = 23;
			end
			
			23: begin 
				center_x_l = 1;
				center_x_sel = 1;
				next = 24;
			end
			
			24: begin 
				center_l = 1;
				next = 25;
			end
			
			25: begin 
				sel_mem_x = 2;
				next = 26;
			end
			
			26: begin 
				sel_mem_x = 2;
				right_l = 1;
				next = 27;
			end
			
			27: begin 
				if(right == 4'b0)
					next = 1;
				else 
					next = 22;
			end
		endcase
	end
	
	set_tile_random(
		up_left, up, up_right, left, center, right, down_left, down, down_right, 
		2'b0, color,
		tile_out,
		tile_out_pos
	);
	
endmodule