/*
    ######### Olimex-ICE40HX8K-EVB #########
*/

module rio (
        output BLINK_LED,
        input sysclk
    );


    blink #(6000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
