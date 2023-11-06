/*
    ######### TangPrimer20K_udp #########
*/

module rio (
        output BLINK_LED,
        input BUTTON1,
        input BUTTON2,
        input BUTTON3,
        output LED1,
        output LED2,
        output LED3,
        output LED4,
        output LED5,
        output DOUT11,
        output ENA,
        output JOINT8_STEPPER_STP,
        output JOINT8_STEPPER_DIR,
        output JOINT9_STEPPER_STP,
        output JOINT9_STEPPER_DIR,
        output JOINT10_STEPPER_STP,
        output JOINT10_STEPPER_DIR,
        input sysclk
    );


    blink #(13500000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

    wire JOINT8Enable;
    wire JOINT9Enable;
    wire JOINT10Enable;
    assign ENA = (JOINT8Enable || JOINT9Enable || JOINT10Enable) && ~ERROR;

    // joints 3
    wire signed [31:0] JOINT8FreqCmd;
    wire signed [31:0] JOINT9FreqCmd;
    wire signed [31:0] JOINT10FreqCmd;
    wire signed [31:0] JOINT8Feedback;
    wire signed [31:0] JOINT9Feedback;
    wire signed [31:0] JOINT10Feedback;


    // joint_stepper
    joint_stepper joint_stepper8 (
        .clk (sysclk),
        .jointEnable (JOINT8Enable && !ERROR),
        .jointFreqCmd (JOINT8FreqCmd),
        .jointFeedback (JOINT8Feedback),
        .DIR (JOINT8_STEPPER_DIR),
        .STP (JOINT8_STEPPER_STP)
    );
    joint_stepper joint_stepper9 (
        .clk (sysclk),
        .jointEnable (JOINT9Enable && !ERROR),
        .jointFreqCmd (JOINT9FreqCmd),
        .jointFeedback (JOINT9Feedback),
        .DIR (JOINT9_STEPPER_DIR),
        .STP (JOINT9_STEPPER_STP)
    );
    joint_stepper joint_stepper10 (
        .clk (sysclk),
        .jointEnable (JOINT10Enable && !ERROR),
        .jointFreqCmd (JOINT10FreqCmd),
        .jointFeedback (JOINT10Feedback),
        .DIR (JOINT10_STEPPER_DIR),
        .STP (JOINT10_STEPPER_STP)
    );
endmodule
