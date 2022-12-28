module WatchChain
#(  parameter DATAWIDTH=16)
(
    input wire [DATAWIDTH-1:0] DataIn,
    input wire ScanIn, ShiftDR, CaptureDR, TCK,
    output wire ScanOut
);
	reg	[DATAWIDTH-1:0]	Capture_Register;

	always @ (posedge TCK) 
	begin
		if(CaptureDR)
			Capture_Register <= DataIn;
		else if (ShiftDR)
			Capture_Register <= {ScanIn, Capture_Register[DATAWIDTH-1:1]};
    end

	assign ScanOut = Capture_Register[0];

endmodule
