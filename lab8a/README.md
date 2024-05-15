## Functionalities

0. Project goal
	Generator Epitrochoidów

1. Generujemy wycentrowany i kwadratowy obraz (384x384) na analogowym monitorze VGA (tryb 640x480)
 - współrzędne (0,0) są w środku ekranu

2. Generujemy obraz czarno-biały (wszystkie bity sygnałów RGB sterujemy równocześnie z tego samego źródła)
 - figura biała
 - tło czarne

3. Ustawianie częstotliwości
 - częstotliwości na kanałach X, Y
 - wartość z zakresu (0-255) ustawiamy za pomocą przełączników SW0-SW7
 - przycisk BTNL (wpis częstotliwości X ustawionej na przełącznikach)
 - przycisk BTNC (wpis częstotliwości Y ustawionej na przełącznikach)
 
4. Ustawianie amplitudy
 - ampliduta na kanałach X, Y
 - amplitudę X ustawiamy za pomocą przełączników SW7-SW4 ( 16px/unit -> 240px )
 - amplitudę Y ustawiamy za pomocą przełączników SW3-SW0 ( 4px/unit -> 60px )
 - przycisk BTNR (wpis aplitud X i Y ustawionej na przełącznikach)
 
4. Przycisk BTND
 - wyczyszczenie ekranu i zresetowanie generatora DDS
   (aby rozpoczął rysowanie figur od zerowych faz)

5. Komponent DDS
 - kanał X to Channel 1
	- współrzędne ujemne są po lewej stronie ekranu dodatnie po prawej
	- amplituda kanału powinna być tak dobrana aby krzywa w pełni wykorzystała dostępny ekran
 - kanał Y to Channel 2 
	- współrzędne ujemne są na dole ekranu dodatnie na górze
	- amplituda kanału powinna być tak dobrana aby krzywa w pełni wykorzystała dostępny ekran

6. Nie korzystamy z sygnału „reset”. Zamiast tego stosujemy wartości początkowe sygnałów i zmiennych.


## About Epitrochoid (knowledge sources)
 - https://en.wikipedia.org/wiki/Epitrochoid


## About VGA 640x480 (knowledge sources)
 - http://www.ue.eti.pg.gda.pl/fpgalab/zadania.spartan3/zad_vga_generowanie_sygnalu_vga.html
 - http://tinyvga.com/vga-timing/640x480@60Hz
 - https://superuser.com/questions/1716784/how-does-vga-work-with-resolutions-higher-than-the-maximum-resolution
 - https://faculty-web.msoe.edu/johnsontimoj/EE3921/files3921/vga_basics.pdf
 - https://web.mit.edu/6.111/www/s2004/NEWKIT/vga.shtml
 
 
## Input
	clk_i – zegar 100MHz
	sw_i – przełączniki do ustawiania częstotliwości i amplitud kanałów
	btn_i – przyciski do wprowadzania częstotliwości i amplitud kanałów ustawionych na przełącznikach
		btn_i(3) – przycisk BTNL
		btn_i(2) – przycisk BTNC
		btn_i(1) – przycisk BTNR
		btn_i(0) – przycisk BTND
	
## Output
	red_o – wyjście sygnału koloru czerwonego do monitora
	green_o – wyjście sygnału koloru zielonego do monitora
	blue_o – wyjście sygnału koloru niebieskiego do monitora
	hsync_o – wyjście sygnału synchronizacji poziomej do monitora
	vsync_o – wyjście sygnału synchronizacji pionowej do monitora


## Settings
 - inicjalne wyświetlanie okręgu (figura zdefiniowana przez ustawienia początkowe częstotliwości i faz)
 - sygnał VGA (częstotliwość pikseli można ustalić na równe 25 MHz)

## Comments
 - przy generacji sygnału wideo należy pamiętać o zerowaniu sygnałów RGB poza obszarem wyświetlania obrazu
 (na podstawie poziomu sygnału analogowego poza obszarem wyświetlania monitor ustala poziom czerni dla każdego z kolorów)
 - do realizacji projektu potrzebne są dwa moduły funkcjonalne wygenerowane przez syntezer IP Core.
	- dwuportowa pamięć RAM jako pamięć obrazu
	- generator DDS (Direct Digital Synthesizer) do wytwarzania cyfrowych sygnałów sinusoidalnych dla kanału X (poziom) i Y (pion)