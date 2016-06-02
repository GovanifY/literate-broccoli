module fpga_top(
	input clk,
	input [749:0] brbselect,
	input [1727:0] bsbselect,
	input [79:0] lbselect,
	input [29:0] leftioselect,
	input [29:0] rightioselect,
	input [29:0] topioselect,
	input [29:0] bottomioselect,
	output [4:0] left, right,
	output [4:0] top, bottom
	);
	// left io blocks
	wire [2:0] ibl1w, ibl2w, ibl3w, ibl4w, ibl5w;
	io_block ibl1(leftioselect[5:0], ibl1w, left[0]);
	io_block ibl2(leftioselect[11:6], ibl2w, left[1]);
	io_block ibl3(leftioselect[17:12], ibl3w, left[2]);
	io_block ibl4(leftioselect[23:18], ibl4w, left[3]);
	io_block ibl5(leftioselect[29:24], ibl4w, left[4]);

	// right io blocks
	wire [2:0] ibr1w, ibr2w, ibr3w, ibr4w, ibr5w;
	io_block ibr1(rightioselect[5:0], ibr1w, right[0]);
	io_block ibr2(rightioselect[11:6], ibr2w, right[1]);
	io_block ibr3(rightioselect[17:12], ibr3w, right[2]);
	io_block ibr4(rightioselect[23:18], ibr4w, right[3]);
	io_block ibr5(rightioselect[29:24], ibr5w, right[4]);

	// top io blocks
	wire [14:0] ibtw;
	io_block ibt1(topioselect[5:0], ibtw[2:0], top[0]);
	io_block ibt2(topioselect[11:6], ibtw[5:3], top[1]);
	io_block ibt3(topioselect[17:12], ibtw[8:6], top[2]);
	io_block ibt4(topioselect[23:18], ibtw[11:9], top[3]);
	io_block ibt5(topioselect[29:24], ibtw[14:12], top[4]);

	// bottom io blocks
	wire [14:0] ibbw;
	io_block ibb1(bottomioselect[5:0], ibbw[2:0], bottom[0]);
	io_block ibb2(bottomioselect[11:6], ibbw[5:3], bottom[1]);
	io_block ibb3(bottomioselect[17:12], ibbw[8:6], bottom[2]);
	io_block ibb4(bottomioselect[23:18], ibbw[11:9], bottom[3]);
	io_block ibb5(bottomioselect[29:24], ibbw[14:12], bottom[4]);

	wire [14:0] r_1, fr1_2, fr2_3, fr3_4;
	// from bottom to top
	last_row_routing lrr1(brbselect[179:0], ibl1w, ibr1w, ibbw, r_1);
	fpga_row fr1(clk, brbselect[359:180], bsbselect[431:0], lbselect[19:0], ibl2w, ibr2w, r_1, fr1_2);
	fpga_row fr2(clk, brbselect[539:360], bsbselect[863:432], lbselect[39:20], ibl3w, ibr3w, fr1_2, fr2_3);
	fpga_row fr3(clk, brbselect[719:540], bsbselect[1295:864], lbselect[59:40], ibl4w, ibr4w, fr2_3, fr3_4);
	fpga_row fr4(clk, brbselect[899:720], bsbselect[1727:1296], lbselect[79:60], ibl5w, ibr5w, fr3_4, ibtw);
endmodule

