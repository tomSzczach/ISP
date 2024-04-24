#define TESTAPP_GEN

/******************************************************************************
*
* Copyright (C) 2002 - 2018 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
* @file  xtmrctr_intr_example.c
*
* This file contains a design example using the timer counter driver
* (XTmCtr) and hardware device using interrupt mode.This example assumes
* that the interrupt controller is also present as a part of the system
*
* This file can be used as a standalone example or by the TestAppGen utility
* to include a test for Timer interrupts.
*
*
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date	 Changes
* ----- ---- -------- -----------------------------------------------
* 1.00b jhl  02/13/02 First release
* 1.00b sv   04/26/05 Minor changes to comply to Doxygen and coding guidelines
* 1.00b sn   05/09/06 Modified to be used by TestAppGen to include test for
*		      interrupts.
* 2.00a ktn  10/30/09 Updated to use HAL API's and minor changes as per coding
*		      guidelines.
* 2.00a ssb  01/11/01 Updated the example to be used with the SCUGIC in
*		      Zynq.
* 4.2   ms   01/23/17 Added xil_printf statement in main function to
*                     ensure that "Successfully ran" and "Failed" strings
*                     are available in all examples. This is a fix for
*                     CR-965028.
* 4.5   mus  07/05/18 Updated example to call TmrCtrDisableIntr function
*                     with correct arguments. Presently device id is
*                     being passed instead of interrupt id. It fixes
*                     CR#1006251.
* 4.5   mus  07/05/18 Fixed checkpatch errors and warnings.
*</pre>
******************************************************************************/

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xtmrctr.h"
#include "xil_exception.h"

#ifdef XPAR_INTC_0_DEVICE_ID
#include "xintc.h"
#include <stdio.h>
#include <math.h>
#include "xgpio.h"
#else
#include "xscugic.h"
#include "xil_printf.h"
#endif


/************************** Constant Definitions *****************************/
#ifndef TESTAPP_GEN
/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are only defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define TMRCTR_DEVICE_ID	XPAR_TMRCTR_0_DEVICE_ID
#define TMRCTR_INTERRUPT_ID	XPAR_INTC_0_TMRCTR_0_VEC_ID

#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_INTC_0_DEVICE_ID
#else
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#endif /* XPAR_INTC_0_DEVICE_ID */


/*
 * The following constant determines which timer counter of the device that is
 * used for this example, there are currently 2 timer counters in a device
 * and this example uses the first one, 0, the timer numbers are 0 based
 */
#define TIMER_CNTR_0	 0

#endif

#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC		XIntc
#define INTC_HANDLER	XIntc_InterruptHandler
#else
#define INTC		XScuGic
#define INTC_HANDLER	XScuGic_InterruptHandler
#endif /* XPAR_INTC_0_DEVICE_ID */


/*
 * The following constant is used to set the reset value of the timer counter,
 * making this number larger reduces the amount of time this example consumes
 * because it is the value the timer counter is loaded with when it is started
 */
#define RESET_VALUE	 0xFFFF0000 ///inne?????
//0xFFFF0000???

/***************** Macros (Inline Functions) Definitions *********************/
#define ERR 0
#define OK 1
#define SKIP 2
#define DL_WYSWIETLACZA 8
#define MAX_NUM 9999999
#define BASE10 10
#define sprawdz_dzialanie(x) (abs(x) > MAX_NUM)
#define printf xil_printf	/* A smaller footprint printf */
/**************************** Type Definitions *******************************/

int rejestr[4] = {0,0,0,0};
char wyswietlacz[DL_WYSWIETLACZA+1] = "00000000";
char pokaz[DL_WYSWIETLACZA+1] = "00000000";
int nr_cyfry = 0;
int pooper =0;
int anodes[DL_WYSWIETLACZA] = { 0x7f, 0xbf, 0xdf, 0xef, 0xf7, 0xfb, 0xfd, 0xfe };
XGpio GpioInput;  /* The driver instance for GPIO Device configured as I/P */
XGpio GpioOutput; /* The driver instance for GPIO Device configured as O/P */
XGpio GpioOutputLeds;

/************************** Function Prototypes ******************************/
int dodaj();
int odejmij();
int pomnoz();
int podziel();
void zamien();
void push();
void pop();
void przesun_rejestry();
void przygotuj_liczbe();
u32 ctol(char c);

int TmrCtrIntrExample(INTC *IntcInstancePtr,
			XTmrCtr *InstancePtr,
			u16 DeviceId,
			u16 IntrId,
			u8 TmrCtrNumber);

static int TmrCtrSetupIntrSystem(INTC *IntcInstancePtr,
				XTmrCtr *InstancePtr,
				u16 DeviceId,
				u16 IntrId,
				u8 TmrCtrNumber);

static void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber);

static void TmrCtrDisableIntr(INTC *IntcInstancePtr, u16 IntrId);

/************************** Variable Definitions *****************************/
#ifndef TESTAPP_GEN
INTC InterruptController;  /* The instance of the Interrupt Controller */

XTmrCtr TimerCounterInst;   /* The instance of the Timer Counter */
#endif
/*
 * The following variables are shared between non-interrupt processing and
 * interrupt processing such that they must be global.
 */
volatile int TimerExpired;


/*****************************************************************************/
/**
* This function is the main function of the Tmrctr example using Interrupts.
*
* @param	None.
*
* @return	XST_SUCCESS to indicate success, else XST_FAILURE to indicate a
*		Failure.
*
* @note		None.
*
******************************************************************************/
#ifndef TESTAPP_GEN
int main(void)
{

	int Status;

	/*
	 * Run the Timer Counter - Interrupt example.
	 */
	Status = TmrCtrIntrExample(&InterruptController,
				  &TimerCounterInst,
				  TMRCTR_DEVICE_ID,
				  TMRCTR_INTERRUPT_ID,
				  TIMER_CNTR_0);
	if (Status != XST_SUCCESS) {
		xil_printf("Tmrctr interrupt Example Failed\r\n");
		return XST_FAILURE;
	}

	xil_printf("Successfully ran Tmrctr interrupt Example\r\n");
	return XST_SUCCESS;

}
#endif

/*****************************************************************************/
/**
* This function does a minimal test on the timer counter device and driver as a
* design example.  The purpose of this function is to illustrate how to use the
* XTmrCtr component.  It initializes a timer counter and then sets it up in
* compare mode with auto reload such that a periodic interrupt is generated.
*
* This function uses interrupt driven mode of the timer counter.
*
* @param	IntcInstancePtr is a pointer to the Interrupt Controller
*		driver Instance
* @param	TmrCtrInstancePtr is a pointer to the XTmrCtr driver Instance
* @param	DeviceId is the XPAR_<TmrCtr_instance>_DEVICE_ID value from
*		xparameters.h
* @param	IntrId is XPAR_<INTC_instance>_<TmrCtr_instance>_INTERRUPT_INTR
*		value from xparameters.h
* @param	TmrCtrNumber is the number of the timer to which this
*		handler is associated with.
*
* @return	XST_SUCCESS if the Test is successful, otherwise XST_FAILURE
*
* @note		This function contains an infinite loop such that if interrupts
*		are not working it may never return.
*
*****************************************************************************/

int dodaj(){
	if(sprawdz_dzialanie(rejestr[0] + rejestr[1])){
		return ERR;
	}
	int tmp = rejestr[0] + rejestr[1];
	pop();
	rejestr[0]=tmp;
	//push();
	//rejestr[0]=0;
	return OK;
}
int odejmij(){
	if(sprawdz_dzialanie(rejestr[1] - rejestr[0])){
		return ERR;
	}
	int tmp = rejestr[1] - rejestr[0];
	pop();
	rejestr[0]=tmp;
	//push();
	//rejestr[0]=0;
	return OK;
}
int pomnoz(){
	if(sprawdz_dzialanie(rejestr[0] * rejestr[1])){
		return ERR;
	}
	int tmp = rejestr[0] * rejestr[1];
	pop();
	rejestr[0]=tmp;
	//push();
	//rejestr[0]=0;
	return OK;
}
int podziel(){
	//sprawdz dzielenie
	if(rejestr[0] == 0){
		return ERR;
	}
	int tmp = rejestr[1] / rejestr[0];
	pop();
	rejestr[0]=tmp;
	//push();
	//rejestr[0]=0;
	return OK;
}
void zamien(){
	int tmp = rejestr[0];
	rejestr[0] = rejestr[1];
	rejestr[1] = tmp;
}
void push(){
	rejestr[3] = rejestr[2];
	rejestr[2] = rejestr[1];
	rejestr[1] = rejestr[0];
}
void pop(){
	rejestr[0] = rejestr[1];
	rejestr[1] = rejestr[2];
	rejestr[2] = rejestr[3];
	rejestr[3] = 0;
}
void przesun_rejestry(){
	int tmp = rejestr[0];
	rejestr[0] = rejestr[1];
	rejestr[1] = rejestr[2];
	rejestr[2] = rejestr[3];
	rejestr[3] = tmp;
}
void konwertuj(){
	int tmp = abs(rejestr[0]);
	for(int i = 7; i>= 0; i--){
		wyswietlacz[i] = '0'+ (tmp%10);
		tmp/=10;
	}
}
void przygotuj_liczbe(int stan){
	//"00000000"
	memset(wyswietlacz, '0', DL_WYSWIETLACZA-1);

	if(stan == ERR){
		strncpy(wyswietlacz, "000Error", DL_WYSWIETLACZA-1);
	}
	else{
		//int to string
		konwertuj();
		//itoa(abs(rejestr[0]), wyswietlacz+1, BASE10);
		//sprintf(wyswietlacz+1,"%07d",abs(rejestr[0]));
		//znak
		wyswietlacz[0] = ((rejestr[0] >= 0) ? '0' : '-' );

	}
	if(wyswietlacz[0] == '-'){
		pokaz[0] = '1';
	}
	else{
		pokaz[0] = '0';
	}

	int zacznijpokazywac=0;
	//wylacz zera ale pierwsze nie
	for(int i = 1; i < DL_WYSWIETLACZA; i++){
		if(wyswietlacz[i] != '0'  || i == DL_WYSWIETLACZA-1){
			zacznijpokazywac = 1;
		}
		if(!zacznijpokazywac){
			pokaz[i] = '0';
		}
		else{
			pokaz[i] = '1';
		}
	}
}

u32 ctol(char digit){
	//char to led
	switch(digit){
	case '0':
		return 0xC0;
	case '1':
		return 0xF9;
	case '2':
		return 0xA4;
	case '3':
		return 0xB0;
	case '4':
		return 0x99;
	case '5':
		return 0x92;
	case '6':
		return 0x82;
	case '7':
		return 0xF8;
	case '8':
		return 0x80;
	case '9':
		return 0x90;
	case 'E':
		return 0x89;
	case 'r':
		return 0xAF;
	case 'o':
		return 0xA3;
	case '-':
		return 0xBF;
	default:
		return 0xFF;
	}
}

int TmrCtrIntrExample(INTC *IntcInstancePtr,
			XTmrCtr *TmrCtrInstancePtr,
			u16 DeviceId,
			u16 IntrId,
			u8 TmrCtrNumber)
{
	int Status;
	int LastTimerExpired = 0;

	/*
	 * Initialize the timer counter so that it's ready to use,
	 * specify the device ID that is generated in xparameters.h
	 */
	Status = XTmrCtr_Initialize(TmrCtrInstancePtr, DeviceId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test to ensure that the hardware was built
	 * correctly, use the 1st timer in the device (0)
	 */
	Status = XTmrCtr_SelfTest(TmrCtrInstancePtr, TmrCtrNumber);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the timer counter to the interrupt subsystem such that
	 * interrupts can occur.  This function is application specific.
	 */
	Status = TmrCtrSetupIntrSystem(IntcInstancePtr,
					TmrCtrInstancePtr,
					DeviceId,
					IntrId,
					TmrCtrNumber);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the handler for the timer counter that will be called from the
	 * interrupt context when the timer expires, specify a pointer to the
	 * timer counter driver instance as the callback reference so the
	 * handler is able to access the instance data
	 */
	XTmrCtr_SetHandler(TmrCtrInstancePtr, TimerCounterHandler,
					   TmrCtrInstancePtr);

	/*
	 * Enable the interrupt of the timer counter so interrupts will occur
	 * and use auto reload mode such that the timer counter will reload
	 * itself automatically and continue repeatedly, without this option
	 * it would expire once only
	 */
	XTmrCtr_SetOptions(TmrCtrInstancePtr, TmrCtrNumber,
				XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION);

	/*
	 * Set a reset value for the timer counter such that it will expire
	 * eariler than letting it roll over from 0, the reset value is loaded
	 * into the timer counter when it is started
	 */
	XTmrCtr_SetResetValue(TmrCtrInstancePtr, TmrCtrNumber, RESET_VALUE);

	/*
	 * Start the timer counter such that it's incrementing by default,
	 * then wait for it to timeout a number of times
	 */
	XTmrCtr_Start(TmrCtrInstancePtr, TmrCtrNumber);

	XGpio_Initialize(&GpioOutput, XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_Initialize(&GpioOutputLeds, XPAR_AXI_GPIO_1_DEVICE_ID);


	/* Set the direction for all signals to be outputs */
	XGpio_SetDataDirection(&GpioOutput, 1, 0x0);
	XGpio_SetDataDirection(&GpioOutput, 2, 0x0);
	XGpio_SetDataDirection(&GpioOutputLeds, 1, 0x0);

	/* Set the GPIO outputs to low */
	XGpio_DiscreteWrite(&GpioOutput, 2, 0x0);
	XGpio_DiscreteWrite(&GpioOutput, 1, 0xff);
	XGpio_DiscreteWrite(&GpioOutputLeds, 1, 0xff);
	//B³¹d operacji (dzielenie przez 0, przekroczenie zakresu) powinien spowodowaæ wyœwietlenie napisu
	//Error  na wyœwietlaczu 7-segmentowym). Napis powinien znikn¹æ po naciœniêciu CLx czyli wys³aniu znaku [C]
	//– co powinno tak¿e wyzerowaæ rejestr X.
	char input;
	int stan = OK;
	while (1) {
		xil_printf("%s\n\r%s\n\r",wyswietlacz,pokaz);
		xil_printf("\n\rX: %d\n\rY: %d\n\rZ: %d\n\rT: %d\n\r",rejestr[0],rejestr[1],rejestr[2],rejestr[3]);
		input = inbyte();
		//xil_printf("%d\n",(int)input);
		if(input == '+' && stan != ERR){
			//dodawanie
			stan = dodaj();
			pooper=1;

		}
		else if(input == '-'&& stan != ERR){
			//odejmowanie
			stan = odejmij();
			pooper=1;
		}
		else if(input == '*'&& stan != ERR){
			//mnozenie
			stan = pomnoz();
			pooper=1;
		}
		else if(input == '/'&& stan != ERR){
			//dzielenie
			stan = podziel();
			pooper=1;
		}
		else if(input == 's' && stan != ERR){
			rejestr[0] = -rejestr[0];

		}
		else if(input == 13 && stan != ERR){
			//push X

			push();
			rejestr[0] = 0;


		}
		else if(input == 'c'){
			//kasuj X
			rejestr[0] = 0;
			stan = OK;
		}
		else if(input == 'x'&& stan != ERR){
			//zmien X na Y i Y na X
			zamien();

		}
		else if(input == 'r' && stan != ERR){
			//zawartoœæ rejestru X zostaje przes³ana do rejestru T
			przesun_rejestry();
		}
		else if(stan != ERR){
			if(pooper){
				push();
				rejestr[0] =0;
				pooper=0;
			}
			if((int)(input - '0') >=0 && (int)(input - '0') < 10){
				int sign = (rejestr[0] >= 0 ? 1 : -1);
				int tmp = abs(10 * rejestr[0])+(int)(input - '0');
				rejestr[0] = tmp*sign;
				//xil_printf("%d",(int)(input - '0'));
			}
			//
		}

		przygotuj_liczbe(stan);

	}

	TmrCtrDisableIntr(IntcInstancePtr, IntrId);
	return XST_SUCCESS;
}

/*****************************************************************************/
/**
* This function is the handler which performs processing for the timer counter.
* It is called from an interrupt context such that the amount of processing
* performed should be minimized.  It is called when the timer counter expires
* if interrupts are enabled.
*
* This handler provides an example of how to handle timer counter interrupts
* but is application specific.
*
* @param	CallBackRef is a pointer to the callback function
* @param	TmrCtrNumber is the number of the timer to which this
*		handler is associated with.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	XTmrCtr *InstancePtr = (XTmrCtr *)CallBackRef;

	/*
	 * Check if the timer counter has expired, checking is not necessary
	 * since that's the reason this function is executed, this just shows
	 * how the callback reference can be used as a pointer to the instance
	 * of the timer counter that expired, increment a shared variable so
	 * the main thread of execution can see the timer expired
	 */
	//if (XTmrCtr_IsExpired(InstancePtr, TmrCtrNumber)) {
	//	TimerExpired++;
	//	if (TimerExpired == 3) {
	//		XTmrCtr_SetOptions(InstancePtr, TmrCtrNumber, 0);
	//	}
	//}
	XGpio_DiscreteWrite(&GpioOutput, 2, anodes[nr_cyfry]);
	if(pokaz[nr_cyfry] == '1'){
		XGpio_DiscreteWrite(&GpioOutput, 1, ctol(wyswietlacz[nr_cyfry]));
	}
	if(pokaz[nr_cyfry] == '0'){
		XGpio_DiscreteWrite(&GpioOutput, 1, 0xFF);
	}
	int dioda[3] = {1,1,1};
	for(int i=0; i<3;i++){
		if(rejestr[i+1] == 0){
			dioda[i]=0;
		}
	}

	XGpio_DiscreteWrite(&GpioOutputLeds, 1, (4*dioda[2]+2*dioda[1]+dioda[0]) & 0xFFFF);

	nr_cyfry = (nr_cyfry+1)%DL_WYSWIETLACZA;
}

/*****************************************************************************/
/**
* This function setups the interrupt system such that interrupts can occur
* for the timer counter. This function is application specific since the actual
* system may or may not have an interrupt controller.  The timer counter could
* be directly connected to a processor without an interrupt controller.  The
* user should modify this function to fit the application.
*
* @param	IntcInstancePtr is a pointer to the Interrupt Controller
*		driver Instance.
* @param	TmrCtrInstancePtr is a pointer to the XTmrCtr driver Instance.
* @param	DeviceId is the XPAR_<TmrCtr_instance>_DEVICE_ID value from
*		xparameters.h.
* @param	IntrId is XPAR_<INTC_instance>_<TmrCtr_instance>_VEC_ID
*		value from xparameters.h.
* @param	TmrCtrNumber is the number of the timer to which this
*		handler is associated with.
*
* @return	XST_SUCCESS if the Test is successful, otherwise XST_FAILURE.
*
* @note		This function contains an infinite loop such that if interrupts
*		are not working it may never return.
*
******************************************************************************/
static int TmrCtrSetupIntrSystem(INTC *IntcInstancePtr,
				 XTmrCtr *TmrCtrInstancePtr,
				 u16 DeviceId,
				 u16 IntrId,
				 u8 TmrCtrNumber)
{
	 int Status;

#ifdef XPAR_INTC_0_DEVICE_ID
#ifndef TESTAPP_GEN
	/*
	 * Initialize the interrupt controller driver so that
	 * it's ready to use, specify the device ID that is generated in
	 * xparameters.h
	 */
	Status = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS)
		return XST_FAILURE;
#endif
	/*
	 * Connect a device driver handler that will be called when an interrupt
	 * for the device occurs, the device driver handler performs the
	 * specific interrupt processing for the device
	 */
	Status = XIntc_Connect(IntcInstancePtr, IntrId,
				(XInterruptHandler)XTmrCtr_InterruptHandler,
				(void *)TmrCtrInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

#ifndef TESTAPP_GEN
	/*
	 * Start the interrupt controller such that interrupts are enabled for
	 * all devices that cause interrupts, specific real mode so that
	 * the timer counter can cause interrupts thru the interrupt controller.
	 */
	Status = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
#endif

	/*
	 * Enable the interrupt for the timer counter
	 */
	XIntc_Enable(IntcInstancePtr, IntrId);

#else

#ifndef TESTAPP_GEN
	XScuGic_Config *IntcConfig;

	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
#endif /* TESTAPP_GEN */

	XScuGic_SetPriorityTriggerType(IntcInstancePtr, IntrId,
					0xA0, 0x3);

	/*
	 * Connect the interrupt handler that will be called when an
	 * interrupt occurs for the device.
	 */
	Status = XScuGic_Connect(IntcInstancePtr, IntrId,
				 (Xil_ExceptionHandler)XTmrCtr_InterruptHandler,
				 TmrCtrInstancePtr);
	if (Status != XST_SUCCESS) {
		return Status;
	}

	/*
	 * Enable the interrupt for the Timer device.
	 */
	XScuGic_Enable(IntcInstancePtr, IntrId);
#endif /* XPAR_INTC_0_DEVICE_ID */


#ifndef TESTAPP_GEN
	/*
	 * Initialize the exception table.
	 */
	Xil_ExceptionInit();

	/*
	 * Register the interrupt controller handler with the exception table.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
					(Xil_ExceptionHandler)
					INTC_HANDLER,
					IntcInstancePtr);

	/*
	 * Enable non-critical exceptions.
	 */
	Xil_ExceptionEnable();

#endif
	return XST_SUCCESS;
}


/******************************************************************************/
/**
*
* This function disables the interrupts for the Timer.
*
* @param	IntcInstancePtr is a reference to the Interrupt Controller
*		driver Instance.
* @param	IntrId is XPAR_<INTC_instance>_<Timer_instance>_VEC_ID
*		value from xparameters.h.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void TmrCtrDisableIntr(INTC *IntcInstancePtr, u16 IntrId)
{
	/*
	 * Disable the interrupt for the timer counter
	 */
#ifdef XPAR_INTC_0_DEVICE_ID
	XIntc_Disable(IntcInstancePtr, IntrId);
#else
	/* Disconnect the interrupt */
	XScuGic_Disable(IntcInstancePtr, IntrId);
	XScuGic_Disconnect(IntcInstancePtr, IntrId);
#endif
}

