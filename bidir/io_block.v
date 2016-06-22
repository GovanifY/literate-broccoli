module io_block(
	input [wire_width*2-1:0] select,
	inout [wire_width-1:0] in,
	inout port
	);
	parameter wire_width = 3;
	wire nowhere, w1;
	genvar x;
	generate
	for (x = 0; x < wire_width; x = x + 1) begin
		bidir_tsb bt(select[x*2+1:x*2], in[x], port);
	end
	endgenerate
	/*bidir_tsb bt1(select[1:0], in[0], port);
	bidir_tsb bt2(select[3:2], in[1], port);
	bidir_tsb bt3(select[5:4], in[2], port);*/
	// bidir_tsb bt1(select[3:2], w1, port);
	// mux4x1 m1(select[1:0], in[0], in[1], in[2], nowhere, w1);
endmodule

