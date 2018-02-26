module out_adderss(
input[x_w:0] x,y,
input[x_w:0] off_x, off_y,
input[3:0] type,
output[15:0] out_x, out_y,
output[7:0] out_type,
output x_num, y_num);
parameter x_w = 10;
parameter depth = 21;

assign out_type = ((type == 4'b001) || (type == 4'b010)) ? 8'd92 : ((type == 4'b0011) || (type == 4'b0100)) ? 8'd43 : 8'd47; 

assign out_x[7:0] = ((x-off_x)<=26) ? (((x - off_x)%27) + 8'd64) : (((x - off_x - 1)%26) + 8'd65);
assign out_x[15:8] = ((x-off_x)<=26) ? (0) : (((((x - off_x)/26)-1)%26) + 8'd65);
assign x_num = (x-off_x)>26;

assign out_y[7:0] = (y - off_y)%10 + 8'd48;
assign out_y[15:8] = ((((y - off_y)/10)%10) == 8'b0)? (0) : ((((y - off_y)/10)%10)+8'd48);
assign y_num = (y-off_y)>=10;

endmodule
