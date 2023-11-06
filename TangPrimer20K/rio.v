/*
    ######### TangPrimer20K #########
*/

module rio (
        output BLINK_LED,
        input sysclk
    );


    blink #(13500000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
