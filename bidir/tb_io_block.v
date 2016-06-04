module tb_bidir_routing_block();
	// Test ports
	reg A;
	wire B;
	reg [5:0] cfg;
	wire [2:0] in; // not just in, but also out possibly
	wire w;

	assign w = A;
	assign B = in[0];

	io_block iob1(cfg, in, w);
	initial begin
		cfg = 6'b0;
		cfg[0] = 1'b1;
		#10 A = 1'b0;
		$monitor("A = %b, cfg = %b, B = %b",
				A, cfg, B);
		#10 A = 1'b0;
		#10 A = 1'b1;
		#10 cfg[0] = 1'b0; cfg[1] = 1'b1;
		A = 1'b0;
		#10 A = 1'b1;

	end
endmodule

