module last_row_routing(
	// input clk,
	input [179:0] brbselect,
	inout [2:0] left,
	inout [2:0] right,
	inout [14:0] top,
	inout [14:0] bottom
	);
	// last row of routing
	wire [2:0] brb1_2;
	wire [2:0] brb2_3;
	wire [2:0] brb3_4;
	wire [2:0] brb4_5;
	
	bidir_routing_block brb1(brbselect[35:0], left, brb1_2, top[2:0], bottom[2:0]);
	bidir_routing_block brb2(brbselect[71:36], brb1_2, brb2_3, top[5:3], bottom[5:3]);
	bidir_routing_block brb3(brbselect[107:72], brb2_3, brb3_4, top[8:6], bottom[8:6]);
	bidir_routing_block brb4(brbselect[143:108], brb3_4, brb4_5, top[11:9], bottom[11:9]);
	bidir_routing_block brb5(brbselect[179:144], brb4_5, right, top[14:12], bottom[14:12]);
endmodule

