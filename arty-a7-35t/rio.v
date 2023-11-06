/*
    ######### arty-a7-35t #########
*/

module rio (
        output BLINK_LED,
        input sysclk
    );


    blink #(50000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
