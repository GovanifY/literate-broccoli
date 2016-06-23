module fulladder(
	input wire a, b, carryin,
	output wire sum, carryout
	);
	wire w1, w2, w3;
	xor(sum, a, b, carryin);
	and(w1, a, carryin);
	and(w2, b, carryin);
	and(w3, a, b);
	or(carryout, w1, w2, w3);
endmodule

