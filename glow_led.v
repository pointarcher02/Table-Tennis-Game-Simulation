`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2023 15:14:59
// Design Name: 
// Module Name: glow_led
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


module glow_led(on , clk_one_sec , led , state , lostA , lostB);
input [2:0]state;
input clk_one_sec;
output reg [5:0]led;
input lostA , lostB;
input on;
always @(posedge clk_one_sec)
begin

    if(on)
        begin
        if(lostA)
        begin
            led = 6'b000000;
        end
        else if(lostB)
        begin
            led = 6'b111111;
        end
        
        else
            begin
            if(state == 0)
            begin
                led = 6'b000001;
            end
            else if(state == 1)
            begin
                led = 6'b000010;
            end
            else if(state == 2)
            begin
                led = 6'b000100;
            end
            else if(state == 3)
            begin
                led = 6'b001000;
            end
            else if(state == 4)
            begin
                led = 6'b010000;
            end
            else if(state == 5)
            begin
                led = 6'b100000;
            end
            end  
        end
    else
        begin
            led = 5'b10001;
        end
end
endmodule
