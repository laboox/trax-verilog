module stack(reset, d_in, push, pop, clk, d_out, of, uf, empty);	
	parameter depth=21;
	parameter stack_depth=6;
	
	input[depth:0] d_in;
	input reset, push, pop, clk;
	output [depth:0] d_out;
	output reg of=0 ,uf=0;
	output empty;
	
	reg [stack_depth:0]sp;
	reg [depth:0] mem [(1<<stack_depth)-1:0];
	assign d_out[depth:0]  = mem [sp-1];
	assign empty = (sp==0);
	
	always @(posedge clk) begin
		if(reset) begin
			sp = 0;
		end
		else if(push) begin
			mem[sp] = d_in;
			if(sp==((1<<stack_depth)-1))
			  of = 1;
			else begin	
			  sp = sp + 1;
			  uf = 0;
			end
		end
		else if(pop) begin
		  if(sp==0)
		    uf = 1;
		  else begin
		    sp = sp - 1;
		    of = 0;
		  end
		end
	end
endmodule
