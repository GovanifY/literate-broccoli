module last_row_routing(
	// input clk,
	input [fpga_width*wire_width*12-1:0] brbselect,
	inout [wire_width-1:0] left, right,
	inout [wire_width*fpga_width-1:0] top, bottom
	);
	parameter wire_width = 3;
	parameter fpga_width = 5;
	wire [wire_width-1:0] brb[fpga_width-1:0];

	genvar x;
	generate
	for (x = 0; x < fpga_width-1; x = x + 1) begin
		localparam brb_base = x*wire_width*12;
		localparam tb_base = x*wire_width;
		if (x == 0) begin
			bidir_routing_block #(wire_width) brb(
				.select(brbselect[brb_base+wire_width*12-1:brb_base]),
				.left(left),
				.right(brb[x]),
				.top(top[tb_base+wire_width-1:tb_base]),
				.bottom(bottom[tb_base+wire_width-1:tb_base])
			);
		end
		else if (x == fpga_width-2) begin
			bidir_routing_block #(wire_width) brb(
				.select(brbselect[brb_base+wire_width*12-1:brb_base]),
				.left(brb[x]),
				.right(right),
				.top(top[tb_base+wire_width-1:tb_base]),
				.bottom(bottom[tb_base+wire_width-1:tb_base])
			);
		end
		else begin
			bidir_routing_block #(wire_width) brb(
				.select(brbselect[brb_base+wire_width*12-1:brb_base]),
				.left(brb[x-1]),
				.right(brb[x]),
				.top(top[tb_base+wire_width-1:tb_base]),
				.bottom(bottom[tb_base+wire_width-1:tb_base])
			);
		end
	end
	endgenerate
	
	/*bidir_routing_block brb1(brbselect[35:0], left, brb1_2, top[2:0], bottom[2:0]);
	bidir_routing_block brb2(brbselect[71:36], brb1_2, brb2_3, top[5:3], bottom[5:3]);
	bidir_routing_block brb3(brbselect[107:72], brb2_3, brb3_4, top[8:6], bottom[8:6]);
	bidir_routing_block brb4(brbselect[143:108], brb3_4, brb4_5, top[11:9], bottom[11:9]);
	bidir_routing_block brb5(brbselect[179:144], brb4_5, right, top[14:12], bottom[14:12]);*/
endmodule

