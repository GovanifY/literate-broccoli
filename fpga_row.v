module fpga_row(
	input clk,
	input [179:0] brbselect,
	input [431:0] bsbselect,
	input [19:0] lbselect,
	inout [2:0] left,
	inout [2:0] right,
	inout [14:0] top,
	inout [14:0] bottom
	);
	wire [2:0] ls1, ls2, ls3, ls4;
	wire [2:0] bsb1l, bsb1r;
	wire [2:0] bsb2l, bsb2r;
	wire [2:0] bsb3l, bsb3r;
	wire [2:0] bsb4l, bsb4r;

	bidir_routing_block brb1(brbselect[35:0], left, bsb1l, top[2:0], bottom[2:0]);
	bidir_routing_block brb2(brbselect[71:36], bsb1r, bsb2l, top[5:3], bottom[5:3]);
	bidir_routing_block brb3(brbselect[107:72], bsb2r, bsb3l, top[8:6], bottom[8:6]);
	bidir_routing_block brb4(brbselect[143:108], bsb3r, bsb4l, top[11:9], bottom[11:9]);
	bidir_routing_block brb5(brbselect[179:144], bsb4r, right, top[14:12], bottom[14:12]);

	bidir_switch_block bsb1(bsbselect[107:0], bsb1l, bsb1r, ls1);
	bidir_switch_block bsb2(bsbselect[215:108], bsb2l, bsb2r, ls2);
	bidir_switch_block bsb3(bsbselect[323:216], bsb3l, bsb3r, ls3);
	bidir_switch_block bsb4(bsbselect[431:324], bsb4l, bsb4r, ls4);

	logic_block lb1(clk, ls1[2:1], lbselect[3:0], lbselect[4], ls1[0]);
	logic_block lb2(clk, ls2[2:1], lbselect[8:5], lbselect[9], ls2[0]);
	logic_block lb3(clk, ls3[2:1], lbselect[13:10], lbselect[14], ls3[0]);
	logic_block lb4(clk, ls4[2:1], lbselect[18:15], lbselect[19], ls4[0]);


endmodule

