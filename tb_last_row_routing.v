module tb_fpga();
	// Test ports
	reg A, B;
	wire out;
	// Configuration ports
	reg [899:0] brbselect;
	/*reg [29:0] leftioselect;
	reg [29:0] rightioselect;
	reg [29:0] topioselect;
	reg [29:0] bottomioselect;*/

	wire [4:0] left, right, top, bottom;

	wire [2:0] ibl1w, ibr1w;
	wire [14:0] ibbw, r_1;

	assign ibbw[0] = A;
	assign out = ibl1w[0];

	last_row_routing lrr1(brbselect[179:0], ibl1w, ibr1w, r_1, ibbw);
	integer k = 5;
	initial begin
		brbselect = 900'b0;
		/*leftioselect = 30'b0;
		rightioselect = 30'b0;
		topioselect = 30'b0;
		bottomioselect = 30'b0;*/
		$display("initialized memory");
		// brbselect[4] = 1'b1;
		// brbselect[5] = 1'b0;

		// A = 1'b0;
		$monitor("A = %b, out = %b", A, out);
		// for (k = 0; k < 12; k = k + 1) begin
			$display ("Current value of k is %d", k);
			#10 brbselect = 900'b0; brbselect[k] = 1'b1; A = 1'b0;
			#10 A = 1'b1;
		// end
	end

endmodule

