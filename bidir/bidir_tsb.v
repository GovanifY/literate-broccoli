module bidir_tsb(
	input [1:0] select,
	inout left, right
	);
	// tsb t1(select[0], left, right);
	// tsb t2(select[1], right, left);

	// out, in, control
	bufif1 b1(right, left, select[0]);
	bufif1 b2(left, right, select[1]);
endmodule

