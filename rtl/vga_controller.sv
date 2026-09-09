module vga_controller (
    input  logic clk,
    input  logic reset,

    output logic hsync,
    output logic vsync,

    output logic [9:0] pixel_x,
    output logic [9:0] pixel_y,

    output logic video_on
);

    parameter H_VISIBLE = 640;
    parameter H_FRONT   = 16;
    parameter H_SYNC    = 96;
    parameter H_BACK    = 48;

    parameter V_VISIBLE = 480;
    parameter V_FRONT   = 10;
    parameter V_SYNC    = 2;
    parameter V_BACK    = 33;

    parameter H_TOTAL = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;
    parameter V_TOTAL = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pixel_x <= 0;
            pixel_y <= 0;
        end
        else begin
            if (pixel_x == H_TOTAL - 1) begin
                pixel_x <= 0;

                if (pixel_y == V_TOTAL - 1)
                    pixel_y <= 0;
                else
                    pixel_y <= pixel_y + 1;
            end
            else begin
                pixel_x <= pixel_x + 1;
            end
        end
    end

    always_comb begin
        hsync = !((pixel_x >= H_VISIBLE + H_FRONT) &&
                  (pixel_x < H_VISIBLE + H_FRONT + H_SYNC));

        vsync = !((pixel_y >= V_VISIBLE + V_FRONT) &&
                  (pixel_y < V_VISIBLE + V_FRONT + V_SYNC));

        video_on = (pixel_x < H_VISIBLE) &&
                   (pixel_y < V_VISIBLE);
    end

endmodule