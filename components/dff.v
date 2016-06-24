module dff(
	input d, clk,
	output qout
	);
	reg q;
	assign qout = q;
	/*initial begin
		q <= 1'b0;
	end*/
	always @ (posedge clk) begin 
		q <= d;
	end
endmodule

