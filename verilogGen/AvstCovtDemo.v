// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : AvstCovtDemo
// Git hash  : 5f2a260c171bbf6c17ba1ad4182794c45f3c5766


module AvstCovtDemo (
  output wire          io_asvst_in_ready,
  input  wire          io_asvst_in_valid,
  input  wire [511:0]  io_asvst_in_payload_data,
  input  wire [127:0]  io_asvst_in_payload_channel,
  input  wire [5:0]    io_asvst_in_payload_empty,
  input  wire          io_asvst_in_payload_eop,
  input  wire          io_asvst_in_payload_sop,
  input  wire          io_avst_out_ready,
  output wire          io_avst_out_valid,
  output wire [127:0]  io_avst_out_payload_data,
  output wire [127:0]  io_avst_out_payload_channel,
  output wire [3:0]    io_avst_out_payload_empty,
  output wire          io_avst_out_payload_eop,
  output wire          io_avst_out_payload_sop,
  input  wire          clk,
  input  wire          reset
);

  wire       [1:0]    tmp_step_valueNext;
  wire       [0:0]    tmp_step_valueNext_1;
  wire       [10:0]   tmp_bytes_num;
  wire       [2:0]    tmp_bytes_num_1;
  wire       [2:0]    tmp_bytes_num_2;
  wire       [1:0]    tmp_bytes_num_3;
  wire       [11:0]   tmp_bytes_num_4;
  wire       [6:0]    tmp_bytes_num_5;
  wire                tmp_when;
  reg        [127:0]  tmp_io_avst_out_payload_data;
  wire       [3:0]    tmp_io_avst_out_payload_empty;
  wire       [5:0]    tmp_io_avst_out_payload_empty_1;
  reg                 step_willIncrement;
  reg                 step_willClear;
  reg        [1:0]    step_valueNext;
  reg        [1:0]    step_value;
  wire                step_willOverflowIfInc;
  wire                step_willOverflow;
  wire       [11:0]   bytes_num;
  wire                overflow;

  assign tmp_when = (io_avst_out_valid && (io_avst_out_ready || io_avst_out_ready));
  assign tmp_step_valueNext_1 = step_willIncrement;
  assign tmp_step_valueNext = {1'd0, tmp_step_valueNext_1};
  assign tmp_bytes_num = (tmp_bytes_num_1 * 8'h80);
  assign tmp_bytes_num_1 = ({1'b0,step_value} + tmp_bytes_num_2);
  assign tmp_bytes_num_3 = {1'b0,1'b1};
  assign tmp_bytes_num_2 = {1'd0, tmp_bytes_num_3};
  assign tmp_bytes_num_5 = {1'b0,io_asvst_in_payload_empty};
  assign tmp_bytes_num_4 = {5'd0, tmp_bytes_num_5};
  assign tmp_io_avst_out_payload_empty_1 = (io_asvst_in_payload_empty % 8'h80);
  assign tmp_io_avst_out_payload_empty = tmp_io_avst_out_payload_empty_1[3:0];
  always @(*) begin
    case(step_value)
      2'b00 : tmp_io_avst_out_payload_data = io_asvst_in_payload_data[127 : 0];
      2'b01 : tmp_io_avst_out_payload_data = io_asvst_in_payload_data[255 : 128];
      2'b10 : tmp_io_avst_out_payload_data = io_asvst_in_payload_data[383 : 256];
      default : tmp_io_avst_out_payload_data = io_asvst_in_payload_data[511 : 384];
    endcase
  end

  always @(*) begin
    step_willIncrement = 1'b0; // @ Utils.scala l594
    if(tmp_when) begin
      if(!io_avst_out_payload_eop) begin
        step_willIncrement = 1'b1; // @ Utils.scala l598
      end
    end
  end

  always @(*) begin
    step_willClear = 1'b0; // @ Utils.scala l595
    if(tmp_when) begin
      if(io_avst_out_payload_eop) begin
        step_willClear = 1'b1; // @ Utils.scala l597
      end
    end
  end

  assign step_willOverflowIfInc = (step_value == 2'b11); // @ BaseType.scala l305
  assign step_willOverflow = (step_willOverflowIfInc && step_willIncrement); // @ BaseType.scala l305
  always @(*) begin
    step_valueNext = (step_value + tmp_step_valueNext); // @ Utils.scala l606
    if(step_willClear) begin
      step_valueNext = 2'b00; // @ Utils.scala l616
    end
  end

  assign bytes_num = ({1'b0,tmp_bytes_num} + tmp_bytes_num_4); // @ BaseType.scala l299
  assign overflow = (12'h200 <= bytes_num); // @ BaseType.scala l305
  assign io_avst_out_valid = io_asvst_in_valid; // @ BusExt.scala l50
  assign io_avst_out_payload_data = tmp_io_avst_out_payload_data; // @ BusExt.scala l51
  assign io_avst_out_payload_sop = (io_asvst_in_payload_sop && (step_value == 2'b00)); // @ BusExt.scala l52
  assign io_avst_out_payload_eop = (io_asvst_in_payload_eop && overflow); // @ BusExt.scala l53
  assign io_avst_out_payload_empty = (io_avst_out_payload_eop ? tmp_io_avst_out_payload_empty : 4'b0000); // @ BusExt.scala l54
  assign io_avst_out_payload_channel = io_asvst_in_payload_channel; // @ BusExt.scala l56
  assign io_asvst_in_ready = (io_avst_out_ready && overflow); // @ BusExt.scala l57
  always @(posedge clk) begin
    if(reset) begin
      step_value <= 2'b00; // @ Data.scala l409
    end else begin
      step_value <= step_valueNext; // @ Reg.scala l39
    end
  end


endmodule
