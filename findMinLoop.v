module findMinLoop(
	input [1:0] key,
	input clk,
	input reset,
	input start,
	input isWhite,
	input isEnemy,
	input [x_width:0] off_x, off_y, max_off_x, max_off_y,
	input[3:0] ram_in, input ram_ready , output [3:0] ram_out, output [depth:0] ram_addr, output reg ram_write_en,
	output [x_width:0] t_s_x, t_s_y, output [3:0] t_s_t,
	output [w_weight:0] weight,
	output w_end, output [4:0] state, output [17:0] doresh
);

assign state = prev;

parameter depth = 19;
parameter x_width = 10;
parameter w_weight = x_width;

reg [x_width:0] c_x, c_y;
reg [1:0] c_l_base;
reg [1:0] c_l_plus;

assign doresh = key[1]?{DR2X[7:0], DR2Y[7:0], par2}:{DR1X[7:0], DR1Y[7:0], par1};

always @(posedge clk) begin
	if(c_l_base) begin
		c_x = off_x + 1;
		c_y = off_y + 1;
	end
	else if(c_l_plus) begin
		if(c_x>=max_off_x-1) begin
			c_x = off_x + 1;
			c_y = c_y + 1;
		end
		else
			c_x = c_x + 1;
	end
end

wire first_left, first_up, first_down, first_right;
set_dir(
pointer,
isWhite^isEnemy, // 1 = White,  0 = Black
first_left, first_up, first_right, first_down
);

reg [x_width:0] min_x_1, min_y_1;
reg [x_width:0] min_x_2, min_y_2;
reg mins_l;

always @(posedge clk) begin
	if(start) begin
		min_x_1 <= 0;
		min_y_1 <= 0;
		min_x_2 <= (1<<x_width)-1;
		min_y_2 <= (1<<x_width)-1;
	end
	else if(mins_l) begin
		min_x_1 <= DR1X;
		min_y_1 <= DR1Y;
		min_x_2 <= DR2X;
		min_y_2 <= DR2Y;
	end
end

wire littleThan;

assign littleThan = (((min_x_1<min_x_2)?(min_x_2-min_x_1):(min_x_1-min_x_2)) + ((min_y_1<min_y_2)?(min_y_2-min_y_1):(min_y_1-min_y_2)))
							> (((DR1X<DR2X)?(DR2X-DR1X):(DR1X-DR2X)) + ((DR1Y<DR2Y)?(DR2Y-DR1Y):(DR1Y-DR2Y)));
assign weight = (((min_x_1<min_x_2)?(min_x_2-min_x_1):(min_x_1-min_x_2)) + ((min_y_1<min_y_2)?(min_y_2-min_y_1):(min_y_1-min_y_2)));
reg [x_width:0] DR1X, DR1Y, DR2X, DR2Y;
reg [1:0] par1, par2;
reg [2:0] DR1_l, DR2_l;
reg [2:0] DR1_c, DR2_c;
reg skip1;

always @(posedge clk) begin
	if(prev==4)
		skip1=0;
	if(DR1_l==0) begin
		skip1=1;
		DR1X = c_x_m;
		DR1Y = c_y;
		par1 = 2;
	end
	else if(DR1_l==1) begin
		skip1=1;
		DR1X = c_x;
		DR1Y = c_y_m;
		par1 = 3;
	end
	else if(DR1_l==2) begin
		skip1=1;
		DR1X = c_x_p;
		DR1Y = c_y;
		par1 = 0;
	end
	else if(DR1_l==3) begin
		skip1=1;
		DR1X = c_x;
		DR1Y = c_y_p;
		par1 = 1;
	end
	
	if(DR2_l==0) begin
		DR2X = c_x_m;
		DR2Y = c_y;
		par2=2;
	end
	else if(DR2_l==1) begin
		DR2X = c_x;
		DR2Y = c_y_m;
		par2=3;
	end
	else if(DR2_l==2) begin
		DR2X = c_x_p;
		DR2Y = c_y;
		par2 = 0;
	end
	else if(DR2_l==3) begin
		DR2X = c_x;
		DR2Y = c_y_p;
		par2=1;
	end
	
	
	
	if(DR1_c==0) begin
		DR1X = DR1X-1;
		par1 = 2;
	end
	else if(DR1_c==1) begin
		DR1Y = DR1Y-1;
		par1 = 3;
	end
	else if(DR1_c==2) begin
		DR1X = DR1X+1;
		par1 = 0;
	end
	else if(DR1_c==3) begin
		DR1Y = DR1Y+1;
		par1 = 1;
	end
	
	if(DR2_c==0) begin
		DR2X = DR2X-1;
		par2=2;
	end
	else if(DR2_c==1) begin
		DR2Y = DR2Y - 1;
		par2=3;
	end
	else if(DR2_c==2) begin
		DR2X = DR2X+1;
		par2 = 0;
	end
	else if(DR2_c==3) begin
		DR2Y = DR2Y+1;
		par2=1;
	end
end

wire [1:0] next_dir1, next_dir2;

find_dir find_dir_DR1(
pointer,
par1,
isWhite, isEnemy, 
next_dir1
);

find_dir find_dir_DR2(
pointer,
par2,
isWhite, isEnemy, 
next_dir2
);

wire [x_width:0] c_x_p, c_y_p, c_x_m, c_y_m;

assign c_x_p = c_x + 1;
assign c_y_p = c_y + 1;
assign c_x_m = c_x - 1;
assign c_y_m = c_y - 1;

wire [x_width:0] d_x_p, d_y_p, d_x_m, d_y_m;

assign d_x_p = DR1X + 1;
assign d_y_p = DR1Y + 1;
assign d_x_m = DR1X - 1;
assign d_y_m = DR1Y - 1;

wire [x_width:0] min_x_p, min_y_p, min_x_m, min_y_m;

assign min_x_p = min_x_1 + 1;
assign min_y_p = min_y_1 + 1;
assign min_x_m = min_x_1 - 1;
assign min_y_m = min_y_1 - 1;



reg [1:0] ram_sel;
reg [1:0] neigh_sel;
reg mark;
assign ram_addr = (ram_sel==1)?({mark,DR1Y[(x_width-1):0],DR1X[x_width:0]}):(ram_sel==2)?({mark,DR2Y[(x_width-1):0],DR2X[x_width:0]})
						:(ram_sel==0)?({mark,c_y[(x_width-1):0],c_x}): 
						( (neigh_sel==0)?({min_y_1,min_x_m}):(neigh_sel==1)?({min_y_m,min_x_1}):(neigh_sel==2)?({min_y_1,min_x_p})
						:({min_y_p,min_x_1}));

assign ram_out = 4'b1111;

reg [3:0] pointer, up, left, right, down;
reg p_l, up_l, left_l, right_l, down_l;
always @(posedge clk) begin
	if(p_l)
		pointer <= ram_in;
	if(up_l)
		up <= ram_in;
	if(left_l)
		left <= ram_in;
	if(right_l)
		right <= ram_in;
	if(down_l)
		down <= ram_in;
end

best_tile(isWhite, isEnemy, min_x_1, min_y_1, min_x_2, min_y_2, 
up, right, down, left, t_s_t);

assign t_s_x = min_x_1;
assign t_s_y = min_y_1;

reg [7:0] prev, next;
reg stop;
always @(posedge clk) begin
	if(reset)
		prev<=0;
	else begin
		//if(key[0]==stop || start || next<40 || next==39 || next==31) begin
			prev<=next;
		//	stop = !stop;
		//end
	end
end

assign w_end = (prev==12);
always @(*) begin
	next = prev;
	c_l_base = 0;
	c_l_plus = 0;
	mark=0;
	ram_sel=0;
	p_l=0;
	ram_write_en = 0;
	 DR1_l = 4;
	 DR2_l = 4;
	 DR1_c = 4;
	 DR2_c = 4;
	 mins_l=0;
	 neigh_sel=0;
	 
	 {left_l, right_l, down_l, up_l} = 4'b0;
	
	case (prev) 
	0: begin
		if(start) begin
			next = 1;
		end
		else next=0;
	end
	1: begin
		c_l_base=1;
		next = 2;
	end
	2: begin
		ram_sel=0;
		mark=1;
		next=3;
	end
	3: begin
		ram_sel=0;
		mark=1;
		p_l=1;
		next=15;
	end
	15: begin
		next = 4;
	end
	4: begin
		if(pointer!=0)
			next = 10;
		else
			next = 5;
	end
	5: begin
		ram_sel=0;
		next=6;
	end
	6: begin
		ram_sel=0;
		p_l=1;
		next=16;
	end
	16: begin
		next = 7;
	end
	7: begin
		if(pointer==0)
			next = 10;
		else
			next = 8;
	end
	8: begin
		ram_sel=0;
		mark=1;
		next = 9;
	end
	9: begin
		ram_sel=0;
		mark = 1;
		ram_write_en = 1;
		next = 13; 
	end
	13: begin
		ram_sel=0;
		mark = 1;
		if(ram_ready==0) next = 13;
		else next = 17;
	end
	10: begin // update center
		c_l_plus=1;
		next=14;
	end
	14: begin
		next = 11;
	end
	11: begin
		if(c_y>=max_off_y)
			next = 42; // goto end
		else
			next = 2;
	end
	12: begin
		next = 0; // end state
	end
	17: begin
		if(first_left==1) begin
			DR1_l = 0;
		end
		next = 18;
	end
	18: begin
		next=19;
	end
	19: begin
		if(first_up==1) begin
			if(skip1==1)
				DR2_l = 1;
			else
				DR1_l = 1;
		end
		next = 20;
	end
	20: begin
		next = 21;
	end
	21: begin
		if(first_right==1) begin
			if(skip1==1)
				DR2_l = 2;
			else
				DR1_l = 2;
		end
		next = 22;
	end
	22: begin
		next = 23;
	end
	23: begin
		if(first_down==1) begin
			if(skip1==1)
				DR2_l = 3;
			else
				DR1_l = 3;
		end
		next = 24;
	end
	24: begin
		next = 25;
	end
	25: begin // load 2
		ram_sel=2;
		next=26;
	end
	26: begin
		ram_sel=2;
		p_l=1;
		next=27;
	end
	27: begin
		next=28;
	end
	28: begin
		if(pointer == 4'b0)
			next = 32;
		else
			next = 29;
	end
	29: begin
		ram_sel=2;
		mark=1;
		ram_write_en=1;
		next = 30;
	end
	30: begin
		ram_sel=2;
		mark=1;
		if(ram_ready == 0) next = 30;
		else next = 31;
	end
	31: begin
		DR2_c = next_dir2;
		next = 24;
	end
	32: begin // load 1
		next = 33;
	end
	33: begin 
		ram_sel=1;
		next=34;
	end
	34: begin
		ram_sel=1;
		p_l=1;
		next=35;
	end
	35: begin
		next=36;
	end
	36: begin
		if(pointer == 4'b0)
			next = 40;
		else
			next = 37;
	end
	37: begin
		ram_sel=1;
		mark=1;
		ram_write_en=1;
		next = 38;
	end
	38: begin
		ram_sel=1;
		mark=1;
		if(ram_ready == 0) next = 38;
		else next = 39;
	end
	39: begin
		DR1_c = next_dir1;
		next = 32;
	end
	40: begin // compare
		next = 41;
	end
	41: begin
		if(littleThan)
			mins_l=1;
		next = 10;
	end
	42: begin  // load up down left right 
		next = 43;
	end
	43: begin
		neigh_sel = 0;
		ram_sel=3;
		next=44;
	end
	44: begin
		neigh_sel = 0;
		ram_sel=3;
		left_l=1;
		next = 45;
	end
	45: begin
		neigh_sel = 1;
		ram_sel=3;
		next=46;
	end
	46: begin
		neigh_sel = 1;
		ram_sel=3;
		up_l=1;
		next = 47;
	end
	47: begin
		neigh_sel = 2;
		ram_sel=3;
		next=48;
	end
	48: begin
		neigh_sel = 2;
		ram_sel=3;
		right_l=1;
		next = 49;
	end
	49: begin
		neigh_sel = 3;
		ram_sel=3;
		next=50;
	end
	50: begin
		neigh_sel = 3;
		ram_sel=3;
		down_l=1;
		next = 51;
	end
	51 : begin
		next = 52;
	end
	52: begin
		next = 12;
	end
	default:  begin
		next=0;
	end
	endcase
end


endmodule