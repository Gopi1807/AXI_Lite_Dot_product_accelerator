module axi_top(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [31:0] vector_a,
    input wire [31:0] vector_b,
    input wire [31:0] vector_a_addr,
    input wire [31:0] vector_b_addr,
    input wire [31:0] vector_len,
    input wire [31:0] output_addr,
    input wire [31:0] read_data_addr,
    output wire [31:0] rdata
);

   
    wire [31:0] read_data;
    wire status;
    wire fetch_done;
    wire processing_done;
    wire store_done;
    wire read_done;
    wire rvalid;
    
    wire [31:0] wdata_a;
    wire [31:0] wdata_b;
    wire [31:0] waddr_a;
    wire [31:0] waddr_b;
    wire [31:0] waddr_output;
    wire [31:0] vector_len_o;
    wire wdvalid;
    wire awvalid;
    
    wire start_fetch;
    wire start_compute;
    wire start_write;
    wire start_read;

   
    axi_master master_inst (
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
        .read_data(read_data),
        .status(status),
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
        .wdvalid(wdvalid),
        .awvalid(awvalid),
        .start_fetch(start_fetch),
        .start_compute(start_compute),
        .start_write(start_write),
        .start_read(start_read)
    );

   
    axi_slave slave_inst (
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
        .rvalid(rvalid),
        .start_fetch(start_fetch),
        .start_compute(start_compute),
        .start_write(start_write),
        .start_read(start_read)
    );

endmodule
