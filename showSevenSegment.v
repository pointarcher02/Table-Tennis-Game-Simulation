`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2022 22:59:58
// Design Name: 
// Module Name: showSevenSegment
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



module showSevenSegment(in , inB, led , ledB);

input [3:0] in , inB;
output reg [6:0] led , ledB;

always @(in , inB)
begin
    case(in)
        
        0: led=7'b0000001;1: led=7'b1001111;2: led=7'b0010010;3: led=7'b0000110;
    4: led=7'b1001100;5: led=7'b0100100;6: led=7'b0100000;7: led=7'b0001111;
    8: led=7'b0000000;9: led=7'b0000100;
    10: led= 7'b0110001; 11: led = 7'b1110001;
//    10: led=7'b0001000;11: led=7'b1100000;
//    12: led=7'b0110001;13: led=7'b1000010;14: led=7'b0110000;15: led=7'b0111000;
        default: 
            led = 7'b0000000; 
     endcase
     
     case(inB)
        
        0: ledB=7'b0000001;1: ledB=7'b1001111;2: ledB=7'b0010010;3: ledB=7'b0000110;
    4: ledB=7'b1001100;5: ledB=7'b0100100;6: ledB=7'b0100000;7: ledB=7'b0001111;
    8: ledB=7'b0000000;9: ledB=7'b0000100;
    10: ledB= 7'b0110001; 11: ledB = 7'b1110001;
//    10: led=7'b0001000;11: led=7'b1100000;
//    12: led=7'b0110001;13: led=7'b1000010;14: led=7'b0110000;15: led=7'b0111000;
        default: 
            ledB = 7'b0000000; 
     endcase
     
end


endmodule
