module controller(
input clk,
input reset,
input isWhite, // recive order color 
input send_recive, // recive order input
input tile_select_ready, // writer
input placer_ready,
input force_ready,
output placer_start, 
output reg tile_select_start,
output reg force_start,
output [1:0] sram_sel,
output placer_sel,
output [5:0] state
);

	reg[5:0] prev, next;
	assign state = prev;
	always @(posedge clk) begin
		if(reset)
			prev <= 1;
		else
			prev <= next;
	end
	
	assign placer_start = (prev==5)||(prev==10);
	
	always @(*) begin
		//placer_start = 0;
		tile_select_start = 0;
		force_start = 0;
		next = prev;
		
		case (prev)
		0: begin
			next=1;
		end
		1: begin
			if(send_recive)
				next=2;
			else
				next = 1;
		end
		2: begin
				if(isWhite)
					next=3;
				else
					next = 9;
		end
		3: begin
			tile_select_start = 1;
			next =4;
		end
		4: begin
			if(tile_select_ready==0)
				next = 4;
			else next=5; // fix
		end
		5: begin
			//placer_start=1;
			next=6;
		end	
		6: begin
			if(placer_ready==0)
				next = 6;
			else
				next = 7;
		end
		7: begin
			force_start=1;
			next = 8;
		end
		8: begin
			if(force_ready==0)
				next = 8;
			else
				next = 9;
		end
		9: begin
			if(send_recive==0)
				next = 9;
			else	
				next = 10;
		end
		10: begin
			//placer_start=1;
			next = 11;
		end
		11: begin
			if(placer_ready==0)
				next=11;
			else
				next=12;
		end
		12: begin
			force_start=1;
			next=13;
		end
		13: begin
			if(force_ready==0)
				next = 13;
			else
				next = 3;
		end
		endcase
	end
	
	assign sram_sel = ((prev==7) || (prev==8) || (prev==12) || (prev==13))? 1 : ((prev==3) || (prev==4)) ? 2 : 0;
	assign  placer_sel = ((prev==5) || (prev==6) || (prev==3) || (prev==4))?1:0;
	
endmodule