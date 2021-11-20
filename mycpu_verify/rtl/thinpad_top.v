`default_nettype none

module thinpad_top(
    input wire clk_50M,           //50MHz 时钟输入
    input wire reset_btn,         //BTN6手动复位按钮�?关，带消抖电路，按下时为1
    input  wire[31:0] dip_sw,     //32位拨码开关，拨到“ON”时�?1
    output wire[15:0] leds       //16位LED，输出时1点亮	
);

/* =========== Demo code begin =========== */


wire inst_sram_wen;
wire[31:0] inst_sram_addr;
wire[31:0] inst_sram_wdata;
wire[31:0] inst_sram_rdata;
wire       data_sram_wen;
wire[31:0] data_sram_addr;
wire[31:0] data_sram_wdata;
wire[31:0] data_sram_rdata;

inst_ram inst_ram
(
    .clk   (clk_50M             ),   
    .we    (inst_sram_wen       ),   
    .a     (inst_sram_addr[17:2]),   
    .d     (inst_sram_wdata     ),   
    .spo   (inst_sram_rdata     )   
);

mycpu_top mycpu_top
(
     .clk(clk_50M),
     .resetn(~reset_btn),
     .inst_sram_wen(inst_sram_wen),
     .inst_sram_addr(inst_sram_addr),
     .inst_sram_wdata(inst_sram_wdata),
     .inst_sram_rdata(inst_sram_rdata),	
	 .data_sram_wen(data_sram_wen),
	 .data_sram_addr(data_sram_addr),
	 .data_sram_wdata(data_sram_wdata),
	 .data_sram_rdata({24'b0,dip_sw[7:0]})
);

confreg confreg
( 
     .clk(clk_50M),
     .reset(reset_btn),
     .conf_wen(data_sram_wen),
     .conf_wdata(data_sram_wdata[15:0]),
	 .leds(leds)
);	 

endmodule
