`timescale  1ns/10ps

module neuron2
(
    input   clk,        // clock
    input   rst,        // reset
    input   input1,     // primary input * w || input from previous neuron
    input   input2,     // primary input * w || input from previous neuron   

    input   [7:0]  weight1,
    input   [7:0]  weight2,
    input   [7:0]  bias,

    output  reg [9:0] neuron_out
);

    reg [9:0] tmp_out;
    
    always@(posedge clk) begin
        if (rst) begin
            neuron_out <= 10'b000000000;         // if reset, output is reset to zero
        end
        else begin
            tmp_out <= (input1 * weight1) + (input2 * weight2) + bias;
            
            //ReLU
            neuron_out <= (tmp_out <= 10'b000000000) ? 10'b000000000 : tmp_out[9:0];
        end
    end

endmodule