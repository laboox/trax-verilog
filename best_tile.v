module best_tile(input isWhite, input isEnemy, input [x_width:0] x1, y1, x2, y2, 
input [3:0] up, right, down, left, output reg[3:0] best_t);
/*wire [1:0] tile_type;
assign x_pos = (x1>x2):2'b01:(x1==x2)?2'b10:2'b00;	
assign y_pos = (y1>y2):2'b01: (y1==y2)?2'b10:2'b00;
assign tile_type = ((x1>x2)&&(y1>y2))?2'b10:((x1>x2)&&(y1<y2))?2'b00:((x1<x2)&&(y1>y2))?2'b00:2'b10;
*/
parameter x_width = 9;
always@(*) begin 
	best_t = 0;
	if(~isEnemy) begin
		if(isWhite) begin 
			//We are White and checking ourseleves
			if((left == 1 || left == 3 || left == 5) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					//al three cases are the same
					best_t = 3;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					best_t = 6;
				end
			end
			else if((left == 2 || left == 4 || left == 6) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					best_t = 5;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					best_t = 4;
				end
			end
			else if((left == 1 || left == 3 || left == 5) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 3;
					else
						best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 2;
				end
 			end
			else if((left == 2 || left == 4 || left == 6) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 1;
					else
						best_t = 4;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					best_t = 4;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin 
					best_t = 4;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 6;
					else 
						best_t = 4;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 5;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 3;
					else 
						best_t = 5;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					best_t = 4;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 4;
					else 
						best_t = 2;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					best_t = 1;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 1;
					else 
						best_t = 3;
				end
 			end
			else if(right == 1 || right == 4 || right == 5) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 6;
					else if(y1==y2)
						best_t = 4;
					else if(y1>y2)
						best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 6;
					else 
						best_t = 2;
				end
 			end
			else if(up == 1 || up == 3 || up == 6) begin 
				if(x1>x2) begin 
					best_t = 5;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					best_t = 2;
				end
 			end
			else if(left == 2 || left == 4 || left == 6) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 1;
					else if(y1==y2)
						best_t = 4;
					else if(y1>y2)
						best_t = 5;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					best_t = 4;
				end
 			end
			else if(down == 2 || down == 3 || down == 5) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 1;
					else if(y1==y2)
						best_t = 1;
					else if(y1>y2)
						best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 6;
					else 
						best_t = 6;
				end
 			end
		end
		else begin 
			//We are black and checking ourseleves
			if((left == 1 || left == 3 || left == 5) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					//al three cases are the same
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 6;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					best_t = 3;
				end
			end
			else if((left == 2 || left == 4 || left == 6) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					best_t = 4;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					best_t = 5;
				end
			end
			else if((left == 1 || left == 3 || left == 5) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 2;
					else
						best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					best_t = 3;
				end
 			end
			else if((left == 2 || left == 4 || left == 6) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 4;
					else
						best_t = 1;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					best_t = 1;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin 
					best_t = 6;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 4;
					else 
						best_t = 6;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 5;
					else 
						best_t = 3;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 2;
					else 
						best_t = 4;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 3;
					else 
						best_t = 1;
				end
 			end
			else if(right == 2 || right == 3 || right == 6) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 5;
					else if(y1==y2)
						best_t = 3;
					else if(y1>y2)
						best_t = 1;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 5;
					else 
						best_t = 1;
				end
 			end
			else if(up == 2 || up == 4 || up == 5) begin 
				if(x1>x2) begin 
					best_t = 6;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					best_t = 1;
				end
 			end
			else if(left == 1 || left == 3 || left == 5) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 2;
					else if(y1==y2)
						best_t = 3;
					else if(y1>y2)
						best_t = 6;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					best_t = 3;
				end
 			end
			else if(down == 1 || down == 4 || down == 6) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 2;
					else if(y1==y2)
						best_t = 2;
					else if(y1>y2)
						best_t = 4;//
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 5;
					else 
						best_t = 5;
				end
 			end
		end
	end
	else begin  
		if(~isWhite) begin 
			//Enemy is black
			if((left == 1 || left == 3 || left == 5) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					//all three cases are the same
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 6;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					best_t = 3;
				end
			end
			else if((left == 2 || left == 4 || left == 6) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					best_t = 4;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 5;
					else 
						best_t = 4;
				end
			end
			else if((left == 1 || left == 3 || left == 5) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 2;
					else
						best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 3;
				end
 			end
			else if((left == 2 || left == 4 || left == 6) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 4;
					else
						best_t = 1;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					best_t = 4; 
						
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 6;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 4;
					else 
						best_t = 6;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 5;
					else 
						best_t = 3;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 4;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 2;
					else 
						best_t = 4;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 3;
					else 
						best_t = 1;
				end
 			end
			else if(right == 1 || right == 4 || right == 5) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 2;
					else if(y1==y2)
						best_t = 6;
					else if(y1>y2)
						best_t = 6;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 6;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 2;
					else 
						best_t = 6;
				end
 			end
			else if(up == 1 || up == 3 || up == 6) begin 
				if(x1>x2) begin 
					best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 2;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					best_t = 5;
				end
 			end
			else if(left == 2 || left == 4 || left == 6) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 1;
					else if(y1==y2)
						best_t = 4;
					else if(y1>y2)
						best_t = 5;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 5;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					if(y1<y2)
						best_t = 5;
					else if(y1==y2)
						best_t = 5;
					else 
						best_t = 1;
				end
 			end
			else if(down == 2 || down == 3 || down == 5) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 6;
					else if(y1==y2)
						best_t = 6;
					else if(y1>y2)
						best_t = 6;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 1;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 1;
					else 
						best_t = 1;
				end
 			end
		end
		else begin 
			//We are black and checking ourseleves
			if((left == 1 || left == 3 || left == 5) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					//al three cases are the same
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 3;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin
					if(y1<=y2)
						best_t = 3;
					else	
						best_t = 6;
				end
			end
			else if((left == 2 || left == 4 || left == 6) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 5;
				end
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					best_t = 4;
				end
			end
			else if((left == 1 || left == 3 || left == 5) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 3;
					else
						best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin 
					best_t = 2;
				end
 			end
			else if((left == 2 || left == 4 || left == 6) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 1;
					else
						best_t = 4;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 4;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (up == 2 || up == 4 || up == 5)) begin 
				if(x1>x2) begin
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 4;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 6;
					else 
						best_t = 4;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (up == 1 || up == 3 || up == 6)) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 5;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 3;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 3;
					else 
						best_t = 5;
				end
 			end
			else if((right == 1 || right == 4 || right == 5) && (down == 1 || down == 4 || down == 6)) begin 
				if(x1>x2) begin 
					if(y1<=y2)
					best_t = 4;
					else 
					best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 4;
					else 
						best_t = 2;
				end
 			end
			else if((right == 2 || right == 3 || right == 6) && (down == 2 || down == 3 || down == 5)) begin 
				if(x1>x2) begin 
					if(y1<=y2)
					best_t = 1;
					else 
					best_t = 3;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 3;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 1;
					else 
						best_t = 3;
				end
 			end
			else if(right == 2 || right == 3 || right == 6) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 1;
					else if(y1==y2)
						best_t = 1;
					else if(y1>y2)
						best_t = 5;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 1;
					else 
						best_t = 5;
				end
				else if(x1<x2) begin 
					if(y1<=y2)
						best_t = 1;
					else 
						best_t = 5;
				end
 			end
			else if(up == 2 || up == 4 || up == 5) begin 
				if(x1>x2) begin 
					best_t = 1;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 4;
				end
				else if(x1<x2) begin 
					best_t = 1;
				end
 			end
			else if(left == 1 || left == 3 || left == 5) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 6;
					else if(y1==y2)
						best_t = 3;
					else if(y1>y2)
						best_t = 2;
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 6;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin
					if(y1<y2)
					best_t = 6;
					else 
					best_t = 2;
				end
 			end
			else if(down == 1 || down == 4 || down == 6) begin 
				if(x1>x2) begin 
					if(y1<y2)
						best_t = 4;
					else if(y1==y2)
						best_t = 5;
					else if(y1>y2)
						best_t = 4;//
				end 
				else if(x1==x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 2;
				end
				else if(x1<x2) begin 
					if(y1<y2)
						best_t = 4;
					else 
						best_t = 2;
				end
 			end
		end
	end
end
endmodule