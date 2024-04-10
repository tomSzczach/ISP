// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Sat Mar 23 02:27:17 2024
// Host        : DESKTOP-ORJH6EE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top char_mem -prefix
//               char_mem_ char_mem_sim_netlist.v
// Design      : char_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "char_mem,blk_mem_gen_v8_4_7,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_7,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module char_mem
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [11:0]addra;
  wire clka;
  wire [7:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.326399 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "char_mem.mem" *) 
  (* C_INIT_FILE_NAME = "char_mem.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  char_mem_blk_mem_gen_v8_4_7 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 25184)
`pragma protect data_block
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
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
