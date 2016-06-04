module tb_io_brb();
	// Test ports
	reg A;
	wire B;
	reg [35:0] cfg;
	wire [2:0] left1, right1, top1, bottom1;
	wire [2:0] left2, right2, top2, bottom2;

	reg [5:0] cfg_iob1, cfg_iob2;
	wire [2:0] io_w1, io_w2;
	wire io_w3, io_w4;

	assign io_w3 = A;
	assign B = io_w4;

	wire [2:0] midway;

	io_block iob1(cfg_iob1, io_w1, io_w3);
	io_block iob2(cfg_iob2, io_w2, io_w4);
	bidir_routing_block brb1(cfg, left1, right1, midway, io_w1);
	bidir_routing_block brb2(cfg, left2, right2, io_w2, midway);
	initial begin
		cfg = 36'b0;
		cfg_iob1 = 6'b0;
		cfg_iob2 = 6'b0;
		cfg[7] = 1'b1;

		cfg_iob1[1] = 1'b1;
		cfg_iob2[0] = 1'b1;

		#10 A = 1'b0;
		$monitor("A = %b, B = %b",
				A, B);
		#10 A = 1'b0;
		#10 A = 1'b1;
		// #10 cfg[7] = 1'b0; cfg[6] = 1'b1;
		// A = 1'b0;
		// #10 A = 1'b1;

	end
endmodule

