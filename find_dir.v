module find_dir(
input[3:0] tile,
input[1:0] parent,
input isWhite, isEnemy, 
output reg[1:0] dir
);

	always@(*)begin
		dir = 0;
		// check baraye khodemun
		if(isEnemy == 0) begin
			if(isWhite) begin          // we are White
				if(tile==1)begin
					if(parent==0)
						dir=3;
					else
						dir=0;
				end
				
				else if(tile==2)begin
					if(parent==1)
						dir=2;
					else
						dir=1;
				end
				
				else if(tile==3)begin
					if(parent==1)
						dir=3;
					else
						dir=1;
				end
				
				else if(tile==4)begin
					if(parent==0)
						dir=2;
					else
						dir=0;
				end
				
				else if(tile==5)begin
					if(parent==0)
						dir=1;
					else
						dir=0;
				end
				
				else if(tile==6)begin
					if(parent==2)
						dir=3;
					else
						dir=2;
				end
			end
			else begin   // we are Black
				if(tile==1)begin
					if(parent==1)
						dir=2;
					else
						dir=1;
				end
				
				else if(tile==2)begin
					if(parent==0)
						dir=3;
					else
						dir=0;
				end
				
				else if(tile==3)begin
					if(parent==0)
						dir=2;
					else
						dir=0;
				end
				
				else if(tile==4)begin
					if(parent==1)
						dir=3;
					else
						dir=1;
				end
				
				else if(tile==5)begin
					if(parent==2)
						dir=3;
					else
						dir=2;
				end
				
				else if(tile==6)begin
					if(parent==0)
						dir=1;
					else
						dir=0;
				end
			end
		end
		
		
		// Check for enemy
		
		
		
		else begin   // isEnemy == 1
			if(isWhite) begin          // we are White
				if(tile==1)begin
					if(parent==1)
						dir=2;
					else
						dir=1;
				end
				
				else if(tile==2)begin
					if(parent==0)
						dir=3;
					else
						dir=0;
				end
				
				else if(tile==3)begin
					if(parent==0)
						dir=2;
					else
						dir=0;
				end
				
				else if(tile==4)begin
					if(parent==1)
						dir=3;
					else
						dir=1;
				end
				
				else if(tile==5)begin
					if(parent==2)
						dir=3;
					else
						dir=2;
				end
				
				else if(tile==6)begin
					if(parent==0)
						dir=1;
					else
						dir=0;
				end
			end
			else begin   // we are Black
				if(tile==1)begin
					if(parent==0)
						dir=3;
					else
						dir=0;
				end
				
				else if(tile==2)begin
					if(parent==1)
						dir=2;
					else
						dir=1;
				end
				
				else if(tile==3)begin
					if(parent==1)
						dir=3;
					else
						dir=1;
				end
				
				else if(tile==4)begin
					if(parent==0)
						dir=2;
					else
						dir=0;
				end
				
				else if(tile==5)begin
					if(parent==0)
						dir=1;
					else
						dir=0;
				end
				
				else if(tile==6)begin
					if(parent==2)
						dir=3;
					else
						dir=2;
				end
			end
		end
	end

endmodule

