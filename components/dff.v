module dff(
	input d, clk,
	output reg q, qnot
	);
	initial begin
		q = 1'b0;
		qnot = 1'b1;
	end
	always @ (posedge clk) begin 
		q = d;
		qnot = ~d;
	end
endmodule

