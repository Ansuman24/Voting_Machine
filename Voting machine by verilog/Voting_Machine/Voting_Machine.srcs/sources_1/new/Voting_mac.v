`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2023 20:46:53
// Design Name: 
// Module Name: Voting_mac
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Voting_mac(
input clock,
input reset,
input button,
output reg valid_vote);
reg [30:0] counter;

always@(posedge clock)
begin
if(reset)
counter<=0;
else
begin
if(button & counter < 11)
counter<=counter+1;
else if(!button)
counter<=0;
end
end

always@(posedge clock)
begin
if(reset)
valid_vote <= 1'b0;
else
begin
if(counter==10)
valid_vote<=1'b1;
else
valid_vote<=1'b0;
end
end
endmodule




module votelogger(
input clock,
input reset,
input mode,
input c1_vote_valid,
input c2_vote_valid,
input c3_vote_valid,
input c4_vote_valid,
output reg [7:0] c1_vote_recvd,
output reg [7:0] c2_vote_recvd,
output reg [7:0] c3_vote_recvd,
output reg [7:0] c4_vote_recvd
);

always@(posedge clock)
begin
if(reset)
begin
c1_vote_recvd<=0;
c2_vote_recvd<=0;
c3_vote_recvd<=0;
c4_vote_recvd<=0;
end
else
begin
if(c1_vote_valid & mode==0)
c1_vote_recvd<=c1_vote_recvd+1;
else if(c2_vote_valid & mode==0)
c2_vote_recvd<=c2_vote_recvd+1;
else if(c3_vote_valid & mode==0)
c3_vote_recvd<=c3_vote_recvd+1;
else if(c4_vote_valid & mode==0)
c4_vote_recvd<=c4_vote_recvd+1;
end
end
endmodule





module modecontrol(
input clock,
input reset,
input mode,
input valid_vote_casted,
input [7:0] can1_vote,
input [7:0] can2_vote,
input [7:0] can3_vote,
input [7:0] can4_vote,
input can1_button_press,
input can2_button_press,
input can3_button_press,
input can4_button_press,
output reg [7:0] leds
);
reg [30:0] counter;
always@(posedge clock)
begin
if(reset)
counter<=0;
else if(valid_vote_casted)
counter<=counter+1;
else
counter<=0;
end

always@(posedge clock)
begin
if(reset)
leds<=0;
else
begin
if(mode==0 & counter<0)
leds<=8'hFF;
else if(mode==0)
leds<=8'h00;
else if(mode==1)
begin
if(can1_button_press)
leds<=can1_vote;
else if(can2_button_press)
leds<=can2_vote;
else if(can3_button_press)
leds<=can3_vote;
else if(can4_button_press)
leds<=can4_vote;
end
end
end
endmodule


module votingmachine(
input clock,
input reset,
input mode,
input button1,
input button2,
input button3,
input button4,
output [7:0] led
);

wire valid_vote1;
wire valid_vote2;
wire valid_vote3;
wire valid_vote4;
wire [7:0] c1_vote_recvd;
wire [7:0] c2_vote_recvd;
wire [7:0] c3_vote_recvd;
wire [7:0] c4_vote_recvd;
wire anyvalidvote;

assign anyvalidvote = valid_vote1|valid_vote2|valid_vote3|valid_vote4;

Voting_mac bc1(
.clock(clock),  
.reset(reset),
.button(button1),
.valid_vote(valid_vote1)
);

Voting_mac bc2(      
.clock(clock),          
.reset(reset),          
.button(button2),       
.valid_vote(valid_vote2)
);

Voting_mac bc3(
.clock(clock),   
.reset(reset), 
.button(button3),
.valid_vote(valid_vote3)  
);         

Voting_mac bc4(
.clock(clock),
.reset(reset),
.button(button4),
.valid_vote(valid_vote4)
);

votelogger VL(
.clock(clock), 
.reset(reset), 
.mode(mode),
.c1_vote_valid(valid_vote1),
.c2_vote_valid(valid_vote2),
.c3_vote_valid(valid_vote3),
.c4_vote_valid(valid_vote4),
.c1_vote_recvd(c1_vote_recvd),
.c2_vote_recvd(c2_vote_recvd),
.c3_vote_recvd(c3_vote_recvd),
.c4_vote_recvd(c4_vote_recvd)
);

modecontrol MC(
.clock(clock),  
.reset(reset),  
.mode(mode),
.valid_vote_casted(anyvalidvote),
.can1_vote(c1_vote_recvd),
.can2_vote(c1_vote_recvd),
.can3_vote(c1_vote_recvd),
.can4_vote(c1_vote_recvd), 
.can1_button_press(valid_vote1),
.can2_button_press(valid_vote1),
.can3_button_press(valid_vote1),
.can4_button_press(valid_vote1), 
.leds(led)
);

endmodule