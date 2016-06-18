module fpga_row(
	input clk,
	input [fpga_width*wire_width*12-1:0] brbselect,
	input [(fpga_width-1)*(wire_width*wire_width*12)-1:0] bsbselect,
	input [((fpga_width-1)*5)-1:0] lbselect,
	inout [wire_width-1:0] left,
	inout [wire_width-1:0] right,
	inout [fpga_width*wire_width-1:0] top,
	inout [fpga_width*wire_width-1:0] bottom
	);
	parameter wire_width = 3;
	parameter fpga_width = 5;
	wire [wire_width-1:0] ls1, ls2, ls3, ls4;
	wire [wire_width-1:0] bsb1l, bsb1r;
	wire [wire_width-1:0] bsb2l, bsb2r;
	wire [wire_width-1:0] bsb3l, bsb3r;
	wire [wire_width-1:0] bsb4l, bsb4r;

	wire [wire_width-1:0] bsbl[fpga_width-1:0];
	wire [wire_width-1:0] bsbr[fpga_width-1:0];
	wire [wire_width-1:0] ls[fpga_width-1:0];

	genvar x;
	generate
	for (x = 0; x < fpga_width; x = x + 1) begin
		localparam brb_base = x*wire_width*12;
		localparam tb_base = x*wire_width;
		if (x == 0) begin
			bidir_routing_block brb(
				.select(brbselect[brb_base+wire_width*12-1:brb_base]),
				.left(left),
				.right(bsbl[x]),
				.top(top[tb_base+wire_width-1:tb_base]),
				.bottom(bottom[tb_base+wire_width-1:tb_base])
			);
		end
		else if (x == fpga_width-1) begin
			bidir_routing_block brb(
				.select(brbselect[brb_base+wire_width*12-1:brb_base]),
				.left(bsbr[x]),
				.right(right),
				.top(top[tb_base+wire_width-1:tb_base]),
				.bottom(bottom[tb_base+wire_width-1:tb_base])
			);
		end
		else begin
			bidir_routing_block brb(
				.select(brbselect[brb_base+wire_width*12-1:brb_base]),
				.left(bsbr[x-1]),
				.right(bsbl[x]),
				.top(top[tb_base+wire_width-1:tb_base]),
				.bottom(bottom[tb_base+wire_width-1:tb_base])
			);
		end
	end
	endgenerate

	generate
	for (x = 0; x < fpga_width; x = x + 1) begin
		localparam bsb_base = x*wire_width*wire_width*12;
		localparam tb_base = x*wire_width;
		bidir_switch_block bsb(
			.select(bsbselect[bsb_base+wire_width*wire_width*12-1:bsb_base]),
			.left(bsbl[x]),
			.right(bsbr[x]),
			.bottom(ls[x])
		);
	end
	endgenerate

	generate
	for (x = 0; x < fpga_width-1; x = x + 1) begin
		localparam lb_base = x*5;
		// localparam tb_base = x*wire_width;
		logic_block lb(
			.clk(clk),
			.const_mem(lbselect[lb_base+3:lb_base]),
			.sync(lbselect[lb_base+4]),
			.select(ls[x][1:0]),
			.out(ls[x][2])
		);
	end
	endgenerate

endmodule

