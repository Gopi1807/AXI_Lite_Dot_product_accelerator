`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gopi Chand Ananthu
// 
// Create Date: 06.02.2025 14:59:58
// Design Name: 
// Module Name: tb_top_axi
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module tb_axi_top();
   
    reg clk;
    reg rst;
    reg start;

  
    reg [31:0] vector_a;
    reg [31:0] vector_b;
    reg [31:0] vector_a_addr;
    reg [31:0] vector_b_addr;
    reg [31:0] vector_len;
    reg [31:0] output_addr;
    reg [31:0] read_data_addr;

  
    wire [31:0] rdata;

  
    always #5 clk = ~clk;

   
    axi_top uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .vector_a(vector_a),
        .vector_b(vector_b),
        .vector_a_addr(vector_a_addr),
        .vector_b_addr(vector_b_addr),
        .vector_len(vector_len),
        .output_addr(output_addr),
        .read_data_addr(read_data_addr),
        .rdata(rdata)
    );

    
    initial begin
        
        clk = 0;
        rst = 1;
        start = 0;
        vector_a = 0;
        vector_b = 0;
        vector_a_addr = 5;  
        vector_b_addr = 10;
        vector_len = 3;  
        output_addr = 15;
        read_data_addr = 20;
        
        
        rst = 0;
        #10;
        rst = 1;
        #10;

       
       
        start = 1;
        vector_a = 11;  
        vector_b = -4;
        #10;
        start = 1;  
        #120;
        
         vector_a = 5;   vector_b = -6; #240;
        
        vector_a = 2;   vector_b = -3; #240;
       
        vector_a = 7;   vector_b = -13; #240;
        
        
      
        
        #400;
        
        $finish;
    end

endmodule

