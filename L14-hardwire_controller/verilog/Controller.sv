`include "definitions.sv"
module Controller(
   input  wire  [3:0] iOpcode,
   input  defs::t_cmp iCmp,
   output logic [3:0] oALUop,
   output logic oYsel, oRegWr, oPCld
);

import defs::*;


endmodule