module bidir_switch(
	input [11:0] select,
	inout left, right, top, bottom
	);
	wire center;
	bidir_tsb bt1(select[1:0], left, top);
	bidir_tsb bt2(select[3:2], left, right);
	bidir_tsb bt3(select[5:4], left, bottom);
	bidir_tsb bt4(select[7:6], top, bottom);
	bidir_tsb bt5(select[9:8], top, right);
	bidir_tsb bt6(select[11:10], right, bottom);
endmodule

