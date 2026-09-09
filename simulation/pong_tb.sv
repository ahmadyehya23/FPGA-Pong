module pong_tb;

    logic clk;
    logic reset;
    logic enable;

    logic left_up;
    logic left_down;
    logic right_up;
    logic right_down;

    logic [9:0] ball_x;
    logic [9:0] ball_y;

    logic [9:0] paddle_left_y;
    logic [9:0] paddle_right_y;

    logic [3:0] score_left;
    logic [3:0] score_right;


    // Clock generation
    always begin
        #10 clk = ~clk;
    end


    // Pong engine
    pong_engine DUT (
        .clk(clk),
        .reset(reset),
        .enable(enable),

        .left_up(left_up),
        .left_down(left_down),
        .right_up(right_up),
        .right_down(right_down),

        .ball_x(ball_x),
        .ball_y(ball_y),

        .paddle_left_y(paddle_left_y),
        .paddle_right_y(paddle_right_y),

        .score_left(score_left),
        .score_right(score_right)
    );


    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        enable = 0;

        left_up = 0;
        left_down = 0;
        right_up = 0;
        right_down = 0;


        // Reset game
        #100;
        reset = 0;
        enable = 1;


        // Test left paddle movement
        left_down = 1;
        #200;
        left_down = 0;

        left_up = 1;
        #200;
        left_up = 0;


        // Test right paddle movement
        right_down = 1;
        #200;
        right_down = 0;

        right_up = 1;
        #200;
        right_up = 0;


        // Allow the ball to travel
        #8000;


        // Display final game state
        $display("================================");
        $display("PONG SIMULATION COMPLETE");
        $display("Ball X: %0d", ball_x);
        $display("Ball Y: %0d", ball_y);
        $display("Left Paddle Y: %0d", paddle_left_y);
        $display("Right Paddle Y: %0d", paddle_right_y);
        $display("Left Score: %0d", score_left);
        $display("Right Score: %0d", score_right);
        $display("================================");


        $finish;

    end

endmodule