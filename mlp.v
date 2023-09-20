`timescale 1ns/10ps

`include "neuron2.v"
`include "neuron3.v"

// MLP with XOR logic
// Input layer:     2 inputs
// Hidden layer:    3 neurons
// Output layer:    1 output 


module  MLP (
    input clk,              // clock
    input reset,            // reset

    input in1,              // xor input 1
    input in2,              // xor input 2

    input signed [7:0] hidden_weight1,
    input signed [7:0] hidden_weight2,
    input signed [7:0] hidden_bias1,

    input signed [7:0] hidden_weight3,
    input signed [7:0] hidden_weight4,
    input signed [7:0] hidden_bias2  ,

    input signed [7:0] hidden_weight5,
    input signed [7:0] hidden_weight6,
    input signed [7:0] hidden_bias3  ,
   
    input signed [7:0] output_weight1,
    input signed [7:0] output_weight2,
    input signed [7:0] output_weight3,
    input signed [7:0] output_bias   ,

    output reg final_out    //1-bit output
);

    // Hidden Layer
    wire [9:0] hidden_neuron1_out;
    wire [9:0] hidden_neuron2_out;
    wire [9:0] hidden_neuron3_out;

    // hidden layer
    neuron2 hidden_neuron1(
        .clk(clk),
        .rst(reset),
        .input1(in1),
        .input2(in2),
        .weight1(hidden_weight1),
        .weight2(hidden_weight2),
        .bias(hidden_bias1),
        .neuron_out(hidden_neuron1_out)
    );

    neuron2 hidden_neuron2(
        .clk(clk),
        .rst(reset),
        .input1(in1),
        .input2(in2),
        .weight1(hidden_weight3),
        .weight2(hidden_weight4),
        .bias(hidden_bias2),
        .neuron_out(hidden_neuron2_out)
    );

    neuron2 hidden_neuron3(
        .clk(clk),
        .rst(reset),
        .input1(in1),
        .input2(in2),
        .weight1(hidden_weight5),
        .weight2(hidden_weight6),
        .bias(hidden_bias3),
        .neuron_out(hidden_neuron3_out)
    );
    
    // output layer
    wire [10:0] output_neuron_out;

    neuron3 output_neuron(
        .clk(clk),
        .rst(reset),
        .input1(hidden_neuron1_out),
        .input2(hidden_neuron2_out),
        .input3(hidden_neuron3_out),
        .weight1(output_weight1),
        .weight2(output_weight2),
        .weight3(output_weight3),
        .bias(output_bias),
        .neuron_out(output_neuron_out)
    );

    // Final Output
    always@(posedge clk) begin
        if(reset) begin                  
            final_out <= 0;
        end
        else begin
            // MSB
            final_out <= output_neuron_out[10];

            // Threshold
            // if(output_neuron_out > 11'b0111111111) begin 
            //     final_out <= 1'b1;
            // end else begin
            //     final_out <= 1'b0;
            // end
        end
    end 

endmodule