module force_move(
input clk,
input reset,
input start,
input[x_width:0] last_x, last_y,

input sram_ready,
input [3:0] sram_data_in,
output [3:0] sram_data_out,
output [depth:0] sram_addr,
output reg sram_write_en,

output end_w,
output error
 );
 
	parameter depth = 21;
	parameter x_width = 10;
	parameter stack_depth=6;
	
	defparam sta.depth = depth;
	defparam sta.stack_depth = stack_depth;
	
	
	wire tile_error;
	assign error = (prev==34);
	wire empty;
	wire cmp_tile;
	wire [depth:0] d_in , d_out;
	
	reg [3:0] up, down, left, right, center;
	reg up_l, down_l, left_l, right_l, center_l;
	wire[3:0] tile_out;
	assign end_w = (prev==33)?1:0;
	reg [x_width:0] center_addr_x, center_addr_y;
	
	//assign doresh = { up[2:0], down[2:0], left[2:0], right[2:0], center[2:0] };
	//assign tos[3:0] = tile_out[3:0];
	
	wire [x_width:0] c_x_p, c_x_m, c_y_p, c_y_m;
	assign c_x_p = center_addr_x+1;
	assign c_x_m = center_addr_x-1;
	assign c_y_p = center_addr_y+1;
	assign c_y_m = center_addr_y-1;
	
	assign cmp_tile = (center[2:0]==tile_out[2:0]);
	
	assign sram_data_out = tile_out;
	reg[6:0] prev, next;
	reg push, pop;
	
	reg [2:0] sel_stack;
	
	reg [2:0] sel_mem_x;
	reg [2:0] sel_mem_y;
	
	reg center_load;
	reg center_sel;
	
	always @(posedge clk) begin
		if(reset) begin
			prev <= 0;
		end 
		else begin
			prev <= next;
		end
	end
	
	always @(posedge clk) begin
		if( center_load==1'b1 )begin
			if(center_sel==1'b0) 
				{center_addr_y[x_width:0], center_addr_x[x_width:0]} = d_out[depth:0];
			else
				{center_addr_y[x_width:0], center_addr_x[x_width:0]} = {last_y[x_width:0], last_x[x_width:0]};
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
	end
	
	always@(*) begin
		next = 0;
		sel_mem_x = 0;
		sel_mem_y = 0;
		sram_write_en = 0;
		push=0;
		pop=0;
		sel_stack = 0;
		right_l =0;
		left_l =0;
		up_l =0;
		down_l =0;
		center_l=0;
		center_load=0;
		center_sel=0;
		case(prev) 
			0: begin 
				center_sel=1;
				if(start==1)
					next = 1;
				else
					next = 0;
			end
			1: begin
				center_sel=1;
				center_load=1;
				next = 2;
			end
			2: begin
				next = 3;
			end
			3: begin
				sel_stack = 0;
				next = 4;
			end
			4: begin
				sel_stack = 0;
				push = 1;
				next = 5;
			end
			5: begin
				sel_stack = 1;
				next = 6;
			end
			6: begin
				sel_stack = 1;
				push=1;
				next = 7;
			end
			7: begin
				sel_stack = 2;
				next = 8;
			end
			8: begin
				sel_stack = 2;
				push=1;
				next = 9;
			end
			9: begin
				sel_stack = 3;
				next = 10;
			end
			10: begin
				sel_stack = 3;
				push=1;
				next = 11;
			end
			11: begin
				if(!empty)
					next=12;
				else
					next = 33;
			end
			12: begin
				center_load=1;
				next=13;
			end
			13: begin
				pop=1;
				next=14;
			end
			14: begin
				sel_mem_x = 0;
				sel_mem_y = 1;
				next = 15;
			end
			15: begin
				sel_mem_x = 0;
				sel_mem_y = 1;
				up_l = 1;
				next = 16;
			end
			16: begin
				sel_mem_x = 0;
				sel_mem_y = 2;
				next = 17;
			end
			17: begin
				sel_mem_x = 0;
				sel_mem_y = 2;
				down_l = 1;
				next = 18;
			end
			18: begin
				sel_mem_x = 1;
				sel_mem_y = 0;
				next = 19;
			end
			19: begin
				sel_mem_x = 1;
				sel_mem_y = 0;
				left_l=1;
				next = 20;
			end
			20: begin
				sel_mem_x = 2;
				sel_mem_y = 0;
				next = 21;
			end
			21: begin
				sel_mem_x = 2;
				sel_mem_y = 0;
				right_l=1;
				next = 22;
			end
			22: begin
				sel_mem_x = 0;
				sel_mem_y = 0;
				next = 23;
			end
			23: begin
				sel_mem_x = 0;
				sel_mem_y = 0;
				center_l=1;
				next = 24;
			end
				
			24: begin
				if(!tile_error) begin
					if(cmp_tile)
						next = 11;
					else
						next = 25;
				end
				else
					next = 34;
			end
			25: begin
				sram_write_en = 1;
				next = 26;
				sel_stack = 0;
			end
			26: begin
				sel_stack = 0;
				push = 1;
				next = 27;
			end
			27: begin
				sel_stack = 1;
				next = 28;
			end
			28: begin
				sel_stack = 1;
				push=1;
				next = 29;
			end
			29: begin
				sel_stack = 2;
				next = 30;
			end
			30: begin
				sel_stack = 2;
				push=1;
				next = 31;
			end
			31: begin
				sel_stack = 3;
				next = 32;
			end
			32: begin
				sel_stack = 3;
				push=1;
				next = 11;
			end
			33: begin
				next = 0;
			end
			34: begin
				next = 0;
			end
		endcase
	end
	
	assign sram_addr[depth:x_width+1] = (sel_mem_y==1)? (c_y_m) : (sel_mem_y==2)? (c_y_p) : center_addr_y ;
	assign sram_addr[x_width:0] = (sel_mem_x==1)? (c_x_m) : (sel_mem_x==2)? (c_x_p) : center_addr_x ;
	
	wire [stack_depth:0] spt;
	stack sta(reset, d_in, push, pop, clk, d_out, of, uf, empty);
	
	/*wire [depth:0] moves_out;
	stack moves(reset, sram_addr, sram_write_en, 1'b0 , clk, force_last_move);*/
	
	assign d_in = (sel_stack==0)?({c_y_m,center_addr_x}):(sel_stack==1)?({c_y_p, center_addr_x}):(sel_stack==2)?
					({center_addr_y,c_x_m}):(sel_stack==3)?({center_addr_y,c_x_p}):0;
	set_tile_force_move(
		left, down, right, up, center,
		tile_out, tile_error);
endmodule