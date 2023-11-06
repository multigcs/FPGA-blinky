/*
    ######### EP4CE6E22C8 #########
*/

module rio (
        output BLINK_LED,
        input sysclk
    );


    blink #(24000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
