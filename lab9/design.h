#include "systemc.h"

SC_MODULE (gray) {
// Input and output signals:
  sc_in<bool > clk_i;
  sc_in<sc_logic > rst_i;
  sc_out<sc_uint<3> > led_o;

  //------------Local Variables Here---------------------
  sc_uint<3>	gray_encoder;
  int q = 0;

  //------------Code Starts Here-------------------------
  // Below function implements actual counter logic
  void gray_process () {
    // At every rising edge of clock we check if reset is active    
    if (rst_i.read() == 1) {
      count =  0;
      count2 =  0;
      led_o.write(0);    
    }     
    else {
		q++;
		gray_encoder[2] = (q >> 2) & 1;
		gray_encoder[1] = ((q >> 1) ^ (q >> 2)) & 1;
		gray_encoder[0] = (q ^ (q >> 1)) & 1;		
	}
	led_o.write(gray_encoder);
  }

  // Constructor for the counter
  // Since this counter is a positive edge trigged one,
  // We trigger the below block with respect to positive
  // edge of the clock and also when ever reset changes state
  SC_CTOR(gray) {
	led_o.initialize(0);
	q=0;
    cout<<"Executing new"<<endl;
    SC_METHOD(gray_process);
    sensitive << rst_i.pos();
    sensitive << clock.pos();
  } // End of Constructor

}; // End of Module 
