/*
    ######### BugblatPIF_2 #########
*/

module rio (
        output BLINK_LED
    );

	wire sysclk;
    OSCH #(.NOM_FREQ("133.00")) rc_oscillator(.STDBY(1'b0), .OSC(sysclk));

    blink #(133000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

endmodule
