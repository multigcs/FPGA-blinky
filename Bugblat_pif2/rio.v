/*
    ######### BugblatPIF_2 #########
*/

module rio (
        output BLINK_LED,
        input sysclk
    );


    blink #(66500000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
