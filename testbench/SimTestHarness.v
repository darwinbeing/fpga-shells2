`timescale 1ns / 1ps

module SimTestHarness( );
    
    reg reset;
    reg clk;
    reg uart_rx;

    initial begin
        reset = 1;
        clk = 1;
        uart_rx = 1;
        #20;
        reset = 0;
    end
    always #5 clk = ~clk;

    StarshipTop dut (
        .clock(clk),
        .reset(reset),
        .uart_0_rxd(uart_rx)
    );
        
endmodule
