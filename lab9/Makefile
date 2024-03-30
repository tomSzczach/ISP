# Simple Makefile
TARGET = johnson
SYSTEMC = /usr/local/systemc-2.2
INCDIR = -I. -I/usr/local/systemc-2.2/include
LIBDIR = -L. -L/usr/local/systemc-2.2/lib-cygwin
LIBS   = -lsystemc -lm

CC     = g++
CFLAGS = -g -Wno-deprecated -Wall -std=c++98 -O0 -fpermissive

OBJS   = testbench.o

EXE    = $(TARGET)

all: $(EXE)

$(EXE): $(OBJS)  
	$(CC) $(CFLAGS) $(INCDIR) $(LIBDIR) -o $@ $(OBJS) $(LIBS) 2>&1

testbench.o:	testbench.cpp design.h
	$(CC) $(CFLAGS) $(INCDIR) -c $<

clean:
	rm -f $(OBJS) $(EXE) *.vcd

