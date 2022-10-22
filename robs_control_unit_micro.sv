// this control unit implements the microcode required to control the datapath
// needed by a Robertson's multiplier described in toprobertsons.v.
// No need to edit for Lab 1.
module robs_control_unit_micro(
	input clk, reset,
	input zq, zy, zr,
	output[14:0] c,
	output logic done
	);
	
    wire load_incr;
    wire [4:0] upc;
    wire [22:0] uinstr;
	
    // micro-PC, equiv. to a program counter in ARM or MIPS
    upcreg upc_reg(.clk, .reset, .load_incr, .upc_next(uinstr[19:15]), .upc);
    
    // condition select mux
    mux5 cs_mux(.d0(1'b0), .d1(zq), .d2(zr), .d3(zy), .d4(1'b1), .s(uinstr[22:20]), .y(load_incr));
    
    // control (instruction) memory
    rom control_memory(.addr(upc), .data(uinstr));
    
	// output logic
	assign c = uinstr[14:0];		// machine code
    
    always_latch// @(upc)
      if     (reset)     done = 0;
      else if(upc == 17) done = 1;
    
endmodule
