//**Binary Image**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: thresholding each pixel according to intensity value
//Note: this module is my individual work

module Binary_Img(
input [7:0] grey_in,
input [7:0] threshold,
output [7:0] grey_out
);
//threshold the pixel
assign grey_out = (grey_in>threshold) ? 8'hff : 8'h00;

endmodule 