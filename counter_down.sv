// Counter that decrements from WIDTH to 0 at every positive clock edge.
// CSE140L      lab 1
module counter_down	#(parameter dw=8, WIDTH=7)
(
  input                 clk,
  input                 reset,
  input                 ena,
  output logic [dw-1:0] result);

  always @(posedge clk)	 begin
// fill in guts -- clocked (sequential) logic
//  if(...) result <= ...;	      // note nonblocking (<=) assignment!!
//  else if(...) result <= ...;
//reset   ena      result
//  1      1       WIDTH
//  1      0       WIDTH						 
//  0      1       decrease by 1				 
//  0      0       hold

  // ------------------------------------------
      result <= reset ? WIDTH : (ena? result - 1 : result);
  // ------------------------------------------

  end
endmodule	