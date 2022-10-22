// load and store register with signals to control 
//   high and low bits separately or at the same time
// double-wide register -- very common in double-precision work
// needed here because multiplying two 8-bit numbers provides a 16-bit product
module register_hl # (parameter N = 16)
 (input                clk,
  input [N/2-1:0]      inh,
  input [N/2-1:0]      inl,
  input                loadh,
  input                loadl,
  input                clear,
  output logic[N-1:0]  out	  	);
	
  always_ff @ (posedge clk, posedge clear) begin
//fill in the guts  -- sequential
// if(...) out[N-1:N/2] <= ...;
// else if(...) out[N-1:N/2] <= ...;
// if(...) out[N/2-1:0] <= ...;
//  clear   loadh    loadl   out[N-1:N/2]   out[N/2-1:0] 
//  1       x        x       0              0
//  0       0        1       hold           inl
//  0       1        0       inh            hold
//  0       1        1       inh            inl
//  0       0        0       hold           hold
  end	


  // ------------------------------------------
  always_ff @ (posedge clk, posedge clear) begin
    if(clear) out[N-1:0] <= 0;
    else begin
      if (loadh) out[N-1:N/2] <= inh;
      if (loadl) out[N/2-1:0] <= inl;
    end
  end
  // ------------------------------------------

endmodule
