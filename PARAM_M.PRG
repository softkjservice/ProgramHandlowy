**PROCEDURE PARAM
local ek,ek1,ek2
local t[10],h[2],w[15],d[3],m[3],o[2],d1[2],c[3]
local s:=1
local has:=space(10),lfis_druk:=fis_druk
ztrah=trah
hel="param"
c[1]:=" COM1    1016 "
c[2]:=" COM2     760 "
c[3]:=" INNY         "
o[1]:="iloscDNI"
o[2]:="DATA/DNI"
m[1]:="DEF.NAZW"
m[2]:="OKNO AS."
m[3]:="Stany(-)"
w[1]:="Papier  "
w[2]:="StronaDl"
w[3]:="Tekst d1"
w[4]:="Tekst d2"
w[5]:="Tekst m "
w[6]:="Tlusty  "
w[7]:="PARAGON "
w[8]:="FIS_DRUK"
w[9]:="        "
w[10]:="        "
w[11]:="        "
w[12]:="        "
w[13]:="        "
w[14]:="        "
w[15]:="        "
d[1]:= "FAKTURA "
d[2]:= "RACHUNEK"
d[3]:= "PARAGON "
d1[1]:= "PRZESUN."
d1[2]:= " W - Z  "
*d1[3]:= " P - Z  "


h[1]:=" PRACOWNIK  "
H[2]:=" ZARZADCA   "
t[1]:="NUMERACJA  "
t[2]:="PAR.WYDRUKU"
t[3]:="KOLOR      "
t[4]:="HASLO      "
t[5]:="MAGAZYNY   "
t[6]:="CENY BRUTTO"
t[7]:="UZYTKOWNIK "
t[8]:="TYP DOKUM. "
t[9]:="TERMIN PLAT"
t[10]:="DRUKARKA   "
*t[11]:="KONTRAHENT "
*t[12]:="Powt.  KTM "
*t[13]:="Szukaj KTM "
*t[14]:="Detal_cen  "
*t[15]:="Kurs dnia  "
hel="param"
set color to (coldef)
@ 0,0,24,79 box tlo
set color to
@ 4,2 say "-----------"
if kolor=0
  set color to n/w
else
  set color to (coldef)
endif  
@ 0,0 SAY "  SYSTEM ZARZADZANIA PRZEDSIEBIORSTWEM   * P A R A M E T R Y *                  "
@ 0,69 say daf
set color to n/w

for i=3 to 19
  @ i,14 say space(19)
next

@ 2,1 to 20,33 double

@ 4,14 say "-------------------"
*@ 5,14 say daf
@ 7,16 say kolor picture "9"
@ 10,16 say sklep
@ 13,14 say opoznionaPlatnosc picture "999"
set color to
do suf
@ 22,15 say "   WYBIERZ POZYCJE I ZATWIERDZ KLAWISZEM ENTER    "
@ 3,2 say " - WYBOR - "
@ 3,14 say "- P A R A M E T R -"
set color to (n/w,w/n)
for i=4 to 13   
  @ i,42 say space(36)
next
@ 4,42 to 13,77 double
@ 5,43 say "LICENCJONOWANY UZYTKOWNIK PROGRAMU"
@ 6,43 say "----------------------------------"
@ 7,43 say flic1
@ 8,43 say flic2
@ 9,43 say flic3
@ 10,43 say flic4
@ 11,43 say flic5
@ 12,43 say flic6
for i=15 to 20
  @ i,42 say space(36)
next
@ 15,42 to 20,77 double
@ 16,43 say "         P R O D U C E N T        "
@ 17,43 say "----------------------------------"
@ 18,43 say fdys1
@ 19,43 say fdys2

do while .t.
set color to
s=achoice(5,2,19,12,t,,,s) 
do suf
save screen to ek1
do case
  case s=1
    do dnumery
  case s=2
    save screen to ek
    ww=1
    do while.t.
      @ 4,14 to 20,33 double
	  for j=5 to 19
		    @ j,24 say chr(176)
	  next
	  set color to n/w
	  @ 5,29 say orginal picture "9"
	  @ 6,27 say dlugosc picture "999"
	  @ 10,27 say grafik
	  @ 12,27 say fis_druk
	  set color to 		
	  ww=achoice(5,15,19,23,w,,,ww)
	  set cursor on
      do case
		    case ww=1
		      do suf
		      @ 22,16 say "0-papier przebitkowy opisany, 1-papier  "
		      @ 23,16 say "bez przebitki, 2-przebitkowy bez opisu  "		
		      @ 5,29 get orginal picture "9"
			  read
		    case ww=2
			  do suf
		      @ 22,16 say "Okreslenie optymalnej ilosci wierszy dla"
		      @ 23,16 say "wydrukow.                               "
		      @ 6,27 get dlugosc picture "999"
			  read
		    case ww=3
			  do suf
		      @ 22,16 say "Wprowadzony tu tekst pojawi sie na wyd- " 
		      @ 23,16 say "rukach dokumentow !     Nacisnij klawisz"	
			  inkey(0)
		      @ 21,0 clear to 24,79
			  @ 22,0 get dtxt1
			  @ 24,0 get dtxt2
			  read			  
		    case ww=4
			  do suf
		      @ 22,16 say "Wprowadzony tu tekst pojawi sie na wyd- " 
		      @ 23,16 say "rukach dokumentow z opozniona platnoscia"	
			  inkey(0)
              @ 18,0 to 24,31 double
			  @ 19,1 get dtxt6
			  @ 20,1 get dtxt7
			  @ 21,1 get dtxt8
			  @ 22,1 get dtxt9
			  @ 23,1 get dtxt10
			  read			  			  
		    case ww=5 
			  do suf
		      @ 22,16 say "Wprowadzony tu tekst pojawi sie na wyd- " 
		      @ 23,16 say "rukach oferty!     Nacisnij klawisz!    "	
			  inkey(0)			
		      @ 21,0 clear to 24,79
			  @ 22,0 get dtxt3
			  @ 23,0 get dtxt4
			  @ 24,0 get dtxt5
			  read
		    case ww=6 
			  do suf
		      @ 22,16 say "T - uwypuklenie waznych czesci wydrukow " 
		      @ 23,16 say "F - wydruk jednolity                    "	
		      @ 10,27 get grafik
			  read			  			  			  
		    case ww=7 
			  do suf
		      @ 22,16 say "  Definiowanie parametrow paragonow.    " 
		      @ 23,16 say "                                        "				  
			  do parokno
		    case ww=8 
			  do suf
		      @ 22,16 say ".T. Drukuj paragon fiskalny /DF2-ORHMET/" 
		      @ 23,16 say ".F. Nie drukuj paragonu fiskalnego      "				  
              set cursor on
              lfis_druk=fis_druk
			  @ 12,27 get lfis_druk
              read
              set cursor off
              if lastkey()#27
                fis_druk=lfis_druk
                paragtyp=2
				if.not.wlasny5
				  rachuntyp=2
				else
				  rachuntyp=1
				endif  
                save to pam
              endif	  		                
              if fis_druk
                save screen to ek2
                @ 19,25 clear to 23,50
				@ 19,25 to 23,50 double
				lcom=3
				do case
				  case fis_com=1016
				    lcom=1
				  case fis_com=760
				    lcom=2					
				endcase
				lcom=achoice(20,26,22,49,c,,,lcom)
				do case
				  case lcom=1
				    fis_com=1016
				  case lcom=2
				    fis_com=760
				  case lcom=3
                    set cursor on
					@ 22,32 get fis_com
					read 			
                    set cursor off
				endcase 	
                save to pam	
				restore screen from ek2	  
			  endif
            case ww=0
			  exit
	  endcase 
	  set cursor off
	  if lastkey()#27
	    if file("firma\pam.mem")
		  save to firma\pam.mem
		else   
		  save to pam
		endif  
      endif
    enddo
    restore screen from ek

  case s=3
		do suf
		@ 22,16 say " 0-Brak kolory  1-niebieski  2-zielony  "
		@ 23,16 say " 3-czerwony  4-brazowy  5-zolty  6-karm."  
        set cursor on
		@ 7,16 get kolor picture "9"
		read
        if lastkey()#27
		  do case
		    case kolor=0
			  coldef="W/N,N/W,N,N,N/W"
		    case kolor=1
			 * coldef="W/B,B/W"
			   coldef="bg+"
		    case kolor=2
			  coldef="N/G,G/N"
		    case kolor=3
			  coldef="W/R,R/W"			  			  			  
			case kolor=4
			  coldef="W/GR,GR/W"  
			case kolor=5
			  coldef="W/GR+,GR+/W"  			  
			case kolor=6
			  coldef="W/RB,RB/W"  			  
		  endcase
		  set color to (coldef)
		  save to pam
		endif
        set cursor off

  case s=4	
		do suf
		@ 22,16 say "Dwupoziomowe haslo wejsciowe do systemu."
		@ 23,16 say "                                        "
        hs=1
		if in28           &&jesli zainstalowano haslo dwupoziomowe  
          save screen to ek
          @ 7,18 to 10,31 double
		  hs=achoice(8,19,9,30,h) 		
          restore screen from ek
		endif  
		if hs#0
    	  do haslo with 17,5
		  if dostep
		    set cursor on
		    @ 8,14 get has
		    read
		    set cursor off
		    zz=.t.
		    do gkom with "Zatwierdzic nowe haslo ? [T/F] ",zz
		    if zz.and.lastkey()#27.and.hs=1
		      haslo=has
		      if.not.in28
			    shaslo=haslo
			  endif
			  save to pam
		    endif	
		    if zz.and.lastkey()#27.and.hs=2.and.MagPraw=.t.
		      shaslo=has
		      save to pam
		    endif				
		  endif
		endif		  
		
	  case s=5
        save screen to ek
        ww=1
        do while.t.
	      @ 8,14 to 12,33 double
		  for j=9 to 11
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 10,27 say wyboras
		  @ 11,27 say minus_mag
		  set color to 		
		  ww=achoice(9,15,11,23,m,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "Mozliwosc zdefiniowania nazw i adresow  "
		      @ 23,16 say "magazynow wspolpracujacych.             "
              if file("magdef.dbf")
                save screen to ek
                select 22
		        use magdef
		        browse(8,14,16,78)
		        use
	            do mdef 
		        restore screen from ek
		      else
		        do tkom with "Dostepne w wersji wielomagazynowej. Nacisnij dowolny klawisz."  
		      endif

		    case ww=2.and.in42
			  do suf
		      @ 22,16 say "T - Wejscie do magazynu poprzedza okno   "
		      @ 23,16 say "wyboru asortymentu  F - pominiecie okna. "	
		      @ 10,27 get wyboras 
			  read			  
            case ww=3
			  do suf
		      @ 22,16 say "T - Mozliwosc sprzedazy ponizej stanow maga- "
		      @ 23,16 say "zynowych  F - blokada sprzedazy ponizej stanu"	
		      @ 11,27 get minus_mag
			  read
		    case ww=333
			  do suf
		      @ 22,16 say "T - Wejscie do magazynu poprzedza okno wyboru"
		      @ 23,16 say "asortymentu z poziomu dokumentu  F-Rezygnacja"	
		      @ 11,27 get asmenpar
			  read			  			  
            case ww=0
			  exit
		  endcase 
		  set cursor off
		  if lastkey()#27
		    save to pam
	      endif
        enddo
        restore screen from ek

  case s=6
		do suf
		@ 22,16 say " F - Definiowanie cen NETTO  tow. handlowych"
		@ 23,16 say " T - Definiowanie cen BRUTTO tow. handlowych"		
		set cursor on
		@ 10,16 get sklep
		read
		set cursor off   
		if lastkey()#27
		  save to pam
		endif 						
		
        
  case s=7
    do uzytkwew
              if lastkey()#27
                save to pam
              endif	  		  		  
    case s=8
      save screen to ek
      ww=1
      do case
	   case sh_firma.and.vvt 
	    do while.t.
	      @ 12,14 to 16,33 double
		  for j=13 to 16
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 13,27 say fakturtyp picture "9"
		  @ 14,27 say rachuntyp picture "9" 
		  @ 15,27 say paragtyp picture "9"
*	  @ 16,27 say przestyp picture "9"
		  set color to 		
		  ww=achoice(13,15,15,23,d,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "1 - faktury liczone w cenach NETTO      "
		      @ 23,16 say "2 - faktury liczone w cenach BRUTTO     "	
		      @ 13,27 get fakturtyp picture "9" range 1,2
              read
		    case ww=2
		      if.not.fis_druk
			    @ 22,16 say "1 - rachunki liczone w cenach NETTO     "
		        @ 23,16 say "2 - rachunki liczone w cenach BRUTTO    "	
		        @ 14,27 get rachuntyp picture "9" range 1,2
                read
			  else
			    do tkom with "Korzystasz z drukarki fiskalnej - rozliczenie w cenach brutto. OK! " 
                rachuntyp=2
			  endif	
		    case ww=3
		      @ 22,16 say "BEZIMIENNE: 1-ceny NETTO  2-ceny BRUTTO "
		      @ 23,16 say "IMIENNE:    3-ceny NETTO  4-ceny BRUTTO "	
		      @ 15,27 get paragtyp picture "9" range 1,4
              read			
			  do case
			    case paragtyp=1.or.paragtyp=2
				  gonful=.f.			  
                  if paragtyp=1.and.fis_druk
				    paragtyp=2
				  endif
			    case paragtyp=3
				  paragtyp=1
                  if fis_druk
				    paragtyp=2
					rachuntyp=2
				  endif
				  gonful=.t.
			    case paragtyp=4
				  paragtyp=2
				  gonful=.t.				  
			  endcase
            case ww=0
			  exit
		  endcase 
		  if lastkey()#27
		    save to pam
	      endif	  		  
        enddo
		
       case m_firma
	    do while.t.
	      @ 12,14 to 15,33 double
		  for j=13 to 14
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 13,27 say przestyp picture "9"
		  @ 14,27 say wztyp picture "9" 
*         @ 15,27 say pztyp picture "9"
*	  @ 16,27 say przestyp picture "9"
		  set color to 		
		  ww=achoice(13,15,14,23,d1,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "1 - przes. w ceanch magazynowych NETTO  "
		      @ 23,16 say "2 - przes. w cenach detalicznych BRUTTO "	
		      @ 13,27 get przestyp picture "9" range 1,2
              read
		    case ww=2
		      @ 22,16 say "1 :  W - Z   liczone w cenach NETTO     "
		      @ 23,16 say "2 :  W - Z   liczone w cenach BRUTTO    "	
		      @ 14,27 get wztyp picture "9" range 1,2
              read
*		    case ww=3
*		      @ 22,16 say "1 :  P - Z   liczone w cenach NETTO     "
*		      @ 23,16 say "2 :  P - Z   liczone w cenach BRUTTO    "	
*		      @ 15,27 get pztyp picture "9" range 1,2
*             read			
            case ww=0
			  exit
		  endcase 
		  if lastkey()#27
		    save to pam
	      endif	  		  
        enddo	   
	   
	   
        case p_firma
		      @ 22,16 say " Parametr  dostepny  w innych  modulach  "
		      @ 23,16 say " pakietu.    Nacisnij dowolny klawisz !  "	
			  inkey(0)		
	  endcase 
		  if lastkey()#27
		    save to pam
	      endif	  
		  set cursor off		  
      restore screen from ek
******
	case s=9
      if sh_firma    
        save screen to ek
        ww=1
        do while.t.
	      @ 13,14 to 16,33 double
		  for j=14 to 15
		    @ j,24 say chr(176)
		  next
		  set color to n/w
		  @ 14,27 say OpoznionaPlatnosc picture "999"
		  @ 15,27 say opdat
		  set color to 		
		  ww=achoice(14,15,15,23,o,,,ww)
		  set cursor on
          do case
		    case ww=1
		      do suf
		      @ 22,16 say "Podana tu ilosc dni bedzie doliczana do  "
		      @ 23,16 say "aktualnej daty aby podac termin platnosci"
		      set cursor on
		      @ 14,27 get OpoznionaPlatnosc picture "999"
		      read
              zOpoznionaPlatnosc=OpoznionaPlatnosc
		    case ww=2
			  do suf
		      @ 22,16 say "T - Zatwierdzanie daty rozliczenia dok.  "
		      @ 23,16 say "F - Zatwierdzanie ilosci dni opozn.platn."	
		      @ 15,27 get opdat 
			  read
			  
            case ww=0
			  exit
		  endcase 
		  set cursor off
		  if lastkey()#27
		    save to pam
	      endif
        enddo
        restore screen from ek
      else
		      @ 22,16 say " Parametr  dostepny  w innych  modulach  "
		      @ 23,16 say " pakietu.    Nacisnij dowolny klawisz !  "	
			  inkey(0)			  
	  endif

  case s=10
    druk_wybor(15,30)
  case s=0
    keyboard chr(205)
	exit
endcase
restore screen from ek1
set color to n/w
@ 7,16 say kolor picture "9"
@ 10,16 say sklep
*@ 11,14 say wzdruk
*@ 11,16 say pzdruk
@ 13,14 say opoznionaPlatnosc picture "999"
set color to (coldef)
enddo
set color to
RETURN

PROCEDURE SUF
set color to n/w
@ 22,0 say "  * sufler *  |                                                  |              "
@ 23,0 say "              |                                                  |  * sufler *  "  
set color to 
RETURN

PROCEDURE KONTO
parameters pkon,pnkon
local ek:=savescreen(0,0,24,79)
local t[2],q[2]
t[1]:="kon"
t[2]:="nkon"
q[1]:=""
q[2]:=""
set color to (coldef)
for i=8 to 18
  @ i,2 say replicate(chr(176),76)
next
@ 9,5 say space(70)
@ 9,5 say "NAZWA I NUMER KONTA           CD                            "
do skom with "Dopisz  Popraw  Kasuj  ENTER-zatwierdz  ESC-zrezygnuj"
use konto new
*locate for nkon=pnkon
keyboard chr(205)
dbedit(10,5,15,74,t,"UK","",q)
use
set color to (coldef) 
restscreen(0,0,24,79,ek)
RETURN

FUNCTION UK(tryb,numer)
local pole,pol
local last:=lastkey()
commit
do case
  case last=68.or.last=100    &&Dopisz
    set cursor on
    zkon=space(60)
    @ 17,5 get zkon picture "@!"
    read
    if lastkey()#27
      go bottom
	  znkon=nkon
	  append blank
	  replace kon with zkon
	  replace nkon with znkon+1
    endif
    set cursor off
    set color to (coldef)
    @ 17,5 say replicate(chr(176),70)
    set color to I,
    keyboard chr(205)
    return 2
  
  case last=75.or.last=107
    delete
    pack
    keyboard chr(205)
    return 2  
  
  case last=80.or.last=112
    pole:=field(numer)
    pol:=&pole
    set cursor on
    @ row(),col() get pol
    read
    set cursor off
    if lastkey()#27
      replace &pole with pol
    endif   
    keyboard chr(205)
    return 2
    
  case last=13
    znkon=nkon
    zkonto=nkon
    zkon=kon
*   keyboard chr(205)  
   
    return 0  	
	
  case last=27
     return 0
 endcase
RETURN 1


PROCEDURE DNUMERY
local lnumfakt,lnumrach,lnumpar,lnumpz,lnum1dzy,lnum2dzy,lnumprzer,ek
save screen to ek
if file("firma\bazy\1dok\dpam.dbf")
  use firma\bazy\1dok\dpam new
else
  use dpam new
endif  
do case
  case sh_firma
    lnumfakt=dnumfakt+1
    lnumrach=dnumrach+1
    lnumpar=dnumpar+1
    lnumpz=dnumpz+1


    @ 22,15 say " Wpisz numery poczatkowe wystawianych w programie "
    @ 23,15 say "             d o k u m e n t o w                  "
    @ 5,15 to 10,53 double
    @ 6,16 say " Poczatkowy numer FAKTURY            "
    @ 7,16 say " Poczatkowy numer RACHUNKU           "
    @ 8,16 say " Poczatkowy numer PARAGONU           "		
    @ 9,16 say " Poczatkowy numer DOK.ZAKUPU         "
	set cursor on
	@ 6,45 get lnumfakt picture "999999"
	@ 7,45 get lnumrach picture "999999"
	@ 8,45 get lnumpar picture "999999"
	@ 9,45 get lnumpz picture "999999"	
	read
	set cursor off
	if lastkey()#27
	  replace dnumfakt with lnumfakt-1
	  replace dnumrach with lnumrach-1
	  replace dnumpar with lnumpar-1
	  replace dnumpz with lnumpz-1
	endif
  case m_firma
    lnum1dzy=dnum1dzy+1
    lnum2dzy=dnum2dzy+1
    @ 22,15 say " Wpisz numery poczatkowe wystawianych w programie "
    @ 23,15 say "             d o k u m e n t o w                  "
    @ 5,15 to 8,53 double
    @ 6,16 say " Dokument - magazyn wydal            "
    @ 7,16 say " Dokument - magazyn przyjal          "	
	set cursor on
	@ 6,45 get lnum1dzy picture "999999"
	@ 7,45 get lnum2dzy picture "999999"	
	read
	set cursor off
	if lastkey()#27
	  replace dnum1dzy with lnum1dzy-1
	  replace dnum2dzy with lnum2dzy-1
	endif	
  case p_firma	
    lnumprzer=dnumprzer+1
    @ 22,15 say " Wpisz numery poczatkowe wystawianych w programie "
    @ 23,15 say "             d o k u m e n t o w                  "
    @ 5,15 to 8,53 double
    @ 6,16 say " Numer dokumentu przerobu            "
    @ 7,16 say "                                     "	
	set cursor on
	@ 6,45 get lnumprzer picture "999999"
	read
	set cursor off
	if lastkey()#27
	  replace dnumprzer with lnumprzer-1
	endif		
endcase  
close
restore screen from ek	
RETURN	

PROCEDURE UZYTKWEW
local lic1:="      PARAMETRY FIRMY         "
local lic2:=" Wypelnij starannie rubryki   "
local lic5:=" 1 - 5  !!!                   "
local lic3:=" gdyz ich modyfikacja  bedzie "
local lic4:=" ograniczona !  Esc-rezygnacja"
local lkod:="  -   ",lnip:=substr(lic5,1,13),lkonto1:=space(30),lkonto2:=space(30)
local ltel:=space(20),lregon:=space(15),lpammiasto:=space(19),lzapisz:=.f.,ek
local pomlic1:=lic1
local pomlic2:=lic2
local pomlic3:=lic3
local pomlic4:=lic4
local pomlic5:=lic5
if alltrim(flic1)#"WERSJA DEMONSTRACYJNA"
  lic1=flic1
  lic2=flic2
  lic3=flic3
  lic4=flic4
  lic5=flic5
  lkod=substr(flic6,1,6)
  lnip=substr(flic5,1,13)
  ltel=substr(flic6,10,20)
  lpammiasto=pammiasto
  lkonto1=substr(zkon,1,30)
  lkonto2=substr(zkon,31,30)  
  lregon=zregon
endif
save screen to ek
do while.t.
  clear
  @ 2,2 to 22,77 double
  @ 4,4 say "1. Nazwisko i imie lub nazwa firmy "
  @ 5,4 say "2. Cd. ............................"
  @ 6,4 say "3. Numer identyfikacyjny   N I P .."  
  @ 7,4 say "4. Adres firmy.    Miasto: ........"
  @ 8,4 say "5. Adres firmy.    Ulica / Nr ....."
  @ 10,4 say "Adres firmy.    Kod pocztowy ......"

  @ 13,4 say"Numer statystyczny   R E G O N  ..."
  @ 15,4 say"Nazwa i numer konta bankowego ....."
  @ 16,4 say"Cd. ..............................."
  @ 18,4 say"Numer telefonu ...................."
  @ 20,4 say"Miejsce prowadznia sprzedazy ......" 
  set cursor on
*  @ 4,40 get lic1
*  @ 5,40 get lic2
*  @ 6,40 get lnip
*  @ 7,40 get lic3
*  @ 8,40 get lic4
set color to n/w
  @ 4,40 say lic1
  @ 5,40 say lic2
  @ 6,40 say lnip
  @ 7,40 say lic3
  @ 8,40 say lic4
set color to  

  @ 10,40 get lkod
  @ 13,40 get lregon
  @ 15,40 get lkonto1
  @ 16,40 get lkonto2
  @ 18,40 get ltel
  @ 20,40 get lpammiasto
  read
  set cursor off
  if lastkey()=27
    flic1=lic1
    flic2=lic2
    flic3=lic3
    flic4=lic4
    flic5=lic5
    fwl=flic1
    save to pam.mem
    exit
  endif
  do fragwew
  set color to n/w
  @ 6,43 say lic1
  @ 7,43 say lic2
  @ 8,43 say lic3
  @ 9,29say lkod
  @ 9,43 say lic4
  @ 10,32 say lnip
  @ 10,56 say lregon
  @ 11,43 say lkonto1
  @ 12,43 say lkonto2
  @ 13,36 say ltel
  set color to
  do konczwew with lzapisz,19,25 
  if lastkey()=27
    exit
  endif
  if lzapisz
    if sh_lic.or.m_lic.or.p_lic.or.kr_lic
      if.not.pierwsza
	      if (flic1#lic1.or.flic2#lic2).and.(ilezmian<2.or.zmiana_naz)
            fold1=flic1
			fold2=flic2
		    flic1=lic1
			flic2=lic2
		    if.not.zmiana_naz
			  ilezmian=ilezmian+1
			endif  
			zmiana_naz=.t.
		  endif
	      if substr(flic5,1,13)#lnip.and.(ilezmian<2.or.zmiana_nip)
		    fold5=flic5
			flic5=lnip
		    if.not.zmiana_nip
			  ilezmian=ilezmian+1
			endif  
			zmiana_nip=.t.
		  endif		  
	      if (flic3#lic3.or.flic4#lic4).and.(ilezmian<2.or.zmiana_adr)
		    fold3=flic3
			fold4=flic4
			flic3=lic3
			flic4=lic4
		    if.not.zmiana_adr
			  ilezmian=ilezmian+1
			endif  
			zmiana_adr=.t.
		  endif		  

	  else	  
	    flic1=lic1
        flic2=lic2
        flic3=lic3
        flic4=lic4
        flic5=lnip
	  endif	
      flic6=stuff(flic6,1,6,lkod)
      flic6=stuff(flic6,10,20,ltel)
      fwl=flic1
      pammiasto=lpammiasto
      zkon=stuff(space(60),1,30,lkonto1)
	  zkon=stuff(zkon,31,30,lkonto2)
      zregon=lregon
      if lic1#pomlic1.or.lic2#pomlic2.or.lic3#pomlic3.or.lic4#pomlic4.or.lic5#pomlic5
        pierwsza=.f.
	  endif	
      save to pam.mem
      if file("konto.dbf")
  	    use konto new
*        go bottom
*	    znkon=nkon
	    znkon=1
	    if lastrec()<1
		  append blank
	    endif
		replace kon with zkon
	    replace nkon with 1
	    close
      endif
	  exit
    else
      do tkom with " UWAGA ! Definiowanie parametrow Uzytkownika mozliwe w wersji licencjonowanej."
      exit
	endif  
  endif
enddo
restore screen from ek
RETURN

PROCEDURE FRAGWEW
local f[20]
clear
f[1]:="                        F A K T U R A   V A T  NR     "
f[2]:="                        =============================="
f[3]:="       ..............................                 "
f[4]:="            PIECZEC   SPRZEDAWCY                      "
f[5]:="S P R Z E D A W C A  :                                "
f[6]:="| Nazwisko i imie ...                               | "
f[7]:="| lub nazwa firmy ...                               | "
f[8]:="| Adres: Miasto .....                               | "
f[9]:="| Kod:        Ulica..                               | "
f[10]:="| N I P :                 REGON :                   | "
f[11]:="| Konto .............                               | "
f[12]:="| Cd konta...........                               | "
f[13]:="   Telefon :                                          "
f[14]:="======================================================"
@ 5,1 say "FRAGMENT        �� "
@ 6,1 say "   DOKUMENTU    ���"
@ 7,1 SAY "      SPRZEDAZY �� " 
@ 0,0 to 24,79 double
set color to n/w
for i=1 to 14
  @ i,22 say f[i]
next
@ 24,0 say "                         [ Esc ]  -  rezygnacja                                 "
set color to
RETURN

PROCEDURE KONCZWEW
parameters pzapisz,pw,pk
local t[2],s
pzapisz=.f.
t[1]:="     Zapamietaj zmiany        "
t[2]:="     Powroc do  edycji        "
@ pw,pk to pw+3,pk+31 double
s=achoice(pw+1,pk+1,pw+2,pk+30,t)
if s=1
  pzapisz=.t.
endif
RETURN

PROCEDURE PAROKNO
local t[3],f[2],k[2],w[2],c[2],s,m,ek,lzmiana:=.f.
local lpar_skrocony:=par_skrocony,lgonful:=gonful,lparagtyp:=paragtyp
local lstron_par:=zstron_par,lwysuw_par:=zwysuw_par
t[1]:=" Format         " 
t[2]:=" Kontrahent     " 
*t[3]:="Wysuw papieru  " 
t[3]:=" Ceny           " 
f[1]:="Pelny          " 
f[2]:="Skrocony       " 
k[1]:="Drukowac       " 
k[2]:="Pominac        " 
w[1]:="Do konca strony"
w[2]:="Do oddarcia    "  
c[1]:="Netto          " 
c[2]:="Brutto         " 
save screen to ek
@ 4,40 clear to 20,78
@ 4,40 to 20,78 double
if par_skrocony
  @ 8,65 say "SKROCONY"
else
  @ 8,65 say "PELNY   "
endif
if gonful
  @ 9,65 say "DRUKOWAC" 
else
  @ 9,65 say "POMINAC " 
endif
if paragtyp=1
  @ 10,65 say "NETTO  "
else
  @ 10,65 say "BRUTTO "
endif
set color to n/w
@ 5,41 say "     P A R A G O N  - parametry      "
@ 6,41 say "====================================="

set color to (coldef)
@ 18,41 say "-------------------------------------"
@ 19,41 say "           Esc - koncz               "
do while.t.
  s=achoice(8,44,10,58,t)
  do case
    case s=1
      m=achoice(14,44,15,64,f)
	  do case
	    case m=1
	      lpar_skrocony=.f.
          @ 8,65 say "PELNY   "
	    case m=2
	      lpar_skrocony=.t.
          @ 8,65 say "SKROCONY"	
	      lparagtyp=2
          @ 10,65 say "BRUTTO  "
          lgonful=.f.
          @ 9,65 say "POMINAC " 		  		  	
		  if lpar_skrocony
		    set cursor on
		    @ 14,44 say "Stronicowac ? [T/N] "
		    @ 14,67 get lstron_par
		    @ 15,44 say "Wysuw papieru:      "
		    read
		    if.not.lstron_par
			  @ 15,66 get lwysuw_par picture "999"
			  read 
		    endif
		    set cursor off
		  endif
	  endcase
    case s=2
      m=achoice(14,50,15,64,k)
	  do case
	    case m=1
          lgonful=.t.
		  @ 9,65 say "DRUKOWAC"
	      lpar_skrocony=.f.
          @ 8,65 say "PELNY   "		   
	    case m=2
          lgonful=.f.
          @ 9,65 say "POMINAC " 
	  endcase
    case s=3
      m=achoice(14,50,15,64,c)
	  do case
	    case m=1
	      lparagtyp=1
          @ 10,65 say "NETTO   "
	      lpar_skrocony=.f.
          @ 8,65 say "PELNY   "		  
	    case m=2
	      lparagtyp=2
          @ 10,65 say "BRUTTO  "
	  endcase	  	  
  endcase
  @ 14,43 clear to 15,65
*  if lastkey()=27
  *  if lpar_skrocony#par_skrocony.or.lgonful#gonful.or.lparagtyp#paragtyp
	  zz=.t.
	  @ 13,42 to 15,76 
	  @ 14,43 say " Zapamietac zmiany ?  [T/N]      "
      set cursor on
	  @ 14,74 get zz
	  read
	  set cursor off
	  if zz.and.lastkey()#27
	    par_skrocony=lpar_skrocony
		gonful=lgonful
		paragtyp=lparagtyp
	    zstron_par=lstron_par
		zwysuw_par=lwysuw_par
	  endif
	*endif
    exit
 * endif
enddo
if fis_druk
  paragtyp=2
  rachuntyp=2
endif
restore screen from ek
RETURN

PROCEDURE KURS_WALUT
local t[6],q[6]
t[1]:="k_data"
t[2]:="k_w1"
t[3]:="k_w2"
t[4]:="k_w3"
t[5]:="k_w4"
t[6]:="k_w5"
q[1]:="Data"
q[2]:="Kurs dnia"
q[3]:="Kurs dnia"
q[4]:="Kurs dnia"
q[5]:="Kurs dnia"
q[6]:="Kurs dnia"
select 99
*use kursy new
use kursy 
index on k_data to kursy
use kursy index kursy 
@ 3,2 clear to 18,12
do suf
@ 22,16 say "    Dopisz   Popraw   Kasuj   Esc-rezygnuj    "
@ 23,16 say "                                              "	
set color to "n/w,w/n"
@ 19,15 say space(21)
@ 2,14 to 20,36 double
do while.t.
  dbedit(3,15,18,35,t,"PKFU1","",q,,,chr(205))
  if lastkey()=27
    exit
  endif
enddo  
close
*dbedit(wiersz,1,18,78,q,"UF0","",w,,,chr(205))
RETURN

FUNCTION PKFU1(tryb,numer)
*realizacja przegladu
local last:=lastkey()
do case
  case last=68.or.last=100         &&Dopisz
    append blank
	set cursor on
	@ 19,15 get k_data
	@ 19,26 get k_w1 picture "999.999999"
	read
	set cursor off
	@ 19,15 say space(21)
	return 0
  case last=80.or.last=112                         &&Popraw  
	set cursor on
	@ 19,15 get k_data
	@ 19,26 get k_w1 picture "999.999999"
	read
	set cursor off
	@ 19,15 say space(21)
	return 0
  case last=75.or.last=107         &&Kasuj
    delete
    pack
	keyboard chr(205)
	return 0
  case last=27
    return 0
endcase
RETURN 1