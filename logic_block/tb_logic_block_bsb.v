module tb_logic_block();
	// Test ports
	reg clk, sync;
	reg [3:0] mem;
	reg [107:0] cfg;
	reg [1:0] in;
	wire out;

	wire [2:0] left, right, bottom;

	assign left[0] = in[0];
	assign left[1] = in[1];
	assign out = right[0];

	logic_block lb1(clk, bottom[1:0], mem, sync, bottom[2]);
	bidir_switch_block bsb1(cfg, left, right, bottom);
	initial begin
		cfg = 108'b0;
		cfg[4] = 1'b1;

		cfg[2+36] = 1'b1;
		cfg[4+12+36] = 1'b1;
		cfg[6+12] = 1'b1;

		cfg[11+24] = 1'b1;

		#10 in = 2'b00; mem = 4'b0110;
		#10 sync = 1'b0;
		$monitor("in = %b, out = %b",
				in, out);
		#10 in = 2'b00; mem = 4'b0110;
		// #10 in = 2'b00;
		#10 in = 2'b01;
		#10 in = 2'b10;
		#10 in = 2'b11;
	end
endmodule

