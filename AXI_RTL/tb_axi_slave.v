`timescale 1ns/1ps

module axi_slave_tb;

    reg clk;
    reg rst;
    
    
    wire [31:0] read_data;
    wire status;
 
    wire processing_done;
    wire store_done;
    wire read_done;
    
    
    reg [31:0] wdata_a;
    reg [31:0] wdata_b;
    reg [31:0] waddr_a;
    reg [31:0] waddr_b;
    reg [31:0] waddr_output;
    reg [31:0] vector_len_o;
    reg wdvalid;
    reg awvalid;
    
    
    reg start_fetch;
    reg start_compute;
    reg start_write;
    reg start_read;

    
    axi_slave uut (
        .clk(clk),
        .rst(rst),
        .read_data(read_data),
        .status(status),
        .fetch_done(fetch_done),
        .processing_done(processing_done),
        .store_done(store_done),
        .read_done(read_done),
        .wdata_a(wdata_a),
        .wdata_b(wdata_b),
        .waddr_a(waddr_a),
        .waddr_b(waddr_b),
        .waddr_output(waddr_output),
        .vector_len_o(vector_len_o),
        .wdvalid(wdvalid),
        .awvalid(awvalid),
        .start_fetch(start_fetch),
        .start_compute(start_compute),
        .start_write(start_write),
        .start_read(start_read)
    );

   
    always #5 clk = ~clk;

    initial begin
       
        clk = 0;
        rst = 1;
        wdata_a = 0;
        wdata_b = 0;
        waddr_a = 0;
        waddr_b = 0;
        waddr_output = 0;
        vector_len_o = 0;
        wdvalid = 0;
        awvalid = 0;
        start_fetch = 0;
        start_compute = 0;
        start_write = 0;
        start_read = 0;

        // Reset sequence
        #10 rst = 0;
        #10 rst = 1;
        

        
        waddr_a = 5;  
        waddr_b = 10; 
        waddr_output = 15; 
        vector_len_o = 10;  
        
        

      /*
        // Test case 1: A = {2, -4, 6, -8}, B = {-3, 5, -7, 9}
        wdata_a = 2;  wdata_b = -3; start_fetch = 1; #10 start_fetch = 0; #20;
        wdata_a = -4; wdata_b = 5;  start_fetch = 1; #10 start_fetch = 0; #20;
        wdata_a = 6;  wdata_b = -7; start_fetch = 1; #10 start_fetch = 0; #20;
        wdata_a = -8; wdata_b = 9;  start_fetch = 1; #10 start_fetch = 0; #20; */
        
       wdata_a = 11;  wdata_b = -4;waddr_a = 0; waddr_b = 0;  start_fetch = 1; #10 start_fetch = 0; #200;
       wdata_a = -5; wdata_b = 12;waddr_a = 1; waddr_b = 1; start_fetch = 1; #10 start_fetch = 0; #200;
       wdata_a = 7;  wdata_b = - 10; start_fetch = 1; #10 start_fetch = 0; #200;
       wdata_a = -5; wdata_b = 10;  start_fetch = 1; #10 start_fetch = 0; #20; 
        
       

        
        start_compute = 1;
        #10 start_compute = 0;
        #50;
      

        
        start_write = 1;
        #10 start_write = 0;
        #20;
       

        
        start_read = 1;
        #10 start_read = 0;
        #20;
             
       

        
        #1000;
       
        $finish;
    end
endmodule