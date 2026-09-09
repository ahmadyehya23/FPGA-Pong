module clock_enable (
    input logic clk,
    input logic reset,
    output logic enable
);

    logic [19:0] counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            enable <= 0;
        end
        else begin
            if (counter == 833333) begin
                counter <= 0;
                enable <= 1;
            end
            else begin
                counter <= counter + 1;
                enable <= 0;
            end
        end
    end

endmodule