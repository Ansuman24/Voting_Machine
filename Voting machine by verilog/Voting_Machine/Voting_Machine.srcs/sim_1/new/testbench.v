`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 21:44:23
// Design Name: 
// Module Name: testbench
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


module testbench;
reg clock;
reg reset;
reg mode;
reg button1;
reg button2;
reg button3;
reg button4;

reg c1_vote_recvd; 
reg c2_vote_recvd; 
reg c3_vote_recvd; 
reg c4_vote_recvd; 

wire [7:0]led;

votingmachine uut(
.clock(clock),
.reset(reset),
.mode(mode),
.button1(button1),
.button2(button2),
.button3(button3),
.button4(button4),
.led(led));

initial begin
clock=0;
forever #5 clock=~clock;
end

initial begin
reset=1; mode=0; button1=0; button2=0; button3=0; button4=0;
#100;

#100 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=1;button2=0;button3=0;button4=0;
#10 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=1;button2=0;button3=0;button4=0;
#200 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#10 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;

#5 reset=0;mode=0;button1=0;button2=1;button3=0;button4=0;
#200 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#10 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;

#5 reset=0;mode=0;button1=0;button2=1;button3=1;button4=0;
#200 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#10 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;

#5 reset=0;mode=1;button1=0;button2=1;button3=0;button4=0;
#200 reset=0;mode=1;button1=0;button2=0;button3=1;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#10 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;

#5 reset=0;mode=0;button1=0;button2=0;button3=1;button4=0;
#200 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#10 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;
#5 reset=0;mode=0;button1=0;button2=0;button3=0;button4=0;

$finish;
end


endmodule
