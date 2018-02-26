//`timescale 1ns/1ps
module my_sram_controller(
input clk,
input rst,
input clean_mark,
input[depth:0] addr,
input write_en,
input [15:0] data_in,
output [15:0] data_out,
output ready,
//  output
output[depth:0] sram_addr,
output sram_wr_n,
output sram_ce_n,
output sram_oe_n,
output sram_ub_n,
output sram_lb_n,
//  inout
inout [15:0] sram_data
);

parameter depth  = 19;

assign sram_ce_n = 1'b0;    //sram chip select always enable
assign sram_oe_n = 1'b0;    //sram output always enable
assign sram_ub_n = 1'b0;    //upper byte always available
assign sram_lb_n = 1'b0;    //lower byte always available
assign sram_addr = cleaning? (just_mark ? {1'b1,cleanAddr[depth-1:0]} : cleanAddr) : addr;
assign sram_wr_n = (!cleaning ) && (!writing);
assign sram_data = cleaning?16'b0:(writing? data_in : 16'hzzzz);
assign data_out = sram_data;
assign ready=(prev==3);

	reg writing;
	reg just_mark;
	reg cleaning;
	reg [depth:0] cleanAddr;
	reg cleanAddrOvf;
	
	reg[3:0] prev, next;
	
	always @(posedge clk) begin
		prev<=next;
	end
	
	always @(posedge clk) begin
		if(prev==0)
			just_mark = 0;
		if(prev==5)
			just_mark = 1;
		
		if(cleaning==0)
			cleanAddr=0;
		else
			{cleanAddrOvf,cleanAddr} = cleanAddr + 1'b1;
	end
	
	always @(*) begin
		writing = 0;
		next = 0;
		cleaning=0;
		case (prev)
		0: begin
			if(write_en) next=1;
			if(rst) next=4;
			if(clean_mark) next = 5;
		end
		1: begin
			writing=1;
			next=3;
		end
		/*2: begin
				writing=1;
				next=3;
		end*/
		3: begin
			next=0;
		end
		4: begin
			cleaning=1;
			if(cleanAddrOvf==0)
				next=4;
			else
				next=3;
		end
		5: begin
			next = 6;
		end
		6: begin
			next = 4;
		end
		endcase
	end
 
endmodule