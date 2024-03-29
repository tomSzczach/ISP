// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Sat Mar 23 02:29:40 2024
// Host        : DESKTOP-ORJH6EE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Tomasz/DATA/CODING/ISP/lab5a/lab5a.gen/sources_1/ip/fifo_mem/fifo_mem_sim_netlist.v
// Design      : fifo_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fifo_mem,fifo_generator_v13_2_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_9,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module fifo_mem
   (clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 core_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME core_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [7:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [7:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;

  wire clk;
  wire [7:0]din;
  wire [7:0]dout;
  wire empty;
  wire full;
  wire rd_en;
  wire wr_en;
  wire NLW_U0_almost_empty_UNCONNECTED;
  wire NLW_U0_almost_full_UNCONNECTED;
  wire NLW_U0_axi_ar_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_overflow_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_full_UNCONNECTED;
  wire NLW_U0_axi_ar_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_underflow_UNCONNECTED;
  wire NLW_U0_axi_aw_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_overflow_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_full_UNCONNECTED;
  wire NLW_U0_axi_aw_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_underflow_UNCONNECTED;
  wire NLW_U0_axi_b_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_overflow_UNCONNECTED;
  wire NLW_U0_axi_b_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_b_prog_full_UNCONNECTED;
  wire NLW_U0_axi_b_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_underflow_UNCONNECTED;
  wire NLW_U0_axi_r_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_overflow_UNCONNECTED;
  wire NLW_U0_axi_r_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_r_prog_full_UNCONNECTED;
  wire NLW_U0_axi_r_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_underflow_UNCONNECTED;
  wire NLW_U0_axi_w_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_overflow_UNCONNECTED;
  wire NLW_U0_axi_w_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_w_prog_full_UNCONNECTED;
  wire NLW_U0_axi_w_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_underflow_UNCONNECTED;
  wire NLW_U0_axis_dbiterr_UNCONNECTED;
  wire NLW_U0_axis_overflow_UNCONNECTED;
  wire NLW_U0_axis_prog_empty_UNCONNECTED;
  wire NLW_U0_axis_prog_full_UNCONNECTED;
  wire NLW_U0_axis_sbiterr_UNCONNECTED;
  wire NLW_U0_axis_underflow_UNCONNECTED;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_m_axi_arvalid_UNCONNECTED;
  wire NLW_U0_m_axi_awvalid_UNCONNECTED;
  wire NLW_U0_m_axi_bready_UNCONNECTED;
  wire NLW_U0_m_axi_rready_UNCONNECTED;
  wire NLW_U0_m_axi_wlast_UNCONNECTED;
  wire NLW_U0_m_axi_wvalid_UNCONNECTED;
  wire NLW_U0_m_axis_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_tvalid_UNCONNECTED;
  wire NLW_U0_overflow_UNCONNECTED;
  wire NLW_U0_prog_empty_UNCONNECTED;
  wire NLW_U0_prog_full_UNCONNECTED;
  wire NLW_U0_rd_rst_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_s_axis_tready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire NLW_U0_underflow_UNCONNECTED;
  wire NLW_U0_valid_UNCONNECTED;
  wire NLW_U0_wr_ack_UNCONNECTED;
  wire NLW_U0_wr_rst_busy_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_wr_data_count_UNCONNECTED;
  wire [5:0]NLW_U0_data_count_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awuser_UNCONNECTED;
  wire [63:0]NLW_U0_m_axi_wdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wuser_UNCONNECTED;
  wire [7:0]NLW_U0_m_axis_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tid_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tstrb_UNCONNECTED;
  wire [3:0]NLW_U0_m_axis_tuser_UNCONNECTED;
  wire [5:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [5:0]NLW_U0_wr_data_count_UNCONNECTED;

  (* C_ADD_NGC_CONSTRAINT = "0" *) 
  (* C_APPLICATION_TYPE_AXIS = "0" *) 
  (* C_APPLICATION_TYPE_RACH = "0" *) 
  (* C_APPLICATION_TYPE_RDCH = "0" *) 
  (* C_APPLICATION_TYPE_WACH = "0" *) 
  (* C_APPLICATION_TYPE_WDCH = "0" *) 
  (* C_APPLICATION_TYPE_WRCH = "0" *) 
  (* C_AXIS_TDATA_WIDTH = "8" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TKEEP_WIDTH = "1" *) 
  (* C_AXIS_TSTRB_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "4" *) 
  (* C_AXIS_TYPE = "0" *) 
  (* C_AXI_ADDR_WIDTH = "32" *) 
  (* C_AXI_ARUSER_WIDTH = "1" *) 
  (* C_AXI_AWUSER_WIDTH = "1" *) 
  (* C_AXI_BUSER_WIDTH = "1" *) 
  (* C_AXI_DATA_WIDTH = "64" *) 
  (* C_AXI_ID_WIDTH = "1" *) 
  (* C_AXI_LEN_WIDTH = "8" *) 
  (* C_AXI_LOCK_WIDTH = "1" *) 
  (* C_AXI_RUSER_WIDTH = "1" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_AXI_WUSER_WIDTH = "1" *) 
  (* C_COMMON_CLOCK = "1" *) 
  (* C_COUNT_TYPE = "0" *) 
  (* C_DATA_COUNT_WIDTH = "6" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "8" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "8" *) 
  (* C_ENABLE_RLOCS = "0" *) 
  (* C_ENABLE_RST_SYNC = "1" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_ERROR_INJECTION_TYPE = "0" *) 
  (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_FULL_FLAGS_RST_VAL = "0" *) 
  (* C_HAS_ALMOST_EMPTY = "0" *) 
  (* C_HAS_ALMOST_FULL = "0" *) 
  (* C_HAS_AXIS_TDATA = "1" *) 
  (* C_HAS_AXIS_TDEST = "0" *) 
  (* C_HAS_AXIS_TID = "0" *) 
  (* C_HAS_AXIS_TKEEP = "0" *) 
  (* C_HAS_AXIS_TLAST = "0" *) 
  (* C_HAS_AXIS_TREADY = "1" *) 
  (* C_HAS_AXIS_TSTRB = "0" *) 
  (* C_HAS_AXIS_TUSER = "1" *) 
  (* C_HAS_AXI_ARUSER = "0" *) 
  (* C_HAS_AXI_AWUSER = "0" *) 
  (* C_HAS_AXI_BUSER = "0" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_AXI_RD_CHANNEL = "1" *) 
  (* C_HAS_AXI_RUSER = "0" *) 
  (* C_HAS_AXI_WR_CHANNEL = "1" *) 
  (* C_HAS_AXI_WUSER = "0" *) 
  (* C_HAS_BACKUP = "0" *) 
  (* C_HAS_DATA_COUNT = "0" *) 
  (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
  (* C_HAS_DATA_COUNTS_RACH = "0" *) 
  (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WACH = "0" *) 
  (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
  (* C_HAS_INT_CLK = "0" *) 
  (* C_HAS_MASTER_CE = "0" *) 
  (* C_HAS_MEMINIT_FILE = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
  (* C_HAS_PROG_FLAGS_RACH = "0" *) 
  (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WACH = "0" *) 
  (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
  (* C_HAS_RD_DATA_COUNT = "0" *) 
  (* C_HAS_RD_RST = "0" *) 
  (* C_HAS_RST = "0" *) 
  (* C_HAS_SLAVE_CE = "0" *) 
  (* C_HAS_SRST = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_HAS_VALID = "0" *) 
  (* C_HAS_WR_ACK = "0" *) 
  (* C_HAS_WR_DATA_COUNT = "0" *) 
  (* C_HAS_WR_RST = "0" *) 
  (* C_IMPLEMENTATION_TYPE = "0" *) 
  (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
  (* C_INIT_WR_PNTR_VAL = "0" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_MEMORY_TYPE = "1" *) 
  (* C_MIF_FILE_NAME = "BlankString" *) 
  (* C_MSGON_VAL = "1" *) 
  (* C_OPTIMIZATION_MODE = "0" *) 
  (* C_OVERFLOW_LOW = "0" *) 
  (* C_POWER_SAVING_MODE = "0" *) 
  (* C_PRELOAD_LATENCY = "1" *) 
  (* C_PRELOAD_REGS = "0" *) 
  (* C_PRIM_FIFO_TYPE = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) 
  (* C_PROG_EMPTY_TYPE = "0" *) 
  (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
  (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "62" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "61" *) 
  (* C_PROG_FULL_TYPE = "0" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "6" *) 
  (* C_RD_DEPTH = "64" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "6" *) 
  (* C_REG_SLICE_MODE_AXIS = "0" *) 
  (* C_REG_SLICE_MODE_RACH = "0" *) 
  (* C_REG_SLICE_MODE_RDCH = "0" *) 
  (* C_REG_SLICE_MODE_WACH = "0" *) 
  (* C_REG_SLICE_MODE_WDCH = "0" *) 
  (* C_REG_SLICE_MODE_WRCH = "0" *) 
  (* C_SELECT_XPM = "0" *) 
  (* C_SYNCHRONIZER_STAGE = "2" *) 
  (* C_UNDERFLOW_LOW = "0" *) 
  (* C_USE_COMMON_OVERFLOW = "0" *) 
  (* C_USE_COMMON_UNDERFLOW = "0" *) 
  (* C_USE_DEFAULT_SETTINGS = "0" *) 
  (* C_USE_DOUT_RST = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_ECC_AXIS = "0" *) 
  (* C_USE_ECC_RACH = "0" *) 
  (* C_USE_ECC_RDCH = "0" *) 
  (* C_USE_ECC_WACH = "0" *) 
  (* C_USE_ECC_WDCH = "0" *) 
  (* C_USE_ECC_WRCH = "0" *) 
  (* C_USE_EMBEDDED_REG = "0" *) 
  (* C_USE_FIFO16_FLAGS = "0" *) 
  (* C_USE_FWFT_DATA_COUNT = "0" *) 
  (* C_USE_PIPELINE_REG = "0" *) 
  (* C_VALID_LOW = "0" *) 
  (* C_WACH_TYPE = "0" *) 
  (* C_WDCH_TYPE = "0" *) 
  (* C_WRCH_TYPE = "0" *) 
  (* C_WR_ACK_LOW = "0" *) 
  (* C_WR_DATA_COUNT_WIDTH = "6" *) 
  (* C_WR_DEPTH = "64" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "6" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  (* is_du_within_envelope = "true" *) 
  fifo_mem_fifo_generator_v13_2_9 U0
       (.almost_empty(NLW_U0_almost_empty_UNCONNECTED),
        .almost_full(NLW_U0_almost_full_UNCONNECTED),
        .axi_ar_data_count(NLW_U0_axi_ar_data_count_UNCONNECTED[4:0]),
        .axi_ar_dbiterr(NLW_U0_axi_ar_dbiterr_UNCONNECTED),
        .axi_ar_injectdbiterr(1'b0),
        .axi_ar_injectsbiterr(1'b0),
        .axi_ar_overflow(NLW_U0_axi_ar_overflow_UNCONNECTED),
        .axi_ar_prog_empty(NLW_U0_axi_ar_prog_empty_UNCONNECTED),
        .axi_ar_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_prog_full(NLW_U0_axi_ar_prog_full_UNCONNECTED),
        .axi_ar_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_rd_data_count(NLW_U0_axi_ar_rd_data_count_UNCONNECTED[4:0]),
        .axi_ar_sbiterr(NLW_U0_axi_ar_sbiterr_UNCONNECTED),
        .axi_ar_underflow(NLW_U0_axi_ar_underflow_UNCONNECTED),
        .axi_ar_wr_data_count(NLW_U0_axi_ar_wr_data_count_UNCONNECTED[4:0]),
        .axi_aw_data_count(NLW_U0_axi_aw_data_count_UNCONNECTED[4:0]),
        .axi_aw_dbiterr(NLW_U0_axi_aw_dbiterr_UNCONNECTED),
        .axi_aw_injectdbiterr(1'b0),
        .axi_aw_injectsbiterr(1'b0),
        .axi_aw_overflow(NLW_U0_axi_aw_overflow_UNCONNECTED),
        .axi_aw_prog_empty(NLW_U0_axi_aw_prog_empty_UNCONNECTED),
        .axi_aw_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_prog_full(NLW_U0_axi_aw_prog_full_UNCONNECTED),
        .axi_aw_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_rd_data_count(NLW_U0_axi_aw_rd_data_count_UNCONNECTED[4:0]),
        .axi_aw_sbiterr(NLW_U0_axi_aw_sbiterr_UNCONNECTED),
        .axi_aw_underflow(NLW_U0_axi_aw_underflow_UNCONNECTED),
        .axi_aw_wr_data_count(NLW_U0_axi_aw_wr_data_count_UNCONNECTED[4:0]),
        .axi_b_data_count(NLW_U0_axi_b_data_count_UNCONNECTED[4:0]),
        .axi_b_dbiterr(NLW_U0_axi_b_dbiterr_UNCONNECTED),
        .axi_b_injectdbiterr(1'b0),
        .axi_b_injectsbiterr(1'b0),
        .axi_b_overflow(NLW_U0_axi_b_overflow_UNCONNECTED),
        .axi_b_prog_empty(NLW_U0_axi_b_prog_empty_UNCONNECTED),
        .axi_b_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_prog_full(NLW_U0_axi_b_prog_full_UNCONNECTED),
        .axi_b_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_rd_data_count(NLW_U0_axi_b_rd_data_count_UNCONNECTED[4:0]),
        .axi_b_sbiterr(NLW_U0_axi_b_sbiterr_UNCONNECTED),
        .axi_b_underflow(NLW_U0_axi_b_underflow_UNCONNECTED),
        .axi_b_wr_data_count(NLW_U0_axi_b_wr_data_count_UNCONNECTED[4:0]),
        .axi_r_data_count(NLW_U0_axi_r_data_count_UNCONNECTED[10:0]),
        .axi_r_dbiterr(NLW_U0_axi_r_dbiterr_UNCONNECTED),
        .axi_r_injectdbiterr(1'b0),
        .axi_r_injectsbiterr(1'b0),
        .axi_r_overflow(NLW_U0_axi_r_overflow_UNCONNECTED),
        .axi_r_prog_empty(NLW_U0_axi_r_prog_empty_UNCONNECTED),
        .axi_r_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_prog_full(NLW_U0_axi_r_prog_full_UNCONNECTED),
        .axi_r_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_rd_data_count(NLW_U0_axi_r_rd_data_count_UNCONNECTED[10:0]),
        .axi_r_sbiterr(NLW_U0_axi_r_sbiterr_UNCONNECTED),
        .axi_r_underflow(NLW_U0_axi_r_underflow_UNCONNECTED),
        .axi_r_wr_data_count(NLW_U0_axi_r_wr_data_count_UNCONNECTED[10:0]),
        .axi_w_data_count(NLW_U0_axi_w_data_count_UNCONNECTED[10:0]),
        .axi_w_dbiterr(NLW_U0_axi_w_dbiterr_UNCONNECTED),
        .axi_w_injectdbiterr(1'b0),
        .axi_w_injectsbiterr(1'b0),
        .axi_w_overflow(NLW_U0_axi_w_overflow_UNCONNECTED),
        .axi_w_prog_empty(NLW_U0_axi_w_prog_empty_UNCONNECTED),
        .axi_w_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_prog_full(NLW_U0_axi_w_prog_full_UNCONNECTED),
        .axi_w_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_rd_data_count(NLW_U0_axi_w_rd_data_count_UNCONNECTED[10:0]),
        .axi_w_sbiterr(NLW_U0_axi_w_sbiterr_UNCONNECTED),
        .axi_w_underflow(NLW_U0_axi_w_underflow_UNCONNECTED),
        .axi_w_wr_data_count(NLW_U0_axi_w_wr_data_count_UNCONNECTED[10:0]),
        .axis_data_count(NLW_U0_axis_data_count_UNCONNECTED[10:0]),
        .axis_dbiterr(NLW_U0_axis_dbiterr_UNCONNECTED),
        .axis_injectdbiterr(1'b0),
        .axis_injectsbiterr(1'b0),
        .axis_overflow(NLW_U0_axis_overflow_UNCONNECTED),
        .axis_prog_empty(NLW_U0_axis_prog_empty_UNCONNECTED),
        .axis_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_prog_full(NLW_U0_axis_prog_full_UNCONNECTED),
        .axis_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_rd_data_count(NLW_U0_axis_rd_data_count_UNCONNECTED[10:0]),
        .axis_sbiterr(NLW_U0_axis_sbiterr_UNCONNECTED),
        .axis_underflow(NLW_U0_axis_underflow_UNCONNECTED),
        .axis_wr_data_count(NLW_U0_axis_wr_data_count_UNCONNECTED[10:0]),
        .backup(1'b0),
        .backup_marker(1'b0),
        .clk(clk),
        .data_count(NLW_U0_data_count_UNCONNECTED[5:0]),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .int_clk(1'b0),
        .m_aclk(1'b0),
        .m_aclk_en(1'b0),
        .m_axi_araddr(NLW_U0_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_U0_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_U0_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_U0_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_U0_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_U0_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_U0_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_U0_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(1'b0),
        .m_axi_arregion(NLW_U0_m_axi_arregion_UNCONNECTED[3:0]),
        .m_axi_arsize(NLW_U0_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_U0_m_axi_aruser_UNCONNECTED[0]),
        .m_axi_arvalid(NLW_U0_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_U0_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_U0_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_U0_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_U0_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_U0_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_U0_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_U0_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_U0_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awregion(NLW_U0_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_U0_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_U0_m_axi_awuser_UNCONNECTED[0]),
        .m_axi_awvalid(NLW_U0_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(1'b0),
        .m_axi_bready(NLW_U0_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_buser(1'b0),
        .m_axi_bvalid(1'b0),
        .m_axi_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_rid(1'b0),
        .m_axi_rlast(1'b0),
        .m_axi_rready(NLW_U0_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({1'b0,1'b0}),
        .m_axi_ruser(1'b0),
        .m_axi_rvalid(1'b0),
        .m_axi_wdata(NLW_U0_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wid(NLW_U0_m_axi_wid_UNCONNECTED[0]),
        .m_axi_wlast(NLW_U0_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_U0_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wuser(NLW_U0_m_axi_wuser_UNCONNECTED[0]),
        .m_axi_wvalid(NLW_U0_m_axi_wvalid_UNCONNECTED),
        .m_axis_tdata(NLW_U0_m_axis_tdata_UNCONNECTED[7:0]),
        .m_axis_tdest(NLW_U0_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_U0_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_U0_m_axis_tkeep_UNCONNECTED[0]),
        .m_axis_tlast(NLW_U0_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(1'b0),
        .m_axis_tstrb(NLW_U0_m_axis_tstrb_UNCONNECTED[0]),
        .m_axis_tuser(NLW_U0_m_axis_tuser_UNCONNECTED[3:0]),
        .m_axis_tvalid(NLW_U0_m_axis_tvalid_UNCONNECTED),
        .overflow(NLW_U0_overflow_UNCONNECTED),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(1'b0),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[5:0]),
        .rd_en(rd_en),
        .rd_rst(1'b0),
        .rd_rst_busy(NLW_U0_rd_rst_busy_UNCONNECTED),
        .rst(1'b0),
        .s_aclk(1'b0),
        .s_aclk_en(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arid(1'b0),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_aruser(1'b0),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awuser(1'b0),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_buser(NLW_U0_s_axi_buser_UNCONNECTED[0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_ruser(NLW_U0_s_axi_ruser_UNCONNECTED[0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wid(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wuser(1'b0),
        .s_axi_wvalid(1'b0),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(1'b0),
        .s_axis_tlast(1'b0),
        .s_axis_tready(NLW_U0_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb(1'b0),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .srst(1'b0),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(NLW_U0_valid_UNCONNECTED),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(1'b0),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[5:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jLV29U0rrfMIZhYJzdoUrPoqB9eHQ5NXmWyCdqnN3Wgm+GU4C3zthrN1m4QGiaj0thPCIynZbX+0
7yjtkv+T5ByJ6NhiofAwWseGLvPXlYu6ERAPvi4SAYpF2VUqQHtPAbPmnPubGdDRgIEpeobF7hsz
rEcpEru1pyiScUriyuo=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vsoizVrOONWw/DhjRLEYrtRmtji+Ok63CbpSg/l9VnoKAi8tAzqRbQ57atGB2N6IGGbKHkbK2Uzh
EHgWvYZeyt4hE+bpQX91vc9PNxfjQMGzPoFD3jCWk30EmEk+AND39eWx+DhJ8xhFuucoOQ2GwyAk
B+Mjs15naPE7DvlHel8hnD4dfSdYhGKp96oozu8JeBto8aHG6poOuYkxSwaut7NCI+mabCkMxtMp
RrydgmRuTvhRTbJMyx5CxFSZTRDrS5aU1vaRlnMiqKCI7g2KY9pemYaJsFeVodBuo6IyKGynyEhs
wr+VtUhQDtaVhMkwB95WwmMoDk9F2L5Au1I+TQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
W081dPMCWhKs5YlQD7n3zvf7+PTcnb8eFWxoVs8+zHLkxDMA1klITbsfztGYvJFce8Yao5XQLLqZ
oUE5Pq2arq+zwICFUcLjdMsmP1WmL82znHOPHm83zNwrxWMloHkySAqzFbgJeHa973uZqj0M8ydc
sYmzCYVlGVjt0QX0xqA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Zpc3MmdLWaVOv+S4z2POuoyslYoAbWc+Npxq2UyQRtDwf566IId3uwAetolMAgfLo/G3ezuSOXMn
8NznS37h9XvmVrxA50SAux68P87WgkLtiUYqM3CMBKkxNlZ/TR8WzTuQyFdvzkOE9lp8HC7LXnk5
RDsnOM+su46FW7ysY01COslo9Xc7rhs6WFqx29+Xcqk8+ZMLSzaJfuwZdNmJFS3Q1vhlq3ZeYqMl
wMieB731KsPxjxp7VKNHpTbgFryC2isqc4ohBDOt52M/Bz4B/rIpFeHfZ7X3jWSiKtSuBsDN2NXf
EMjfAT248dlK7NxJ+NBNPhS5sLxTiGyQhta57A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rPMYqnkKhJKV1wltOfDrKos9ZbucaoX3WGTuqsdLkGpcKObzslHBwlGrKtWV7bZYmS2SM+QuEMfa
CE+tCUdsSiprp+n5BuSQlJa6BJ8mlqccjoo/JLw2QEmUhyMXQ3TLGomGGoZdeTmMPXhUBAOyLPea
Ddc8mgtTN8Kpy117GOTXDKP+IKJqW01fLrPJpgEhFiJCbyElLgtCRWmI94gX+y4XNVS0Cd1YwNw6
4nHgnEdC7fXARDKcYO3VsWC/pdzPQgursXloNLrVYa6i2xr+8E1V0+nSWwNYQZP7XUIVqXKMU8Ea
bT4acXrRCF/5tJJ5B9JparYI0zxXSbaakn1dIw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mfroTgL8g2pyIXQ/mGO9YHm19cd5mOlJ++qpusOYeVxGmkIhvF4aKx+AyIUz2yGGAeCtOzIasHty
pyqKgZhibSqxcpHgR0m6GOxXXOXJiHaK8NzxUzXeRJovcBI/WjtDhXeb1LRMI1J97jVBtJPJQH0Y
fGOD7jWvkvQwxnrZdyLp6kPWgSIcavHHDbO7iJv4gnyGp6W3/FCDo2RKWNLoW+SNjSdLZ6YRP8a+
ldaGU8TYvJ03KWlmik7repuN6AwxCjg2KeQ+x1sBAEXzROXomuSbvX3ZAo8UiIKAQY1SJumHLG3L
QI/S4Wbl1Hz6LDTsttMwP480gq6+tb6s1E4oWw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QJIabgm8dx/gVHbOQFwt8maOKVHFgkpZTPR6dzD8fqoGo9M9oGPTqBqchtPZWgv2UYFF2KEUSlV4
L3SDXBKrLs+NsAVTcICaEMiEi6j82zj/C1LsPkQfS8RLrg0ab8lbDMb5YqJ7lkHs3iM65x2iN1Mf
66cTgCbkAdl3rDpab75btpTQt5ZKiq5CSY3RZfyIW0uWbTGTELm6liuRKM9+K8BQwTU7A+FFFQBA
/9eJwQYzNNA/iwoYJ2WTPd6pBlzXriNLu9M+/2bYicNBSuH1PBR9v2ESrTB6k7EiV1zvBXV9NuG/
sFt4MumWMuSNwP2W38bQATxxW/l0IrmaXGOC/w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
lhKf/Vgj6pHpme1ji4HVe36BU8pMkam/2I9lFeyOiBnIbzgdEGfLJBcEvkL33A7s0hxa6LFbHnkT
upgMpPjmIghBz3xUQ13vpiY152thFec6qvlcdg1r+GTmnBOSFl6g/OfZ3eFUhfsve6ZjQHpXnKFo
a55hN2+eP1EG9+VxGeM7XkHaeFhEIry52qtnmg072KEFIwRiGs2d/TJ4AqupuIdIiP1kTN9k+oqa
2ta1vdtqPY0dDHqrf+5YSd0CejkhQeCqg/bauLP3755SwdOPRgooG5ANT8hUpTiFMFXtU+GC9NSp
evJtMHUy1NbgMmhFHO+w3URLEdjSaBxZPD7YLdWkF65jY526tJzoek+BzEKoBaGfCaY7O1nHKXm+
89k3rPUy0Xo4/0nHpno+N/Db09heJPbnGsCwN/l+KnR6Lz8kvWziBjZe0ijOkKI+T12y3T1VeOtY
H/aqtNlQt1mhFwrbw6ezaAiDPVbCQXnly6b4tbb8+nFsxWOGIGAfLozB

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PNsQ8uEcQYrl+GaDuBaq1tQ5br5aAdaqHnyrc0NVu/JnQUk53jaiLx8Oz5fNACvWelUUk2/C+P5I
b2rbU1bb/dC6TqC5J1N0yoMYRYw58u4Lrl8Kgqgt9Rlph5Qgzzfxp+oblXF/pO4mRyAXpZhpNkFT
0Ar9BUtPOTOtJ9/g53SRnZ6GjxzfeD+25J4fcXBNo2gCTgUkwiLSsJRwTB/cJmn+dZPwPdIOHEP9
TkfDK+OrbLYO3T+DFBTCMRNH2NB1J9sc5s+nPU8iYnjgPTo6HoGW+LIlCz6yNJMZzJzoeW708utc
0fJXkT7vLDVh7olvy3V9AAY8Do0YR1kiZlhVhQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
zAz8RnGHFebkJFAS+gjC+mXHW7m7We+JgSmIz15mS01u/4+9Ng0sJfkeXOClmVPTQ2Mp2Yuv6/6f
ehzUTcANilWsqLM6Q1FToCPNX/NTqodlcHirGM7b5R9yevouNT/aqH12nmbunBQmBHmehNutdCjG
r6Z7kZgeZ2ZE7MMOF0rTy1XHEPkqgMNTRoS8R/pPWPTW4/j+bn3aJj0Q/fTz4Gi3mbSUKWs2fREQ
UKiuolNJkN6DiDvhlVYHUyytXNJG44ikmBXehoQQRLapkYaxnQmMRT1ok9uY6pKoy71CtvJ3Mt2x
EQv1GU2i4qQyAOwa0mkEohWXduicU6tDz3zQwQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TK3eE9V+v1z2P1KjG4GrjhA1n3qDOpNzLGXdtjnjhF0QBFPSuhC+nmNqTPOb3p2a9r5KD0miY3Cd
+KpjH6Ao09E2/LD2Go4aLQh6vP+9BldlSKEwCGfx2NjBQrXWVH21lQR7IRjOvyTOclpd7SgtUJLw
dvebETyLiKr9C6RfnIBeptuCA3iJlXfwkh6I0JfzD5WBizQkotioZmmrXv5105pCXQ4Ta1WThFsA
2ll9dZeSjEDHUxxhfyfjryv9m4VL89ZDU/rGITsdptwB1BC1jLqmPDymY05lyECnjA6NIR5GGfI4
K2y2f4GfikKoN5r9IOvFzw963Wm82ZZPtXOKGg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 76272)
`pragma protect data_block
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
15RLoWuu
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
