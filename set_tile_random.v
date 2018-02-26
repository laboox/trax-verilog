module set_tile_random(
input[3:0] tile1, tile2, tile3, tile4, tile5, tile6, tile7, tile8, tile9, 
input[1:0] turn,
input color,
output reg[3:0] tile_out,
output reg[1:0] dir);

//reg[1:0] turn;

	always@(*)begin
	tile_out = 4'b0000;
	dir = 2'b00;
		// bord ba yek harekat black
		if(
		((color == 0) && (tile5 == 1))
		&& 
		(((tile6 == 6) && (tile2 == 0))
		&& ((tile3 == 0 ))) )begin
						tile_out = 5;
						dir = 1;
		
	end
	
	else if(
		((color == 0) && (tile5 == 6))
		&& 
		(((tile4 == 1) && (tile2 == 0))
		&& ((tile1 == 0 ))) )begin
						tile_out = 2;
						dir = 1;
		
	end
	
	else if(
		((color == 0) && (tile5 == 5))
		&& 
		(((tile6 == 2) && (tile8 == 0))
		&& ((tile9 == 0 ))) )begin
						tile_out = 1;
						dir = 3;
		
	end
	
	else if(
		((color == 0) && (tile5 == 2))
		&& 
		(((tile4 == 5) && (tile8 == 0))
		&& ((tile7 == 0 ))) )begin
						tile_out = 6;
						dir = 3;
		
	end
	
	else if(
		((color == 0) && (tile5 == 5))
		&& 
		(((tile9 == 0) && (tile8 == 1))
		&& ((tile6 == 0 ))) )begin
						tile_out = 2;
						dir = 2;
		
	end
	
	else if(
		((color == 0) && (tile5 == 1))
		&& 
		(((tile3 == 0) && (tile2 == 5))
		&& ((tile6 == 0 ))) )begin
						tile_out = 6;
						dir = 2;
		
	end
	
	
	else if(
		((color == 0) && (tile5 == 6))
		&& 
		(((tile2 == 2) && (tile4 == 0))
		&& ((tile1 == 0 ))) )begin
						tile_out = 1;
						dir = 0;
		
	end
	
	else if(
		((color == 0) && (tile5 == 2))
		&& 
		(((tile8 == 6) && (tile4 == 0))
		&& ((tile7 == 0 ))) )begin
						tile_out = 5;
						dir = 0;
		
	end
	
	
	//
	
	// bord ba yek harekat White 
	else if(
		((color == 1) && (tile5 == 2))
		&& 
		(((tile6 == 5) && (tile2 == 0))
		&& ((tile3 == 0 ))) )begin
						tile_out = 6;
						dir = 1;
		
	end
	
	else if(
		((color == 1) && (tile5 == 5))
		&& 
		(((tile4 == 2) && (tile2 == 0))
		&& ((tile1 == 0 ))) )begin
						tile_out = 1;
						dir = 1;
		
	end
	
	else if(
		((color == 1) && (tile5 == 6))
		&& 
		(((tile6 == 1) && (tile8 == 0))
		&& ((tile9 == 0 ))) )begin
						tile_out = 1;
						dir = 3;
		
	end
	
	else if(
		((color == 1) && (tile5 == 1))
		&& 
		(((tile4 == 6) && (tile8 == 0))
		&& ((tile7 == 0 ))) )begin
						tile_out = 5;
						dir = 3;
		
	end
	
	else if(
		((color == 1) && (tile5 == 6))
		&& 
		(((tile9 == 0) && (tile8 == 2))
		&& ((tile6 == 0 ))) )begin
						tile_out = 1;
						dir = 2;
		
	end
	
	else if(
		((color == 1) && (tile5 == 2))
		&& 
		(((tile3 == 0) && (tile2 == 6))
		&& ((tile6 == 0 ))) )begin
						tile_out = 5;
						dir = 2;
		
	end
	
	
	else if(
		((color == 1) && (tile5 == 5))
		&& 
		(((tile2 == 1) && (tile4 == 0))
		&& ((tile1 == 0 ))) )begin
						tile_out = 2;
						dir = 0;
		
	end
	
	else if(
		((color == 1) && (tile5 == 1))
		&& 
		(((tile8 == 5) && (tile4 == 0))
		&& ((tile7 == 0 ))) )begin
						tile_out = 2;
						dir = 0;
		
	end
	
	//
	// jelogiri az bord dar yek harekat Black
	
	else if(
		((color == 1) && (tile5 == 1))
		&& 
		(((tile6 == 6) && (tile2 == 0))
		&& ((tile3 == 0 ))) )begin
			if(((tile1 == 2) || (tile1 == 6)) || (tile1 == 4))begin
				tile_out = 4;
				dir = 1;
			end
			else begin
						tile_out = 2;
						dir = 1;
			end
	end
	
	else if(
		((color == 1) && (tile5 == 6))
		&& 
		(((tile4 == 1) && (tile2 == 0))
		&& ((tile1 == 0 ))) )begin
			if(((tile3 == 1) || (tile3 == 5)) || (tile3 == 4))begin
				tile_out = 4;
				dir = 1;
			end
			else begin
						tile_out = 5;
						dir = 1;
			end
		
	end
	
	else if(
		((color == 1) && (tile5 == 5))
		&& 
		(((tile6 == 2) && (tile8 == 0))
		&& ((tile9 == 0 ))) )begin
		if(((tile7 == 2) || (tile7 == 4)) || (tile7 == 6))begin
				tile_out = 4;
				dir = 3;
			end
			else begin
						tile_out = 6;
						dir = 3;
			end
		
	end
	
	else if(
		((color == 1) && (tile5 == 2))
		&& 
		(((tile4 == 5) && (tile8 == 0))
		&& ((tile7 == 0 ))) )begin
		if(((tile9 == 1) || (tile9 == 5)) || (tile9 == 4))begin
				tile_out = 4;
				dir = 3;
			end
			else begin
						tile_out = 1;
						dir = 3;
			end
		
	end
	
	else if(
		((color == 1) && (tile5 == 5))
		&& 
		(((tile9 == 0) && (tile8 == 1))
		&& ((tile6 == 0 ))) )begin
			if(((tile3 == 1) || (tile3 == 3)) || (tile3 == 6))begin
				tile_out = 3;
				dir = 2;
			end
			else begin
						tile_out = 6;
						dir = 2;
			end
		
	end
	
	else if(
		((color == 1) && (tile5 == 1))
		&& 
		(((tile3 == 0) && (tile2 == 5))
		&& ((tile6 == 0 ))) )begin
			if(((tile9 == 2) || (tile9 == 3)) || (tile9 == 5))begin
				tile_out = 3;
				dir = 2;
			end
			else begin
						tile_out = 2;
						dir = 2;
			end
		
	end
	
	
	else if(
		((color == 1) && (tile5 == 6))
		&& 
		(((tile2 == 2) && (tile4 == 0))
		&& ((tile1 == 0 ))) )begin
			if(((tile7 == 2) || (tile7 == 3)) || (tile7 == 5))begin
				tile_out = 3;
				dir = 0;
			end
			else begin
						tile_out = 5;
						dir = 0;
			end
		
	end
	
	else if(
		((color == 1) && (tile5 == 2))
		&& 
		(((tile8 == 6) && (tile4 == 0))
		&& ((tile7 == 0 ))) )begin
			if(((tile1 == 1) || (tile1 == 3)) || (tile1 == 6))begin
				tile_out = 3;
				dir = 0;
			end
			else begin
						tile_out = 1;
						dir = 0;
			end
		
	end
	
	/// 
	
	///
	// jelogiri az bord dar yek harekat White
	
	else if(
		((color == 0) && (tile5 == 2))
		&& 
		(((tile6 == 5) && (tile2 == 0))
		&& ((tile3 == 0 ))) )begin
			if(((tile1 == 1) || (tile1 == 3)) || (tile1 == 5))begin
				tile_out = 3;
				dir = 1;
			end
			else begin
						tile_out = 1;
						dir = 1;
			end
	end
	
	else if(
		((color == 0) && (tile5 == 5))
		&& 
		(((tile4 == 2) && (tile2 == 0))
		&& ((tile1 == 0 ))) )begin
			if(((tile3 == 2) || (tile3 == 3)) || (tile3 == 6))begin
				tile_out = 3;
				dir = 1;
			end
			else begin
						tile_out = 6;
						dir = 1;
			end
		
	end
	
	else if(
		((color == 0) && (tile5 == 6))
		&& 
		(((tile6 == 1) && (tile8 == 0))
		&& ((tile9 == 0 ))) )begin
		if(((tile7 == 1) || (tile7 == 3)) || (tile7 == 6))begin
				tile_out = 3;
				dir = 3;
			end
			else begin
						tile_out = 5;
						dir = 3;
			end
		
	end
	
	else if(
		((color == 0) && (tile5 == 1))
		&& 
		(((tile4 == 6) && (tile8 == 0))
		&& ((tile7 == 0 ))) )begin
		if(((tile9 == 2) || (tile9 == 3)) || (tile9 == 6))begin
				tile_out = 3;
				dir = 3;
			end
			else begin
						tile_out = 2;
						dir = 3;
			end
		
	end
	
	else if(
		((color == 0) && (tile5 == 6))
		&& 
		(((tile9 == 0) && (tile8 == 2))
		&& ((tile6 == 0 ))) )begin
			if(((tile3 == 2) || (tile3 == 4)) || (tile3 == 5))begin
				tile_out = 4;
				dir = 2;
			end
			else begin
						tile_out = 5;
						dir = 2;
			end
		
	end
	
	else if(
		((color == 0) && (tile5 == 2))
		&& 
		(((tile3 == 0) && (tile2 == 6))
		&& ((tile6 == 0 ))) )begin
			if(((tile9 == 1) || (tile9 == 4)) || (tile9 == 6))begin
				tile_out = 4;
				dir = 2;
			end
			else begin
						tile_out = 1;
						dir = 2;
			end
		
	end
	
	
	else if(
		((color == 0) && (tile5 == 5))
		&& 
		(((tile2 == 1) && (tile4 == 0))
		&& ((tile1 == 0 ))) )begin
			if(((tile7 == 1) || (tile7 == 4)) || (tile7 == 6))begin
				tile_out = 4;
				dir = 0;
			end
			else begin
						tile_out = 6;
						dir = 0;
			end
		
	end
	
	else if(
		((color == 0) && (tile5 == 1))
		&& 
		(((tile8 == 5) && (tile4 == 0))
		&& ((tile7 == 0 ))) )begin
			if(((tile1 == 2) || (tile1 == 5)) || (tile1 == 4))begin
				tile_out = 4;
				dir = 0;
			end
			else begin
						tile_out = 2;
						dir = 0;
			end
		
	end
	
	else if(((tile5==4 && tile2==2)&&(tile8==6 && tile1==0))&& (tile7==0 && tile4==0))begin
	if(color==0)begin
		tile_out = 4;
		dir = 0;
	end
	else begin
		tile_out=6;
		dir = 0;
	end

end

else if(((tile5==3 && tile2==0 )&&(tile1==0 && tile3==0))&& (tile4==1 && tile6==6))begin
	if(color==0)begin
		tile_out = 3;
		dir = 1;
	end
	else begin
		tile_out=6;
		dir = 1;
	end

end

else if(((tile5==4 && tile6==0)&&(tile9==0 && tile3==0))&& (tile2==5 && tile8==1))begin
	if(color==0)begin
		tile_out = 4;
		dir = 2;
	end
	else begin
		tile_out=1;
		dir = 2;
	end

end


else if(((tile5==3 && tile7==0 )&&(tile8==0 && tile9==0))&& (tile4==5 && tile6==2))begin
	if(color==0)begin
		tile_out = 3;
		dir = 3;
	end
	else begin
		tile_out=2;
		dir = 3;
	end

end

else if(((tile5==3 && tile2==1)&&(tile8==5 && tile1==0))&& (tile7==0 && tile4==0))begin
	if(color==0)begin
		tile_out = 5;
		dir = 0;
	end
	else begin
		tile_out=3;
		dir = 0;
	end

end


else if(((tile5==4 && tile4==2)&&(tile6==5 && tile1==0))&& (tile2==0 && tile3==0))begin
	if(color==0)begin
		tile_out = 5;
		dir = 1;
	end
	else begin
		tile_out=4;
		dir = 1;
	end

end


else if(((tile5==3 && tile2==6)&&(tile8==2 && tile3==0))&& (tile7==0 && tile9==0))begin
	if(color==0)begin
		tile_out = 2;
		dir = 2;
	end
	else begin
		tile_out=3;
		dir = 2;
	end

end

else if(((tile5==4 && tile4==6)&&(tile6==5 && tile7==0))&& (tile8==0 && tile9==0))begin
	if(color==0)begin
		tile_out = 6;
		dir = 3;
	end
	else begin
		tile_out=4;
		dir = 3;
	end

end
	
	//// left	
		else if(tile4 == 0) begin    // check if left is empty
			//if((tile1 == 0) && (tile7 != 0))begin
				//if((tile5 == 5 || tile5 == 4 || tile5 == 1) && (tile7 == 1 || tile7 == 4 || tile7 == 6))begin
					if(tile5==5 && ((tile1 == 0) && (tile7 != 0)))begin
						if(color==0)begin
							tile_out = 4;
							dir = 0;
						end
							else begin
								tile_out = 2;
								dir = 0;
							end
					end
					
					else if((tile5==4 || tile5==1)&& ((tile1 == 0) && (tile7 != 0)))begin
						if(color==0)begin
							tile_out = 4;
							dir = 0;
						end
							else begin
								if(tile7==6)begin
									tile_out = 4;
									dir = 0;
								end
								else begin
									tile_out = 2;
									dir = 0;
								end
							end
					end
					/*if(turn == 2'b00)begin
						tile_out = 2;
						dir = 2'b00;
					end
					else begin
						tile_out = 4;
						dir = 2'b00;
					end*/
				//end
				//else if((tile5 == 6 || tile5 == 3 || tile5 == 2) && (tile7 == 5 || tile7 == 3 || tile7 == 2))begin
				else	if(tile5==6 && ((tile1 == 0) && (tile7 != 0))) begin
						if(color == 0) begin
							tile_out = 1;
							dir = 0;
						end
						else begin
							tile_out =3;
							dir = 0;
						end
					end
				else if(tile5==3 && ((tile1 == 0) && (tile7 != 0))) begin
						tile_out = 3;
						dir =0;
					end
				else 	if(tile5==2&& ((tile1 == 0) && (tile7 != 0))) begin
						if(color == 0) begin
							if(tile7 == 5) begin
								tile_out = 3;
								dir = 0;
							end
							else begin
								tile_out = 1;
								dir = 0;
							end
						end
						else begin
							if(tile7 == 5) begin
								tile_out = 1;
								dir = 0;
							end
							else begin
								tile_out = 3;
								dir = 0;
							end
						end
					end
					/*if(turn == 2'b00)begin
						tile_out = 1;
						dir = 2'b00;
					end
					else begin
						tile_out = 3;
						dir = 2'b00;
					end*/
					
				//end]
			
		//	else if((tile7 == 0) && (tile1 != 0))beginkjhflisfk**************************************
			//	if((tile5 == 5 || tile5 == 4 || tile5 == 2) && (tile1 == 5 || tile1 == 4 || tile1 == 1))begin
				else	if(tile5==5 && ((tile7 == 0) && (tile1 != 0))) begin
						if(color ==0)begin
							if(tile1 == 2)begin
							tile_out = 6;
							dir = 0;
							end
							else begin
								tile_out = 4;
								dir = 0;
							end
						end
						else begin 
							tile_out = 4;
							dir = 0;
						end
				end
				
				else	if(tile5==4 && ((tile7 == 0) && (tile1 != 0))) begin
					tile_out = 4;
					dir = 0;
				
				end
				
				else	if(tile5==1 && ((tile7 == 0) && (tile1 != 0))) begin
						if(color==0)begin
							tile_out = 4;
							dir = 0;
						end
						else begin
							if(tile1== 2)begin
								tile_out = 4;
								dir = 0;
							end
							else begin
								tile_out = 6;
								dir = 0;
							end
						end
				end
				
				else	if(tile5==6 && ((tile7 == 0) && (tile1 != 0))) begin
					if(color ==0)begin
						tile_out = 3;
						dir = 0;
					end
					else begin
						if(tile1 == 1 || tile1 ==6)begin
							tile_out = 5;
							dir = 0;
						end
						else begin
							tile_out = 3;
							dir = 0;
						end
					end
				end
				
				else	if(tile5==2 && ((tile7 == 0) && (tile1 != 0))) begin
					if(color == 0) begin
						tile_out = 5;
						dir = 0;
					end
					else begin
						tile_out = 3;
						dir =0 ;
					end
				end
				
				else	if(tile5==3 && ((tile7 == 0) && (tile1 != 0))) begin
					if(color==0)begin
						tile_out = 3;
						dir = 0;
					end
					else begin
						if(tile1 == 1)begin
							tile_out = 5;
							dir = 0;
						end
						else begin
							tile_out = 3;
							dir = 0;
						end
					end
				end
					/*if(turn == 2'b00)begin
						tile_out = 6;
						dir = 2'b00;
					end
					else begin
						tile_out = 4;
						dir = 2'b00;
					end*/
			//	end
				/*if((tile5 == 6 || tile5 == 3 || tile5 == 2) && (tile1 == 6 || tile1 == 3 || tile1 == 1))begin
					if(turn == 2'b00)begin
						tile_out = 3;
						dir = 2'b00;
					end
					else begin
						tile_out = 5;
						dir = 2'b00;
					end
				end*/
			else if(tile5==6 && ((tile7 == 0) && (tile1 != 0))) begin
				if(color == 0)begin
					tile_out = 3;
					dir = 3;
				end
				else begin
					if(tile1==1)begin
						tile_out = 5;
						dir =0;
					end
					else begin
						tile_out = 3;
						dir = 0;
					end
				end
			end
			
			else if(tile5==2 && ((tile7 == 0) && (tile1 != 0))) begin
				if(color==0)begin
					tile_out = 5;
					dir = 0;
				end
				else begin
					tile_out = 3;
					dir = 3;
				end
			end
			else if(tile5==3 && ((tile7 == 0) && (tile1 != 0))) begin
				if(color == 0) begin
					tile_out = 3;
					dir = 0;
				end
				
				else begin
					if(tile1 == 1)begin
						tile_out = 5;
						dir = 0;
					end
					else begin
						tile_out = 3;
						dir = 0;
					end
				end
			end
			//end
			
			else if((tile5==6) && ((tile7 == 0) && (tile1 == 0)) ) begin
				if(color==0) begin
					tile_out = 1;
					dir =0;
				end
				
				else begin
					tile_out = 5;
					dir = 0;
				end
			end
			
			else if((tile5==3) && ((tile7 == 0) && (tile1 == 0)) ) begin
				if(color==0) begin
					tile_out = 3;
					dir =0;
				end
				
				else begin
					tile_out = 1;
					dir = 0;
				end
			end
			
			else if((tile5==2) && ((tile7 == 0) && (tile1 == 0)) ) begin
				if(color==0) begin
					tile_out = 5;
					dir =0;
				end
				
				else begin
					tile_out = 1;
					dir = 0;
				end
			end
			
			else if((tile5==5) && ((tile7 == 0) && (tile1 == 0)) ) begin
				if(color==0) begin
					tile_out = 6;
					dir =0;
				end
				
				else begin
					tile_out = 2;
					dir = 0;
				end
			end
			
				else if((tile5==1) && ((tile7 == 0) && (tile1 == 0)) ) begin
				if(color==0) begin
					tile_out = 2;
					dir =0;
				end
				
				else begin
					tile_out = 6;
					dir = 0;
				end
			end
			
			else if((tile5==4) && ((tile7 == 0) && (tile1 == 0)) ) begin
					tile_out = 4;
					dir = 0;
			end
			
			
		//end
		
		end
	//// up	
		else if(tile2 == 4'b0000 || tile2[3] == 1'b1)begin
			if((tile1 == 4'b0000 || tile1[3] == 1'b1) && (tile3 != 4'b0000 && tile3[3] == 1'b0))begin
				if((tile5 == 5 || tile5 == 3 || tile5 == 2) && (tile3 == 6 || tile3 == 3 || tile3 == 2))begin
					if(color == 0)begin
						tile_out = 3;
						dir = 2'b01;
					end
					else begin
						tile_out = 1;
						dir = 2'b01;
					end
				end
				else if((tile5 == 6 || tile5 == 4 || tile5 == 1) && (tile3 == 5 || tile3 == 4 || tile3 == 1))begin
					if(color==0)begin
						tile_out = 2;
						dir = 2'b01;
					end
					else begin
						tile_out = 4;
						dir = 2'b01;
					end
				end
			end
			//
			if((tile3 == 4'b0000 || tile3[3] == 1'b1) && (tile1 != 4'b0000 && tile1[3] == 1'b0))begin
				if((tile5 == 5 || tile5 == 3 || tile5 == 2) && (tile1 == 5 || tile1 == 3 || tile1 == 1))begin
					if(color == 0)begin
						tile_out = 3;
						dir = 2'b01;
					end
					else begin
						tile_out = 6;
						dir = 2'b01;
					end
				end
				else if((tile5 == 6 || tile5 == 4 || tile5 == 1) && (tile1 == 6 || tile1 == 4 || tile1 == 2))begin
					if(color == 0)begin
						tile_out = 4;
						dir = 2'b01;
					end
					else begin
						tile_out = 5;
						dir = 2'b01;
					end
				end
			end
			
			//
			else if((tile1 == 4'b0000 || tile1[3] == 1'b1) && (tile3 == 4'b0000 || tile3[3] == 1'b1)) begin
				if(tile5 == 5 || tile5 == 3 || tile5 == 2)begin
					if(color==0)begin
						tile_out = 3;
						dir = 2'b01;
					end
					else begin
						tile_out = 1;
						dir = 2'b01;
					end
				end
				
				if(tile5 == 6 || tile5 == 4 || tile5 == 1)begin
					if(color==0)begin
						tile_out = 2;
						dir = 2'b01;
					end
					else begin
						tile_out = 4;
						dir = 2'b01;
					end
				end
			end
			//
			
		end
		
		
	//// right
		else if(tile6 == 4'b0000 || tile6[3] == 1'b1)begin
			if((tile9 == 4'b0000 || tile9[3] == 1'b1) && (tile3 != 4'b0000 && tile3[3] == 1'b0))begin
				if((tile5 == 5 || tile5 == 3 || tile5 == 1) && (tile3 == 6 || tile3 == 3 || tile3 == 1))begin
					if(color==0)begin
						tile_out = 2;
						dir = 2'b10;
					end
					else begin
						tile_out = 3;
						dir = 2'b10;
					end
				end
				else if((tile5 == 6 || tile5 == 4 || tile5 == 2) && (tile3 == 5 || tile3 == 4 || tile3 == 2))begin
					if(color==0)begin
						tile_out = 4;
						dir = 2'b10;
					end
					else begin
						tile_out = 4;
						dir = 2'b10;
					end
				end
			end
			//
			if((tile3 == 4'b0000 || tile3[3] == 1'b1) && (tile9 != 4'b0000 && tile9[3] == 1'b0))begin
				if((tile5 == 6 || tile5 == 4 || tile5 == 2) && (tile9 == 6 || tile9 == 4 || tile9 == 1))begin
					if(color==0)begin
						tile_out = 4;
						dir = 2'b10;
					end
					else begin
						tile_out = 5;
						dir = 2'b10;
					end
				end
				else if((tile5 == 5 || tile5 == 3 || tile5 == 1) && (tile9 == 5 || tile9 == 3 || tile9 == 2))begin
					if(color==0)begin
						tile_out = 6;
						dir = 2'b10;
					end
					else begin
						tile_out = 3;
						dir = 2'b10;
					end
				end
			end
			
			//
			else if((tile9 == 4'b0000 || tile9[3] == 1'b1) && (tile3 == 4'b0000 || tile3[3] == 1'b1)) begin
				if(tile5 == 5 || tile5 == 3 || tile5 == 1)begin
					if(color==0)begin
						tile_out = 6;
						dir = 2'b10;
					end
					else begin
						tile_out = 3;
						dir = 2'b10;
					end
				end
				
				if(tile5 == 6 || tile5 == 4 || tile5 == 2)begin
					if(color==0)begin
						tile_out = 4;
						dir = 2'b10;
					end
					else begin
						tile_out = 5;
						dir = 2'b10;
					end
				end
			end
			//
		end
	

	//// down
		else if(tile8 == 4'b0000 || tile8[3] == 1'b1)begin
			if((tile9 == 4'b0000 || tile9[3] == 1'b1) && (tile7 != 4'b0000 && tile7[3] == 1'b0))begin
				if((tile5 == 5 || tile5 == 4 || tile5 == 2) && (tile7 == 6 || tile7 == 4 || tile7 == 2))begin
					if(color==0)begin
						tile_out = 1;
						dir = 2'b11;
					end
					else begin
						tile_out = 4;
						dir = 2'b11;
					end
				end
				else if((tile5 == 6 || tile5 == 3 || tile5 == 1) && (tile7 == 5 || tile7 == 3 || tile7 == 1))begin
					if(color==0)begin
						tile_out = 2;
						dir = 2'b11;
					end
					else begin
						tile_out = 3;
						dir = 2'b11;
					end
				end
			end
			//
			if((tile7 == 4'b0000 || tile7[3] == 1'b1) && (tile9 != 4'b0000 && tile9[3] == 1'b0))begin
				if((tile5 == 5 || tile5 == 4 || tile5 == 2) && (tile9 == 5 || tile9 == 4 || tile9 == 1))begin
					if(color==0)begin
						tile_out = 6;
						dir = 2'b11;
					end
					else begin
						tile_out = 4;
						dir = 2'b11;
					end
				end
				else if((tile5 == 6 || tile5 == 3 || tile5 == 1) && (tile9 == 6 || tile9 == 3 || tile9 == 2))begin
					if(color==0)begin
						tile_out = 3;
						dir = 2'b11;
					end
					else begin
						tile_out = 3;
						dir = 2'b11;
					end
				end
			end
			
			//
			else if((tile9 == 4'b0000 || tile9[3] == 1'b1) && (tile7 == 4'b0000 || tile7[3] == 1'b1)) begin
				if(tile5 == 6 || tile5 == 3 || tile5 == 1)begin
					if(color==0)begin
						tile_out = 3;
						dir = 2'b11;
					end
					else begin
						tile_out = 5;
						dir = 2'b11;
					end
				end
				
				if(tile5 == 5 || tile5 == 4 || tile5 == 2)begin
					if(color==0)begin
						tile_out = 6;
						dir = 2'b11;
					end
					else begin
						tile_out = 4;
						dir = 2'b11;
					end
				end
			end
		end
		
		// all zero
	//	if((tile4 == 4'b0000 || tile4[3] == 1'b1) && (tile4 == 4'b0000 || tile4[3] == 1'b1))
		
	end
endmodule