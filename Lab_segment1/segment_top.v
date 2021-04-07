// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: segment_top
// 
// Author: Step
// 
// Description: segment_top
// 
// Web: www.ecbcamp.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module segment_top
(
input			clk_in,
input			rst_n_in,
output	[8:0]	segment_led_1,  //MSB~LSB = SEG,DP,G,F,E,D,C,B,A
output	[8:0]	segment_led_2   //MSB~LSB = SEG,DP,G,F,E,D,C,B,A
);

parameter	CNT_NUM = 12_000_000;

reg		[23:0]	cnt; 
always @(posedge clk_in or negedge rst_n_in)begin
	if(!rst_n_in)begin
		cnt <= 1'b0;
	end else if(cnt >= CNT_NUM - 1)begin
		cnt <= 1'b0;
	end else
		cnt <= cnt + 1'b1;
end

reg		[3:0]	seg_data;
always @(posedge clk_in or negedge rst_n_in)begin
	if(!rst_n_in)begin
		seg_data <= 1'b0;
	end else if(cnt == CNT_NUM - 1)begin
		if(seg_data >= 9)seg_data <= 1'b0;
		else seg_data <= seg_data + 1'b1;
	end else
		seg_data <= seg_data;
end

segment_led segment_led_uut
(
.seg_data_1(seg_data),  //seg_data input
.seg_data_2(seg_data),  //seg_data input
.segment_led_1(segment_led_1),  //segment_led output, MSB~LSB = SEG,DP,G,F,E,D,C,B,A
.segment_led_2(segment_led_2)   //segment_led output, MSB~LSB = SEG,DP,G,F,E,D,C,B,A
);

endmodule
