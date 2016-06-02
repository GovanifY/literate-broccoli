module bidir_routing_block(
	input [35:0] select,
	// zero, zero in lower left corner
	inout [2:0] left, 
	inout [2:0] right,
	inout [2:0] top,
	inout [2:0] bottom
	);
	bidir_switch bs1(select[11:0], left[0], right[0], top[0], bottom[0]);
	bidir_switch bs2(select[23:12], left[1], right[1], top[1], bottom[1]);
	bidir_switch bs3(select[35:24], left[2], right[2], top[2], bottom[2]);
endmodule

