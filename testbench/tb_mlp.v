`timescale 1ns/10ps
`define CYCLE 8.0

module tb_MLP;

    reg clk;
    reg reset;
    reg in1, in2;
    wire final_out;

    // Weights and biases
    // hidden layer
    reg signed [7:0] hidden_weight1;
    reg signed [7:0] hidden_weight2;
    reg signed [7:0] hidden_bias1  ;

    reg signed [7:0] hidden_weight3;
    reg signed [7:0] hidden_weight4;
    reg signed [7:0] hidden_bias2  ;

    reg signed [7:0] hidden_weight5;
    reg signed [7:0] hidden_weight6;
    reg signed [7:0] hidden_bias3  ;

    // output layer
    reg signed [7:0] output_weight1;
    reg signed [7:0] output_weight2;
    reg signed [7:0] output_weight3;
    reg signed [7:0] output_bias   ;


    // Instantiate the MLP
    MLP uut (
        .clk(clk),
        .reset(reset),
        .in1(in1),
        .in2(in2),
        
        .hidden_weight1(hidden_weight1),
        .hidden_weight2(hidden_weight2),
        .hidden_bias1(hidden_bias1),

        .hidden_weight3(hidden_weight3),
        .hidden_weight4(hidden_weight4),
        .hidden_bias2(hidden_bias2),

        .hidden_weight5(hidden_weight5),
        .hidden_weight6(hidden_weight6),
        .hidden_bias3(hidden_bias3),   
        
        .output_weight1(output_weight1),
        .output_weight2(output_weight2),
        .output_weight3(output_weight3),
        .output_bias(output_bias),

        .final_out(final_out) 
    );

    // Clock Generation
    always begin #(`CYCLE/2) clk = ~clk; end


    // Testbench Logic
    initial begin
        $display("Starting testbench...");

        // Initialize signals
        clk = 0;
        reset = 0;
        in1 = 0;
        in2 = 0;

        hidden_weight1 = 8'b10010010;
        hidden_weight2 = 8'b01101110;
        hidden_bias1   = 8'b01101110;

        hidden_weight3 = 8'b11001000;
        hidden_weight4 = 8'b00001110;
        hidden_bias2   = 8'b11110001;

        hidden_weight5 = 8'b10000000;
        hidden_weight6 = 8'b01111111;
        hidden_bias3   = 8'b00000000;

        output_weight1 = 8'b10000000;
        output_weight2 = 8'b11110001;
        output_weight3 = 8'b01111111;
        output_bias    = 8'b01111111;


        $dumpfile("xor_mlp.vcd");
        $dumpvars(0, tb_MLP);

        //$monitor("# %d Input: Input 1: %b, Input 2: %b || Output: %b", $realtime, in1, in2, final_out);


        // Apply reset
        #5;
        #10 reset = 1;                
        #10 reset = 0; 
    
        // Test XOR functionality
        // 0 XOR 0
        #10 in1 = 0; in2 = 0;
        #50;
        $display("For inputs 0 and 0, Output is: %b", final_out);
        #10;

        // 0 XOR 1
        #10 in1 = 0; in2 = 1;
        #50;
        $display("For inputs 0 and 1, Output is: %b", final_out);                
        #10;

        // 1 XOR 0
        #10 in1 = 1; in2 = 0;
        #50;
        $display("For inputs 1 and 0, Output is: %b", final_out);   
        #10;

        // 1 XOR 1
        #10 in1 = 1; in2 = 1;
        #50;
        $display("For inputs 1 and 1, Output is: %b", final_out); 
        #50;


        // Complete the simulation
        $display("Testbench completed!");
        $finish;
    end
endmodule
