// 3:1 mux    
// CSE140L	  
module mux3 #(parameter WIDTH = 8)
  (input       [WIDTH-1:0] d0, d1, d2,
   input       [1:0]       s, 	// s[1] s[0]
   output logic[WIDTH-1:0] y);

// fill in guts (combinational -- assign or always_comb, use =)
//  s[1]  s[0]  y
//  0     0    d0
//  0     1	   d1
//  1     0    d2
//  1     1	   d2


// ------------------------------------------
always_comb assign y[1:0] = s[1] ? d2[1:0] : (s[0] ? d1[1:0] : d0[1:0]);
// ------------------------------------------
            

endmodule