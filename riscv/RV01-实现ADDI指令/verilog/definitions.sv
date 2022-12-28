`ifndef DEFINITIONS_SVH
`define DEFINITIONS_SVH

package riscv_defs;

    typedef struct packed{
        logic J; 
        logic U; 
        logic B; 
        logic S;
        logic I;
    } t_imm;
    
endpackage

`endif