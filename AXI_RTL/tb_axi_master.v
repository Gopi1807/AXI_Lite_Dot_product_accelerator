`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2025 22:21:29
// Design Name: 
// Module Name: tb_axi_master
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


`timescale 1ns / 1ps

module axi_master_tb();

    
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
    reg [31:0] read_data;
    reg status;
   // reg fetch_done;
    reg processing_done;
    reg store_done;
    reg read_done;
    reg rvalid;

    
    wire wdvalid;
    wire awvalid;
    wire [31:0] rdata;
    wire [31:0] wdata_a;
    wire [31:0] wdata_b;
    wire [31:0] waddr_a;
    wire [31:0] waddr_b;
    wire [31:0] waddr_output;
    wire [31:0] vector_len_o;
    wire start_fetch;
    wire start_compute;
    wire start_write;
    wire start_read;

    
    axi_master uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .vector_a(vector_a),
        .vector_b(vector_b),
        .wdvalid(wdvalid),
        .vector_a_addr(vector_a_addr),
        .vector_b_addr(vector_b_addr),
        .awvalid(awvalid),
        .vector_len(vector_len),
        .output_addr(output_addr),
        .read_data_addr(read_data_addr),
        .read_data(read_data),
        .status(status),
       // .fetch_done(fetch_done),
        .processing_done(processing_done),
        .store_done(store_done),
        .read_done(read_done),
        .rdata(rdata),
        .rvalid(rvalid),
        .wdata_a(wdata_a),
        .wdata_b(wdata_b),
        .waddr_a(waddr_a),
        .waddr_b(waddr_b),
        .waddr_output(waddr_output),
        .vector_len_o(vector_len_o),
        .start_fetch(start_fetch),
        .start_compute(start_compute),
        .start_write(start_write),
        .start_read(start_read)
    );

   
    always #5 clk = ~clk; 

   
    initial begin
       
        clk = 0;
        rst = 1;
        start = 0;
        vector_a = 32'hA5A5A5A5;
        vector_b = 32'h5A5A5A5A;
        vector_a_addr = 32'h00000010;
        vector_b_addr = 32'h00000020;
        vector_len = 32'h00000004;
        output_addr = 32'h00000030;
        read_data_addr = 32'h00000040;
        read_data = 0;
        status = 0;
     
        processing_done = 0;
        store_done = 0;
        read_done = 0;
        rvalid = 0;

        
        #10 rst = 0;
        #10 rst = 1;

        
        //#10 start = 1;
        #10 start = 1; 
       
        #20; 
        

       
  //      #10 fetch_done = 1;
 //       #10 fetch_done = 0;

       
        #20; 
        processing_done = 1;
        #10 processing_done = 0;

        
        #20; 
        store_done = 1;
        #10 store_done = 0;

        
        #20; 
        read_done = 1;
        rvalid = 1;
        read_data = 32'hA5A5A5A5;
        #10 read_done = 0;

       
        #20 start = 1;
        #10 start = 0;

        #50; 

        
        $stop;
    end

endmodule

