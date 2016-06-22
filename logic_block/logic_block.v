module logic_block(
	input clk,
	input [9:0] cfg,
	// io[3:0] are regular inputs
	// io[4] is the carry in
	// io[5] is the output
	// io[6] is the carry out
	inout [6:0] io
	);
	defparam fpga_top.wire_width = 7;
	parameter cfg_size = 10;
	wire l1out, l2out, sum, m1out, m2out, dout, dnotout;

	// io[2:0] is the first three combinational inputs
	// cfg[7:0] is the LUT memory
	lut l1(io[2:0], cfg[7:0], l1out);
	lut l2(io[2:0], cfg[7:0], l2out);

	// io[4] is cin
	// io[6] is cout
	fulladder f1(
		.a(l1out),
		.b(l2out),
		.carryin(io[4]),
		.sum(sum),
		.carryout(io[6])
	);

	// cfg[4] is sync enable
	dff dff1(m2out, clk, dout, dnotout);

	// io[3] picks which LUT to use
	mux2x1 m1(io[3], l1out, l2out, m1out);

	// cfg[8] enables the full adder
	mux2x1 m2(cfg[8], sum, m1out, m2out);

	// cfg[9] enables the d-flipflop
	mux2x1 m3(cfg[9], m2out, dout, io[5]);

endmodule

module lut(
	input [2:0] select, 
	input [7:0] const_mem,
	output out
	);
	assign out = const_mem[select];
endmodule

