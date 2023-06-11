`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2023 15:19:01
// Design Name: 
// Module Name: main_module
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


module main_module(on ,  clk_in, btnA, btnB, led , outA , outB, specialButton, difficultyButton);
    
input on;
input clk_in;
input btnA , btnB;
wire clk_reduced;
output [5:0]led;
input specialButton;
input difficultyButton;

reg [1:0]difficultyLevel;
freq_divider F( clk_in , clk_reduced , difficultyLevel[0] , difficultyLevel[1]);

reg [2:0] state = 3'd0;
reg lostA , lostB;
glow_led GL(on,clk_reduced , led , state , lostA , lostB);
reg player = 0;
//player = 0 means player A to play
//player = 1 means player B to play

reg [3:0]scoreA = 4'd0;
reg [3:0]scoreB = 4'd0;

//output reg[6:0]outA = 7'b1111111;
//output reg [6:0]outB = 7'b1111111;

output [6:0]outA;
output [6:0]outB;

// display the current state

reg releaseA = 1;
reg releaseB = 1;

reg [26:0] countA = 0;
reg [26:0] countB = 0;


//always @(posedge clk_in)
//begin
//    if(btnA)
//        countA = countA + 27'd1;
//    else
//        countA = 27'd0;

//    if(btnB)
//        countB = countB + 27'd1;
//    else
//        countB = 27'd0;
//end


always @(posedge clk_in)
begin
    
    if(btnA)
        releaseA = 0;
    else
        releaseA = 1;
end

always @(posedge clk_in)
begin
    if(btnB)
        releaseB = 0;
    else
        releaseB = 1;
end

showSevenSegment(scoreA , scoreB , outA , outB);

always @(posedge clk_reduced)
begin

        if(on)
            begin
                
                if(difficultyButton)
                begin
                    difficultyLevel = difficultyLevel + 4'd1;
                    if(difficultyLevel == 4'd4)
                    begin
                        difficultyLevel = 4'd0;
                    end
                end
                
                if(scoreA < 4'd10 & scoreB < 4'd10)
                    begin
                
                        if(lostA | lostB)
                        begin
                            if(specialButton)
                            begin
                                state = 3'd0;
                                lostA = 0;
                                lostB = 0;
                                player = 0;
                                countA = 0;
                                countB = 0;
    
                            end
                        end
                        
                        else
                        begin
                    
                        if(!player & state==3'd5)
                        begin
                            if(!btnA)
                            begin
                                lostA = 1;
                                scoreB = scoreB + 4'd1;
                            end
                        end
                        
                        if(player & state==3'd0)
                        begin
                            if(!btnB)
                            begin
                                lostB = 1;
                                scoreA = scoreA + 4'd1;
                            end
                        end
                        
                        if(player & state==3'd4) // now A's chance is gone and ball is going right
                        
                        begin
                             // We want to check if A had hit the in the prev cycle or not
                            if(releaseA & countA < 27'd125000000)
                            begin
                                
                            end
                            else
                            begin
                                // A lost as could not play in time
                                lostA = 1;
                                scoreB = scoreB + 4'd1;
                                
                            end
                        end
                        
                        if(!player & state==3'd1) // now B's chance is gone and ball is going left
                
                        begin
                            // We want to check if B had hit the in the prev cycle or not
                            if(releaseB & countB < 27'd125000000)
                            begin
                                // B had pressed and B had not taken more than 1 sec to play shot
                                // all OK
    //                         
                            end
                            else
                            begin
                                // B lost as could not play in time
                                lostB = 1;
                                scoreA = scoreA + 4'd1;
                            end
                        end
                        
                        if(!lostA & !lostB)
                    begin
                    
                        if(!player) // means player A's turn
                        begin
                            if(state == 3'd5) // condition to flip whose turn
                                begin
                                    state = 3'd4;
                                    player = 1;
                                end
                            else
                                state = state + 3'd1;
                        end
                        
                        else // means player B's turn
                        begin
                            
                            if(state == 3'd0) // condition to flip whose turn
                                begin
                                    state = 3'd1;
                                    player = 0;
                                end
                            else
                                state = state - 3'd1;
                                
                        end
                    
                    end
                        
                    end    
                   end
                    
                else
                    begin
                       
                       if(specialButton)
                       begin
                            state = 3'd0;
                            lostA = 0;
                            lostB = 0;
                            player = 0;
//                            scoreA = 4'd0;
//                            scoreB = 4'd0;
                            
//                            outA = 7'b1111111;
//                            outB = 7'b1111111;
                            
//                            releaseA = 1;
//                            releaseB = 1;
                            
                            countA = 0;
                            countB = 0;


                       end
                       
                       else
                           begin
                           if(scoreA == 4'd10)
                            begin
                                scoreB = 4'd11;
                                scoreA = 4'd10;
                            end
                           else
                           begin
                                scoreA = 4'd11;
                                scoreB = 4'd10;
                           end 
                       end
                    end
            end
                
end

endmodule

