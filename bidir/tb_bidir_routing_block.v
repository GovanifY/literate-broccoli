module tb_bidir_routing_block();
	// Test ports
	reg A;
	wire B;
	reg [35:0] cfg;
	wire [2:0] left, right, top, bottom;

	assign bottom[0] = A;
	assign B = top[0];

	bidir_routing_block brb1(cfg, left, right, top, bottom);
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

