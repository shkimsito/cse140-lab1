// this datapath implements hardware required to perform signed
// Robertson's multiplication described in toprobertsons.v.
module robs_datapath #(parameter WIDTH = 8)
    (
	input clk, reset,
	input [WIDTH-1:0] multiplier, multiplicand,
	input[14:0]  c,
	output [WIDTH*2-1:0] product,
	output zq, zr
	);
	
	// Internal signals of the datapath module
	wire [WIDTH-1:0] y, a, in_x, x, in_rh, in_rl, alu_out, q;
	wire [WIDTH*2-1:0] r, sr;
	
	register #(.N(WIDTH)) reg_y(.clk(clk), .in(multiplicand), .out(y), .load(c[0]), .clear(1'b0));
	register #(.N(WIDTH)) reg_a(.clk, .in(r[WIDTH*2-1:WIDTH]), .out(a), .load(c[14]), .clear(c[2]));
	register #(.N(WIDTH)) reg_x(.clk, .in(in_x), .out(x), .load(c[3]), .clear(1'b0));
	register_hl reg_r(.clk(clk), .inh(in_rh), .inl(in_rl), .loadh(c[8]), .loadl(c[9]), .clear(1'b0), .out(r));
	
	right_shift_register #(.WIDTH(2*WIDTH)) sign_ext(.clk, .enable(c[12]), .in(r), .mode(c[11]), .out(sr)); 
	
	mux2 #(.WIDTH(WIDTH)) mux_x(.d0(multiplier), .d1(r[WIDTH-1:0]), .s(c[7]), .y(in_x));
	mux3 #(.WIDTH(WIDTH)) mux_rh(.d0(a), .d1(sr[WIDTH*2-1:WIDTH]), .d2(alu_out), .s(c[5:4]), .y(in_rh));
	mux2 #(.WIDTH(WIDTH)) mux_rl(.d0(x), .d1(sr[WIDTH-1:0]), .s(c[6]), .y(in_rl));
	
	addsub #(.dw(WIDTH)) addsub(.dataa(r[WIDTH*2-1:WIDTH]), .datab(y), .add_sub(c[10]), .result(alu_out));
	
	counter_down #(.dw(WIDTH),.WIDTH(WIDTH-1)) decrement8(.clk, .reset(c[1]), .ena(c[13]), .result(q));
	
	// External: signals to control unit and outbus
	assign product = {a,x};			 // concatenate operator, creates one vector from a followed by x
// fill in guts
//  always_comb if(...) zr = 1; else zr = 0;
//  similar treatment for zq;
//    zr = 1 if r is even
//    zq = 1 if q is divisible by 8
	// ------------------------------------------
	always_comb begin
		if(!r[0]) zr = 1;	// A number is odd if the last bit is 1.
		else zr = 0;
	end
	// ------------------------------------------

endmodule
