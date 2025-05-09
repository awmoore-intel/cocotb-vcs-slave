// Generated by CIRCT firtool-1.62.0
// Standard header to adapt well known macros for prints and assertions.

// Users can define 'PRINTF_COND' to add an extra gate to prints.
// Standard header to adapt well known macros for register randomization.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// Include register initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_REG_
    `define ENABLE_INITIAL_REG_
  `endif // not def ENABLE_INITIAL_REG_
`endif // not def SYNTHESIS

// Include rmemory initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_MEM_
    `define ENABLE_INITIAL_MEM_
  `endif // not def ENABLE_INITIAL_MEM_
`endif // not def SYNTHESIS

`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

module Crc32(	// src/main/scala/crc32.scala:7:7
  input         clock,	// <stdin>:10:11
  input         reset,	// <stdin>:11:11
  input         io_cmd_valid,	// src/main/scala/crc32.scala:8:14
  input  [63:0] io_cmd_bits_rs1,	// src/main/scala/crc32.scala:8:14
  input  [63:0] io_cmd_bits_rs2,	// src/main/scala/crc32.scala:8:14
  output        io_resp_valid,	// src/main/scala/crc32.scala:8:14
  output [63:0] io_resp_bits_data,	// src/main/scala/crc32.scala:8:14
  input         io_mem_req_ready,	// src/main/scala/crc32.scala:8:14
  output        io_mem_req_valid,	// src/main/scala/crc32.scala:8:14
  output        io_mem_req_bits_is_read,	// src/main/scala/crc32.scala:8:14
  output [3:0]  io_mem_req_bits_size_in_bytes,	// src/main/scala/crc32.scala:8:14
  output [63:0] io_mem_req_bits_addr,	// src/main/scala/crc32.scala:8:14
  output [63:0] io_mem_req_bits_data,	// src/main/scala/crc32.scala:8:14
  input         io_mem_resp_valid,	// src/main/scala/crc32.scala:8:14
  input  [63:0] io_mem_resp_bits_data,	// src/main/scala/crc32.scala:8:14
  output        io_busy	// src/main/scala/crc32.scala:8:14
);

  reg  [1:0]  state;	// src/main/scala/crc32.scala:81:22
  reg  [63:0] src_addr;	// src/main/scala/crc32.scala:82:25
  reg  [63:0] dst_addr;	// src/main/scala/crc32.scala:83:25
  reg  [63:0] len;	// src/main/scala/crc32.scala:84:20
  reg  [31:0] crc32_val;	// src/main/scala/crc32.scala:85:26
  wire        _GEN = state == 2'h0 & io_cmd_valid;	// src/main/scala/crc32.scala:81:22, :93:{14,25}
  wire        _GEN_0 = _GEN & (|io_cmd_bits_rs1);	// src/main/scala/crc32.scala:93:25, :94:{27,36}
  `ifndef SYNTHESIS	// src/main/scala/crc32.scala:97:13
    always @(posedge clock) begin	// src/main/scala/crc32.scala:97:13
      if ((`PRINTF_COND_) & _GEN_0 & ~reset)	// src/main/scala/crc32.scala:94:36, :97:13
        $fwrite(32'h80000002, "CRC32 RTL: CMD with src: 0x%x, dst: 0x%x\n",
                io_cmd_bits_rs1, io_cmd_bits_rs2);	// src/main/scala/crc32.scala:97:13
      if ((`PRINTF_COND_) & _GEN & ~(|io_cmd_bits_rs1) & ~reset)	// src/main/scala/crc32.scala:93:25, :94:{27,36}, :97:13, :102:13
        $fwrite(32'h80000002,
                "CRC32 RTL: CMD with len: 0x%x Recall src: 0x%x, dst: 0x%x\n",
                io_cmd_bits_rs2, src_addr, dst_addr);	// src/main/scala/crc32.scala:82:25, :83:25, :97:13, :102:13
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        io_mem_req_bits_is_read_0 = state == 2'h1;	// src/main/scala/crc32.scala:81:22, :101:19, :104:20
  wire        _GEN_1 = state == 2'h2;	// src/main/scala/crc32.scala:81:22, :112:20
  wire        io_mem_req_valid_0 = ~_GEN & (io_mem_req_bits_is_read_0 | _GEN_1);	// src/main/scala/crc32.scala:88:20, :93:{25,42}, :104:{20,32}, :105:22, :112:{20,33}
  wire        _GEN_2 = io_mem_req_bits_is_read_0 | _GEN_1;	// src/main/scala/crc32.scala:90:17, :104:{20,32}, :112:{20,33}, :119:32
  wire        _GEN_3 = _GEN | _GEN_2;	// src/main/scala/crc32.scala:90:17, :93:{25,42}, :104:32, :112:33, :119:32
  reg  [31:0] casez_tmp;	// src/main/scala/crc32.scala:145:35
  always_comb begin	// src/main/scala/crc32.scala:13:30
    casez (crc32_val[7:0] ^ io_mem_resp_bits_data[7:0])	// src/main/scala/crc32.scala:13:30, :85:26, :144:{36,61}
      8'b00000000:
        casez_tmp = 32'h0;	// src/main/scala/crc32.scala:13:30
      8'b00000001:
        casez_tmp = 32'h77073096;	// src/main/scala/crc32.scala:13:30
      8'b00000010:
        casez_tmp = 32'hEE0E612C;	// src/main/scala/crc32.scala:13:30
      8'b00000011:
        casez_tmp = 32'h990951BA;	// src/main/scala/crc32.scala:13:30
      8'b00000100:
        casez_tmp = 32'h76DC419;	// src/main/scala/crc32.scala:13:30
      8'b00000101:
        casez_tmp = 32'h706AF48F;	// src/main/scala/crc32.scala:13:30
      8'b00000110:
        casez_tmp = 32'hE963A535;	// src/main/scala/crc32.scala:13:30
      8'b00000111:
        casez_tmp = 32'h9E6495A3;	// src/main/scala/crc32.scala:13:30
      8'b00001000:
        casez_tmp = 32'hEDB8832;	// src/main/scala/crc32.scala:13:30
      8'b00001001:
        casez_tmp = 32'h79DCB8A4;	// src/main/scala/crc32.scala:13:30
      8'b00001010:
        casez_tmp = 32'hE0D5E91E;	// src/main/scala/crc32.scala:13:30
      8'b00001011:
        casez_tmp = 32'h97D2D988;	// src/main/scala/crc32.scala:13:30
      8'b00001100:
        casez_tmp = 32'h9B64C2B;	// src/main/scala/crc32.scala:13:30
      8'b00001101:
        casez_tmp = 32'h7EB17CBD;	// src/main/scala/crc32.scala:13:30
      8'b00001110:
        casez_tmp = 32'hE7B82D07;	// src/main/scala/crc32.scala:13:30
      8'b00001111:
        casez_tmp = 32'h90BF1D91;	// src/main/scala/crc32.scala:13:30
      8'b00010000:
        casez_tmp = 32'h1DB71064;	// src/main/scala/crc32.scala:13:30
      8'b00010001:
        casez_tmp = 32'h6AB020F2;	// src/main/scala/crc32.scala:13:30
      8'b00010010:
        casez_tmp = 32'hF3B97148;	// src/main/scala/crc32.scala:13:30
      8'b00010011:
        casez_tmp = 32'h84BE41DE;	// src/main/scala/crc32.scala:13:30
      8'b00010100:
        casez_tmp = 32'h1ADAD47D;	// src/main/scala/crc32.scala:13:30
      8'b00010101:
        casez_tmp = 32'h6DDDE4EB;	// src/main/scala/crc32.scala:13:30
      8'b00010110:
        casez_tmp = 32'hF4D4B551;	// src/main/scala/crc32.scala:13:30
      8'b00010111:
        casez_tmp = 32'h83D385C7;	// src/main/scala/crc32.scala:13:30
      8'b00011000:
        casez_tmp = 32'h136C9856;	// src/main/scala/crc32.scala:13:30
      8'b00011001:
        casez_tmp = 32'h646BA8C0;	// src/main/scala/crc32.scala:13:30
      8'b00011010:
        casez_tmp = 32'hFD62F97A;	// src/main/scala/crc32.scala:13:30
      8'b00011011:
        casez_tmp = 32'h8A65C9EC;	// src/main/scala/crc32.scala:13:30
      8'b00011100:
        casez_tmp = 32'h14015C4F;	// src/main/scala/crc32.scala:13:30
      8'b00011101:
        casez_tmp = 32'h63066CD9;	// src/main/scala/crc32.scala:13:30
      8'b00011110:
        casez_tmp = 32'hFA0F3D63;	// src/main/scala/crc32.scala:13:30
      8'b00011111:
        casez_tmp = 32'h8D080DF5;	// src/main/scala/crc32.scala:13:30
      8'b00100000:
        casez_tmp = 32'h3B6E20C8;	// src/main/scala/crc32.scala:13:30
      8'b00100001:
        casez_tmp = 32'h4C69105E;	// src/main/scala/crc32.scala:13:30
      8'b00100010:
        casez_tmp = 32'hD56041E4;	// src/main/scala/crc32.scala:13:30
      8'b00100011:
        casez_tmp = 32'hA2677172;	// src/main/scala/crc32.scala:13:30
      8'b00100100:
        casez_tmp = 32'h3C03E4D1;	// src/main/scala/crc32.scala:13:30
      8'b00100101:
        casez_tmp = 32'h4B04D447;	// src/main/scala/crc32.scala:13:30
      8'b00100110:
        casez_tmp = 32'hD20D85FD;	// src/main/scala/crc32.scala:13:30
      8'b00100111:
        casez_tmp = 32'hA50AB56B;	// src/main/scala/crc32.scala:13:30
      8'b00101000:
        casez_tmp = 32'h35B5A8FA;	// src/main/scala/crc32.scala:13:30
      8'b00101001:
        casez_tmp = 32'h42B2986C;	// src/main/scala/crc32.scala:13:30
      8'b00101010:
        casez_tmp = 32'hDBBBC9D6;	// src/main/scala/crc32.scala:13:30
      8'b00101011:
        casez_tmp = 32'hACBCF940;	// src/main/scala/crc32.scala:13:30
      8'b00101100:
        casez_tmp = 32'h32D86CE3;	// src/main/scala/crc32.scala:13:30
      8'b00101101:
        casez_tmp = 32'h45DF5C75;	// src/main/scala/crc32.scala:13:30
      8'b00101110:
        casez_tmp = 32'hDCD60DCF;	// src/main/scala/crc32.scala:13:30
      8'b00101111:
        casez_tmp = 32'hABD13D59;	// src/main/scala/crc32.scala:13:30
      8'b00110000:
        casez_tmp = 32'h26D930AC;	// src/main/scala/crc32.scala:13:30
      8'b00110001:
        casez_tmp = 32'h51DE003A;	// src/main/scala/crc32.scala:13:30
      8'b00110010:
        casez_tmp = 32'hC8D75180;	// src/main/scala/crc32.scala:13:30
      8'b00110011:
        casez_tmp = 32'hBFD06116;	// src/main/scala/crc32.scala:13:30
      8'b00110100:
        casez_tmp = 32'h21B4F4B5;	// src/main/scala/crc32.scala:13:30
      8'b00110101:
        casez_tmp = 32'h56B3C423;	// src/main/scala/crc32.scala:13:30
      8'b00110110:
        casez_tmp = 32'hCFBA9599;	// src/main/scala/crc32.scala:13:30
      8'b00110111:
        casez_tmp = 32'hB8BDA50F;	// src/main/scala/crc32.scala:13:30
      8'b00111000:
        casez_tmp = 32'h2802B89E;	// src/main/scala/crc32.scala:13:30
      8'b00111001:
        casez_tmp = 32'h5F058808;	// src/main/scala/crc32.scala:13:30
      8'b00111010:
        casez_tmp = 32'hC60CD9B2;	// src/main/scala/crc32.scala:13:30
      8'b00111011:
        casez_tmp = 32'hB10BE924;	// src/main/scala/crc32.scala:13:30
      8'b00111100:
        casez_tmp = 32'h2F6F7C87;	// src/main/scala/crc32.scala:13:30
      8'b00111101:
        casez_tmp = 32'h58684C11;	// src/main/scala/crc32.scala:13:30
      8'b00111110:
        casez_tmp = 32'hC1611DAB;	// src/main/scala/crc32.scala:13:30
      8'b00111111:
        casez_tmp = 32'hB6662D3D;	// src/main/scala/crc32.scala:13:30
      8'b01000000:
        casez_tmp = 32'h76DC4190;	// src/main/scala/crc32.scala:13:30
      8'b01000001:
        casez_tmp = 32'h1DB7106;	// src/main/scala/crc32.scala:13:30
      8'b01000010:
        casez_tmp = 32'h98D220BC;	// src/main/scala/crc32.scala:13:30
      8'b01000011:
        casez_tmp = 32'hEFD5102A;	// src/main/scala/crc32.scala:13:30
      8'b01000100:
        casez_tmp = 32'h71B18589;	// src/main/scala/crc32.scala:13:30
      8'b01000101:
        casez_tmp = 32'h6B6B51F;	// src/main/scala/crc32.scala:13:30
      8'b01000110:
        casez_tmp = 32'h9FBFE4A5;	// src/main/scala/crc32.scala:13:30
      8'b01000111:
        casez_tmp = 32'hE8B8D433;	// src/main/scala/crc32.scala:13:30
      8'b01001000:
        casez_tmp = 32'h7807C9A2;	// src/main/scala/crc32.scala:13:30
      8'b01001001:
        casez_tmp = 32'hF00F934;	// src/main/scala/crc32.scala:13:30
      8'b01001010:
        casez_tmp = 32'h9609A88E;	// src/main/scala/crc32.scala:13:30
      8'b01001011:
        casez_tmp = 32'hE10E9818;	// src/main/scala/crc32.scala:13:30
      8'b01001100:
        casez_tmp = 32'h7F6A0DBB;	// src/main/scala/crc32.scala:13:30
      8'b01001101:
        casez_tmp = 32'h86D3D2D;	// src/main/scala/crc32.scala:13:30
      8'b01001110:
        casez_tmp = 32'h91646C97;	// src/main/scala/crc32.scala:13:30
      8'b01001111:
        casez_tmp = 32'hE6635C01;	// src/main/scala/crc32.scala:13:30
      8'b01010000:
        casez_tmp = 32'h6B6B51F4;	// src/main/scala/crc32.scala:13:30
      8'b01010001:
        casez_tmp = 32'h1C6C6162;	// src/main/scala/crc32.scala:13:30
      8'b01010010:
        casez_tmp = 32'h856530D8;	// src/main/scala/crc32.scala:13:30
      8'b01010011:
        casez_tmp = 32'hF262004E;	// src/main/scala/crc32.scala:13:30
      8'b01010100:
        casez_tmp = 32'h6C0695ED;	// src/main/scala/crc32.scala:13:30
      8'b01010101:
        casez_tmp = 32'h1B01A57B;	// src/main/scala/crc32.scala:13:30
      8'b01010110:
        casez_tmp = 32'h8208F4C1;	// src/main/scala/crc32.scala:13:30
      8'b01010111:
        casez_tmp = 32'hF50FC457;	// src/main/scala/crc32.scala:13:30
      8'b01011000:
        casez_tmp = 32'h65B0D9C6;	// src/main/scala/crc32.scala:13:30
      8'b01011001:
        casez_tmp = 32'h12B7E950;	// src/main/scala/crc32.scala:13:30
      8'b01011010:
        casez_tmp = 32'h8BBEB8EA;	// src/main/scala/crc32.scala:13:30
      8'b01011011:
        casez_tmp = 32'hFCB9887C;	// src/main/scala/crc32.scala:13:30
      8'b01011100:
        casez_tmp = 32'h62DD1DDF;	// src/main/scala/crc32.scala:13:30
      8'b01011101:
        casez_tmp = 32'h15DA2D49;	// src/main/scala/crc32.scala:13:30
      8'b01011110:
        casez_tmp = 32'h8CD37CF3;	// src/main/scala/crc32.scala:13:30
      8'b01011111:
        casez_tmp = 32'hFBD44C65;	// src/main/scala/crc32.scala:13:30
      8'b01100000:
        casez_tmp = 32'h4DB26158;	// src/main/scala/crc32.scala:13:30
      8'b01100001:
        casez_tmp = 32'h3AB551CE;	// src/main/scala/crc32.scala:13:30
      8'b01100010:
        casez_tmp = 32'hA3BC0074;	// src/main/scala/crc32.scala:13:30
      8'b01100011:
        casez_tmp = 32'hD4BB30E2;	// src/main/scala/crc32.scala:13:30
      8'b01100100:
        casez_tmp = 32'h4ADFA541;	// src/main/scala/crc32.scala:13:30
      8'b01100101:
        casez_tmp = 32'h3DD895D7;	// src/main/scala/crc32.scala:13:30
      8'b01100110:
        casez_tmp = 32'hA4D1C46D;	// src/main/scala/crc32.scala:13:30
      8'b01100111:
        casez_tmp = 32'hD3D6F4FB;	// src/main/scala/crc32.scala:13:30
      8'b01101000:
        casez_tmp = 32'h4369E96A;	// src/main/scala/crc32.scala:13:30
      8'b01101001:
        casez_tmp = 32'h346ED9FC;	// src/main/scala/crc32.scala:13:30
      8'b01101010:
        casez_tmp = 32'hAD678846;	// src/main/scala/crc32.scala:13:30
      8'b01101011:
        casez_tmp = 32'hDA60B8D0;	// src/main/scala/crc32.scala:13:30
      8'b01101100:
        casez_tmp = 32'h44042D73;	// src/main/scala/crc32.scala:13:30
      8'b01101101:
        casez_tmp = 32'h33031DE5;	// src/main/scala/crc32.scala:13:30
      8'b01101110:
        casez_tmp = 32'hAA0A4C5F;	// src/main/scala/crc32.scala:13:30
      8'b01101111:
        casez_tmp = 32'hDD0D7CC9;	// src/main/scala/crc32.scala:13:30
      8'b01110000:
        casez_tmp = 32'h5005713C;	// src/main/scala/crc32.scala:13:30
      8'b01110001:
        casez_tmp = 32'h270241AA;	// src/main/scala/crc32.scala:13:30
      8'b01110010:
        casez_tmp = 32'hBE0B1010;	// src/main/scala/crc32.scala:13:30
      8'b01110011:
        casez_tmp = 32'hC90C2086;	// src/main/scala/crc32.scala:13:30
      8'b01110100:
        casez_tmp = 32'h5768B525;	// src/main/scala/crc32.scala:13:30
      8'b01110101:
        casez_tmp = 32'h206F85B3;	// src/main/scala/crc32.scala:13:30
      8'b01110110:
        casez_tmp = 32'hB966D409;	// src/main/scala/crc32.scala:13:30
      8'b01110111:
        casez_tmp = 32'hCE61E49F;	// src/main/scala/crc32.scala:13:30
      8'b01111000:
        casez_tmp = 32'h5EDEF90E;	// src/main/scala/crc32.scala:13:30
      8'b01111001:
        casez_tmp = 32'h29D9C998;	// src/main/scala/crc32.scala:13:30
      8'b01111010:
        casez_tmp = 32'hB0D09822;	// src/main/scala/crc32.scala:13:30
      8'b01111011:
        casez_tmp = 32'hC7D7A8B4;	// src/main/scala/crc32.scala:13:30
      8'b01111100:
        casez_tmp = 32'h59B33D17;	// src/main/scala/crc32.scala:13:30
      8'b01111101:
        casez_tmp = 32'h2EB40D81;	// src/main/scala/crc32.scala:13:30
      8'b01111110:
        casez_tmp = 32'hB7BD5C3B;	// src/main/scala/crc32.scala:13:30
      8'b01111111:
        casez_tmp = 32'hC0BA6CAD;	// src/main/scala/crc32.scala:13:30
      8'b10000000:
        casez_tmp = 32'hEDB88320;	// src/main/scala/crc32.scala:13:30
      8'b10000001:
        casez_tmp = 32'h9ABFB3B6;	// src/main/scala/crc32.scala:13:30
      8'b10000010:
        casez_tmp = 32'h3B6E20C;	// src/main/scala/crc32.scala:13:30
      8'b10000011:
        casez_tmp = 32'h74B1D29A;	// src/main/scala/crc32.scala:13:30
      8'b10000100:
        casez_tmp = 32'hEAD54739;	// src/main/scala/crc32.scala:13:30
      8'b10000101:
        casez_tmp = 32'h9DD277AF;	// src/main/scala/crc32.scala:13:30
      8'b10000110:
        casez_tmp = 32'h4DB2615;	// src/main/scala/crc32.scala:13:30
      8'b10000111:
        casez_tmp = 32'h73DC1683;	// src/main/scala/crc32.scala:13:30
      8'b10001000:
        casez_tmp = 32'hE3630B12;	// src/main/scala/crc32.scala:13:30
      8'b10001001:
        casez_tmp = 32'h94643B84;	// src/main/scala/crc32.scala:13:30
      8'b10001010:
        casez_tmp = 32'hD6D6A3E;	// src/main/scala/crc32.scala:13:30
      8'b10001011:
        casez_tmp = 32'h7A6A5AA8;	// src/main/scala/crc32.scala:13:30
      8'b10001100:
        casez_tmp = 32'hE40ECF0B;	// src/main/scala/crc32.scala:13:30
      8'b10001101:
        casez_tmp = 32'h9309FF9D;	// src/main/scala/crc32.scala:13:30
      8'b10001110:
        casez_tmp = 32'hA00AE27;	// src/main/scala/crc32.scala:13:30
      8'b10001111:
        casez_tmp = 32'h7D079EB1;	// src/main/scala/crc32.scala:13:30
      8'b10010000:
        casez_tmp = 32'hF00F9344;	// src/main/scala/crc32.scala:13:30
      8'b10010001:
        casez_tmp = 32'h8708A3D2;	// src/main/scala/crc32.scala:13:30
      8'b10010010:
        casez_tmp = 32'h1E01F268;	// src/main/scala/crc32.scala:13:30
      8'b10010011:
        casez_tmp = 32'h6906C2FE;	// src/main/scala/crc32.scala:13:30
      8'b10010100:
        casez_tmp = 32'hF762575D;	// src/main/scala/crc32.scala:13:30
      8'b10010101:
        casez_tmp = 32'h806567CB;	// src/main/scala/crc32.scala:13:30
      8'b10010110:
        casez_tmp = 32'h196C3671;	// src/main/scala/crc32.scala:13:30
      8'b10010111:
        casez_tmp = 32'h6E6B06E7;	// src/main/scala/crc32.scala:13:30
      8'b10011000:
        casez_tmp = 32'hFED41B76;	// src/main/scala/crc32.scala:13:30
      8'b10011001:
        casez_tmp = 32'h89D32BE0;	// src/main/scala/crc32.scala:13:30
      8'b10011010:
        casez_tmp = 32'h10DA7A5A;	// src/main/scala/crc32.scala:13:30
      8'b10011011:
        casez_tmp = 32'h67DD4ACC;	// src/main/scala/crc32.scala:13:30
      8'b10011100:
        casez_tmp = 32'hF9B9DF6F;	// src/main/scala/crc32.scala:13:30
      8'b10011101:
        casez_tmp = 32'h8EBEEFF9;	// src/main/scala/crc32.scala:13:30
      8'b10011110:
        casez_tmp = 32'h17B7BE43;	// src/main/scala/crc32.scala:13:30
      8'b10011111:
        casez_tmp = 32'h60B08ED5;	// src/main/scala/crc32.scala:13:30
      8'b10100000:
        casez_tmp = 32'hD6D6A3E8;	// src/main/scala/crc32.scala:13:30
      8'b10100001:
        casez_tmp = 32'hA1D1937E;	// src/main/scala/crc32.scala:13:30
      8'b10100010:
        casez_tmp = 32'h38D8C2C4;	// src/main/scala/crc32.scala:13:30
      8'b10100011:
        casez_tmp = 32'h4FDFF252;	// src/main/scala/crc32.scala:13:30
      8'b10100100:
        casez_tmp = 32'hD1BB67F1;	// src/main/scala/crc32.scala:13:30
      8'b10100101:
        casez_tmp = 32'hA6BC5767;	// src/main/scala/crc32.scala:13:30
      8'b10100110:
        casez_tmp = 32'h3FB506DD;	// src/main/scala/crc32.scala:13:30
      8'b10100111:
        casez_tmp = 32'h48B2364B;	// src/main/scala/crc32.scala:13:30
      8'b10101000:
        casez_tmp = 32'hD80D2BDA;	// src/main/scala/crc32.scala:13:30
      8'b10101001:
        casez_tmp = 32'hAF0A1B4C;	// src/main/scala/crc32.scala:13:30
      8'b10101010:
        casez_tmp = 32'h36034AF6;	// src/main/scala/crc32.scala:13:30
      8'b10101011:
        casez_tmp = 32'h41047A60;	// src/main/scala/crc32.scala:13:30
      8'b10101100:
        casez_tmp = 32'hDF60EFC3;	// src/main/scala/crc32.scala:13:30
      8'b10101101:
        casez_tmp = 32'hA867DF55;	// src/main/scala/crc32.scala:13:30
      8'b10101110:
        casez_tmp = 32'h316E8EEF;	// src/main/scala/crc32.scala:13:30
      8'b10101111:
        casez_tmp = 32'h4669BE79;	// src/main/scala/crc32.scala:13:30
      8'b10110000:
        casez_tmp = 32'hCB61B38C;	// src/main/scala/crc32.scala:13:30
      8'b10110001:
        casez_tmp = 32'hBC66831A;	// src/main/scala/crc32.scala:13:30
      8'b10110010:
        casez_tmp = 32'h256FD2A0;	// src/main/scala/crc32.scala:13:30
      8'b10110011:
        casez_tmp = 32'h5268E236;	// src/main/scala/crc32.scala:13:30
      8'b10110100:
        casez_tmp = 32'hCC0C7795;	// src/main/scala/crc32.scala:13:30
      8'b10110101:
        casez_tmp = 32'hBB0B4703;	// src/main/scala/crc32.scala:13:30
      8'b10110110:
        casez_tmp = 32'h220216B9;	// src/main/scala/crc32.scala:13:30
      8'b10110111:
        casez_tmp = 32'h5505262F;	// src/main/scala/crc32.scala:13:30
      8'b10111000:
        casez_tmp = 32'hC5BA3BBE;	// src/main/scala/crc32.scala:13:30
      8'b10111001:
        casez_tmp = 32'hB2BD0B28;	// src/main/scala/crc32.scala:13:30
      8'b10111010:
        casez_tmp = 32'h2BB45A92;	// src/main/scala/crc32.scala:13:30
      8'b10111011:
        casez_tmp = 32'h5CB36A04;	// src/main/scala/crc32.scala:13:30
      8'b10111100:
        casez_tmp = 32'hC2D7FFA7;	// src/main/scala/crc32.scala:13:30
      8'b10111101:
        casez_tmp = 32'hB5D0CF31;	// src/main/scala/crc32.scala:13:30
      8'b10111110:
        casez_tmp = 32'h2CD99E8B;	// src/main/scala/crc32.scala:13:30
      8'b10111111:
        casez_tmp = 32'h5BDEAE1D;	// src/main/scala/crc32.scala:13:30
      8'b11000000:
        casez_tmp = 32'h9B64C2B0;	// src/main/scala/crc32.scala:13:30
      8'b11000001:
        casez_tmp = 32'hEC63F226;	// src/main/scala/crc32.scala:13:30
      8'b11000010:
        casez_tmp = 32'h756AA39C;	// src/main/scala/crc32.scala:13:30
      8'b11000011:
        casez_tmp = 32'h26D930A;	// src/main/scala/crc32.scala:13:30
      8'b11000100:
        casez_tmp = 32'h9C0906A9;	// src/main/scala/crc32.scala:13:30
      8'b11000101:
        casez_tmp = 32'hEB0E363F;	// src/main/scala/crc32.scala:13:30
      8'b11000110:
        casez_tmp = 32'h72076785;	// src/main/scala/crc32.scala:13:30
      8'b11000111:
        casez_tmp = 32'h5005713;	// src/main/scala/crc32.scala:13:30
      8'b11001000:
        casez_tmp = 32'h95BF4A82;	// src/main/scala/crc32.scala:13:30
      8'b11001001:
        casez_tmp = 32'hE2B87A14;	// src/main/scala/crc32.scala:13:30
      8'b11001010:
        casez_tmp = 32'h7BB12BAE;	// src/main/scala/crc32.scala:13:30
      8'b11001011:
        casez_tmp = 32'hCB61B38;	// src/main/scala/crc32.scala:13:30
      8'b11001100:
        casez_tmp = 32'h92D28E9B;	// src/main/scala/crc32.scala:13:30
      8'b11001101:
        casez_tmp = 32'hE5D5BE0D;	// src/main/scala/crc32.scala:13:30
      8'b11001110:
        casez_tmp = 32'h7CDCEFB7;	// src/main/scala/crc32.scala:13:30
      8'b11001111:
        casez_tmp = 32'hBDBDF21;	// src/main/scala/crc32.scala:13:30
      8'b11010000:
        casez_tmp = 32'h86D3D2D4;	// src/main/scala/crc32.scala:13:30
      8'b11010001:
        casez_tmp = 32'hF1D4E242;	// src/main/scala/crc32.scala:13:30
      8'b11010010:
        casez_tmp = 32'h68DDB3F8;	// src/main/scala/crc32.scala:13:30
      8'b11010011:
        casez_tmp = 32'h1FDA836E;	// src/main/scala/crc32.scala:13:30
      8'b11010100:
        casez_tmp = 32'h81BE16CD;	// src/main/scala/crc32.scala:13:30
      8'b11010101:
        casez_tmp = 32'hF6B9265B;	// src/main/scala/crc32.scala:13:30
      8'b11010110:
        casez_tmp = 32'h6FB077E1;	// src/main/scala/crc32.scala:13:30
      8'b11010111:
        casez_tmp = 32'h18B74777;	// src/main/scala/crc32.scala:13:30
      8'b11011000:
        casez_tmp = 32'h88085AE6;	// src/main/scala/crc32.scala:13:30
      8'b11011001:
        casez_tmp = 32'hFF0F6A70;	// src/main/scala/crc32.scala:13:30
      8'b11011010:
        casez_tmp = 32'h66063BCA;	// src/main/scala/crc32.scala:13:30
      8'b11011011:
        casez_tmp = 32'h11010B5C;	// src/main/scala/crc32.scala:13:30
      8'b11011100:
        casez_tmp = 32'h8F659EFF;	// src/main/scala/crc32.scala:13:30
      8'b11011101:
        casez_tmp = 32'hF862AE69;	// src/main/scala/crc32.scala:13:30
      8'b11011110:
        casez_tmp = 32'h616BFFD3;	// src/main/scala/crc32.scala:13:30
      8'b11011111:
        casez_tmp = 32'h166CCF45;	// src/main/scala/crc32.scala:13:30
      8'b11100000:
        casez_tmp = 32'hA00AE278;	// src/main/scala/crc32.scala:13:30
      8'b11100001:
        casez_tmp = 32'hD70DD2EE;	// src/main/scala/crc32.scala:13:30
      8'b11100010:
        casez_tmp = 32'h4E048354;	// src/main/scala/crc32.scala:13:30
      8'b11100011:
        casez_tmp = 32'h3903B3C2;	// src/main/scala/crc32.scala:13:30
      8'b11100100:
        casez_tmp = 32'hA7672661;	// src/main/scala/crc32.scala:13:30
      8'b11100101:
        casez_tmp = 32'hD06016F7;	// src/main/scala/crc32.scala:13:30
      8'b11100110:
        casez_tmp = 32'h4969474D;	// src/main/scala/crc32.scala:13:30
      8'b11100111:
        casez_tmp = 32'h3E6E77DB;	// src/main/scala/crc32.scala:13:30
      8'b11101000:
        casez_tmp = 32'hAED16A4A;	// src/main/scala/crc32.scala:13:30
      8'b11101001:
        casez_tmp = 32'hD9D65ADC;	// src/main/scala/crc32.scala:13:30
      8'b11101010:
        casez_tmp = 32'h40DF0B66;	// src/main/scala/crc32.scala:13:30
      8'b11101011:
        casez_tmp = 32'h37D83BF0;	// src/main/scala/crc32.scala:13:30
      8'b11101100:
        casez_tmp = 32'hA9BCAE53;	// src/main/scala/crc32.scala:13:30
      8'b11101101:
        casez_tmp = 32'hDEBB9EC5;	// src/main/scala/crc32.scala:13:30
      8'b11101110:
        casez_tmp = 32'h47B2CF7F;	// src/main/scala/crc32.scala:13:30
      8'b11101111:
        casez_tmp = 32'h30B5FFE9;	// src/main/scala/crc32.scala:13:30
      8'b11110000:
        casez_tmp = 32'hBDBDF21C;	// src/main/scala/crc32.scala:13:30
      8'b11110001:
        casez_tmp = 32'hCABAC28A;	// src/main/scala/crc32.scala:13:30
      8'b11110010:
        casez_tmp = 32'h53B39330;	// src/main/scala/crc32.scala:13:30
      8'b11110011:
        casez_tmp = 32'h24B4A3A6;	// src/main/scala/crc32.scala:13:30
      8'b11110100:
        casez_tmp = 32'hBAD03605;	// src/main/scala/crc32.scala:13:30
      8'b11110101:
        casez_tmp = 32'hCDD70693;	// src/main/scala/crc32.scala:13:30
      8'b11110110:
        casez_tmp = 32'h54DE5729;	// src/main/scala/crc32.scala:13:30
      8'b11110111:
        casez_tmp = 32'h23D967BF;	// src/main/scala/crc32.scala:13:30
      8'b11111000:
        casez_tmp = 32'hB3667A2E;	// src/main/scala/crc32.scala:13:30
      8'b11111001:
        casez_tmp = 32'hC4614AB8;	// src/main/scala/crc32.scala:13:30
      8'b11111010:
        casez_tmp = 32'h5D681B02;	// src/main/scala/crc32.scala:13:30
      8'b11111011:
        casez_tmp = 32'h2A6F2B94;	// src/main/scala/crc32.scala:13:30
      8'b11111100:
        casez_tmp = 32'hB40BBE37;	// src/main/scala/crc32.scala:13:30
      8'b11111101:
        casez_tmp = 32'hC30C8EA1;	// src/main/scala/crc32.scala:13:30
      8'b11111110:
        casez_tmp = 32'h5A05DF1B;	// src/main/scala/crc32.scala:13:30
      default:
        casez_tmp = 32'h2D02EF8D;	// src/main/scala/crc32.scala:13:30
    endcase	// src/main/scala/crc32.scala:13:30, :85:26, :144:{36,61}
  end // always_comb
  wire [1:0]  _GEN_4 = {(|io_cmd_bits_rs1) | io_cmd_bits_rs2 == 64'h0, 1'h1};	// src/main/scala/crc32.scala:82:25, :94:{27,36}, :97:13, :98:13, :101:{13,19,36}
  wire        _GEN_5 = _GEN_2 | ~(&state);	// src/main/scala/crc32.scala:81:22, :90:17, :104:32, :112:33, :119:{20,32}
  wire        _GEN_6 = io_mem_req_ready & io_mem_req_valid_0;	// src/main/scala/chisel3/util/Decoupled.scala:51:35, src/main/scala/crc32.scala:88:20, :93:42, :104:32
  always @(posedge clock) begin	// <stdin>:10:11
    if (reset) begin	// <stdin>:10:11
      state <= 2'h0;	// src/main/scala/crc32.scala:81:22
      src_addr <= 64'h0;	// src/main/scala/crc32.scala:82:25
      dst_addr <= 64'h0;	// src/main/scala/crc32.scala:82:25, :83:25
      len <= 64'h0;	// src/main/scala/crc32.scala:82:25, :84:20
      crc32_val <= 32'hFFFFFFFF;	// src/main/scala/crc32.scala:85:26
    end
    else begin	// <stdin>:10:11
      if (_GEN_6) begin	// src/main/scala/chisel3/util/Decoupled.scala:51:35
        if (io_mem_req_bits_is_read_0) begin	// src/main/scala/crc32.scala:104:20
          if (len == 64'h1)	// src/main/scala/crc32.scala:84:20, :132:17
            state <= 2'h2;	// src/main/scala/crc32.scala:81:22, :112:20
          else if (_GEN)	// src/main/scala/crc32.scala:93:25
            state <= _GEN_4;	// src/main/scala/crc32.scala:81:22, :94:36, :98:13, :101:{13,19}
          else if (_GEN_5) begin	// src/main/scala/crc32.scala:81:22, :104:32, :112:33, :119:32
          end
          else	// src/main/scala/crc32.scala:81:22, :104:32, :112:33, :119:32
            state <= 2'h0;	// src/main/scala/crc32.scala:81:22
        end
        else	// src/main/scala/crc32.scala:104:20
          state <= 2'h3;	// src/main/scala/crc32.scala:81:22, :98:13
      end
      else if (_GEN)	// src/main/scala/crc32.scala:93:25
        state <= _GEN_4;	// src/main/scala/crc32.scala:81:22, :94:36, :98:13, :101:{13,19}
      else if (_GEN_5) begin	// src/main/scala/crc32.scala:81:22, :104:32, :112:33, :119:32
      end
      else	// src/main/scala/crc32.scala:81:22, :104:32, :112:33, :119:32
        state <= 2'h0;	// src/main/scala/crc32.scala:81:22
      if (_GEN_6 & io_mem_req_bits_is_read_0) begin	// src/main/scala/chisel3/util/Decoupled.scala:51:35, src/main/scala/crc32.scala:93:42, :104:20, :129:26, :130:29, :131:16
        src_addr <= 64'(src_addr + 64'h1);	// src/main/scala/crc32.scala:82:25, :131:28, :132:17
        len <= 64'(len - 64'h1);	// src/main/scala/crc32.scala:84:20, :135:18
      end
      else begin	// src/main/scala/crc32.scala:93:42, :129:26, :130:29, :131:16
        if (_GEN_0)	// src/main/scala/crc32.scala:94:36
          src_addr <= io_cmd_bits_rs1;	// src/main/scala/crc32.scala:82:25
        if (_GEN) begin	// src/main/scala/crc32.scala:93:25
          if (~(|io_cmd_bits_rs1))	// src/main/scala/crc32.scala:94:27
            len <= io_cmd_bits_rs2;	// src/main/scala/crc32.scala:84:20
        end
        else if (_GEN_5) begin	// src/main/scala/crc32.scala:81:22, :84:20, :104:32, :112:33, :119:32
        end
        else	// src/main/scala/crc32.scala:84:20, :104:32, :112:33, :119:32
          len <= 64'h0;	// src/main/scala/crc32.scala:82:25, :84:20
      end
      if (_GEN_0)	// src/main/scala/crc32.scala:94:36
        dst_addr <= io_cmd_bits_rs2;	// src/main/scala/crc32.scala:83:25
      if (io_mem_resp_valid)	// src/main/scala/crc32.scala:8:14
        crc32_val <= {8'h0, crc32_val[31:8]} ^ casez_tmp;	// src/main/scala/crc32.scala:85:26, :145:{29,35}
      else if (_GEN_3 | ~(&state)) begin	// src/main/scala/crc32.scala:81:22, :85:26, :90:17, :93:42, :104:32, :112:33, :119:{20,32}
      end
      else	// src/main/scala/crc32.scala:85:26, :93:42, :104:32, :112:33, :119:32
        crc32_val <= 32'hFFFFFFFF;	// src/main/scala/crc32.scala:85:26
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// src/main/scala/crc32.scala:7:7
    `ifdef FIRRTL_BEFORE_INITIAL	// src/main/scala/crc32.scala:7:7
      `FIRRTL_BEFORE_INITIAL	// src/main/scala/crc32.scala:7:7
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:263];	// src/main/scala/crc32.scala:7:7
    initial begin	// src/main/scala/crc32.scala:7:7
      `ifdef INIT_RANDOM_PROLOG_	// src/main/scala/crc32.scala:7:7
        `INIT_RANDOM_PROLOG_	// src/main/scala/crc32.scala:7:7
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// src/main/scala/crc32.scala:7:7
        for (logic [8:0] i = 9'h0; i < 9'h108; i += 9'h1) begin
          _RANDOM[i] = `RANDOM;	// src/main/scala/crc32.scala:7:7
        end	// src/main/scala/crc32.scala:7:7
        state = _RANDOM[9'h100][1:0];	// src/main/scala/crc32.scala:7:7, :81:22
        src_addr = {_RANDOM[9'h100][31:2], _RANDOM[9'h101], _RANDOM[9'h102][1:0]};	// src/main/scala/crc32.scala:7:7, :81:22, :82:25
        dst_addr = {_RANDOM[9'h102][31:2], _RANDOM[9'h103], _RANDOM[9'h104][1:0]};	// src/main/scala/crc32.scala:7:7, :82:25, :83:25
        len = {_RANDOM[9'h104][31:2], _RANDOM[9'h105], _RANDOM[9'h106][1:0]};	// src/main/scala/crc32.scala:7:7, :83:25, :84:20
        crc32_val = {_RANDOM[9'h106][31:2], _RANDOM[9'h107][1:0]};	// src/main/scala/crc32.scala:7:7, :84:20, :85:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// src/main/scala/crc32.scala:7:7
      `FIRRTL_AFTER_INITIAL	// src/main/scala/crc32.scala:7:7
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_resp_valid = ~_GEN_3 & (&state);	// src/main/scala/crc32.scala:7:7, :81:22, :90:17, :93:42, :104:32, :112:33, :119:{20,32}
  assign io_resp_bits_data = {32'h0, ~crc32_val};	// src/main/scala/crc32.scala:7:7, :85:26, :117:26, :121:{23,37}
  assign io_mem_req_valid = io_mem_req_valid_0;	// src/main/scala/crc32.scala:7:7, :88:20, :93:42, :104:32
  assign io_mem_req_bits_is_read = io_mem_req_bits_is_read_0;	// src/main/scala/crc32.scala:7:7, :104:20
  assign io_mem_req_bits_size_in_bytes = io_mem_req_bits_is_read_0 ? 4'h1 : 4'h4;	// src/main/scala/crc32.scala:7:7, :104:{20,32}, :108:35, :112:33, :116:35
  assign io_mem_req_bits_addr = io_mem_req_bits_is_read_0 ? src_addr : dst_addr;	// src/main/scala/crc32.scala:7:7, :82:25, :83:25, :104:{20,32}, :107:26, :112:33
  assign io_mem_req_bits_data = {32'h0, ~crc32_val};	// src/main/scala/crc32.scala:7:7, :85:26, :117:{26,40}
  assign io_busy = |state;	// src/main/scala/crc32.scala:7:7, :81:22, :87:21
endmodule

