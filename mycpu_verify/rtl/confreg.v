module confreg(
    input             clk,
    input             reset,
	input             conf_wen,	
	input      [15:0] conf_wdata,
    output     [15:0] leds
);

reg[15:0] led_data;
wire write_led = conf_wen;
assign leds = led_data;
always @(posedge clk)
begin
    if(reset)
    begin
        led_data <= 16'h0;
    end
    else if(write_led)
    begin
        led_data <= conf_wdata;
    end
end
endmodule