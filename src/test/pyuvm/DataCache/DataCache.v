// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : DataCache
// Git hash  : 3c943fa4c6be39962f8d53037b7f25d533b81501



module DataCache (
    input  wire        io_cpu_cmd_valid,
    output wire        io_cpu_cmd_ready,
    input  wire [ 1:0] io_cpu_cmd_payload_kind,
    input  wire        io_cpu_cmd_payload_wr,
    input  wire [11:0] io_cpu_cmd_payload_address,
    input  wire [15:0] io_cpu_cmd_payload_data,
    input  wire [ 1:0] io_cpu_cmd_payload_mask,
    input  wire        io_cpu_cmd_payload_bypass,
    input  wire        io_cpu_cmd_payload_all,
    output wire        io_cpu_rsp_valid,
    output wire [15:0] io_cpu_rsp_payload_data,
    output reg         io_mem_cmd_valid,
    input  wire        io_mem_cmd_ready,
    output reg         io_mem_cmd_payload_wr,
    output reg  [11:0] io_mem_cmd_payload_address,
    output reg  [15:0] io_mem_cmd_payload_data,
    output reg  [ 1:0] io_mem_cmd_payload_mask,
    output reg  [ 3:0] io_mem_cmd_payload_length,
    input  wire        io_mem_rsp_valid,
    input  wire [15:0] io_mem_rsp_payload_data,
    output reg         io_flushDone,
    input  wire        clk,
    input  wire        reset
);
    localparam DataCacheCpuCmdKind_MEMORY = 2'd0;
    localparam DataCacheCpuCmdKind_FLUSH = 2'd1;
    localparam DataCacheCpuCmdKind_EVICT = 2'd2;

    reg  [ 4:0] ways_0_tags_spinal_port1;
    reg  [15:0] ways_0_data_spinal_port1;
    reg  [15:0] victim_buffer_spinal_port1;
    wire [ 4:0] tmp_ways_0_tags_port;
    wire        tmp_ways_0_data_port;
    wire        tmp_ways_0_dataReadRsp;
    wire        tmp_when;
    wire        tmp_when_1;
    wire        tmp_when_2;
    wire [ 2:0] tmp_victim_counter_valueNext;
    wire [ 0:0] tmp_victim_counter_valueNext_1;
    wire        tmp_ways_0_tags_port_1;
    wire        tmp_tmp_manager_waysRead_0_tag_used;
    wire        tmp_when_3;
    wire        tmp_when_4;
    wire        tmp_when_5;
    wire        tmp_when_6;
    wire        tmp_when_7;
    wire        tmp_when_8;
    wire        tmp_when_9;
    wire        tmp_when_10;
    wire        tmp_when_11;
    wire [ 2:0] tmp_loader_counter_valueNext;
    wire [ 0:0] tmp_loader_counter_valueNext_1;
    wire        tmp_when_12;
    reg         tmp_1;
    reg         tmp_2;
    reg         tmp_3;
    reg         haltCpu;
    wire [ 4:0] tagsReadCmd;
    reg         tagsWriteCmd_valid;
    reg  [ 4:0] tagsWriteCmd_payload_address;
    reg         tagsWriteCmd_payload_data_used;
    reg         tagsWriteCmd_payload_data_dirty;
    reg  [ 2:0] tagsWriteCmd_payload_data_address;
    reg         tagsWriteLastCmd_valid;
    reg  [ 4:0] tagsWriteLastCmd_payload_address;
    reg         tagsWriteLastCmd_payload_data_used;
    reg         tagsWriteLastCmd_payload_data_dirty;
    reg  [ 2:0] tagsWriteLastCmd_payload_data_address;
    reg  [ 7:0] dataReadCmd;
    reg         dataWriteCmd_valid;
    reg  [ 7:0] dataWriteCmd_payload_address;
    reg  [15:0] dataWriteCmd_payload_data;
    reg  [ 1:0] dataWriteCmd_payload_mask;
    wire [15:0] ways_0_dataReadRsp;
    reg  [15:0] dataReadedValue_0;
    reg         victim_requestIn_valid;
    reg         victim_requestIn_ready;
    reg  [11:0] victim_requestIn_payload_address;
    wire        victim_request_valid;
    reg         victim_request_ready;
    wire [11:0] victim_request_payload_address;
    reg         victim_requestIn_rValid;
    reg  [11:0] victim_requestIn_rData_address;
    reg  [ 3:0] victim_readLineCmdCounter;
    reg         victim_dataReadCmdOccure;
    reg         victim_dataReadCmdOccureLast;
    reg  [ 3:0] victim_readLineRspCounter;
    reg         victim_dataReadCmdOccure_delay_1;
    reg         victim_dataReadCmdOccure_delay_2;
    reg  [ 3:0] victim_bufferReadCounter;
    wire        victim_bufferReadStream_valid;
    wire        victim_bufferReadStream_ready;
    wire [ 3:0] victim_bufferReadStream_payload;
    wire        victim_bufferReadStream_fire;
    wire        tmp_victim_bufferReadStream_ready;
    reg         tmp_victim_bufferReadStream_ready_1;
    reg         tmp_victim_bufferReadStream_ready_2;
    wire        victim_bufferReaded_valid;
    reg         victim_bufferReaded_ready;
    wire [15:0] victim_bufferReaded_payload;
    reg         tmp_victim_bufferReaded_valid;
    reg  [15:0] tmp_victim_bufferReaded_payload;
    reg  [ 2:0] victim_bufferReadedCounter;
    reg         victim_memCmdAlreadyUsed;
    wire        victim_counter_willIncrement;
    wire        victim_counter_willClear;
    reg  [ 2:0] victim_counter_valueNext;
    reg  [ 2:0] victim_counter_value;
    wire        victim_counter_willOverflowIfInc;
    wire        victim_counter_willOverflow;
    wire        tmp_io_cpu_cmd_ready;
    reg         tmp_io_cpu_cmd_ready_1;
    wire [ 1:0] tmp_manager_request_payload_kind;
    wire        manager_request_valid;
    reg         manager_request_ready;
    wire [ 1:0] manager_request_payload_kind;
    wire        manager_request_payload_wr;
    wire [11:0] manager_request_payload_address;
    wire [15:0] manager_request_payload_data;
    wire [ 1:0] manager_request_payload_mask;
    wire        manager_request_payload_bypass;
    wire        manager_request_payload_all;
    reg         tmp_manager_request_valid;
    reg  [ 1:0] tmp_manager_request_payload_kind_1;
    reg         tmp_manager_request_payload_wr;
    reg  [11:0] tmp_manager_request_payload_address;
    reg  [15:0] tmp_manager_request_payload_data;
    reg  [ 1:0] tmp_manager_request_payload_mask;
    reg         tmp_manager_request_payload_bypass;
    reg         tmp_manager_request_payload_all;
    reg         manager_waysHitValid;
    wire [ 0:0] manager_waysHitOneHot;
    reg         manager_waysHitInfo_used;
    reg         manager_waysHitInfo_dirty;
    reg  [ 2:0] manager_waysHitInfo_address;
    wire        manager_request_isStall;
    reg         manager_delayedValid;
    reg         manager_delayedWaysHitValid;
    wire [11:0] manager_waysReadAddress;
    reg         manager_waysRead_0_tag_used;
    reg         manager_waysRead_0_tag_dirty;
    reg  [ 2:0] manager_waysRead_0_tag_address;
    wire [ 4:0] tmp_manager_waysRead_0_tag_used;
    reg  [ 4:0] tmp_10;
    wire        manager_writebackWayInfo_used;
    wire        manager_writebackWayInfo_dirty;
    wire [ 2:0] manager_writebackWayInfo_address;
    reg         manager_cpuRspIn_valid;
    reg         manager_cpuRspIn_ready;
    reg         manager_cpuRspIn_payload_fromBypass;
    reg         manager_loaderValid;
    reg         manager_loaderReady;
    reg         manager_loadingDone;
    reg         manager_victimSent;
    wire        victim_requestIn_fire;
    reg         manager_flushAllState;
    reg         manager_flushAllDone;
    wire [ 3:0] tmp_victim_requestIn_payload_address;
    wire        victim_requestIn_isStall;
    wire [ 3:0] tmp_victim_requestIn_payload_address_1;
    wire        io_mem_cmd_fire;
    wire        victim_request_isStall;
    wire [ 3:0] tmp_victim_requestIn_payload_address_2;
    wire        manager_cpuRsp_valid;
    wire        manager_cpuRsp_ready;
    wire        manager_cpuRsp_payload_fromBypass;
    reg         manager_cpuRspIn_rValid;
    reg         manager_cpuRspIn_rData_fromBypass;
    wire        manager_cpuRspIsWaitingMemRsp;
    wire        manager_cpuRsp_fire;
    reg         loader_valid;
    reg         loader_memCmdSent;
    reg         loader_counter_willIncrement;
    wire        loader_counter_willClear;
    reg  [ 2:0] loader_counter_valueNext;
    reg  [ 2:0] loader_counter_value;
    wire        loader_counter_willOverflowIfInc;
    wire        loader_counter_willOverflow;
`ifndef SYNTHESIS
    reg [47:0] io_cpu_cmd_payload_kind_string;
    reg [47:0] tmp_manager_request_payload_kind_string;
    reg [47:0] manager_request_payload_kind_string;
    reg [47:0] tmp_manager_request_payload_kind_1_string;
`endif

    reg [ 4:0] ways_0_tags                  [ 0:31];
    reg [ 7:0] ways_0_data_symbol0          [0:255];
    reg [ 7:0] ways_0_data_symbol1          [0:255];
    reg [ 7:0] tmp_ways_0_datasymbol_read;
    reg [ 7:0] tmp_ways_0_datasymbol_read_1;
    reg [15:0] victim_buffer                [ 0:15];

    assign tmp_when_1 = (((4'b0010 <= victim_readLineCmdCounter) && (! victim_readLineRspCounter[3])) && victim_dataReadCmdOccure_delay_2);
    assign tmp_when_6 = (!manager_flushAllState);
    assign tmp_when_7 = (!victim_requestIn_isStall);
    assign tmp_when_9 = (manager_waysHitValid && (!manager_loadingDone));
    assign tmp_when_12 = (io_mem_rsp_valid && (!manager_cpuRspIsWaitingMemRsp));
    assign tmp_when_8 = (!victim_request_valid);
    assign tmp_when_11 = (loader_valid && (!loader_memCmdSent));
    assign tmp_when_10 = (manager_writebackWayInfo_used && manager_writebackWayInfo_dirty);
    assign tmp_when_2 = ((!victim_memCmdAlreadyUsed) && io_mem_cmd_ready);
    assign tmp_when = (victim_request_valid && (!victim_readLineCmdCounter[3]));
    assign tmp_when_5 = (manager_request_payload_address[8 : 4] != 5'h1f);
    assign tmp_when_4 = manager_waysHitOneHot[0];
    assign tmp_when_3 = ((tagsWriteLastCmd_valid && 1'b1) && (tagsWriteLastCmd_payload_address == tmp_10));
    assign tmp_victim_counter_valueNext_1 = victim_counter_willIncrement;
    assign tmp_victim_counter_valueNext = {2'd0, tmp_victim_counter_valueNext_1};
    assign tmp_loader_counter_valueNext_1 = loader_counter_willIncrement;
    assign tmp_loader_counter_valueNext = {2'd0, tmp_loader_counter_valueNext_1};
    assign tmp_ways_0_tags_port = {
        tagsWriteCmd_payload_data_address,
        {tagsWriteCmd_payload_data_dirty, tagsWriteCmd_payload_data_used}
    };
    assign tmp_tmp_manager_waysRead_0_tag_used = 1'b1;
    assign tmp_ways_0_dataReadRsp = 1'b1;
    always @(posedge clk) begin
        if (tmp_3) begin
            ways_0_tags[tagsWriteCmd_payload_address] <= tmp_ways_0_tags_port;
        end
    end

    always @(posedge clk) begin
        if (tmp_tmp_manager_waysRead_0_tag_used) begin
            ways_0_tags_spinal_port1 <= ways_0_tags[tagsReadCmd];
        end
    end

    always @(*) begin
        ways_0_data_spinal_port1 = {tmp_ways_0_datasymbol_read_1, tmp_ways_0_datasymbol_read};
    end
    always @(posedge clk) begin
        if (dataWriteCmd_payload_mask[0] && tmp_2) begin
            ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
        end
        if (dataWriteCmd_payload_mask[1] && tmp_2) begin
            ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
        end
    end

    always @(posedge clk) begin
        if (tmp_ways_0_dataReadRsp) begin
            tmp_ways_0_datasymbol_read   <= ways_0_data_symbol0[dataReadCmd];
            tmp_ways_0_datasymbol_read_1 <= ways_0_data_symbol1[dataReadCmd];
        end
    end

    always @(posedge clk) begin
        if (tmp_1) begin
            victim_buffer[victim_readLineRspCounter] <= dataReadedValue_0;
        end
    end

    always @(posedge clk) begin
        if (victim_bufferReadStream_fire) begin
            victim_buffer_spinal_port1 <= victim_buffer[victim_bufferReadStream_payload];
        end
    end

`ifndef SYNTHESIS
    always @(*) begin
        case (io_cpu_cmd_payload_kind)
            DataCacheCpuCmdKind_MEMORY: io_cpu_cmd_payload_kind_string = "MEMORY";
            DataCacheCpuCmdKind_FLUSH: io_cpu_cmd_payload_kind_string = "FLUSH ";
            DataCacheCpuCmdKind_EVICT: io_cpu_cmd_payload_kind_string = "EVICT ";
            default: io_cpu_cmd_payload_kind_string = "??????";
        endcase
    end
    always @(*) begin
        case (tmp_manager_request_payload_kind)
            DataCacheCpuCmdKind_MEMORY: tmp_manager_request_payload_kind_string = "MEMORY";
            DataCacheCpuCmdKind_FLUSH: tmp_manager_request_payload_kind_string = "FLUSH ";
            DataCacheCpuCmdKind_EVICT: tmp_manager_request_payload_kind_string = "EVICT ";
            default: tmp_manager_request_payload_kind_string = "??????";
        endcase
    end
    always @(*) begin
        case (manager_request_payload_kind)
            DataCacheCpuCmdKind_MEMORY: manager_request_payload_kind_string = "MEMORY";
            DataCacheCpuCmdKind_FLUSH: manager_request_payload_kind_string = "FLUSH ";
            DataCacheCpuCmdKind_EVICT: manager_request_payload_kind_string = "EVICT ";
            default: manager_request_payload_kind_string = "??????";
        endcase
    end
    always @(*) begin
        case (tmp_manager_request_payload_kind_1)
            DataCacheCpuCmdKind_MEMORY: tmp_manager_request_payload_kind_1_string = "MEMORY";
            DataCacheCpuCmdKind_FLUSH: tmp_manager_request_payload_kind_1_string = "FLUSH ";
            DataCacheCpuCmdKind_EVICT: tmp_manager_request_payload_kind_1_string = "EVICT ";
            default: tmp_manager_request_payload_kind_1_string = "??????";
        endcase
    end
`endif

    always @(*) begin
        tmp_1 = 1'b0;  // @ when.scala l47
        if (tmp_when_1) begin
            tmp_1 = 1'b1;  // @ when.scala l52
        end
    end

    always @(*) begin
        tmp_2 = 1'b0;  // @ when.scala l47
        if ((dataWriteCmd_valid && 1'b1)) begin
            tmp_2 = 1'b1;  // @ when.scala l52
        end
    end

    always @(*) begin
        tmp_3 = 1'b0;  // @ when.scala l47
        if ((tagsWriteCmd_valid && 1'b1)) begin
            tmp_3 = 1'b1;  // @ when.scala l52
        end
    end

    always @(*) begin
        haltCpu = 1'b0;  // @ DCache.scala l142
        if((((io_cpu_cmd_payload_address == manager_request_payload_address) && manager_request_valid) && io_cpu_cmd_valid)) begin
            haltCpu = 1'b1;  // @ DCache.scala l524
        end
    end

    always @(*) begin
        tagsWriteCmd_valid = 1'b0;  // @ DCache.scala l182
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                    if (manager_request_payload_all) begin
                        tagsWriteCmd_valid = 1'b1;  // @ DCache.scala l353
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                tagsWriteCmd_valid = 1'b1;  // @ DCache.scala l365
                            end
                        end
                    end
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (tmp_when_6) begin
                            if (tmp_when_7) begin
                                tagsWriteCmd_valid = 1'b1;  // @ DCache.scala l389
                            end
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                tagsWriteCmd_valid = victim_requestIn_ready;  // @ DCache.scala l406
                            end
                        end
                    end
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                tagsWriteCmd_valid = 1'b1;  // @ DCache.scala l444
                            end
                        end
                    end
                end
            endcase
        end
        if (loader_counter_willOverflow) begin
            tagsWriteCmd_valid = 1'b1;  // @ DCache.scala l512
        end
    end

    always @(*) begin
        tagsWriteCmd_payload_address = 5'bxxxxx;  // @ UInt.scala l467
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                    if (manager_request_payload_all) begin
                        tagsWriteCmd_payload_address = manager_request_payload_address[8 : 4]; // @ DCache.scala l355
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                tagsWriteCmd_payload_address = manager_request_payload_address[8 : 4]; // @ DCache.scala l367
                            end
                        end
                    end
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (tmp_when_6) begin
                            tagsWriteCmd_payload_address = manager_request_payload_address[8 : 4]; // @ DCache.scala l382
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                tagsWriteCmd_payload_address = manager_request_payload_address[8 : 4]; // @ DCache.scala l408
                            end
                        end
                    end
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                tagsWriteCmd_payload_address = manager_request_payload_address[8 : 4]; // @ DCache.scala l446
                            end
                        end
                    end
                end
            endcase
        end
        if (loader_counter_willOverflow) begin
            tagsWriteCmd_payload_address = manager_request_payload_address[8 : 4]; // @ DCache.scala l514
        end
    end

    always @(*) begin
        tagsWriteCmd_payload_data_used = 1'bx;  // @ Bool.scala l296
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                    if (manager_request_payload_all) begin
                        tagsWriteCmd_payload_data_used = 1'b0;  // @ DCache.scala l356
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                tagsWriteCmd_payload_data_used = 1'b0;  // @ DCache.scala l368
                            end
                        end
                    end
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (tmp_when_6) begin
                            tagsWriteCmd_payload_data_used = 1'b0;  // @ DCache.scala l383
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                tagsWriteCmd_payload_data_used = 1'b0;  // @ DCache.scala l409
                            end
                        end
                    end
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                tagsWriteCmd_payload_data_used = 1'b1;  // @ DCache.scala l447
                            end
                        end
                    end
                end
            endcase
        end
        if (loader_counter_willOverflow) begin
            tagsWriteCmd_payload_data_used = 1'b1;  // @ DCache.scala l515
        end
    end

    always @(*) begin
        tagsWriteCmd_payload_data_dirty = 1'bx;  // @ Bool.scala l296
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                tagsWriteCmd_payload_data_dirty = 1'b1;  // @ DCache.scala l448
                            end
                        end
                    end
                end
            endcase
        end
        if (loader_counter_willOverflow) begin
            tagsWriteCmd_payload_data_dirty = 1'b0;  // @ DCache.scala l516
        end
    end

    always @(*) begin
        tagsWriteCmd_payload_data_address = 3'bxxx;  // @ UInt.scala l467
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                tagsWriteCmd_payload_data_address = manager_request_payload_address[11 : 9]; // @ DCache.scala l449
                            end
                        end
                    end
                end
            endcase
        end
        if (loader_counter_willOverflow) begin
            tagsWriteCmd_payload_data_address = manager_request_payload_address[11 : 9]; // @ DCache.scala l517
        end
    end

    always @(*) begin
        dataWriteCmd_valid = 1'b0;  // @ DCache.scala l184
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                dataWriteCmd_valid = 1'b1;  // @ DCache.scala l438
                            end
                        end
                    end
                end
            endcase
        end
        if (tmp_when_12) begin
            dataWriteCmd_valid = 1'b1;  // @ DCache.scala l501
        end
    end

    always @(*) begin
        dataWriteCmd_payload_address = 8'bxxxxxxxx;  // @ UInt.scala l467
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                dataWriteCmd_payload_address = manager_request_payload_address[8 : 1]; // @ DCache.scala l440
                            end
                        end
                    end
                end
            endcase
        end
        if (tmp_when_12) begin
            dataWriteCmd_payload_address = {
                manager_request_payload_address[8 : 4], loader_counter_value
            };  // @ DCache.scala l503
        end
    end

    always @(*) begin
        dataWriteCmd_payload_data = 16'bxxxxxxxxxxxxxxxx;  // @ Bits.scala l231
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                dataWriteCmd_payload_data = manager_request_payload_data; // @ DCache.scala l441
                            end
                        end
                    end
                end
            endcase
        end
        if (tmp_when_12) begin
            dataWriteCmd_payload_data = io_mem_rsp_payload_data;  // @ DCache.scala l504
        end
    end

    always @(*) begin
        dataWriteCmd_payload_mask = 2'bxx;  // @ Bits.scala l231
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                dataWriteCmd_payload_mask = manager_request_payload_mask; // @ DCache.scala l442
                            end
                        end
                    end
                end
            endcase
        end
        if (tmp_when_12) begin
            dataWriteCmd_payload_mask = 2'b11;  // @ DCache.scala l505
        end
    end

    always @(*) begin
        io_mem_cmd_valid = 1'b0;  // @ DCache.scala l186
        if (victim_bufferReaded_valid) begin
            io_mem_cmd_valid = 1'b1;  // @ DCache.scala l260
        end
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            io_mem_cmd_valid = (! ((! manager_request_payload_wr) && (! manager_cpuRspIn_ready))); // @ DCache.scala l421
                        end
                    end
                end
            endcase
        end
        if (tmp_when_11) begin
            io_mem_cmd_valid = 1'b1;  // @ DCache.scala l485
        end
    end

    always @(*) begin
        io_mem_cmd_payload_wr = 1'bx;  // @ Bool.scala l296
        if (victim_bufferReaded_valid) begin
            io_mem_cmd_payload_wr = 1'b1;  // @ DCache.scala l261
        end
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            io_mem_cmd_payload_wr = manager_request_payload_wr; // @ DCache.scala l422
                        end
                    end
                end
            endcase
        end
        if (tmp_when_11) begin
            io_mem_cmd_payload_wr = 1'b0;  // @ DCache.scala l486
        end
    end

    always @(*) begin
        io_mem_cmd_payload_address = 12'bxxxxxxxxxxxx;  // @ UInt.scala l467
        if (victim_bufferReaded_valid) begin
            io_mem_cmd_payload_address = {
                victim_request_payload_address[11 : 4], 4'b0000
            };  // @ DCache.scala l262
        end
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            io_mem_cmd_payload_address = {
                                manager_request_payload_address[11 : 1], 1'b0
                            };  // @ DCache.scala l423
                        end
                    end
                end
            endcase
        end
        if (tmp_when_11) begin
            io_mem_cmd_payload_address = {
                manager_request_payload_address[11 : 4], 4'b0000
            };  // @ DCache.scala l487
        end
    end

    always @(*) begin
        io_mem_cmd_payload_data = 16'bxxxxxxxxxxxxxxxx;  // @ Bits.scala l231
        if (victim_bufferReaded_valid) begin
            io_mem_cmd_payload_data = victim_bufferReaded_payload;  // @ DCache.scala l264
        end
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            io_mem_cmd_payload_data = manager_request_payload_data; // @ DCache.scala l425
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        io_mem_cmd_payload_mask = 2'bxx;  // @ Bits.scala l231
        if (victim_bufferReaded_valid) begin
            io_mem_cmd_payload_mask = 2'b11;  // @ DCache.scala l265
        end
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            io_mem_cmd_payload_mask = manager_request_payload_mask; // @ DCache.scala l424
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        io_mem_cmd_payload_length = 4'bxxxx;  // @ UInt.scala l467
        if (victim_bufferReaded_valid) begin
            io_mem_cmd_payload_length = 4'b1000;  // @ DCache.scala l263
        end
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            io_mem_cmd_payload_length = 4'b0001;  // @ DCache.scala l426
                        end
                    end
                end
            endcase
        end
        if (tmp_when_11) begin
            io_mem_cmd_payload_length = 4'b1000;  // @ DCache.scala l488
        end
    end

    assign ways_0_dataReadRsp = ways_0_data_spinal_port1;  // @ Bits.scala l133
    always @(*) begin
        victim_requestIn_valid = 1'b0;  // @ DCache.scala l219
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (tmp_when_6) begin
                            victim_requestIn_valid = (manager_waysRead_0_tag_used && manager_waysRead_0_tag_dirty); // @ DCache.scala l377
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                victim_requestIn_valid = 1'b1;  // @ DCache.scala l402
                            end
                        end
                    end
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (!tmp_when_9) begin
                            if (tmp_when_10) begin
                                victim_requestIn_valid = (! manager_victimSent); // @ DCache.scala l459
                            end
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        victim_requestIn_payload_address = 12'bxxxxxxxxxxxx;  // @ UInt.scala l467
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (tmp_when_6) begin
                            victim_requestIn_payload_address = {
                                {
                                    manager_writebackWayInfo_address,
                                    manager_request_payload_address[8 : 4]
                                },
                                tmp_victim_requestIn_payload_address
                            };  // @ DCache.scala l379
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                victim_requestIn_payload_address = {
                                    {
                                        manager_writebackWayInfo_address,
                                        manager_request_payload_address[8 : 4]
                                    },
                                    tmp_victim_requestIn_payload_address_1
                                };  // @ DCache.scala l404
                            end
                        end
                    end
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (!tmp_when_9) begin
                            if (tmp_when_10) begin
                                victim_requestIn_payload_address = {
                                    {
                                        manager_writebackWayInfo_address,
                                        manager_request_payload_address[8 : 4]
                                    },
                                    tmp_victim_requestIn_payload_address_2
                                };  // @ DCache.scala l461
                            end
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        victim_requestIn_ready = victim_request_ready;  // @ Stream.scala l374
        if ((!victim_request_valid)) begin
            victim_requestIn_ready = 1'b1;  // @ Stream.scala l375
        end
    end

    assign victim_request_valid = victim_requestIn_rValid;  // @ Stream.scala l377
    assign victim_request_payload_address = victim_requestIn_rData_address;  // @ Stream.scala l378
    always @(*) begin
        victim_request_ready = 1'b0;  // @ DCache.scala l223
        if (victim_bufferReaded_valid) begin
            if (tmp_when_2) begin
                if ((victim_bufferReadedCounter == 3'b111)) begin
                    victim_request_ready = 1'b1;  // @ DCache.scala l271
                end
            end
        end
    end

    always @(*) begin
        victim_dataReadCmdOccure = 1'b0;  // @ DCache.scala l229
        if (tmp_when) begin
            victim_dataReadCmdOccure = 1'b1;  // @ DCache.scala l235
        end
    end

    assign victim_bufferReadStream_valid = (victim_bufferReadCounter < victim_readLineRspCounter); // @ DCache.scala l248
    assign victim_bufferReadStream_payload = victim_bufferReadCounter;  // @ DCache.scala l249
    assign victim_bufferReadStream_fire = (victim_bufferReadStream_valid && victim_bufferReadStream_ready); // @ BaseType.scala l305
    assign victim_bufferReadStream_ready = ((! tmp_victim_bufferReadStream_ready) || tmp_victim_bufferReadStream_ready_1); // @ Mem.scala l58
    assign tmp_victim_bufferReadStream_ready = tmp_victim_bufferReadStream_ready_2; // @ Mem.scala l60
    always @(*) begin
        tmp_victim_bufferReadStream_ready_1 = victim_bufferReaded_ready;  // @ Stream.scala l374
        if ((!victim_bufferReaded_valid)) begin
            tmp_victim_bufferReadStream_ready_1 = 1'b1;  // @ Stream.scala l375
        end
    end

    assign victim_bufferReaded_valid   = tmp_victim_bufferReaded_valid;  // @ Stream.scala l377
    assign victim_bufferReaded_payload = tmp_victim_bufferReaded_payload;  // @ Stream.scala l378
    always @(*) begin
        victim_bufferReaded_ready = 1'b0;  // @ DCache.scala l254
        if (victim_bufferReaded_valid) begin
            if (tmp_when_2) begin
                victim_bufferReaded_ready = 1'b1;  // @ DCache.scala l268
            end
        end
    end

    always @(*) begin
        victim_memCmdAlreadyUsed = 1'b0;  // @ DCache.scala l258
        if ((loader_valid && (!loader_memCmdSent))) begin
            victim_memCmdAlreadyUsed = 1'b1;  // @ DCache.scala l496
        end
    end

    assign victim_counter_willIncrement = 1'b0;  // @ Utils.scala l594
    assign victim_counter_willClear = 1'b0;  // @ Utils.scala l595
    assign victim_counter_willOverflowIfInc = (victim_counter_value == 3'b111); // @ BaseType.scala l305
    assign victim_counter_willOverflow = (victim_counter_willOverflowIfInc && victim_counter_willIncrement); // @ BaseType.scala l305
    always @(*) begin
        victim_counter_valueNext = (victim_counter_value + tmp_victim_counter_valueNext); // @ Utils.scala l606
        if (victim_counter_willClear) begin
            victim_counter_valueNext = 3'b000;  // @ Utils.scala l616
        end
    end

    always @(*) begin
        io_flushDone = 1'b0;  // @ DCache.scala l286
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (!tmp_when_6) begin
                            io_flushDone = manager_flushAllDone;  // @ DCache.scala l395
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (!manager_delayedWaysHitValid) begin
                                io_flushDone = 1'b1;  // @ DCache.scala l412
                            end
                        end
                    end
                end
                default: begin
                end
            endcase
        end
    end

    assign tmp_io_cpu_cmd_ready = (!haltCpu);  // @ BaseType.scala l299
    assign io_cpu_cmd_ready = (tmp_io_cpu_cmd_ready_1 && tmp_io_cpu_cmd_ready); // @ Stream.scala l434
    assign tmp_manager_request_payload_kind = io_cpu_cmd_payload_kind;  // @ Stream.scala l435
    always @(*) begin
        tmp_io_cpu_cmd_ready_1 = manager_request_ready;  // @ Stream.scala l374
        if ((!manager_request_valid)) begin
            tmp_io_cpu_cmd_ready_1 = 1'b1;  // @ Stream.scala l375
        end
    end

    assign manager_request_valid = tmp_manager_request_valid;  // @ Stream.scala l377
    assign manager_request_payload_kind = tmp_manager_request_payload_kind_1; // @ Stream.scala l378
    assign manager_request_payload_wr = tmp_manager_request_payload_wr;  // @ Stream.scala l378
    assign manager_request_payload_address = tmp_manager_request_payload_address; // @ Stream.scala l378
    assign manager_request_payload_data = tmp_manager_request_payload_data;  // @ Stream.scala l378
    assign manager_request_payload_mask = tmp_manager_request_payload_mask;  // @ Stream.scala l378
    assign manager_request_payload_bypass = tmp_manager_request_payload_bypass; // @ Stream.scala l378
    assign manager_request_payload_all = tmp_manager_request_payload_all;  // @ Stream.scala l378
    always @(*) begin
        manager_request_ready = (!manager_request_valid);  // @ DCache.scala l289
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                    if (manager_request_payload_all) begin
                        if (!tmp_when_5) begin
                            manager_request_ready = 1'b1;  // @ DCache.scala l360
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            manager_request_ready = 1'b1;  // @ DCache.scala l370
                        end
                    end
                end
                DataCacheCpuCmdKind_FLUSH: begin
                    if (manager_request_payload_all) begin
                        if (!tmp_when_6) begin
                            manager_request_ready = manager_flushAllDone;  // @ DCache.scala l394
                        end
                    end else begin
                        if (manager_delayedValid) begin
                            if (manager_delayedWaysHitValid) begin
                                manager_request_ready = victim_requestIn_ready; // @ DCache.scala l400
                            end else begin
                                manager_request_ready = 1'b1;  // @ DCache.scala l411
                            end
                        end
                    end
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            manager_request_ready = io_mem_cmd_fire;  // @ DCache.scala l431
                        end else begin
                            manager_request_ready = 1'b0;  // @ DCache.scala l433
                        end
                    end else begin
                        if (tmp_when_9) begin
                            if (manager_request_payload_wr) begin
                                manager_request_ready = 1'b1;  // @ DCache.scala l450
                            end else begin
                                manager_request_ready = (manager_cpuRspIn_ready && (! victim_dataReadCmdOccureLast)); // @ DCache.scala l453
                            end
                        end else begin
                            manager_request_ready = 1'b0;  // @ DCache.scala l456
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        manager_waysHitValid = 1'b0;  // @ DCache.scala l296
        if (tmp_when_4) begin
            manager_waysHitValid = 1'b1;  // @ DCache.scala l320
        end
    end

    always @(*) begin
        manager_waysHitInfo_used = 1'bx;  // @ Bool.scala l296
        if (tmp_when_4) begin
            manager_waysHitInfo_used = manager_waysRead_0_tag_used;  // @ DCache.scala l321
        end
    end

    always @(*) begin
        manager_waysHitInfo_dirty = 1'bx;  // @ Bool.scala l296
        if (tmp_when_4) begin
            manager_waysHitInfo_dirty = manager_waysRead_0_tag_dirty;  // @ DCache.scala l321
        end
    end

    always @(*) begin
        manager_waysHitInfo_address = 3'bxxx;  // @ UInt.scala l467
        if (tmp_when_4) begin
            manager_waysHitInfo_address = manager_waysRead_0_tag_address;  // @ DCache.scala l321
        end
    end

    assign manager_request_isStall = (manager_request_valid && (! manager_request_ready)); // @ BaseType.scala l305
    assign manager_waysReadAddress = (manager_request_isStall ? manager_request_payload_address : io_cpu_cmd_payload_address); // @ Expression.scala l1444
    assign tagsReadCmd = manager_waysReadAddress[8 : 4];  // @ DCache.scala l307
    always @(*) begin
        dataReadCmd = manager_waysReadAddress[8 : 1];  // @ DCache.scala l308
        if (victim_dataReadCmdOccure) begin
            dataReadCmd = {
                victim_request_payload_address[8 : 4], victim_readLineCmdCounter[2 : 0]
            };  // @ DCache.scala l310
        end
    end

    assign tmp_manager_waysRead_0_tag_used = ways_0_tags_spinal_port1;  // @ Mem.scala l310
    always @(*) begin
        manager_waysRead_0_tag_used = tmp_manager_waysRead_0_tag_used[0];  // @ Bool.scala l209
        if (tmp_when_3) begin
            manager_waysRead_0_tag_used = tagsWriteLastCmd_payload_data_used; // @ DCache.scala l316
        end
    end

    always @(*) begin
        manager_waysRead_0_tag_dirty = tmp_manager_waysRead_0_tag_used[1];  // @ Bool.scala l209
        if (tmp_when_3) begin
            manager_waysRead_0_tag_dirty = tagsWriteLastCmd_payload_data_dirty; // @ DCache.scala l316
        end
    end

    always @(*) begin
        manager_waysRead_0_tag_address = tmp_manager_waysRead_0_tag_used[4 : 2]; // @ UInt.scala l381
        if (tmp_when_3) begin
            manager_waysRead_0_tag_address = tagsWriteLastCmd_payload_data_address; // @ DCache.scala l316
        end
    end

    assign manager_waysHitOneHot[0] = (manager_waysRead_0_tag_used && (manager_waysRead_0_tag_address == manager_request_payload_address[11 : 9])); // @ DCache.scala l318
    assign manager_writebackWayInfo_used = manager_waysRead_0_tag_used;  // @ Vec.scala l169
    assign manager_writebackWayInfo_dirty = manager_waysRead_0_tag_dirty;  // @ Vec.scala l169
    assign manager_writebackWayInfo_address = manager_waysRead_0_tag_address;  // @ Vec.scala l169
    always @(*) begin
        manager_cpuRspIn_valid = 1'b0;  // @ DCache.scala l334
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            manager_cpuRspIn_valid = ((! manager_request_payload_wr) && io_mem_cmd_fire); // @ DCache.scala l428
                        end
                    end else begin
                        if (tmp_when_9) begin
                            if (!manager_request_payload_wr) begin
                                manager_cpuRspIn_valid = (! victim_dataReadCmdOccureLast); // @ DCache.scala l452
                            end
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        manager_cpuRspIn_payload_fromBypass = 1'b0;  // @ DCache.scala l335
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (manager_request_payload_bypass) begin
                        if (tmp_when_8) begin
                            manager_cpuRspIn_payload_fromBypass = 1'b1;  // @ DCache.scala l429
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        manager_loaderValid = 1'b0;  // @ DCache.scala l339
        if (manager_request_valid) begin
            case (manager_request_payload_kind)
                DataCacheCpuCmdKind_EVICT: begin
                end
                DataCacheCpuCmdKind_FLUSH: begin
                end
                default: begin
                    if (!manager_request_payload_bypass) begin
                        if (!tmp_when_9) begin
                            manager_loaderValid = ((! manager_loadingDone) && (! ((! manager_victimSent) && victim_request_isStall))); // @ DCache.scala l457
                        end
                    end
                end
            endcase
        end
    end

    always @(*) begin
        manager_loaderReady = 1'b0;  // @ DCache.scala l340
        if (loader_counter_willOverflow) begin
            manager_loaderReady = 1'b1;  // @ DCache.scala l518
        end
    end

    assign victim_requestIn_fire = (victim_requestIn_valid && victim_requestIn_ready); // @ BaseType.scala l305
    assign tmp_victim_requestIn_payload_address[3 : 0] = 4'b0000;  // @ Literal.scala l88
    assign victim_requestIn_isStall = (victim_requestIn_valid && (! victim_requestIn_ready)); // @ BaseType.scala l305
    assign tmp_victim_requestIn_payload_address_1[3 : 0] = 4'b0000;  // @ Literal.scala l88
    assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);  // @ BaseType.scala l305
    assign victim_request_isStall = (victim_request_valid && (! victim_request_ready)); // @ BaseType.scala l305
    assign tmp_victim_requestIn_payload_address_2[3 : 0] = 4'b0000;  // @ Literal.scala l88
    always @(*) begin
        manager_cpuRspIn_ready = manager_cpuRsp_ready;  // @ Stream.scala l374
        if ((!manager_cpuRsp_valid)) begin
            manager_cpuRspIn_ready = 1'b1;  // @ Stream.scala l375
        end
    end

    assign manager_cpuRsp_valid = manager_cpuRspIn_rValid;  // @ Stream.scala l377
    assign manager_cpuRsp_payload_fromBypass = manager_cpuRspIn_rData_fromBypass; // @ Stream.scala l378
    assign manager_cpuRspIsWaitingMemRsp = (manager_cpuRsp_valid && io_mem_rsp_valid); // @ BaseType.scala l305
    assign manager_cpuRsp_fire = (manager_cpuRsp_valid && manager_cpuRsp_ready); // @ BaseType.scala l305
    assign io_cpu_rsp_valid = manager_cpuRsp_fire;  // @ DCache.scala l472
    assign io_cpu_rsp_payload_data = (manager_cpuRsp_payload_fromBypass ? io_mem_rsp_payload_data : dataReadedValue_0); // @ DCache.scala l473
    assign manager_cpuRsp_ready = (! (manager_cpuRsp_payload_fromBypass && (! io_mem_rsp_valid))); // @ DCache.scala l474
    always @(*) begin
        loader_counter_willIncrement = 1'b0;  // @ Utils.scala l594
        if (tmp_when_12) begin
            loader_counter_willIncrement = 1'b1;  // @ Utils.scala l598
        end
    end

    assign loader_counter_willClear = 1'b0;  // @ Utils.scala l595
    assign loader_counter_willOverflowIfInc = (loader_counter_value == 3'b111); // @ BaseType.scala l305
    assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement); // @ BaseType.scala l305
    always @(*) begin
        loader_counter_valueNext = (loader_counter_value + tmp_loader_counter_valueNext); // @ Utils.scala l606
        if (loader_counter_willClear) begin
            loader_counter_valueNext = 3'b000;  // @ Utils.scala l616
        end
    end

    always @(posedge clk) begin
        tagsWriteLastCmd_valid <= tagsWriteCmd_valid;  // @ Reg.scala l39
        tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;  // @ Reg.scala l39
        tagsWriteLastCmd_payload_data_used <= tagsWriteCmd_payload_data_used;  // @ Reg.scala l39
        tagsWriteLastCmd_payload_data_dirty <= tagsWriteCmd_payload_data_dirty;  // @ Reg.scala l39
        tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address; // @ Reg.scala l39
        dataReadedValue_0 <= ways_0_dataReadRsp;  // @ Reg.scala l39
        if (victim_requestIn_ready) begin
            victim_requestIn_rData_address <= victim_requestIn_payload_address; // @ Stream.scala l366
        end
        victim_dataReadCmdOccureLast <= victim_dataReadCmdOccure;  // @ Reg.scala l39
        victim_dataReadCmdOccure_delay_1 <= victim_dataReadCmdOccure;  // @ Reg.scala l39
        victim_dataReadCmdOccure_delay_2 <= victim_dataReadCmdOccure_delay_1;  // @ Reg.scala l39
        if (tmp_victim_bufferReadStream_ready_1) begin
            tmp_victim_bufferReaded_payload <= victim_buffer_spinal_port1;  // @ Stream.scala l366
        end
        if (tmp_io_cpu_cmd_ready_1) begin
            tmp_manager_request_payload_wr <= io_cpu_cmd_payload_wr;  // @ Stream.scala l366
            tmp_manager_request_payload_data <= io_cpu_cmd_payload_data;  // @ Stream.scala l366
            tmp_manager_request_payload_mask <= io_cpu_cmd_payload_mask;  // @ Stream.scala l366
            tmp_manager_request_payload_bypass <= io_cpu_cmd_payload_bypass;  // @ Stream.scala l366
        end
        manager_delayedWaysHitValid <= manager_waysHitValid;  // @ Reg.scala l39
        tmp_10 <= manager_waysReadAddress[8 : 4];  // @ Reg.scala l39
        if (manager_cpuRspIn_ready) begin
            manager_cpuRspIn_rData_fromBypass <= manager_cpuRspIn_payload_fromBypass; // @ Stream.scala l366
        end
        loader_valid <= manager_loaderValid;  // @ Reg.scala l39
        if (loader_counter_willOverflow) begin
            loader_valid <= 1'b0;  // @ DCache.scala l511
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            victim_requestIn_rValid <= 1'b0;  // @ Data.scala l409
            victim_readLineCmdCounter <= 4'b0000;  // @ Data.scala l409
            victim_readLineRspCounter <= 4'b0000;  // @ Data.scala l409
            victim_bufferReadCounter <= 4'b0000;  // @ Data.scala l409
            tmp_victim_bufferReadStream_ready_2 <= 1'b0;  // @ Data.scala l409
            tmp_victim_bufferReaded_valid <= 1'b0;  // @ Data.scala l409
            victim_bufferReadedCounter <= 3'b000;  // @ Data.scala l409
            victim_counter_value <= 3'b000;  // @ Data.scala l409
            tmp_manager_request_valid <= 1'b0;  // @ Data.scala l409
            tmp_manager_request_valid <= 1'b1;  // @ Data.scala l409
            tmp_manager_request_payload_kind_1 <= DataCacheCpuCmdKind_EVICT;  // @ Data.scala l409
            tmp_manager_request_payload_all <= 1'b1;  // @ Data.scala l409
            tmp_manager_request_payload_address <= 12'h0;  // @ Data.scala l409
            manager_delayedValid <= 1'b0;  // @ Data.scala l409
            manager_loadingDone <= 1'b0;  // @ Data.scala l409
            manager_victimSent <= 1'b0;  // @ Data.scala l409
            manager_flushAllState <= 1'b0;  // @ Data.scala l409
            manager_flushAllDone <= 1'b0;  // @ Data.scala l409
            manager_cpuRspIn_rValid <= 1'b0;  // @ Data.scala l409
            loader_memCmdSent <= 1'b0;  // @ Data.scala l409
            loader_counter_value <= 3'b000;  // @ Data.scala l409
        end else begin
            if (victim_requestIn_ready) begin
                victim_requestIn_rValid <= victim_requestIn_valid;  // @ Stream.scala l365
            end
            if (tmp_when) begin
                victim_readLineCmdCounter <= (victim_readLineCmdCounter + 4'b0001); // @ DCache.scala l233
            end
            if (tmp_when_1) begin
                victim_readLineRspCounter <= (victim_readLineRspCounter + 4'b0001); // @ DCache.scala l242
            end
            if (victim_bufferReadStream_fire) begin
                victim_bufferReadCounter <= (victim_bufferReadCounter + 4'b0001); // @ DCache.scala l251
            end
            if (tmp_victim_bufferReadStream_ready_1) begin
                tmp_victim_bufferReadStream_ready_2 <= 1'b0;  // @ Mem.scala l52
            end
            if (victim_bufferReadStream_ready) begin
                tmp_victim_bufferReadStream_ready_2 <= victim_bufferReadStream_valid; // @ Mem.scala l55
            end
            if (tmp_victim_bufferReadStream_ready_1) begin
                tmp_victim_bufferReaded_valid <= tmp_victim_bufferReadStream_ready; // @ Stream.scala l365
            end
            if (victim_bufferReaded_valid) begin
                if (tmp_when_2) begin
                    victim_bufferReadedCounter <= (victim_bufferReadedCounter + 3'b001); // @ DCache.scala l269
                end
            end
            victim_counter_value <= victim_counter_valueNext;  // @ Reg.scala l39
            if (victim_request_ready) begin
                victim_readLineCmdCounter[3] <= 1'b0;  // @ DCache.scala l279
                victim_readLineRspCounter[3] <= 1'b0;  // @ DCache.scala l280
                victim_bufferReadCounter[3]  <= 1'b0;  // @ DCache.scala l281
            end
            if (tmp_io_cpu_cmd_ready_1) begin
                tmp_manager_request_valid <= (io_cpu_cmd_valid && tmp_io_cpu_cmd_ready); // @ Stream.scala l365
            end
            if (tmp_io_cpu_cmd_ready_1) begin
                tmp_manager_request_payload_kind_1 <= tmp_manager_request_payload_kind; // @ Stream.scala l366
                tmp_manager_request_payload_address <= io_cpu_cmd_payload_address; // @ Stream.scala l366
                tmp_manager_request_payload_all <= io_cpu_cmd_payload_all;  // @ Stream.scala l366
            end
            manager_delayedValid <= manager_request_isStall;  // @ Reg.scala l39
            manager_loadingDone <= (manager_loaderValid && manager_loaderReady);  // @ Reg.scala l39
            manager_victimSent <= ((manager_victimSent || victim_requestIn_fire) && (! manager_request_ready)); // @ DCache.scala l344
            manager_flushAllDone <= 1'b0;  // @ Reg.scala l39
            if (manager_request_valid) begin
                case (manager_request_payload_kind)
                    DataCacheCpuCmdKind_EVICT: begin
                        if (manager_request_payload_all) begin
                            if (tmp_when_5) begin
                                tmp_manager_request_payload_address[8 : 4] <= (manager_request_payload_address[8 : 4] + 5'h01); // @ DCache.scala l358
                            end
                        end
                    end
                    DataCacheCpuCmdKind_FLUSH: begin
                        if (manager_request_payload_all) begin
                            if (tmp_when_6) begin
                                if (tmp_when_7) begin
                                    tmp_manager_request_payload_address[8 : 4] <= (manager_request_payload_address[8 : 4] + 5'h01); // @ DCache.scala l386
                                    manager_flushAllDone <= (manager_request_payload_address[8 : 4] == 5'h1f); // @ DCache.scala l387
                                    manager_flushAllState <= 1'b1;  // @ DCache.scala l388
                                end
                            end else begin
                                manager_flushAllState <= 1'b0;  // @ DCache.scala l393
                            end
                        end
                    end
                    default: begin
                    end
                endcase
            end
            if (manager_cpuRspIn_ready) begin
                manager_cpuRspIn_rValid <= manager_cpuRspIn_valid;  // @ Stream.scala l365
            end
            if ((loader_valid && io_mem_cmd_ready)) begin
                loader_memCmdSent <= 1'b1;  // @ DCache.scala l492
            end
            loader_counter_value <= loader_counter_valueNext;  // @ Reg.scala l39
            if (loader_counter_willOverflow) begin
                loader_memCmdSent <= 1'b0;  // @ DCache.scala l510
            end
        end
    end


endmodule
