module tb_logic_block();
	// Test ports
	reg clk, sync;
	reg [3:0] mem;
	wire [2:0] io;
	reg [1:0] in;
	wire out;
	assign io[1:0] = in;
	assign out = io[2];

	logic_block lb1(clk, {sync,mem}, io);
	initial begin
		#10 in = 2'b00; mem = 4'b1000;
		#10 sync = 1'b0;
		#10 $display("AND");
		$monitor("in = %b, out = %b",
				in, out);

		#10 in = 2'b00; mem = 4'b1000;
		// #10 in = 2'b00;
		#10 in = 2'b01;
		#10 in = 2'b10;
		#10 in = 2'b11;

		#10 $display("OR");

		#10 in = 2'b00; mem = 4'b1110;
		// #10 in = 2'b00;
		#10 in = 2'b01;
		#10 in = 2'b10;
		#10 in = 2'b11;

		#10 $display("XOR");

		#10 in = 2'b00; mem = 4'b0110;
		// #10 in = 2'b00;
		#10 in = 2'b01;
		#10 in = 2'b10;
		#10 in = 2'b11;
	end
endmodule

