*******************************************************************************
* Modul zapewnia obsluge drukarki fiskalnej DF-2 /realizuje wydruk paragonu/  *
* Dane wejsciowe to otwarty plik "towbuf.dbf"                                 *
* Parametr pcom zawiera adres portu szeregowego                               *
*******************************************************************************
parameters pcom
local lnazwa,lind_ptu,lilosc,lcena,lforma,lkwota_zapl,lkwota_reszty
local kod_zwr,lrabat:="000",lkwota:="0.00     ",lsum:=0
*pcom=1016        && COM1
*pcom=760         && COM2


kod_zwr = DFStart(pcom)
if.not.kod_zwr=1
  do drukcom with kod_zwr
  return  
endif

kod_zwr = DFStartTra()
if.not.kod_zwr=1
  do drukcom with kod_zwr
  return  
endif

use towbuf index towbuf new
do while.not.eof()
  lsum=lsum+round(til*BRUTTO(tcen,tstawka),2)
  lnazwa=substr(tnaz,1,18)
  do case
    case tstawka=22
      lind_ptu="A"
    case tstawka=17
      lind_ptu="B"
    case tstawka=7
      lind_ptu="C"
    case tstawka=0 
      if substr(tster,1,1)="z"
	    lind_ptu="Z"	  	  	  
	  else
        lind_ptu="D"	  	  	  
	  endif	
  endcase
  lilosc=str(til,9,2)
  lcena=str(BRUTTO(tcen,tstawka),9,2)

  kod_zwr = DFAdd(lnazwa,lind_ptu,lilosc,lcena,lrabat)
  if.not.kod_zwr=1
    do drukcom with kod_zwr
    return  
  endif
  skip
enddo
close

kod_zwr = DFFinish( lkwota )
if.not.kod_zwr=1
  do drukcom with kod_zwr
  return  
endif
*lforma=zsposzap             &&sprawdzic dostepne formaty
if zsposzap="G"
  lforma=zsposzap           
else
  lforma="N"
endif
lkwota_zap=str(lsum,9,2)
lkwota_reszty="0.00     "

kod_zwr = DFPrParf(lforma,lkwota_zapl,lkwota_reszty)
if.not.kod_zwr=1
  do drukcom with kod_zwr
  return  
endif
RETURN

PROCEDURE CKOM3
parameters ptxt1,ptxt2,ptxt3
local len[10],ile_wiersz:=5,ile_kol:=30,w1,w2,k1,k2,ek

len1=len(ptxt1)
len2=len(ptxt2)
len3=len(ptxt3)

save screen to ek
if len1#0
  ile_wiersz=1
endif
if len2#0
  ile_wiersz=2
endif
if len3#0
  ile_wiersz=3
endif
ile_kol=max(ile_kol,len1)
ile_kol=max(ile_kol,len2)
ile_kol=max(ile_kol,len3)

w1=round((24-ile_wiersz)/2,0)-1
w2=w1+ile_wiersz+1
k1=round((80-ile_kol)/2,0)-3
k2=k1+ile_kol+6

@ w1,k1 clear to w2,k2
@ w1,k1 to w2,k2 double
@ w1,k1+3 say " Uwaga ! "
@ w2,k1+3 say "Nacisnij dowolny klawisz"
k1=round((80-len1)/2,0)
@ w1+1,k1+1 say ptxt1
k1=round((80-len2)/2,0)
@ w1+2,k1+1 say ptxt2
k1=round((80-len3)/2,0)
@ w1+3,k1+1 say ptxt3

inkey(0)
restore screen from ek
RETURN


PROCEDURE CKOM5
parameters ptxt1,ptxt2,ptxt3,ptxt4,ptxt5
local len[10],ile_wiersz:=5,ile_kol:=30,w1,w2,k1,k2,ek

len1=len(ptxt1)
len2=len(ptxt2)
len3=len(ptxt3)
len4=len(ptxt4)
len5=len(ptxt5)

save screen to ek
if len1#0
  ile_wiersz=1
endif
if len2#0
  ile_wiersz=2
endif
if len3#0
  ile_wiersz=3
endif
if len4#0
  ile_wiersz=4
endif
if len5#0
  ile_wiersz=5
endif
ile_kol=max(ile_kol,len1)
ile_kol=max(ile_kol,len2)
ile_kol=max(ile_kol,len3)
ile_kol=max(ile_kol,len4)
ile_kol=max(ile_kol,len5)

w1=round((24-ile_wiersz)/2,0)-1
w2=w1+ile_wiersz+1
k1=round((80-ile_kol)/2,0)-3
k2=k1+ile_kol+6

@ w1,k1 clear to w2,k2
@ w1,k1 to w2,k2 double
@ w1,k1+3 say " Uwaga ! "
@ w2,k1+3 say "Nacisnij dowolny klawisz"
k1=round((80-len1)/2,0)
@ w1+1,k1+1 say ptxt1
k1=round((80-len2)/2,0)
@ w1+2,k1+1 say ptxt2
k1=round((80-len3)/2,0)
@ w1+3,k1+1 say ptxt3
k1=round((80-len4)/2,0)
@ w1+4,k1+1 say ptxt4
k1=round((80-len5)/2,0)
@ w1+5,k1+1 say ptxt5

inkey(0)
restore screen from ek
RETURN


PROCEDURE DRUKCOM
parameters pkod
local blad:="Blad wykonania NR        "
blad=stuff(blad,19,3,str(pkod,3))
do case
  case pkod=0
    do ckom3 with "Brak komunikacji z drukarka.","",blad
  case pkod=2
    do ckom3 with "Zly zakres lub format danych","",blad
  case pkod=3
    do ckom3 with "Przekroczony zakres arytmetyczny","",blad
  case pkod=4
    do ckom3 with "Transakcja anulowana.","Uplynal maksymalny czas trwania transakcji.",blad
  case pkod=5
    do ckom3 with "Brak napiecia 24 V .","",blad
  case pkod=6
    do ckom3 with "SERWIS WYMAGANY !","Wykryto blad totalizerow.",blad
  case pkod=7
    do ckom3 with "Zablokowany mechanizm drukarki.","",blad
  case pkod=8
    do ckom3 with "Drukarka jest w stanie TYLKO ODCZYT.","",blad
  case pkod=9
    do ckom3 with "Data w kalendarzu drukarki jest wczesniejsza","od daty ostatniej rejestracji w pamieci fiskalnej.",blad
  case pkod=10
    do ckom3 with "Nie wykonano fiskalnego raportu dobowoego","za dzien wczesniejszy",blad
  case pkod=11
    do ckom3 with "Proba sprzedazy towaru ze zwiekszonym indeksem PTU","podczas gdy byl on juz poprzednio zmniejszany",blad
  case pkod=12
    do ckom3 with "Trzy nieudane proby zapisu do pamieci fiskalnej,","drukarka jest w stanie SERVIS WYMAGANY.",blad
  case pkod=13
    do ckom3 with "Brak miejsca na nowe stawki.","",blad
  case pkod=14 
    do ckom3 with "Transakcja nie zostala rozpoczeta.","",blad
  case pkod=15
    do ckom3 with "Zbyt duzo pozycji na paragonie.","",blad
  otherwise
    do ckom3 with "",blad,""	  	
endcase
RETURN

