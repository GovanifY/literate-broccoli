module logic_block(
	input clk,
	input [1:0] select,
	input [3:0] const_mem,
	input sync,
	output out
	);
	wire l1out, sum, m1out, m2out, dout, dnotout;

	lut l1(select[1:0], const_mem, l1out);

	dff dff1(l1out, clk, dout, dnotout);

	mux2x1 m1(sync, l1out, dout, out);
endmodule

module lut(
	input [1:0] select, 
	input [3:0] const_mem,
	output out
	);
	assign out = const_mem[select];
endmodule

