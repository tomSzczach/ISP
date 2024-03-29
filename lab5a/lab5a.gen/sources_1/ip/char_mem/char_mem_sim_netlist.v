// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Sat Mar 23 02:27:17 2024
// Host        : DESKTOP-ORJH6EE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Tomasz/DATA/CODING/ISP/lab5a/lab5a.gen/sources_1/ip/char_mem/char_mem_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 25472)
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
