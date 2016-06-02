module mux4x1(
	input wire [1:0] select,
	input wire A, B, C, D,
	output wire out
	);
	wire m1out, m2out;
	mux2x1 m1(select[0], A, B, m1out);
	mux2x1 m2(select[0], C, D, m2out);
	mux2x1 m3(select[1], m1out, m2out, out);
endmodule

