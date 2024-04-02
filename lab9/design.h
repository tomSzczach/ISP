#include "systemc.h"

SC_MODULE (gray) {
// Input and output signals:
  sc_in<bool > clock;
  sc_in<bool> reset;
  sc_out<sc_uint<3> > led_o;

  //------------Local Variables Here---------------------
  //sc_uint<3>	d;
  sc_uint<3>	q;

  //------------Code Starts Here-------------------------
  // Below function implements actual counter logic
  void gray_process () {
    // At every rising edge of clock we check if reset is active    
    if (reset.read() == 1) {
		q = 0;    
    }  
    else if (clock.posedge()) {
		q = q + 1; // Increment the counter value
    }	
	//gray = liczba ^ (liczba >> 1)
    //000, 001, 011, 010, 110, 111, 101, 100
    led_o.write(q ^ (q >> 1)); // Gray code encoding
  }

  // Constructor for the counter
  // Since this counter is a positive edge trigged one,
  // We trigger the below block with respect to positive
  // edge of the clock and also when ever reset changes state
  SC_CTOR(gray) {
	led_o.initialize(0);
    cout<<"Executing new"<<endl;
    SC_METHOD(gray_process);
    sensitive << reset.pos();
    sensitive << clock.pos();
  } // End of Constructor

}; // End of Module 
