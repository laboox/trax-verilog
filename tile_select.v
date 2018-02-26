module tile_select(input arrayBusy, input [1:0] st, input isWhite, input clk, input reset, input start,input [3:0] ram_data_read, 
	input ram_ready,input [x_width:0] old_off_x, old_off_y, old_max_off_x, old_max_off_y,
	old_last_x, old_last_y,output [x_width:0] offset_x_out, offset_y_out, output ram_write_en, output [3:0] ram_data_out, 
	output [depth:0]ram_addr , output[x_width:0] out_x, out_y, 
	output [3:0] out_t, output reg w_end, output reg clean_mark, output [17:0] cycle_weight, output [4:0] state);
	
parameter x_width=10;
parameter depth = 21;

reg [x_width:0] last_x, last_y, off_x, off_y, max_off_y, max_off_x;	

assign offset_x_out = off_x;
assign offset_y_out = off_y;
//assign clean_mark = 0;

always @(posedge clk) begin
	if(reset) begin
		off_x<=32;
		off_y<=32;
		max_off_y<=32;
		max_off_x<=32;
	end
	else if(start) begin
		last_x<=old_last_x;
		last_y<=old_last_y;
		off_x<=old_off_x;
		off_y<=old_off_y;
		max_off_x<=old_max_off_x;
		max_off_y<=old_max_off_y;
	end
end

/*wire random_end;

defparam rand.depth = depth-2;
defparam rand.x_width = x_width;
random rand(isWhite, last_x, last_y, clk, reset, ram_data_read, start, 
	random_end, ram_addr
	, select_x, select_y, select_t);
*/

reg isEnemy;
	
defparam fml.depth = depth;
defparam fml.x_width = x_width;
findMinLoop fml(
	st,
	clk,
	reset,
	fml_start,
	isWhite,
	isEnemy,
	off_x, off_y, max_off_x, max_off_y,
	ram_data_read, ram_ready , ram_data_out, ram_addr, ram_write_en,
	select_x, select_y, select_t,
	weight,
	fml_ready, state, cycle_weight
); 


wire [x_width:0] weight;

/*defparam breat.depth = depth;
defparam breat.x_width = x_width;
BFS breat(st, clk, reset, bfs_start, last_x, last_y, ram_data_read, ram_ready, ram_data_out, 
			ram_addr, ram_write_en, isWhite, w_end, cycle_weight, state);
	*/
//assign ram_write_en = 0;

always @(posedge clk) begin
	if(our_move_l) begin
		our_x<=select_x;
		our_y<=select_y;
		our_t<= select_t;
		our_w<= weight;
	end
	if(enemy_move_l) begin
		enemy_x<=select_x;
		enemy_y<=select_y;
		enemy_t<= select_t;
		enemy_w<= weight;
	end
end

assign {out_x, out_y, out_t} = (sel_out==0)?({our_x,our_y,our_t}):(sel_out==1)?({enemy_x,enemy_y,enemy_t}):({off_x, off_y, first_t});

wire [x_width:0] select_x, select_y;
wire [3:0] first_t, select_t;
assign first_t = 3;


reg [x_width:0] our_x, our_y, our_w;
reg [3:0] our_t;
reg [x_width:0] enemy_x, enemy_y, enemy_w;
reg [3:0] enemy_t;

reg fml_start;
reg our_move_l;
reg enemy_move_l;
reg [1:0] sel_out;
wire fml_ready;
reg [6:0] prev, next;
always @(posedge clk) begin
	if(reset)
		prev<=0;
	else
		prev<=next;
end

always @(*) begin
	next = prev;
	clean_mark=0;
	fml_start=0;
	isEnemy=0;
	our_move_l=0;
	enemy_move_l=0;
	sel_out = 0;
	w_end = 0;
	
	case(prev)
	0: begin
		if(start) begin
			next = 19;
		end
		else
			next = 0;
	end
	19: begin
		next = 20;
	end
	20: begin
		if( (off_x == max_off_x) && (off_y==max_off_y) )
			next = 12;
		else 
			next = 1;
	end
	11: begin
		sel_out = 2;
		if(arrayBusy==1) next = 11;
		else next = 0;
	end
	12: begin
		w_end = 1;
		next = 11;
		sel_out=2;
	end
	1: begin
		clean_mark=1;
		next=2;
	end
	2: begin
		if(ram_ready==0)
			next=2;
		else next = 3;
	end
	3: begin
		fml_start=1;
		next = 4;
	end
	4: begin
		if(fml_ready==0)
			next=4;
		else
			next=5;
	end
	5: begin
		our_move_l=1;
		next = 13;
	end
	13: begin
		clean_mark = 1;
		next = 18;
	end
	18: begin
		if(ram_ready==0)
			next=18;
		else next = 6;
	end
	6: begin
		isEnemy = 1;
		fml_start = 1;
		next = 7;
	end
	7: begin
		isEnemy = 1;
		if(fml_ready==0)
			next=7;
		else
			next=8;
	end
	8: begin
		isEnemy=1;
		enemy_move_l=1;
		next=9;
	end
	9: begin
		isEnemy=1;
		next=10;
	end
	10: begin
		if(our_w <= enemy_w)
			next = 14;
		else 
			next = 16;
	end
	14: begin
		sel_out = 0;
		w_end = 1;
		next = 15;
	end
	15: begin
		sel_out = 0;
		if(arrayBusy==1) next = 15;
		else next = 0;
	end
	16: begin
		sel_out = 1;
		w_end = 1;
		next = 17;
	end
	17: begin
		sel_out = 1;
		if(arrayBusy==1) next = 17;
		else next = 0;
	end
	endcase
end

endmodule