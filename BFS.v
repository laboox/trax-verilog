module BFS(input [1:0] st, input clk, input reset, input start, input [x_width:0] last_x, last_y, input[3:0] ram_in, input goh_ready , output [3:0] ram_out, output [depth:0] ram_addr, output reg ram_write_en, input isWhite, 
				output w_end, output [13:0] doresh, output [4:0] state);
				
	parameter depth=21;
	parameter w_weight = 4;
	parameter w_queue = depth + w_weight + 1;
	parameter x_width=10;
	
	assign w_end = (prev==16);
	
	assign state = prev;
	
	reg [x_width:0] c_x, c_y;
	reg [w_weight:0] weight;
	
	reg writep, readp;
	reg par_sel;
	reg [1:0] queue_sel;
	reg [2:0] ram_sel;
	reg queue_first;
	reg [2:0] c_sel;
	reg c_l;
	
	//assign cycle_weight = weight;
	
	assign doresh = {up[2:0], left[2:0], right[2:0], down[2:0]};
	
	wire [w_weight:0] weight_next;
	
	assign weight_next = (center[2:0]==3'b0)? weight+1 : 0;
	
	reg [3:0] up, left, right, down, center, parent;
	reg up_l, left_l, right_l, down_l, center_l, parent_l;
	
	wire [x_width:0] c_x_p, c_x_m, c_y_m, c_y_p;
	
	assign c_x_p = c_x + 1;
	assign c_y_p = c_y + 1;
	assign c_x_m = c_x - 1;
	assign c_y_m = c_y - 1;
	
	reg par_write;
	
	reg [5:0] prev, next;	
	
	assign ram_addr =  (ram_sel==0)? {par_sel,c_y[x_width-1:0],c_x[x_width:0]} : (ram_sel==1)? {par_sel,c_y_m[x_width-1:0],c_x[x_width:0]} : 
							(ram_sel==2)? {par_sel,c_y_p[x_width-1:0],c_x[x_width:0]} : (ram_sel==3)? {par_sel,c_y[x_width-1:0],c_x_m[x_width:0]} : 
							 {par_sel,c_y[x_width-1:0],c_x_p[x_width:0]};
	
	assign ram_out = par_write;
	
	always @(posedge clk) begin
		if(reset) 
			prev<=0;
		else
			prev <= next;
	end
	
	always @(posedge clk) begin
		if(c_l) begin
			if(c_sel==1) begin
				c_x <= last_x;
				c_y <= last_x;
				weight <= 0;
			end
			else if(c_sel==0) begin
				c_x <= queue_out[x_width:0];
				c_y <= queue_out[depth:x_width+1];
				weight <= queue_out[w_queue:depth+1];
			end
		end
		if(up_l)
			up<=ram_in;
		if(down_l)
			down<=ram_in;
		if(left_l)
			left<=ram_in;
		if(right_l)
			right<=ram_in;
		if(parent_l)
			parent<=ram_in;
		if(center_l)
			center<=ram_in;
	end
	
	
	always @(posedge clk) begin
		next = prev;
		{up_l, left_l, right_l, down_l, center_l, parent_l} = 0;
		par_sel = 0;
		queue_sel = 0;
		queue_first = 0;
		c_sel =0;
		c_l=0;
		ram_sel = 0;
		par_write=0;
		ram_write_en=0;
		writep=0;
		readp=0;
		
		case(prev)
		0: begin
				if(start)
					next = 1;
				else next = 0;
			end
		1: begin
			c_l=1;
			c_sel=1;
			next=2;
		end
		2: begin
			queue_first=1;
			writep=1;
			next = 3;
		end
		3: begin
			next = 4;
		end
		4: begin
			if(fullp)
				next = 16; // fix
			else if(emptyp==1)
				next = 16; // fix
			else
				next = 5;
		end
		5: begin
			c_sel=0;
			c_l=1;
			next=6;
		end
		6: begin
			readp = 1;
			center_l=1;
			next = 7;
		end
		7: begin
			ram_sel = 1;
			par_sel=1;
			up_l=1;
			next = 8;
		end
		8: begin
			ram_sel = 2;
			par_sel=1;
			down_l=1;
			next = 9;
		end
		9: begin
			ram_sel = 3;
			par_sel=1;
			left_l=1;
			next = 10;
		end
		10: begin
			ram_sel = 4;
			par_sel=1;
			right_l=1;
			next = 11;
		end
		11: begin
			ram_sel=0;
			par_sel=1;
			parent_l=1;
			next=12;
		end
		12: begin
				if(up_go && (up[2:0] == 3'b0) && (parent[2:0] != 2) ) begin
					ram_sel=1;
					par_sel=1;
					par_write = 1;
					ram_write_en=1;
					queue_sel = 0;
					writep=1;
					next = 17;
				end
				else if(up_go && (parent[2:0] != 2)) begin
					//???????? // FOUND CYCLE
					next = 16;
				end 
				else
					next = 13;
		end
		17: begin
			if(goh_ready==0)
				next = 17;
			else	
				next = 13;
		end
		13: begin	
				if(down_go && (down[2:0] == 3'b0) && (parent[2:0] != 1) ) begin
					par_sel=1;
					ram_write_en=1;
					
					ram_sel=2;
					par_write = 2;
					queue_sel = 1;
					writep=1;
					next = 18;
				end
				else if(down_go && (parent[2:0] != 1)) begin
					//???????? // FOUND CYCLE
					next = 16;
				end 
				else
					next = 14;
		end
		18: begin
			if(goh_ready==0)
				next = 18;
			else	
				next = 14;
		end
		14: begin
			if(left_go && (left[2:0] == 3'b0) && (parent[2:0] != 4) ) begin
				par_sel=1;
				ram_write_en=1;
				
				ram_sel=3;
				par_write = 3;
				queue_sel = 3;
				writep=1;
				next = 19;
			end
			else if(left_go && (parent[2:0] != 4)) begin
				//???????? // FOUND CYCLE
				next = 16;
			end 
			else
				next = 15;
		end
		19: begin
			if(goh_ready)
				next = 15;
			else
				next = 19;
		end
		15: begin
			if(right_go && (right[2:0] == 3'b0) && (parent[2:0] != 3) ) begin
				par_sel=1;
				ram_write_en=1;
				
				ram_sel=4;
				par_write = 4;
				queue_sel = 3;
				writep=1;
				next = 20;
			end
			else if(right_go && (parent[2:0] != 3)) begin
				//???????? // FOUND CYCLE
				next = 16;
			end 
			else
				next = 3;
		end
		20: begin
			if(goh_ready==0)
				next = 20;
			else	
				next = 3;
		end
		16: begin
			next = 0;
		end
			
		endcase
	end
	
	wire [w_queue:0] queue_in, queue_out;
	wire emptyp, fullp;
	
	defparam qu.BUFFER_SIZE = w_queue;
	fifo qu(clk, reset, queue_in, writep, readp, queue_out, emptyp, fullp);
	assign queue_in = (queue_first==1)? {weight_next,c_y,c_x} : (queue_sel==2'd0)?{weight_next,c_y_m,c_x}:(queue_sel==2'd1)
								?{weight_next,c_y_p,c_x}:(queue_sel==2'd2)?{weight_next,c_y,c_x_m}:{weight_next,c_y,c_x_p};
	
	wire left_go, up_go, right_go, down_go;
	
	
	set_dir(
		center,
		isWhite, // 1 = White,  0 = Black
		left_go, up_go, right_go, down_go
	);
	
endmodule