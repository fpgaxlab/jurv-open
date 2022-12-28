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
wire S0   = S[9];
wire S1   = S[10];
wire M0   = S[11];
wire [3:0] X = S[7:4];
wire [3:0] Y = S[3:0];

/************* The logic of this experiment *************/
localparam N = 4;
wire [N-1:0] A, B, F; 
wire C0;
logic [N:0] result; // Bit width is N+1 bits
logic sign, zero, overflow, carryOut;

assign A = X; 
assign B = Y ^ {N{M0}};
assign C0 = M0;

always_comb 
begin
   case ({S1,S0})
      2'b00: result = A + B + C0;        
      2'b01: result = {1'b0, (X & Y)};
      2'b10: result = {1'b0, (X | Y)};
      2'b11: result = {1'b0, (X ^ Y)};
      default: result = {(N+1){1'bx}};
   endcase
end

assign F = result[N-1:0];
assign sign = F[N-1];
assign zero = (F==0) ? 1'b1 : 1'b0;  // ~(|F);
assign overflow = ({S1,S0}) ? 1'b0 : (~A[N-1] & ~B[N-1] & F[N-1] | A[N-1] & B[N-1] & ~F[N-1]);
assign carryOut = (M0==1'b0) ? result[N] : ~result[N];

/****** Internal signal assignment to output port *******/
assign L[3:0]  = B[3:0];
assign L[7:4]  = X[3:0]; 
assign L[12:9] = F;
assign L[21:18] = {sign, zero, overflow, carryOut};

endmodule
