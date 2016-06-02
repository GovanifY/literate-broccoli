module tsb(
	input select,
	input x,
	output y
	);
	assign y = select ? x : 1'bz;
endmodule

