module read_write_tile(
input clk,
input reset,
input clean_mark,
input write_en,
input[depth+2:0] address,
input[3:0] data_in,

output[3:0] data_out,
output ready,

output[depth:0] SRAM_ADDR,
output SRAM_WE_N,
output SRAM_CE_N,
output SRAM_OE_N,
output SRAM_UB_N,
output SRAM_LB_N,
//  inout
inout [15:0] SRAM_DQ
);

parameter depth = 19;

reg sram_write;
reg [15:0] sram_data_in;

wire[depth:0] sram_address;
wire[15:0] sram_data_out;

reg[15:0] old_data;

assign sram_address = address[depth+2:2];

assign data_out = (address[1:0] == 2'b00) ? sram_data_out[3:0] : (address[1:0] == 2'b01) ? sram_data_out[7:4] :
						(address[1:0] == 2'b10) ? sram_data_out[11:8] : sram_data_out[15:12];
//assign sram_data = old_data;
reg[2:0] prev, next;
wire sram_ready;

assign ready =  ((prev==4) || (prev==5));

always@(posedge clk) begin
	if(reset)
		prev<=0;
	else
		prev<=next;
end

always @(posedge clk) begin
	if(prev==1) begin
		if(address[1:0]==2'b00)
			sram_data_in = {old_data[15:4],data_in[3:0]};
		else if(address[1:0]==2'b01)
			sram_data_in = {old_data[15:8],data_in[3:0],old_data[3:0]};
		else if(address[1:0]==2'b10)
			sram_data_in = {old_data[15:12],data_in[3:0],old_data[7:0]};
		else if(address[1:0]==2'b11)
			sram_data_in = {data_in[3:0],old_data[11:0]};
	end
end

always @(*) begin
	sram_write=0;
	next=0;
	old_data=0;
	case (prev)
	0: begin
		if(write_en==1) next=1;
		if(clean_mark==1) next=3;
	end
	1: begin
		old_data = sram_data_out;
		sram_write=1;
		next=3;
	end
	3: begin
		if(sram_ready)
			next=4;
		else
			next=3;
	end
	4: begin
		next = 5;
	end
	5: begin
		next = 0;
	end
	
	endcase
end

	defparam msc.depth = depth;
	my_sram_controller msc(
		clk,
		reset,
		clean_mark,
		sram_address,
		sram_write,
		sram_data_in,
		sram_data_out,
		sram_ready,
		//  output
		SRAM_ADDR,
		SRAM_WE_N,
		SRAM_CE_N,
		SRAM_OE_N,
		SRAM_UB_N,
		SRAM_LB_N,
		SRAM_DQ
	);

endmodule