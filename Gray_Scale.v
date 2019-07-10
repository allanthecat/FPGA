module Gray_Scale(
input [7:0] red_in,green_in,blue_in,
output [7:0] grey_out
);
wire [9:0] temp;
assign temp = (red_in+green_in+blue_in)/3;
assign grey_out = temp[7:0];
endmodule 