`default_nettype none 
module VirtualBoard (
    input  wire   CLOCK,      // 10 MHz Input Clock 
    input  wire  [19:0] PB,   // 20 Push Buttons, logical 1 when pressed
    input  wire  [35:0] S,    // 36 Switches
    output logic [35:0] L,    // 36 LEDs, drive logical 1 to light up
    output logic  [7:0] SD7,  // 8 common anode Seven-segment Display
    output logic  [7:0] SD6,
    output logic  [7:0] SD5,
    output logic  [7:0] SD4,
    output logic  [7:0] SD3,
    output logic  [7:0] SD2,
    output logic  [7:0] SD1,
    output logic  [7:0] SD0
); 

/** The input port is replaced with an internal signal **/
wire reset =  PB[0];
wire clk;  // =  PB[1];
wire direction = S[8];

/************* The logic of this experiment *************/
/* 对10MHz系统时钟进行分频，使用分频后的时钟作为移位寄存器的时钟。
   分频系数为10M，输出的clkout的频率为1Hz。 */
ClockDivider #(.RATIO(10000000)) divider_inst(.ClkIn(CLOCK), .Reset(reset), .ClkOut(clk));

// Finite State Machine
logic [7:0] pattern;
enum bit [3:0] {
    STATE0   = 4'b0001,
    STATE1   = 4'b0010,
    STATE2   = 4'b0100,
    STATE3   = 4'b1000
} state, next_state;

always_ff @(posedge clk, posedge reset)
begin
	if (reset)
		state <= STATE0;
	else
		state <= next_state;
end

always_comb
begin : set_next_state
    case (state)
    STATE0: begin
        if (direction==0)
            next_state = STATE1;
        else 
            next_state = STATE3;
        end
    STATE1: begin
        if (direction==0)
            next_state = STATE2;
        else 
            next_state = STATE0;
        end
    STATE2: begin
        if (direction==0)
            next_state = STATE3;
        else 
            next_state = STATE1;
        end
    STATE3: begin
        if (direction==0) 
            next_state = STATE0;
        else 
            next_state = STATE2;
        end
    endcase 
end : set_next_state

always_comb
begin : set_outputs
    case (state)
    STATE0: begin
        pattern = 8'b1000_0001;
        end
    STATE1: begin
        pattern = 8'b0100_0010;
        end
    STATE2: begin
        pattern = 8'b0010_0100;
        end
    STATE3: begin
        pattern = 8'b0001_1000;
        end
    endcase
end : set_outputs

/****** Internal signal assignment to output port *******/
assign L[7:0] = pattern;

endmodule
