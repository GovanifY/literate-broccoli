module logic_block(
	input clk,
	input [4:0] cfg,
	inout [2:0] io
	// input [1:0] select,
	// input [3:0] const_mem,
	// input sync,
	// output out
	);
	wire l1out, sum, m1out, m2out, dout, dnotout;

	// io[1:0] is the combinational inputs
	// cfg[3:0] is the LUT memory
	lut l1(io[1:0], cfg[3:0], l1out);

	dff dff1(l1out, clk, dout, dnotout);

	// io[2] is the output
	// cfg[4] is sync enable
	mux2x1 m1(cfg[4], l1out, dout, io[2]);
endmodule

module lut(
	input [1:0] select, 
	input [3:0] const_mem,
	output out
	);
	assign out = const_mem[select];
endmodule

