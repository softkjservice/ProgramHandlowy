 *************************************************************************
* ANALIZA OBROTU TOWAROWEGO - HISTORIA TOWAROW                                *
*******************************************************************************
PROCEDURE MAGANMENU
parameters pmenu
local t[18],g[4],dk[6],wd[2]
local lms:=month(daf)         &&numer miesiaca do wydruku
local lmiesiac:=space(12)
local ls:=1                   &&numer pozycji menu wyboru okresu raportu
local ld1:=daf                &&raport za dzien lub poczatek przedzialu czasowego
local ld2:=daf                &&koniec przedzialu czasowego
local lbo:=.t.           
local lzakup:=.t.
local lsprzedaz:=.t.      
local lprzesuniecia:=.t. 
local lwz:=.t.
local lpz:=.t.
local lzbiorczy:=.t.          &&wydruk raportu zbiorczego      
local ek:=savescreen(0,0,24,79)
local lfiltr:=""
local ldruk:=.t.
local ekran
private fnum1:=space(15),fnum2:=space(15),fd1:=date(),fd2:=date()
private rnum1:=space(15),rnum2:=space(15),rd1:=date(),rd2:=date()
private pnum1:=space(15),pnum2:=space(15),pd1:=date(),pd2:=date()
private dokument:=0,text1:=space(80),text2:=space(80),text3:=space(80)
public fdat1:=date()
public fdat2:=date()
public fmies:=month(date())
drukar=.t.
hzakup=.f.       && rozgraniczenie wydruku dla zakupu i sprzedazy
w=0
strona=1
fwar=".t."
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "° R A P O R T:  B.O. ZAKUP  SPRZEDAZ  PRZESUNIECIA  WZ  PZ °"
t[3]:= "°==========================================================°"
t[4]:= "°   PARAMETRY   ²    OKRES :                               °"
t[5]:= "°²²²²²²²²²²²²²²²²                                          °"
t[6]:= "° ZATWIERDZENIE ²                                          °"
t[7]:= "° 1. OKRES      ²                                          °"
t[8]:= "° 2. DOKUMENTY  ²                                          °"
t[9]:= "° 3. WYDRUK     ²                                          °"
t[10]:="°²²²²²²²²²²²²²²²²                                          °"
t[11]:="°               ²    DOKUMENTY :        WYDRUK :           °"
t[12]:="°               ²                                          °"
t[13]:="°               ²                                          °"
t[14]:="°               ²                                          °"
t[15]:="°               ²                                          °"
t[16]:="°               ²                                          °"
t[17]:="°               ²                                          °"
t[18]:="°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
g[1]:=" ZATWIERDZENIE "
g[2]:=" 1. OKRES      "
g[3]:=" 2. DOKUMENTY  "
g[4]:=" 3. WYDRUK     "
DK[1]:="ûÞ B.O.       "
DK[2]:="ûÞ ZAKUP      "
DK[3]:="ûÞ SPRZEDAZ   "
DK[4]:="ûÞPRZESUNIECIA"
DK[5]:="ûÞ W-Z.       "
DK[6]:="ûÞ P-Z.       "
WD[1]:="ûÞ DRUKARKA  "
WD[2]:=" Þ EKRAN     "
text2=space(70)
text3=space(70)
save screen to ek
*tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
@ 0,0,24,79 box tlo
set color to n/w,w/n
@ 0,0 say " P A R A M E T R Y     R A P O R T U                                            "
for i=1 to 18
  @ i+2,10 say t[i]
next
do skom with "STRZALKI - przemieszczanie kursora   ENTER -  zatwierdzenie    ESC - rezygnacja"
set color to (coldef)
*@ 3,10,20,69 box chr(205)
@ 3,10 to 20,69 double
@ 14,32 to 18,47 double  
@ 14,51 to 17,65 double  
@ 15,33 say dk[1]
@ 16,33 say dk[2]
@ 17,33 say dk[3]
*@ 18,33 say dk[4]
@ 15,52 say wd[1]
@ 16,52 say wd[2]
do anokres with 7,32,ls,lms,ld1,ld2,.t.
do while .t.
  setprc(0,0)
  w=prow()
  s=achoice(8,11,12,25,g)
  keyboard chr(205)
  do case
    case s=1
      lfiltr=".t."
      save screen to ekran
	  fdat1=ld1          &&przygotowanie zmiennych typu public do filtru
      fdat2=ld2
      fmies=lms
      clear typeahead	
      @ 16,11 say "   Czekaj !    "
      if drukar
        @ 17,11 say "Trwa drukowanne" 
      else
        @ 17,11 say " Trwa analiza. " 
      endif	
************definiowanie filtra czasowego
      do case
        case ls=1                       &&raport za dzien
	      lfiltr="tdat=fdat1"
		  text2="ZA DZIEN  :                                                                                  "          
          text2=stuff(text2,15,8,dtoc(ld1))          		  
	    case ls=2                       &&raport  za miesiac
	      lfiltr="month(tdat)=fmies"
          do miesiac with lms,lmiesiac
		  text2="ZA MIESIAC :                                                                                 "          
          text2=stuff(text2,15,12,lmiesiac)          		
        case ls=3                       &&za okres od do
	      lfiltr="max(fdat1,tdat)=tdat.and.min(fdat2,tdat)=tdat"
		  text2="ZA OKRES OD DNIA :                                                                           "          
		  text3="         DO DNIA :                                                                           "          		  
          text2=stuff(text2,19,8,dtoc(ld1))          		  
          text3=stuff(text3,19,8,dtoc(ld2))          		  		  
      endcase
	  fwar=lfiltr
*************
      if.not.drukar
        @ 16,11 say "   Czekaj !    "
        @ 17,11 say " Trwa analiza. " 
        delete file "\kj.txt"
        set printer to "\kj.txt"
      else
        do startrap with 1,ldruk
	    if.not.ldruk
          restore screen from ek
	      return
	    endif
        @ 16,11 say "   Czekaj !    "
        @ 17,11 say "Trwa drukowanne"   
      endif  
  
      set device to printer
      if drukar
        @ prow(),pcol() say &zdr_kond
      else
	    clear typeahead 
      endif	
      text1="ANALIZA ZBIORCZA B.O. ZAKUPU SPRZEDAZY PRZESUNIEC MIEDZYMAGAZYNOWYCH  WZ i PZ"  

      select 1
     
      set device to screen	  
	  zz=.t.
      do gkom with "Aktualizowac dane ?  [T/N]",zz
	  if zz.and.lastkey()#27
	    do magplik with lbo,lzakup,lsprzedaz,lprzesuniecia,lwz,lpz
	  else
	    if file("magan.dbf")
		  use magan
		else
		  do tkom with "Analiza nie byla jeszcze wykonywana !  Konieczna aktualizacja.  OK! " 
		endif   
	  endif	
      set device to printer	  
*      if drukar
	    do magandruk
*	  else
*       set device to screen	  
*	    browse()
*	  endif      	  
      set device to screen	  	  
      set printer to

      if.not.drukar
	    naz:="\kj.txt"
        do medit with naz
      endif  
      set device to screen	  
      restore screen from ekran
      @ 16,11 say "Koniec raportu!"
      @ 17,11 say "Esc->rezygnacja" 

    case s=2
      do anokres with 7,32,ls,lms,ld1,ld2,.F.
    case s=3
	  set cursor on
      d=1
      do while.t.
        d=achoice(15,33,17,46,dk,,,d)
		do case
		  case d=1
		    @ row(),46 get lbo
			read
			if lbo
			  dk[1]=stuff(dk[1],1,1,"û")
			else
			  dk[1]=stuff(dk[1],1,1," ")			  
			endif
		  case d=2
		    @ row(),46 get lzakup   
			read
			if lzakup   
			  dk[2]=stuff(dk[2],1,1,"û")
			else
			  dk[2]=stuff(dk[2],1,1," ")			  
			endif
		  case d=3
		    @ row(),46 get lsprzedaz
			read
			if lsprzedaz
			  dk[3]=stuff(dk[3],1,1,"û")
			else
			  dk[3]=stuff(dk[3],1,1," ")			  
			endif			
		  case d=4
		    @ row(),46 get lprzesuniecia
			read
			if lprzesuniecia
			  dk[4]=stuff(dk[4],1,1,"û")
			else
			  dk[4]=stuff(dk[4],1,1," ")			  
			endif						
		  case d=5
		    @ row(),46 get lwz
			read
			if lwz
			  dk[5]=stuff(dk[5],1,1,"û")
			else
			  dk[5]=stuff(dk[5],1,1," ")			  
			endif						
		  case d=6
		    @ row(),46 get lpz
			read
			if lpz
			  dk[6]=stuff(dk[6],1,1,"û")
			else
			  dk[6]=stuff(dk[6],1,1," ")			  
			endif												
		  case d=0
		    exit
		endcase
	  enddo	
	  set cursor off
    case s=4
      ws=achoice(15,52,16,64,wd)
      do case
	    case ws=1
		  drukar=.t.
		  wd[1]=stuff(wd[1],1,1,"û")
		  wd[2]=stuff(wd[2],1,1," ")
	    case ws=2
		  drukar=.f.
		  wd[1]=stuff(wd[1],1,1," ")		  
		  wd[2]=stuff(wd[2],1,1,"û")
	  endcase
      @ 15,52 say wd[1]
      @ 16,52 say wd[2]	  
	case s=0
	  exit  
  endcase
enddo
restore screen from ek
RETURN


PROCEDURE MAGANDRUK
local lp:=1
local lt1:="|...|................................|.......|.........................................................................................|"
local lt2:="|   |                                |       |                                                                                         |"
local lt3:="----------------------------------------------------------------------------------------------------------------------------------------"
local lnazwa:=space(32)
local lkod:=space(7)
local ljm:=space(3)
local lbo:=space(10)
local lzakup:=space(10)
local lsprzedaz:=space(10)
local lprzesuniecia:=space(10)
local lwz:=space(10)
local lpz:=space(10)
local lilosc_d:=space(10)
local lilosc_m:=space(10)
local lroznica:=space(10)
local lwartosc_d:=0
local lwartosc_m:=0
setprc(0,0)
w=prow()
do maganglow
do magantyt						
go top
do while.not.eof()
  lnazwa=nazwa
  lkod=kod
    lbo=stuff("..........",11-len(alltrim(str(bo,10,2))),len(alltrim(str(bo,10,2))),alltrim(str(bo,10,2))) 
	lzakup=stuff("..........",11-len(alltrim(str(zakup_d,10,2))),len(alltrim(str(zakup_d,10,2))),alltrim(str(zakup_d,10,2))) 
	lsprzedaz=stuff("..........",11-len(alltrim(str(sprzedaz_d,10,2))),len(alltrim(str(sprzedaz_d,10,2))),alltrim(str(sprzedaz_d,10,2))) 
	lprzesuniecia=stuff("..........",11-len(alltrim(str(przesuniecia_d,10,2))),len(alltrim(str(przesuniecia_d,10,2))),alltrim(str(przesuniecia_d,10,2))) 
	lwz=stuff("..........",11-len(alltrim(str(wz_d,10,2))),len(alltrim(str(wz_d,10,2))),alltrim(str(wz_d,10,2))) 
	lpz=stuff("..........",11-len(alltrim(str(pz_d,10,2))),len(alltrim(str(pz_d,10,2))),alltrim(str(pz_d,10,2))) 	
    lilosc_d=stuff("..........",11-len(alltrim(str(ilosc_d,10,2))),len(alltrim(str(ilosc_d,10,2))),alltrim(str(ilosc_d,10,2))) 
    lilosc_m=stuff("..........",11-len(alltrim(str(ilosc_m,10,2))),len(alltrim(str(ilosc_m,10,2))),alltrim(str(ilosc_m,10,2)))  
    lroznica=stuff("..........",11-len(alltrim(str(roznica_d_m,10,2))),len(alltrim(str(roznica_d_m,10,2))),alltrim(str(roznica_d_m,10,2))) 
	
    lt1=stuff(lt1,2,3,str(lp,3))
    lt1=stuff(lt1,6,32,lnazwa)
	lt1=stuff(lt1,39,7,lkod)
	lt1=stuff(lt1,47,10,lbo)
	lt1=stuff(lt1,57,10,lzakup)
	lt1=stuff(lt1,67,10,lsprzedaz)
	lt1=stuff(lt1,77,10,lprzesuniecia)
	lt1=stuff(lt1,87,10,lwz)
	lt1=stuff(lt1,97,10,lpz)	
	lt1=stuff(lt1,107,10,lilosc_d)	
	lt1=stuff(lt1,117,10,lilosc_m)
	lt1=stuff(lt1,127,10,lroznica)	
*	lt1=stuff(lt1,137,3,jm)
    @ w,0 say lt1
    w=w+1
    lt1:="|...|................................|.......|.........................................................................................|"
  skip
  if w>dlugosc-4.and..not.eof().and.drukar
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
*    do dzysktyt						
    do magantyt					
  endif
  lp=lp+1
enddo
  do maganstopa 
  if drukar
    eject
  else 
    w=0
    clear typeahead  
  endif  
RETURN


*******************************************************************************
* DRUKUJE NAGLOWEK RAPORTU : rodz dokumentu, okres ,od numeru do numeru       *
*******************************************************************************
PROCEDURE MAGANGLOW
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
  endif
  @ w,0 say text1
  w=w+1
  @ w,0 say replicate(chr(205),79)
  w=w+1
  @ w,0 say text2
  w=w+1
  @ w,0 say text3
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
    else
      @ prow(),pcol() say &zdr_kond
    endif  
  endif
  w=w+1
RETURN




PROCEDUR MAGANTYT
local lt1:="========================================================================================================================================="
local lt2:="|Lp.|   N A Z W A   T O W A R U      | K O D |  B. O.  | ZAKUPY  |SPRZEDAZ | PRZESU- |   W-Z   |   P-Z   | ILOSC Z | ILOSC W | ROZNICA  |"
local lt3:="|   |                                |       |         |         |         | NIECIA  |         |         |DOKUMENT.|MAGAZYNIE|DOK.-MAG. |"
local lt4:="|===|================================|=======|=========|=========|=========|=========|=========|=========|=========|=========|========= |"
local lt5:="|   |                                |                                                                                                  |"
@ prow(),pcol() say &zdr_kond
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
@ w,0 say lt5
w=w+1
RETURN


PROCEDURE MAGANSTOPA
local lt1:="|   |                                |       |         |         |         |         |         |         |         |         |         |"
local lt2:="========================================================================================================================================"
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
if.not.drukar
  w=w+5
  @ w,0 say replicate(chr(42),138)
endif
RETURN


PROCEDURE MAGPLIK
parameters pbo,pzakup,psprzedaz,pprzesuniecia,pwz,ppz
*local lnazwa,lkod,lilosc
do dokdefault
if.not.file("magan.dbf")
  do magan_tworz
else
  use magan
  zap
  close
endif
select 1
use magan
select 2
do magdefault
use magazyn index mag_naz
@ 22,2 say "Aktualnie obslugiwany rekord :                 Ostatni :                "  
@ 22,58 say lastrec()
do while.not.eof()
  do maglad
  select 1
  append blank
  replace nazwa with zmnaz,kod with zmkod,ilosc_m with zmil,cena_m with zmcen_m
  replace jm with zmjm
  select 2
  skip
enddo
close
select 1
go top
do while.not.eof()
  @ 22,33 say recno()
  lnazwa=nazwa
  lkod=kod
  if pbo
    select 2
    do magdefault
    if file("bo.dbf")
      use bo index bo_naz
  	  seek lnazwa
	  if found()
	    do while mnaz=lnazwa
		  if mkod=lkod
		    lil=mil
            close
			select 1
		    replace bo with lil
			exit
		  endif
		  skip
		enddo
	  endif
      select 2
	  close
    endif
    select 1	  	
  endif
  do dokdefault
  if pzakup.and.file("zakup.dbf")
      select 2  
      use zakup 
	  set filter to tnaz=lnazwa.and.tkod=lkod
	  go top
      fwar1=fwar+""+".and."+dbfilter()
      set filter to &fwar1
	  go top
	  lil=0
	  do while.not.eof()
	    lil=lil+til
	    skip
      enddo	
	  close
	  select 1
	  replace zakup_d with lil
  endif
  if psprzedaz.and.file("sprzedaz.dbf")
      select 2  
      use sprzedaz
	  set filter to tnaz=lnazwa.and.tkod=lkod
	  go top
      fwar1=fwar+""+".and."+dbfilter()
      set filter to &fwar1
	  go top	  
	  lil=0
	  do while.not.eof()
	    lil=lil+til
	    skip
      enddo	
	  close
	  select 1
	  replace sprzedaz_d with lil
  endif		
    if pwz.and.file("wz_tow.dbf")
      select 2  
      use wz_tow
	  set filter to tnaz=lnazwa.and.tkod=lkod.and.tmagazyn
	  go top
      fwar1=fwar+""+".and."+dbfilter()
      set filter to &fwar1
	  go top	  
	  lil=0
	  do while.not.eof()
	    lil=lil+til
	    skip
      enddo	
	  close
	  select 1
	  replace wz_d with lil
  endif		
    if ppz.and.file("pz_tow.dbf")
      select 2  
      use pz_tow
	  set filter to tnaz=lnazwa.and.tkod=lkod.and.tmagazyn
	  go top
      fwar1=fwar+""+".and."+dbfilter()
      set filter to &fwar1
	  go top	  
	  lil=0
	  do while.not.eof()
	    lil=lil+til
	    skip
      enddo	
	  close
	  select 1
	  replace pz_d with lil
  endif		  
  if pprzesuniecia.and.file("przes1.dbf").and.file("przes2.dbf")
      select 2  
      use przes1 
	  set filter to tnaz=lnazwa.and.tkod=lkod
	  go top
      fwar1=fwar+""+".and."+dbfilter()
      set filter to &fwar1
	  go top	  
	  lil=0
	  do while.not.eof()
	    lil=lil-til
	    skip
      enddo	
	  close
	  select 1
	  replace przesuniecia_d with lil
      select 2  
      use przes2 
	  set filter to tnaz=lnazwa.and.tkod=lkod
	  go top
	  lil=0
	  do while.not.eof()
	    lil=lil+til
	    skip
      enddo	
	  close
	  select 1
	  replace przesuniecia_d with przesuniecia_d+lil	
  endif  
  skip
enddo
go top
do while.not.eof()
  replace ilosc_d with bo+zakup_d-sprzedaz_d+przesuniecia_d-wz_d+pz_d
  replace roznica_d_m with ilosc_d-ilosc_m
  skip
enddo
*browse()
RETURN

PROCEDURE MAGAN_TWORZ
*local lremzer,lremakt,lvatzer,lvatzap,lvat,lryczlt
select 100
create nowa
use nowa 
append blank
replace field_name with "NAZWA"
replace field_type with "C"
replace field_len with 32
append blank
replace field_name with "KOD"
replace field_type with "C"
replace field_len with 7
append blank
replace field_name with "JM"
replace field_type with "C"
replace field_len with 3
append blank
replace field_name with "BO"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ZAKUP_D"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "SPRZEDAZ_D"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "PRZESUNIECIA_D"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "WZ_D"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "PZ_D"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ILOSC_D"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ILOSC_M"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "ROZNICA_D_M"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2
append blank
replace field_name with "CENA_M"
replace field_type with "N"
replace field_len with 12
replace field_dec with 2

create magan from nowa
close
erase nowa.dbf
RETURN