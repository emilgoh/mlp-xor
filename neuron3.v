`timescale  1ns/10ps

module neuron3
(
    input   clk,                // clock
    input   rst,                // reset
    input   [9:0] input1,      // input from previous neuron
    input   [9:0] input2,   
    input   [9:0] input3,     

    input   [7:0]  weight1,
    input   [7:0]  weight2,
    input   [7:0]  weight3,
    input   [7:0]  bias,

    output  reg [10:0] neuron_out
);

    reg     [10:0] tmp_out;
    
    always@(posedge clk) begin
        if (rst) begin
            neuron_out <= 11'b00000000000;         // if reset, output is reset to zero
        end
        else begin
            tmp_out <= (input1 * weight1) + (input2 * weight2) + (input3 * weight3) + bias;
            
            //ReLU
            neuron_out <= (tmp_out <= 11'b00000000000) ? 11'b00000000000 : tmp_out[10:0];
        end
    end

endmodule