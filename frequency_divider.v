`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2022 23:38:02
// Design Name: 
// Module Name: freq_divider
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

module freq_divider(clk_in , clk , difficultyButton1 , difficultyButton2);
input clk_in;
output reg clk;
input difficultyButton1 , difficultyButton2;

reg [26:0] counterA= 0;
reg [27:0] counterB= 0;
reg [28:0] counterC= 0;
reg [29:0] counterD= 0;


always @(posedge clk_in)
begin

    
    
    counterA = counterA + 26'd1;
    counterB = counterB + 27'd1;
    counterC = counterC + 28'd1;
    counterD = counterD + 29'd1;
    
    if(!difficultyButton1 & !difficultyButton2)
        begin
        clk = counterA[26];
        end
    else if(!difficultyButton1 & difficultyButton2)
        begin
        clk = counterB[27];
        end
    else if(difficultyButton1 & !difficultyButton2)
        begin
        clk = counterC[28];
        end
    else if(difficultyButton1 & difficultyButton2)
        begin
        clk = counterD[29];
        end

    
end
endmodule

