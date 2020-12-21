PROCEDURE KSTRANS
local dyskready:=.t.
local miesnum:=0
local miesnaz:=space(15)
            do dysktest with dyskready
            if.not.dyskready
         	  return
        	endif  
            dokexport=.t. 	
            do bufor with 1   &&przygotowanie opisu dyskietki transmisyjnej
            commit
               do kmbuf with -1
               if lastkey()#27
			     do rsum with .f.
			   endif 	 
        	   if lastkey()#27

                 close databases
                 set default to
                 dok=" dok"
                 dok=stuff(dok,1,1,alltrim(str(NumKas)))
                 dys=substr(dysk,1,2)
                 copy file &dok\rejsum.dbf to &dys\rejsum.dbf  
                 copy file &dok\rejsum.ntx to &dys\rejsum.ntx
                 copy file &dok\bufor.dbf to &dys\bufor.dbf
                 do dokdefault			   
			   endif
			dokexport=.f.
RETURN

PROCEDURE KONTTLO1
     if kolor=0  
	   set color to n/w
     else
	   set color to (coldef)
	 endif  
	   for i=9 to 23
         @ i,24 say replicate(chr(178),55)
       next
       set color to (coldef)
       @ 10,26 say "     D A N E    K O N T R A H E N T A    nr        "

       @ 11,26 say " ------------------------------------------------- "
       set color to n/w
	   
       @ 24,0 say space(80)
       @ 12,26 say " NAZWA............                              .  "
       @ 13,26 say " CD NAZWY.........                              .  "
       @ 14,26 say " NIP....             .     KOD POCZTOWY...  -   .  "
       @ 15,26 say " MIASTO...........                              .  "
       @ 16,26 say " ULICA / NR.......                              .  "	   
       @ 17,26 say " GRUPA..     .............TEL....               .  "
       @ 18,26 say " PAGER..               .  FAX....               .  "      
       @ 19,26 say " KONTO..                                        .  "
       @ 20,26 say " KONTO (CD).................                    .  "
       @ 21,26 say " SKROT ...........               .   RABAT      %  "
       set color to
RETURN	   


*******************************************************************************
* Procedura wprowadza zmienne kontrahenta i generuje skroty nazwy i adresu    *
*******************************************************************************
PROCEDURE KONTRAHGET
set color to n/w     
  @ 20,54 say substr(zkkonto,41,20)
set color to 
       set cursor on
       @ 12,44 get znaz1 picture "@!"
       @ 13,44 get znaz2 picture "@!"
       @ 14,34 get znip picture "@!" 
	   @ 14,67 get zkod picture "@!" 	   	   
       @ 15,44 get zmiasto picture "@!"
       @ 16,44 get zulica picture "@!" 
	   @ 17,34 get zgrupa picture "@!" 
       @ 17,59 get ztel picture "@!" 
       @ 18,34 get zpager picture "@!" 
       @ 18,59 get zfax picture "@!" 
       @ 19,34 get zkkonto picture "@S40"
       @ 21,44 get znskrot picture "@!" 
	   @ 21,69 get zrabat picture "99.9"
       read
       if znskrot=space(15)
	     if znip#space(13)
		   znskrot=znip
		 else
		   znskrot=substr(zulica,1,15)
		 endif
       *  znskrot=substr(znaz1,1,15)
         set color to n/w  
         @ 21,44 say znskrot 
         set color to 
       endif
       set color to n/w
	   @ 20,54 say substr(zkkonto,41,20)
	   set color to
RETURN	   


PROCEDURE WPLATA
local t[2],q[2]
local lodsetki,ldrozl
private ptermin1,ptermin2,pkwota1,pkwota2,plastdat,podsetki,min2,t1[6],q1[6]
t[1]:="wdata"
t[2]:="wwplata"
q[1]:="DATA"
q[2]:="WPLATA "
t1[1]:="odat1"
t1[2]:="odat2"
t1[3]:="opodstawa"
t1[4]:="oiledni"
t1[5]:="ostawka"
t1[6]:="odsetki"
q1[1]:="OD DN."
q1[2]:="DO DN."
q1[3]:="PODSTAWA"
q1[4]:="DNI"
q1[5]:="ST."
q1[6]:="ODSETKI"


***
do zflad     &&nadanie zmiennym dokumentu wartosci aktualnego rekordu
*** dane kontrahenta (pracownika)
do case
  case substr(ztyp,4,1)$"FRNfrUu".or.substr(ztyp,4,1)$"PT".and.gonful
    do kondefault
    select 5
    use kontrah index kont_nr
    seek znplat
    if .not. found()
      use trah index trah_nr
        seek znplat
          if .not. found()
          do tkom with "PROBLEM! 1  Indeksuj i ponow probe.   Nacisnij dowolny klawisz"  
          use  
              do dokdefault
            return
        endif
    endif         
    do zklad
      zrabat=zdrabat
      zkontrahkonto=zkkonto
    close  
endcase
do dokdefault
***
clear
set color to n/w
@ 0,0 say "                       ROZLICZENIE OPOZNIONEJ PLATNOSCI                         "
set color to (coldef)
for i=1 to 23
  @ i,0 say chr(176)
  @ i,79 say chr(176)
next
@ 2,1 say " Kontrahent:                                  Numer dokumentu:                "
@ 5,1 say " 1 |   Termin platnosci..               2  |   Termin platnosci..             "
@ 6,1 say "   |   Kwota ............                  |   Kwota ............             "
@ 8,0 say replicate(chr(176),80)
@ 20,0 say replicate(chr(176),80)
for i=8 to 20
  @ i,23 say chr(178)
next
@ 8,4 say " REJESTRACJA "
@ 8,44 say " ROZLICZENIE " 
@ 2,14 say znaz1
@ 3,14 say znaz2
@ 2,63 say zndok
use datyplat index datyplat new
seek zndok
if found()
  ptermin1=dtermin
  pkwota1=dkwota
  if substr(zdster,1,1)$"A"
    skip
    ptermin2=dtermin
    pkwota2=dkwota    
  endif
else
  append blank
  if substr(zdster,1,1)$"A"
    ptermin1=zdatzap
    pkwota1=val(zopis)
    ptermin2=ztermin
    pkwota2=zkwota-pkwota1  
    replace dndok with zndok,dtermin with ptermin1,dkwota with pkwota1
	append blank
	replace dndok with zndok,dtermin with ptermin2,dkwota with pkwota2
  else
    ptermin1=ztermin
	pkwota1=zkwota
    replace dndok with zndok,dtermin with ptermin1,dkwota with pkwota1
  endif
endif
close
if substr(zdster,1,1)$"A"
  @ 5,66 say ptermin2
  @ 6,62 say pkwota2 picture "9 999 999.99"
  min2=.t.
else 
  min2=.f.
endif	   
@ 5,26 say ptermin1
@ 6,22 say pkwota1 picture "9 999 999.99"
do skom with "wplata"
select 16
use odsetki index odsetki
delete all
pack
keyboard chr(27)
dbedit(9,24,19,78,t1,"ODS","",q1)
keyboard chr(205)
select 15
use wplata index wplata 
plastdat=zdatdok
set filter to wndok=zndok
go top
keyboard chr(100)
dbedit(9,1,19,22,t,"WPL","",q)

close
select 1

RETURN

FUNCTION ODS(tryb,numer)
local last:=lastkey()
do case
  case last=27
    return 0
endcase
RETURN 1


FUNCTION WPL(tryb,numer)
local ldata:=daf
local lwplata:=0.00,lstopa:=StawkaOdsetek,liledni:=0,lpodstawa:=0.00,lwplata1:=0
local last:=lastkey()
lwplata=wwplata
ldata=wdata
lstopa=wstopa
lastwplata=0
*do skom with "Dopisz    Popraw    Kasuj    Licz    drukuj_pokwiTowanie/Nakaz    teXt"
do skom with "Dopisz         Popraw         Esc - koniec"

do case
  case last=68.or.last=100      &&Dopisz
    do odsetlicz	
    do skom with "ENTER - zatwierdzenie    ESC - rezygnacja"
    set cursor on
    ldata=daf
	lstopa=StawkaOdsetek
	lwplata=0.00
	@ 21,1 say " Kwota ................            "
    @ 22,1 say " Data dokonania wplaty ..          "	
	@ 23,1 say " Stopa procentowa odsetek ...      "
	@ 21,24 get lwplata picture "9999999.99"	
	@ 22,26 get ldata
	@ 23,30 get lstopa picture "9.99"
	read
    if lastkey()#27
      lastwplata=lwplata
	  StawkaOdsetek=lstopa
	  save to pam    
	  set cursor off
	  if lastkey()#27
        append blank
	    replace wndok with zndok,wdata with ldata,wwplata with lwplata,wstopa with lstopa
        go recno()
	  endif
	  do odsetlicz	
	endif  	  
    keyboard chr(205)
    return 2	  
  
  case last=80.or.last=112      &&Popraw
  do skom with "ENTER - zatwierdzenie    ESC - rezygnacja"  
    lwplata1=lwplata
	set cursor on
	@ 21,1 say " Kwota ................            "
    @ 22,1 say " Data dokonania wplaty ..          "	
	@ 23,1 say " Stopa procentowa odsetek ...      "
	@ 21,24 get lwplata picture "9999999.99"	
	@ 22,26 get ldata
	@ 23,30 get lstopa picture "9.99"
	read
    if lastkey()#27
	  lastwplata=lwplata-lwplata1
      StawkaOdsetek=lstopa
      save to pam    
	  set cursor off
	  if lastkey()#27
	    replace wndok with zndok,wdata with ldata,wwplata with lwplata,wstopa with lstopa
        go recno()
        do odsetlicz	
	  endif
	endif  
    keyboard chr(205)
    return 2	    
  
*  case last=75.or.last=107         &&Kasuj
	@ 21,1 say " Kwota ................            "
    @ 22,1 say " Data dokonania wplaty ..          "	
	@ 23,1 say " Stopa procentowa odsetek ...      "
	@ 21,24 say lwplata picture "9999999.99"	
	@ 22,26 say ldata
	@ 23,30 say lstopa picture "9.99"  
    zz=.t.
	do gkom with "Usunac wplate ?",zz
	if zz.and.lastkey()#27
	  delete
	  pack
	  do odsetlicz
	endif
    keyboard chr(205)
    return 2	    	

  case last=76.or.last=108
    do odsetlicz
    keyboard chr(205)
    return 2	    		
    
  case last=-1
    do odsetlicz	
	
  case last=27
    return 0
endcase
RETURN 1

PROCEDURE ODSETLICZ
local lodsetki:=0,llicz:=1,lsuma:=0,liledni:=0,lpodstawa:=0,lstopa:=0,ldata:=daf
local lp:=1,ltermin1:=ptermin1,ltermin2:=ptermin2,lkwota1:=pkwota1,lkwota2:=pkwota2
local ldat1:=daf
select 16
delete all           &&wyczyszczenie bazy pomocniczej okreslajacej rozliczenie
pack
select 15
do while.t.
  lsuma=0
  go top
  do while.not.eof()
    lp=lp+1 
    ldat=wdata
    if ldat-ltermin1>0
	  if min2.and.llicz=1.and.ldat-ltermin2>0
	    ldat=ltermin2
	  endif
	  lpodstawa=lkwota1-lsuma
	  liledni=ldat-ltermin1
	  lsuma=lsuma+wwplata
	  ldat1=ltermin1
	  ltermin1=ldat
*	  lstopa=StawkaOdsetek
      lstopa=wstopa
	  if lpodstawa>0
	    lodsetki=lodsetki+lpodstawa*liledni*lstopa/100
        select 16
		append blank
		replace odat1 with ldat1,odat2 with ldat,opodstawa with lpodstawa
 		replace oiledni with liledni,ostawka with lstopa,ondok with zndok
		replace odsetki with lpodstawa*liledni*lstopa/100
        go top
        keyboard chr(27)
        dbedit(9,24,19,78,t1,"ODS","",q1)
        keyboard chr(205)
		select 15
	  endif
	else
	  lsuma=lsuma+wwplata
	endif 
    skip
  enddo
  llicz=llicz+1
  if min2
    if llicz>2
	  exit
	else
	  lkwota1=lkwota1+lkwota2
	  ltermin1=ltermin2  
	endif
  else
    exit
  endif
enddo
*@ 21,62 say "RAZEM:"
*@ 21,70 say lodsetki picture "99 999.99"
@ 21,44 say "Kwota do rozliczenia:"
@ 22,44 say "Odsetki: ............"
@ 23,44 say "Razem do zaplaty: ..."
*@ 21,67 say zwartosc-lsuma picture "99 999.99"
@ 21,67 say zkwota-lastwplata picture "99 999.99"
@ 22,67 say lodsetki picture "99 999.99"
*@ 23,67 say zwartosc-lsuma+lodsetki picture "99 999.99"
@ 23,67 say zkwota-lastwplata+lodsetki picture "99 999.99"
select 1
*replace kwota with zwartosc+lodsetki-lsuma
replace kwota with kwota-lastwplata
     if substr(dster,1,1)$"A"
	   lopis=val(zopis)          &&opis zawiera kwote pierwszej wplaty w postaci tekstu
	   lopis=lopis-lsuma
	   if lopis<0
	     lopis=0
	   endif
       replace opis with str(lopis,12,2)
	 else
	   replace datzap with ldat  
	 endif  
     if filtrkart.and.kwota=0 
       go top
     endif  
if lsuma>=zwartosc.and.kwota>0
  replace opis with "ODSETKI"
endif	 
select 15

RETURN
