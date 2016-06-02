module mux2x1(
	input wire select, 
	input wire A, B, 
	output wire out
	);
	assign out = select ? B : A;
endmodule

