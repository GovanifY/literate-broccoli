module tb_bidir_routing_block();
	// Test ports
	reg A;
	wire B;
	reg [35:0] cfg;
	wire [2:0] left1, right1, top1, bottom1;
	wire [2:0] left2, right2, top2, bottom2;

	assign bottom1[0] = A;
	assign B = top2[0];

	assign bottom2 = top1;

	bidir_routing_block brb1(cfg, left1, right1, top1, bottom1);
	bidir_routing_block brb2(cfg, left2, right2, top2, bottom2);
	initial begin
		cfg = 36'b0;
		// cfg[7:6] = 2'b10;
		cfg[7] = 1'b1;
		#10 A = 1'b0;
		$monitor("A = %b, cfg = %b, B = %b",
				A, cfg, B);
		#10 A = 1'b0;
		#10 A = 1'b1;
		#10 cfg[7] = 1'b0; cfg[6] = 1'b1;
		A = 1'b0;
		#10 A = 1'b1;

	end
endmodule

