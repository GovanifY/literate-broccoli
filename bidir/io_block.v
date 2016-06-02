module io_block(
	input [5:0] select,
	inout [2:0] in,
	inout port
	);
	wire nowhere, w1;
	bidir_tsb bt1(select[1:0], in[0], port);
	bidir_tsb bt2(select[3:2], in[1], port);
	bidir_tsb bt3(select[5:4], in[2], port);
	// bidir_tsb bt1(select[3:2], w1, port);
	// mux4x1 m1(select[1:0], in[0], in[1], in[2], nowhere, w1);
endmodule

