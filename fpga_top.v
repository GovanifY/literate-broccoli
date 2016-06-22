module fpga_top(
	input clk,
	input [899:0] brbselect,
	input [1727:0] bsbselect,
	input [79:0] lbselect,
	input [29:0] leftioselect,
	input [29:0] rightioselect,
	input [29:0] topioselect,
	input [29:0] bottomioselect,
	inout [fpga_height-1:0] left, right,
	inout [fpga_width-1:0] top, bottom
	);
	parameter wire_width = 7;
	parameter lb_cfg_size = 10;
	parameter fpga_width = 5;
	parameter fpga_height = 5;

	// left & right io blocks
	wire [wire_width-1:0] iblw[fpga_height-1:0];
	wire [wire_width-1:0] ibrw[fpga_height-1:0];
	genvar y;
	generate
	for (y = 0; y < fpga_height; y = y + 1) begin
		localparam ibl_base = y*2*wire_width;
		localparam ibr_base = y*2*wire_width;
		io_block #(wire_width) ibl(
			.select(leftioselect[ibl_base+2*wire_width-1:ibl_base]),
			.in(iblw[y]),
			.port(left[y])
		);
		io_block #(wire_width) ibr(
			.select(rightioselect[ibr_base+2*wire_width-1:ibr_base]),
			.in(ibrw[y]),
			.port(right[y])
		);
	end
	endgenerate

	// top & bottom io blocks
	wire [wire_width*fpga_width-1:0] ibtw;
	wire [wire_width*fpga_width-1:0] ibbw;
	genvar x;
	generate
	for (x = 0; x < fpga_width; x = x + 1) begin
		localparam ibt_base = x*2*wire_width;
		localparam ibb_base = x*2*wire_width;
		io_block #(wire_width) ibt(
			.select(topioselect[ibt_base+2*wire_width-1:ibt_base]),
			.in(ibtw[x+wire_width-1:x]),
			.port(top[x])
		);
		io_block #(wire_width) ibb(
			.select(bottomioselect[ibb_base+2*wire_width-1:ibb_base]),
			.in(ibbw[x+wire_width-1:x]),
			.port(bottom[x])
		);
	end
	endgenerate

	wire [wire_width*fpga_width-1:0] r[fpga_height-2:0];
	generate
	for (y = 0; y < fpga_height; y = y + 1) begin
		localparam r_base = y*fpga_width*wire_width*12;
		localparam s_base = (y-1)*(fpga_width-1)*wire_width*wire_width*12;
		localparam s_width = (fpga_width-1)*wire_width*wire_width*12;
		localparam l_base = (y-1)*(fpga_width-1)*5;
		localparam l_width = (fpga_width-1)*5;
		if (y == 0) begin
			last_row_routing #(wire_width,fpga_width) lrr(
				.brbselect(brbselect[r_base+fpga_width*wire_width*12-1:r_base]),
				.left(iblw[y]),
				.right(ibrw[y]),
				.top(r[y]),
				.bottom(ibbw)
			);
		end
		else if (y == fpga_height-1) begin
			fpga_row #(wire_width,fpga_width,lb_cfg_size) fr(
				.clk(clk),
				.brbselect(brbselect[r_base+fpga_width*wire_width*12-1:r_base]),
				.bsbselect(bsbselect[s_base+s_width-1:s_base]),
				.lbselect(lbselect[l_base+l_width-1:l_base]),
				.left(iblw[y]),
				.right(ibrw[y]),
				.top(ibtw),
				.bottom(r[y-1])
			);
		end
		else begin
			fpga_row #(wire_width,fpga_width,lb_cfg_size) fr(
				.clk(clk),
				.brbselect(brbselect[r_base+fpga_width*wire_width*12-1:r_base]),
				.bsbselect(bsbselect[s_base+s_width-1:s_base]),
				.lbselect(lbselect[l_base+l_width-1:l_base]),
				.left(iblw[y]),
				.right(ibrw[y]),
				.top(r[y]),
				.bottom(r[y-1])
			);
		end
	end
	endgenerate

endmodule

