`timescale 1ns / 1ps
module tb;

wire clk_50M;
reg reset_btn = 0;         //BTN6手动复位按钮开关，带消抖电路，按下时为1
reg[31:0] dip_sw;     //32位拨码开关，拨到“ON”时为1
wire[15:0] leds;       //16位LED，输出时1点亮

initial begin 
    //在这里可以自定义测试输入序列，例如：
    dip_sw = 32'h4;
    reset_btn = 1;
    #100;
    reset_btn = 0;
    
end

// 待测试用户设计
thinpad_top dut(
    .clk_50M(clk_50M),
    .reset_btn(reset_btn),
    .dip_sw(dip_sw),
    .leds(leds)   
);
// 时钟源
clock osc(
    .clk_50M    (clk_50M)
);

endmodule
