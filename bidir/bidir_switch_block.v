module bidir_switch_block(
	input [107:0] select,
	inout [2:0] left, 
	inout [2:0] right,
	inout [2:0] bottom
	);
	wire nowhere; // surrogate topmost connection
	// Horizontal wires
	wire r1c12, r1c23;
	wire r2c12, r2c23;
	wire r3c12, r3c23;
	
	// First row
	wire w1, w2, w3;
	bidir_switch bs1(select[11:0], left[0], r1c12, w1, bottom[0]);
	bidir_switch bs2(select[23:12], r1c12, r1c23, w2, bottom[1]);
	bidir_switch bs3(select[35:24], r1c23, right[0], w3, bottom[2]);
	// Second row
	wire w4, w5, w6;
	bidir_switch bs4(select[47:36], left[1], r2c12, w4, w1);
	bidir_switch bs5(select[59:48], r2c12, r2c23, w5, w2);
	bidir_switch bs6(select[71:60], r2c23, right[1], w6, w3);
	// Second row
	wire w7, w8, w9;
	bidir_switch bs7(select[83:72], left[2], r3c12, w7, w4);
	bidir_switch bs8(select[95:84], r3c12, r3c23, w8, w5);
	bidir_switch bs9(select[107:96], r3c23, right[2], w9, w6);
	
	// First column
	// Vertical wires
	/*wire w1, w2;
	bidir_switch bs1(select[11:0], left[0], r1c12, w1, bottom[0]);
	bidir_switch bs2(select[23:12], left[1], r2c12, w2, w1);
	bidir_switch bs3(select[35:24], left[2], r3c12, nowhere, w2);
	// Second column
	// Vertical wires
	wire w3, w4;
	bidir_switch bs4(select[47:36], r1c12, r1c23, w3, bottom[1]);
	bidir_switch bs5(select[59:48], r2c12, r2c23, w4, w3);
	bidir_switch bs6(select[71:60], r3c12, r3c23, nowhere, w4);
	// Third column
	// Vertical wires
	wire w5, w6;
	bidir_switch bs7(select[83:72], r1c23, right[0], w5, bottom[1]);
	bidir_switch bs8(select[95:84], r2c23, right[1], w6, w5);
	bidir_switch bs9(select[107:96], r3c23, right[2], nowhere, w6);*/
	
endmodule

