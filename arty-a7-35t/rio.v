/*
    ######### arty-a7-35t #########
*/

module rio (
        output BLINK_LED,
        input HOME_X,
        input HOME_Y,
        input HOME_Z,
        input E_STOP,
        output SPINDLE_ENABLE,
        output COOLANT,
        output ENA,
        input INTERFACE_SPI_MOSI,
        output INTERFACE_SPI_MISO,
        input INTERFACE_SPI_SCK,
        input INTERFACE_SPI_SSEL,
        output JOINT6_STEPPER_STP,
        output JOINT6_STEPPER_DIR,
        output JOINT7_STEPPER_STP,
        output JOINT7_STEPPER_DIR,
        output JOINT8_STEPPER_STP,
        output JOINT8_STEPPER_DIR,
        input sysclk
    );


    reg ESTOP = 0;
    wire ERROR;
    wire INTERFACE_TIMEOUT;
    assign ERROR = (INTERFACE_TIMEOUT | ESTOP);
    blink #(50000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );

    parameter BUFFER_SIZE = 144;

    wire[143:0] rx_data;
    wire[143:0] tx_data;

    reg signed [31:0] header_tx;
    always @(posedge sysclk) begin
        if (ESTOP) begin
            header_tx <= 32'h65737470;
        end else begin
            header_tx <= 32'h64617461;
        end
    end

    wire JOINT6Enable;
    wire JOINT7Enable;
    wire JOINT8Enable;
    wire ENA_INV;
    assign ENA = ~ENA_INV;
    assign ENA_INV = (JOINT6Enable || JOINT7Enable || JOINT8Enable) && ~ERROR;

    // joints 3
    wire signed [31:0] JOINT6FreqCmd;
    wire signed [31:0] JOINT7FreqCmd;
    wire signed [31:0] JOINT8FreqCmd;
    wire signed [31:0] JOINT6Feedback;
    wire signed [31:0] JOINT7Feedback;
    wire signed [31:0] JOINT8Feedback;

    // rx_data 144
    wire [31:0] header_rx;
    assign header_rx = {rx_data[119:112], rx_data[127:120], rx_data[135:128], rx_data[143:136]};
    assign JOINT6FreqCmd = {rx_data[87:80], rx_data[95:88], rx_data[103:96], rx_data[111:104]};
    assign JOINT7FreqCmd = {rx_data[55:48], rx_data[63:56], rx_data[71:64], rx_data[79:72]};
    assign JOINT8FreqCmd = {rx_data[23:16], rx_data[31:24], rx_data[39:32], rx_data[47:40]};
    assign JOINT8Enable = rx_data[10];
    assign JOINT7Enable = rx_data[9];
    assign JOINT6Enable = rx_data[8];
    assign SPINDLE_ENABLE = ~rx_data[7];
    assign COOLANT = ~rx_data[6];
    // assign DOUTx = rx_data[5];
    // assign DOUTx = rx_data[4];
    // assign DOUTx = rx_data[3];
    // assign DOUTx = rx_data[2];
    // assign DOUTx = rx_data[1];
    // assign DOUTx = rx_data[0];
    // tx_data 136
    assign tx_data = {
        header_tx[7:0], header_tx[15:8], header_tx[23:16], header_tx[31:24],
        JOINT6Feedback[7:0], JOINT6Feedback[15:8], JOINT6Feedback[23:16], JOINT6Feedback[31:24],
        JOINT7Feedback[7:0], JOINT7Feedback[15:8], JOINT7Feedback[23:16], JOINT7Feedback[31:24],
        JOINT8Feedback[7:0], JOINT8Feedback[15:8], JOINT8Feedback[23:16], JOINT8Feedback[31:24],
        HOME_X, HOME_Y, HOME_Z, E_STOP, 1'd0, 1'd0, 1'd0, 1'd0,
        8'd0
    };

    // interface_spislave
    interface_spislave #(BUFFER_SIZE, 32'h74697277, 32'd25000000) spi1 (
        .clk (sysclk),
        .SPI_SCK (INTERFACE_SPI_SCK),
        .SPI_SSEL (INTERFACE_SPI_SSEL),
        .SPI_MOSI (INTERFACE_SPI_MOSI),
        .SPI_MISO (INTERFACE_SPI_MISO),
        .rx_data (rx_data),
        .tx_data (tx_data),
        .pkg_timeout (INTERFACE_TIMEOUT)
    );

    // joint_stepper
    joint_stepper joint_stepper6 (
        .clk (sysclk),
        .jointEnable (JOINT6Enable && !ERROR),
        .jointFreqCmd (JOINT6FreqCmd),
        .jointFeedback (JOINT6Feedback),
        .DIR (JOINT6_STEPPER_DIR),
        .STP (JOINT6_STEPPER_STP)
    );
    joint_stepper joint_stepper7 (
        .clk (sysclk),
        .jointEnable (JOINT7Enable && !ERROR),
        .jointFreqCmd (JOINT7FreqCmd),
        .jointFeedback (JOINT7Feedback),
        .DIR (JOINT7_STEPPER_DIR),
        .STP (JOINT7_STEPPER_STP)
    );
    joint_stepper joint_stepper8 (
        .clk (sysclk),
        .jointEnable (JOINT8Enable && !ERROR),
        .jointFreqCmd (JOINT8FreqCmd),
        .jointFeedback (JOINT8Feedback),
        .DIR (JOINT8_STEPPER_DIR),
        .STP (JOINT8_STEPPER_STP)
    );
endmodule
