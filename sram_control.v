`timescale 1ns/1ps
// ********************************************************************* //
// Filename: sram_controller.v                                           //
// Projects: sram_controller on DE2-115                                  //
//           without  external clock                                     //
// Function: check the wirte/read data by led,                           //
//           right:LED=1 Wrong:LED=0                                     //           
// Author  : Liu Qiang                                                   //
// Date    : 2011-11-21                                                  //
// Version : 1.0                                                         //
// Company :                                                             //
// ********************************************************************* //
 
module sram_controller(
//  intput
input clk_50,
input rst_n,
input[19:0] addr_in,
input start,
input[15:0] data_in,
//  output
output[19:0] sram_addr,
output sram_wr_n,
output sram_ce_n,
output sram_oe_n,
output sram_ub_n,
output sram_lb_n,
output led,
//  inout
inout[15:0] sram_data
);
//
assign sram_ce_n = 1'b0;    //sram chip select always enable
assign sram_oe_n = 1'b0;    //sram output always enable
assign sram_ub_n = 1'b0;    //upper byte always available
assign sram_lb_n = 1'b0;    //lower byte always available
//
reg[25:0] delay;        //延时计数器,周期约为1.34s
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        delay <= 26'd0;
    else
        delay <= delay+1'b1;
//
reg[15:0] wr_data;
reg[15:0] rd_data;
reg[19:0] addr_r;
wire sram_wr_req;
wire sram_rd_req;
reg led_r;
 
assign sram_wr_req = (delay == 26'd9999);
assign sram_rd_req = (delay == 26'd19999);
 
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        wr_data <= 16'b0;
    else if(start == 1'b1)
        wr_data <= data_in;
         
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        addr_r <= 20'b0;
    else if(start == 1'b1)
        addr_r <= addr_in;
     
always@(posedge clk_50 or negedge rst_n)
        if(!rst_n)
            led_r <= 1'b0;
        else if(delay == 26'd99)
            begin
                if(wr_data == rd_data)
                    led_r <= 1'b1;
                else
                    led_r <= 1'b0;
            end
assign led = led_r;
//
`define DELAY_80NS  (cnt == 3'd7)   //80nss取决于Twc的值, cnt=7约140ns;
 
reg[3:0] cstate, nstate;
parameter   IDEL = 4'd0,
            WRT0 = 4'd1,
            WRT1 = 4'd2,
            REA0 = 4'd3,
            REA1 = 4'd4;
             
reg[2:0] cnt;
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        cnt <= 3'b0;
    else if(cstate == IDEL)
        cnt <= 3'b0;
    else
        cnt <= cnt+1'b1;
//  两段式状态机写法，时序逻辑      
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        cstate <= IDEL;
    else
        cstate <= nstate;
//  两段式状态机写法，组合逻辑          
always@(posedge clk_50 or negedge rst_n)
    case(cstate)
        IDEL:   if(sram_wr_req)
                    nstate <= WRT0;
                else if(sram_rd_req)
                    nstate <= REA0;
                else
                    nstate <= IDEL;
        WRT0:   if(`DELAY_80NS)
                    nstate <= WRT1;
                else
                    nstate <= WRT0;
        WRT1:   nstate <= IDEL;
        REA0:   if(`DELAY_80NS)
                    nstate <= REA1;
                else
                    nstate <= REA0;
        REA1:   nstate <= IDEL;
        default:nstate <= IDEL;
    endcase
     
assign sram_addr =addr_r;
//  锁存数据
reg sdlink;     //SRAM地址总线控制信号
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        rd_data <= 16'b0;
    else if(cstate == REA1)
        rd_data <= sram_data;
         
always@(posedge clk_50 or negedge rst_n)
    if(!rst_n)
        sdlink <= 1'b0;
    else
        case(cstate)
            IDEL:   if(sram_wr_req)
                        sdlink <= 1'b1;
                    else if(sram_rd_req)
                        sdlink <= 1'b0;
                    else
                        sdlink <= 1'b0;
            WRT0:   sdlink <= 1'b1;
            default:sdlink <= 1'b0;
        endcase
     
assign sram_data = sdlink ? wr_data:16'hzzzz;
assign sram_wr_n = ~sdlink;
 
endmodule