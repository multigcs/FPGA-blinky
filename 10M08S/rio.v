/*
    ######### 10M08SAE144C8G #########
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
