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
wire M   = S[9];
wire [3:0] X = S[7:4];
wire [3:0] Y = S[3:0];

/************* The logic of this experiment *************/
//tag::logic[]
logic [3:0] A, B, F;
logic C0, C4;
logic sign, zero, overflow, carryOut;

assign A = X;
assign B = Y ^ {4{M}};
assign C0 = M;
assign {C4,F} = A + B + C0;  

assign sign = F[3];
assign zero = ~|F;  //<1>
assign overflow = ~A[3] & ~B[3] & F[3] | A[3] & B[3] & ~F[3]; //<2>
assign carryOut = (M==1'b0) ? C4 : ~C4; //<3>
//end::logic[]
/****** Internal signal assign to output port *******/
assign L[3:0]   = B[3:0];
assign L[7:4]   = X[3:0]; 
assign L[11:8]  = F;
assign L[15:12] = {sign, zero, overflow, carryOut};
assign L[26] = C0; 

endmodule
