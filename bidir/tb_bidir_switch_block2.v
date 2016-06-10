module tb_bidir_routing_block();
	// Test ports
	reg A;
	wire B;
	reg [107:0] cfg;
	wire [2:0] left, right, bottom;

	assign left[1] = A;
	assign B = right[1];

	bidir_switch_block bsb1(cfg, left, right, bottom);
	initial begin
		cfg = 108'b0;
		cfg[2+36] = 1'b1;
		cfg[2+12+36] = 1'b1;
		cfg[2+24+36] = 1'b1;
		#10 A = 1'b0;
		$monitor("A = %b, cfg = %b, B = %b",
				A, cfg, B);
		#10 A = 1'b0;
		#10 A = 1'b1;
		// #10 cfg[7] = 1'b0; cfg[6] = 1'b1;
		// A = 1'b0;
		// #10 A = 1'b1;

	end
endmodule

