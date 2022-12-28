`default_nettype none 
module SEG7_DISPLAY (
    input wire  	   iClk,
    input wire   [7:0] iSEG0,
    input wire   [7:0] iSEG1,
    input wire   [7:0] iSEG2,
    input wire   [7:0] iSEG3,
    input wire   [7:0] iSEG4,
    input wire   [7:0] iSEG5,
    input wire   [7:0] iSEG6,
    input wire   [7:0] iSEG7,
	
	output  reg[7:0] oSEL,
    output  reg[7:0] oSEG
); 

	reg[2:0]counter;
	reg[19:0]counter2;
	parameter max_n = 20'd250_000;  //100M*2.5ms
	
	always@(posedge iClk)begin
			
		if(counter2 > max_n ) counter2 <= 0;
		else counter2 <= counter2+1;
			
		if(counter2 == max_n )
			counter <= counter+1;
		
			case(counter)
			3'd0: 	begin
					oSEG <= iSEG0;	
					oSEL <= 8'b11111110;
					end
			3'd1: 	begin
					oSEG <= iSEG1;	
					oSEL <= 8'b11111101;
					end
			3'd2: 	begin
					oSEG <= iSEG2;	
					oSEL <= 8'b11111011;
					end
			3'd3: 	begin
					oSEG <= iSEG3;	
					oSEL <= 8'b11110111;
					end
			3'd4: 	begin
					oSEG <= iSEG4;	
					oSEL <= 8'b11101111;
					end
			3'd5: 	begin
					oSEG <= iSEG5;	
					oSEL <= 8'b11011111;
					end
			3'd6: 	begin
					oSEG <= iSEG6;	
					oSEL <= 8'b10111111;
					end
			3'd7: 	begin
					oSEG <= iSEG7;	
					oSEL <= 8'b01111111;
					end
			endcase
	end
	
endmodule