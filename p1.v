module adder ();
reg[15:0] a, b;
wire[15:0] s;
wire c_out;
fulladder FA0(c1, s[0], a[0], b[0], 1'b0);
fulladder FA1(c2, s[1], a[1], b[1], c1);
fulladder FA2(c3, s[2], a[2], b[2], c2);
fulladder FA3(c4, s[3], a[3], b[3], c3);
fulladder FA4(c5, s[4], a[4], b[4], c4);
fulladder FA5(c6, s[5], a[5], b[5], c5);
fulladder FA6(c7, s[6], a[6], b[6], c6);
fulladder FA7(c8, s[7], a[7], b[7], c7);
fulladder FA8(c9, s[8], a[8], b[8], c8);
fulladder FA9(c10, s[9], a[9], b[9], c9);
fulladder FA10(c11, s[10], a[10], b[10], c10);
fulladder FA11(c12, s[11], a[11], b[11], c11);
fulladder FA12(c13, s[12], a[12], b[12], c12);
fulladder FA13(c14, s[13], a[13], b[13], c13);
fulladder FA14(c15, s[14], a[14], b[14], c14);
fulladder FA15(c_out, s[15], a[15], b[15], c15);
initial begin
$monitor ($time, "a=%b, b=%b, s=%b, cout=%b, c1=%b, c2=%b, c3=%b ", a, b, s, c_out, c1, c2, c3);
a=0; b=0;
#100 $display ($time);
#900 a=15; b=15;
end
endmodule

module fulladder (cout, si, ai, bi, cin);
  parameter delay2=1, delay3=2, delay4=3;

  input ai, bi, cin;
  output cout, si;
  and #delay3 (si1, ~ai, ~bi, cin), (si2, ~ai, bi, ~cin), (si3, ai, ~bi, ~cin), (si4, ai, bi, cin);
  or #delay3 (si, si1, si2, si3, si4);
  and #delay2 (ci1, ai, bi), (ci2, ai, cin), (ci3, bi, cin);
  or #delay3 (cout, ci1, ci2, ci3); 
endmodule
