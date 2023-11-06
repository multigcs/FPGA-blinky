/*
    ######### ICEBreakerV1.0e #########
*/

module rio (
        output BLINK_LED,
        input sysclk_in
    );


    wire sysclk;
    wire locked;
    pll mypll(sysclk_in, sysclk, locked);

    blink #(25125000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
