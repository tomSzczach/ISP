//-----------------------------------------------------
// Testbench for the 4-bit up-counter ---------------->
// Example from www.asic-world.com (with fixes)
//-----------------------------------------------------
#include "systemc.h"
#include "design.h"

int sc_main (int argc, char* argv[]) {
  sc_signal<bool>   rst_i;
  sc_signal<sc_uint<8> > led_o;
  int i = 0;
  // Create clock (period=10 ns  duty=0.5  delay=2 ns):
  sc_clock clk_i("clk_i",10,SC_NS,0.5,2,SC_NS,false);
  
  // Connect the DUT
  gray counter("COUNTER");
  counter.clk_i(clk_i);
  counter.rst_i(rst_i);
  counter.led_o(led_o);



  // Open VCD file
  sc_trace_file *wf = sc_create_vcd_trace_file("counter");
  // Dump the desired signals
  sc_trace(wf, clk_i, "clk_i");
  sc_trace(wf,rst_i, "rst_i");
  sc_trace(wf, led_o, "led_o");

  // Initialize all variables
  rst_i = SC_LOGIC_0;       // initial value of reset
  sc_start(4, SC_NS);
  
  rst_i = SC_LOGIC_1;
  sc_start(40, SC_NS);
  cout << "@" << sc_time_stamp() <<" Terminating simulation\n" << endl;
  sc_close_vcd_trace_file(wf);
  return 0;// Terminate simulation
}
