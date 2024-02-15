/*
    ######### xc3s250e #########
*/

module rio (
        output BLINK_LED,
        input sysclk
    );


    blink #(25000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
