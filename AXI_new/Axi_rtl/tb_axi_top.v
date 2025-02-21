`timescale 1ns/1ps

module axi_top_tb;

    reg clk, rst, start, master_to_slave;
    
    reg [31:0] vector_a_m, vector_b_m, vector_a_addr_m, vector_b_addr_m;
    reg [31:0] vector_len_m, output_addr_m, read_data_addr_m;
    
    reg [31:0] vector_a_s, vector_b_s, vector_a_addr_s, vector_b_addr_s;
    reg [31:0] vector_len_s, output_addr_s, read_data_addr_s;
   // wire [31:0] result_data;
   wire  [31:0] rdata;    
    axi_top uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .master_to_slave(master_to_slave),
        // Inputs for Master
        .vector_a_m(vector_a_m),
        .vector_b_m(vector_b_m),
        .vector_a_addr_m(vector_a_addr_m),
        .vector_b_addr_m(vector_b_addr_m),
        .vector_len_m(vector_len_m),
        .output_addr_m(output_addr_m),
        .read_data_addr_m(read_data_addr_m),
         // Inputs for Slave
         .vector_a_s(vector_a_s),
        .vector_b_s(vector_b_s),
        .vector_a_addr_s(vector_a_addr_s),
        .vector_b_addr_s(vector_b_addr_s),
        .vector_len_s(vector_len_s),
        .output_addr_s(output_addr_s),
        .read_data_addr_s(read_data_addr_s),
      //  .result_data(result_data)
        .rdata(rdata)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 0;
        start = 0;
        master_to_slave = 0;
        
        vector_a_s = 0;
        vector_b_s = 0;
        vector_a_addr_s = 0;
        vector_b_addr_s = 0;
        vector_len_s = 0;
        output_addr_s = 0;
        read_data_addr_s = 0;
        
        vector_a_m = 0;
        vector_b_m = 0;
        vector_a_addr_m = 0;
        vector_b_addr_m = 0;
        vector_len_m = 0;
        output_addr_m = 0;
        read_data_addr_m = 0;
        
        #10 rst = 1;
        
        
        #10 master_to_slave = 1;
        start = 1;
       vector_a_m = 32'h00000008;
       vector_b_m = 32'h00000006;
       vector_a_addr_m = 32'h00000010;
       vector_b_addr_m = 32'h00000020;
        vector_len_m = 32'h00000008;
        output_addr_m = 32'h00000030;
       read_data_addr_m = 32'h00000040;
        
     //    #20 start = 0;
      //   #20 start = 1;
      #10;

        vector_a_m = 32'h00000001;
        vector_b_m = 32'h00000005; 
       #10;    
        
        vector_a_m = 32'h00000005;
        vector_b_m = 32'h00000003;

        
        #10 start = 0;
        
        
        #300 master_to_slave = 0;
        start = 1;
      
       vector_a_s = 32'h00000007;
        vector_b_s = 32'h00000004;
        vector_a_addr_s = 32'h00000050;
        vector_b_addr_s = 32'h00000060;
       vector_len_s = 32'h00000003;
       output_addr_s = 32'h00000070;
        read_data_addr_s = 32'h00000080;
        #10;
        
      

        vector_a_s = 32'h00000003;
        vector_b_s = 32'h00000002;
        #10;
        
        vector_a_s = 32'h00000006;
        vector_b_s = 32'h00000004;

        
      //  #20 start = 0;
        
        #1000;
        
        $stop;
    end

endmodule
