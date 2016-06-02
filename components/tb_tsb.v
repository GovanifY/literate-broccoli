module tb_tsb();
	// Test ports
	reg A, cfg;
	wire B;

	tsb t1(cfg, A, B);
	initial begin
		A = 1'b0; cfg = 1'b0;
		$monitor("A = %b, cfg = %b, B = %b",
				A, cfg, B);
		#10 A = 1'b0; cfg = 1'b0;
		#10 A = 1'b1; cfg = 1'b0;
		#10 A = 1'b0; cfg = 1'b1;
		#10 A = 1'b1; cfg = 1'b1;
	end
endmodule

