`ifndef DEFINITIONS_SVH
`define DEFINITIONS_SVH
//tag::core[]
package riscv_defs;

    typedef struct packed{
        logic J; 
        logic U; 
        logic B; 
        logic S;
        logic I;
    } t_imm;
    
endpackage
//end::core[]
`endif