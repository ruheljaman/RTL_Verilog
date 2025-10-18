module sync_fifo #(parameter DEPTH=8, DWIDTH=16)
(
        input               	reset_n,            // Active low reset
                            	clk,                // Clock
                            	write_enable, 		// Write enable
                            	read_enable, 		// Read enable
        input      [DWIDTH-1:0] data_in, 			// Data written into FIFO
        output reg [DWIDTH-1:0] data_out, 			// Data read from FIFO
        output              	fifo_empty, 		// FIFO is empty when high
                            	fifo_full 			// FIFO is full when high
);


  reg [$clog2(DEPTH)-1:0]   write_ptr;
  reg [$clog2(DEPTH)-1:0]   read_ptr;

  reg [DWIDTH-1 : 0]    fifo_mem[0:DEPTH-1];

  always @ (posedge clk) begin
    if (!reset_n) begin
      write_ptr <= 0;
    end else begin
      if (write_enable & !fifo_full) begin
        fifo_mem[write_ptr] <= data_in;
        write_ptr <= write_ptr + 1;
      end
    end
  end

  initial begin
    $monitor("[%0t] [FIFO] write_enable=%0b data_in=0x%0h read_enable=%0b data_out=0x%0h fifo_empty=%0b fifo_full=%0b",
             $time, write_enable, data_in, read_enable, data_out, fifo_empty, fifo_full);
  end

  always @ (posedge clk) begin
    if (!reset_n) begin
      read_ptr <= 0;
    end else begin
      if (read_enable & !fifo_empty) begin
        data_out <= fifo_mem[read_ptr];
        read_ptr <= read_ptr + 1;
      end
    end
  end

  assign fifo_full  = (write_ptr + 1) == read_ptr;
  assign fifo_empty = write_ptr == read_ptr;
endmodule
//TB
//===========================================================
// Testbench for sync_fifo
//===========================================================
module sync_fifo_Test;

    reg clk, reset_n, write_enable, read_enable;
    reg [15:0] data_in;
    wire [15:0] data_out;
    wire fifo_empty, fifo_full;
    integer i;

    //=======================================================
    // DUT
    //=======================================================
    sync_fifo r1 (clk, reset_n, write_enable, read_enable, data_in, data_out, fifo_empty, fifo_full);

    //=======================================================
    // Clock generation
    //=======================================================
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    //=======================================================
    // Reset sequence
    //=======================================================
    initial begin
        reset_n = 0;
        #20 reset_n = 1;
        #100 reset_n = 0;
        #50  reset_n = 1;
    end

    //=======================================================
    // Test sequence
    //=======================================================
    initial begin
        write_enable = 0;
        read_enable  = 0;
        data_in      = 0;

        @(posedge reset_n);

        // Write data into FIFO
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            if (!fifo_full) begin
                write_enable = 1;
                data_in = i + 16'hA0;
            end else begin
                write_enable = 0;
            end
        end
        write_enable = 0;

        // Read data from FIFO
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            if (!fifo_empty) begin
                read_enable = 1;
            end else begin
                read_enable = 0;
            end
        end
        read_enable = 0;

        #200 $finish;
    end

    //=======================================================
    // Display results
    //=======================================================
    initial begin
        $monitor("Time=%0t clk=%b reset_n=%b wr_en=%b rd_en=%b data_in=0x%0h data_out=0x%0h fifo_empty=%b fifo_full=%b write_ptr=%0d read_ptr=%0d",
                 $realtime, clk, reset_n, write_enable, read_enable, data_in, data_out, fifo_empty, fifo_full,
                 r1.write_ptr, r1.read_ptr);
    end

endmodule
