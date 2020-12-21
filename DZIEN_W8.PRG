 *PROCEDURE DZMENU
local t[18],g[4],dk[3],wd[2]
local lms:=month(daf)         &&numer miesiaca do wydruku
local lmiesiac:=space(12)
local ls:=1                   &&numer pozycji menu wyboru okresu raportu
local ld1:=daf                &&raport za dzien lub poczatek przedzialu czasowego
local ld2:=daf                &&koniec przedzialu czasowego
local lfaktury:=.t.           &&wydruk faktur
local lrachunek:=.t.          &&wydruk rachunkow 
local lparagon:=.t.          &&wydruk paragonow
local ek:=savescreen(0,0,24,79)
local lfiltr:=""
local lzakup:=0
local lsprzedaz:=0
local lnaliczony:=0
local lnalezny:=0
local lszakup:=0
local lssprzedaz:=0
local lsnaliczony:=0
local lsnalezny:=0
local ldruk:=.t.
local ekran
local ltxnum:=str(rdnum+1,4),lrdnum:=0
local ln22:=0,ln07:=0,lv22:=0,lv07:=0
private fn22:=0,fn07:=0,fn00:=0,fnzw:=0,fv22:=0,fv07:=0,fv00:=0,fvzw:=0
private rn22:=0,rn07:=0,rn00:=0,rnzw:=0,rv22:=0,rv07:=0,rv00:=0,rvzw:=0
private pn22:=0,pn07:=0,pn00:=0,pnzw:=0,pv22:=0,pv07:=0,pv00:=0,pvzw:=0
private niedoplata:=0,rddata:=daf
private fnum1:=space(15),fnum2:=space(15),fd1:=date(),fd2:=date()
private rnum1:=space(15),rnum2:=space(15),rd1:=date(),rd2:=date()
private pnum1:=space(15),pnum2:=space(15),pd1:=date(),pd2:=date()
private text1:=space(80),text2:=space(80),text3:=space(80)
public fdat1:=date()
public fdat2:=date()
public fmies:=month(date())
drukar=.t.
w=0
text1="ZESTAWIENIE DOKUMENTOW SPRZEDAZY  NR      "
text1=stuff(text1,38,4,ltxnum)
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "°        Z E S T A W I E N I E     S P R Z E D A Z Y       °"
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
DK[1]:="ûÞ FAKTURY    "
DK[2]:="ûÞ RACHUNKI   "
DK[3]:="ûÞ PARAGONY   "
WD[1]:="ûÞ DRUKARKA  "
WD[2]:=" Þ EKRAN     "
text2=space(80)
text3=space(80)
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
@ 15,52 say wd[1]
@ 16,52 say wd[2]
do anokres with 7,32,ls,lms,ld1,ld2,.t.
do while .t.
  setprc(0,0)
  w=prow()
  s=achoice(8,11,11,25,g)
  keyboard chr(205)
  do case
    case s=1
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
	      lfiltr="datdok=fdat1"
		  text2="ZA DZIEN  :                                                                                  "          
          text2=stuff(text2,15,8,dtoc(ld1))          		  
          text3=space(80)
	    case ls=2                       &&raport za miesiac
	      lfiltr="month(datdok)=fmies"
          do miesiac with lms,lmiesiac
		  text2="ZA MIESIAC :                                                                                 "          
          text2=stuff(text2,15,12,lmiesiac)          
	      text3=space(80)
        case ls=3                       &&za okres od do
	      lfiltr="max(fdat1,datdok)=datdok.and.min(fdat2,datdok)=datdok"
		  text2="ZA OKRES OD DNIA :                                                                           "          
		  text3="         DO DNIA :                                                                           "          		  
          text2=stuff(text2,19,8,dtoc(ld1))          		  
          text3=stuff(text3,19,8,dtoc(ld2))          		  		  
      endcase
*************
      lrdnum=rdnum+1
	  ltxnum=str(lrdnum,4)
	  text1=stuff(text1,38,4,ltxnum)
      if.not.drukar
        @ 16,11 say "   Czekaj !    "
        @ 17,11 say " Trwa analiza. " 
        delete file "\kj.txt"
        set printer to "\kj.txt"
      else
        do rdparam with lrdnum
        if lastkey()=27
          restore screen from ek
	      return		  
		endif
		do startrap with 1,ldruk
	    if.not.ldruk
          restore screen from ek
	      return
	    endif
        @ 16,11 say "   Czekaj !    "
        @ 17,11 say "Trwa drukowanne"   
		rdnum=lrdnum
		ltxnum=str(lrdnum,4)
		text1=stuff(text1,38,4,ltxnum)
		save to pam
      endif  
  
      set device to printer
      if drukar
        @ prow(),pcol() say &zdr_kond
      else
	    clear typeahead 
      endif	
      ************************  obliczanie lacznych wartosci dokumentow
      do rdzer
	  select 1
      if lfaktury
		use dokument index dok_num
	    set filter to &lfiltr
		go top
        fnum1=ndok
        if fnum1#space(15)
		  fnum1=stuff(fnum1,12,1,"F") 
		  *fnum1=space(15)
		endif  
		go bottom
		fnum2=ndok
		if fnum2#space(15)
          fnum2=stuff(fnum2,12,1,"F") 
		  *fnum2=space(15)
		endif  

		
		filtr=lfiltr+".and.substr(ndok,12,1) $ 'FU'"
		set filter to &filtr
		go top
        do while.not.eof()
		  ln22=dnet_22
		  ln07=dnet_07
		  do doklicz with ln22,ln07,lv22,lv07
          fn22=fn22+ln22
		  fn07=fn07+ln07		  
          fn00=fn00+dnet_00
		  fnzw=fnzw+dnet_zw 		  
          fv22=fv22+lv22
		  fv07=fv07+lv07		  		  
          niedoplata=niedoplata+kwota
		  skip
		enddo
        close
      endif
      if lrachunek
*        use rachunek index rach_num
*	    set filter to &lfiltr
*	    go top
		use dokument index dok_num
	    filtr=lfiltr+".and.substr(ndok,12,1) $ 'NR'"
		set filter to &filtr
		go top
        rnum1=ndok
		if rnum1#space(15)
		  *rnum1=stuff(rnum1,12,1,"R")
		  rnum1=space(15)
		endif
		go bottom
		rnum2=ndok
		if rnum2#space(15)
          *rnum2=stuff(rnum2,12,1,"R")
		  rnum2=space(15)
		endif
		go top
        do while.not.eof()
		  ln22=dnet_22
		  ln07=dnet_07
		  do doklicz with ln22,ln07,lv22,lv07
          rn22=rn22+ln22
		  rn07=rn07+ln07		  
          rn00=rn00+dnet_00
		  rnzw=rnzw+dnet_zw 		  
          rv22=rv22+lv22
		  rv07=rv07+lv07		  	
		  niedoplata=niedoplata+kwota	  
		  skip
		enddo
        close
      endif	  
      if lparagon
        use paragon index par_num
	    set filter to &lfiltr
	    go top
        pnum1=ndok
		if pnum1#space(15)
          pnum1=stuff(pnum1,12,1,"P") 
		endif
		go bottom
		pnum2=ndok
		if pnum2#space(15)
          pnum2=stuff(pnum2,12,1,"P") 
		endif
		go top
        do while.not.eof()
		  ln22=dnet_22
		  ln07=dnet_07
		  do doklicz with ln22,ln07,lv22,lv07
          pn22=pn22+ln22
		  pn07=pn07+ln07		  
          pn00=pn00+dnet_00
		  pnzw=pnzw+dnet_zw 		  
          pv22=pv22+lv22
		  pv07=pv07+lv07		  	
		  niedoplata=niedoplata+kwota	  
		  skip
		enddo
        close
      endif  
      do rddruk_w8
  
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
		    @ row(),46 get lfaktury
			read
			if lfaktury
			  dk[1]=stuff(dk[1],1,1,"û")
			else
			  dk[1]=stuff(dk[1],1,1," ")			  
			endif
		  case d=2
		    @ row(),46 get lrachunek
			read
			if lrachunek
			  dk[2]=stuff(dk[2],1,1,"û")
			else
			  dk[2]=stuff(dk[2],1,1," ")			  
			endif
		  case d=3
		    @ row(),46 get lparagon
			read
			if lparagon
			  dk[3]=stuff(dk[3],1,1,"û")
			else
			  dk[3]=stuff(dk[3],1,1," ")			  
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


PROCEDURE RDZIEN
parameters pdok
local ln22:=0
local ln07:=0
local ln00:=0
local lnzw:=0
local lv22:=0
local lv07:=0

local ltxn22:=space(12),ltxn07:=space(12),ltxn00:=space(12),ltxnzw:=space(12)
local ltxv22:=space(12),ltxv07:=space(12),ltxv00:=space(12),ltxvzw:=space(12)
local ltxb22:=space(12),ltxb07:=space(12),ltxb00:=space(12),ltxbzw:=space(12)
local ltxzv:=space(12)
local ltxsn:=space(12)
local ltxsv:=space(12)
local lndok:=space(15)
setprc(0,0)
w=prow()
do rdzienglow
go top
do while.not.eof()
  
  skip
enddo
if pdruk
  do dzyskstopa with lznsum,lsnsum,lzvsum,lsvsum
  if drukar
    eject
  else 
    w=0
    clear typeahead  
  endif  
endif  
RETURN


*******************************************************************************
* DRUKUJE NAGLOWEK RAPORTU : rodz dokumentu, okres ,od numeru do numeru       *
*******************************************************************************
PROCEDURE RDZIENGLOW
if pdruk
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
  endif
  @ w,0 say text1
  w=w+1
  @ w,0 say replicate(chr(205),61)
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
endif
RETURN




PROCEDUR RDZIENTYT

local lt1:="========================================================================================================================"
local lt2:="|Lp.|     NUMER     |  DATA  |   KONTRAHENT  |  WWARTOSC NETTO W CENIE |         V  A  T         |  Z Y S K   |SREDNIA |"
local lt3:="|   |   DOKUMENTU   |        |               |   ZAKUPU   | SPRZEDAZY  | NALICZONY  |  NALEZNY   |   NETTO    | MARZA  |"
local lt4:="|===|===============|========|===============|============|============|============|============|============|========|"
local lt5:="|   |               |        |               |            |            |            |            |            |        |"
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


PROCEDURE RDZIENSTOPA
PARAMETERS pznetto,psnetto,pzvat,psvat   
local lt1:="|   |               |        |               |            |            |            |            |            |        |"
local lt2:="========================================================================================================================"
local lt3:="                             |  R A Z E M  : |            |            |            |            |            |        |"
local lt4:="                             ------------------------------------------------------------------------------------------|"
local lzysk:=0
local lmarza:=0
local ltxzn:=space(12)
local ltxzv:=space(12)
local ltxsn:=space(12)
local ltxsv:=space(12)
local ltxzyzk:=space(12)
local ltxmarza:=space(8)

lzysk=psnetto-pznetto
lmarza=round((lzysk/pznetto)*100,2)

ltxsn=stuff("............",13-len(alltrim(str(psnetto,12,2))),len(alltrim(str(psnetto,12,2))),alltrim(str(psnetto,12,2))) 
ltxsv=stuff("............",13-len(alltrim(str(psvat,12,2))),len(alltrim(str(psvat,12,2))),alltrim(str(psvat,12,2))) 
ltxzn=stuff("............",13-len(alltrim(str(pznetto,12,2))),len(alltrim(str(pznetto,12,2))),alltrim(str(pznetto,12,2))) 
ltxzv=stuff("............",13-len(alltrim(str(pzvat,12,2))),len(alltrim(str(pzvat,12,2))),alltrim(str(pzvat,12,2)))     
ltxzysk=stuff("............",13-len(alltrim(str(lzysk,12,2))),len(alltrim(str(lzysk,12,2))),alltrim(str(lzysk,12,2))) 
ltxmarza=stuff("........",9-len(alltrim(str(lmarza,8,2))),len(alltrim(str(lmarza,8,2))),alltrim(str(lmarza,8,2)))   

lt3=stuff(lt3,47,12,ltxzn)
lt3=stuff(lt3,60,12,ltxsn)
lt3=stuff(lt3,73,12,ltxzv)
lt3=stuff(lt3,86,12,ltxsv)
lt3=stuff(lt3,99,12,ltxzysk)
lt3=stuff(lt3,112,8,ltxmarza)    



@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
if.not.drukar
  w=w+5
  @ w,0 say replicate(chr(42),120)
endif
RETURN


*******************************************************************************
* Procedura wyboru przedzialu czasowego                                       *
* Znaczenie parametrow : pw,pk   gorny rog ramki mmenu                        *
*                        ps - wynik wyboru (moze byc 1 , 2 lub 3              *
*szerokosc ramki = 48    pnum - numer miesiaca                                *
*                        pdat1, pdat2 - data poczatkowa i koncowa             *
*******************************************************************************
*PROCEDURE ANOKRES

*PROCEDURE STARTRAP

PROCEDURE RDDRUK_W8
local t[35]
local ltxn22:=space(12),ltxn07:=space(12),ltxn00:=space(12),ltxnzw:=space(12)
local ltxv22:=space(12),ltxv07:=space(12),ltxb22:=space(12),ltxb07:=space(12)
local lfb22:=fn22+fv22
local lfb07:=fn07+fv07
local lrb22:=rn22+rv22
local lrb07:=rn07+rv07
local lpb22:=pn22+pv22
local lpb07:=pn07+pv07
local lsn22:=fn22+rn22+pn22
local lsn07:=fn07+rn07+pn07
local lsn00:=fn00+rn00+pn00
local lsnzw:=fnzw+rnzw+pnzw
local lsv22:=fv22+rv22+pv22
local lsv07:=fv07+rv07+pv07
local lsb22:=lsn22+lsv22
local lsb07:=lsn07+lsv07
local lsbrutto:=lsb22+lsb07+lsn00+lsnzw
local lsgot:=lsbrutto-niedoplata
local ltxb:=space(12),ltxniedop:=space(12),ltxg:=space(12)
t[1]:= "==============================================================================================================="
t[2]:= "|Lp.|DOKUMENT|               |               |  WWARTOSC  |      S  T  A  W  K  A    P  O  D  A  T  K  U      |"
t[3]:= "|   |        |   OD NUMERU   |   DO NUMERU   |            |    22  %   |    7  %    |    0  %    |     zw.    |"
t[4]:= "|===|========|===============|===============|============|============|============|============|============|"
t[5]:= "| 1 |FAKTURY |     Numeracja laczna dla obu  |  NETTO...  |            |            |            |            |"
t[6]:= "|   |  DLA   |                               |  VAT.....  |            |            |            |            |"
t[7]:= "|   | FIRM   |         typow faktur          |  BRUTTO..  |            |            |            |            |"
t[8]:= "|-------------------------------------------------------------------------------------------------------------|"
t[9]:= "| 2 |FAKTURY |               |               |  NETTO...  |            |            |            |            |"
t[10]:="|   |  DLA   |               |               |  VAT.....  |            |            |            |            |"
t[11]:="|   | OSOB   |               |               |  BRUTTO..  |            |            |            |            |"
t[12]:="|-------------------------------------------------------------------------------------------------------------|"
t[13]:="| 3 |PARAGONY|               |               |  NETTO...  |            |            |            |            |"
t[14]:="|   |        |               |               |  VAT.....  |            |            |            |            |"
t[15]:="|   |        |               |               |  BRUTTO..  |            |            |            |            |"
t[16]:="|-------------------------------------------------------------------------------------------------------------|"
t[17]:="                             |   RAZEM :     |  NETTO...  |            |            |            |            |"
t[18]:="                             |               |  VAT.....  |            |            |            |            |"
t[19]:="                             |               |  BRUTTO..  |            |            |            |            |"
t[20]:="                             ----------------------------------------------------------------------------------"
t[21]:="                                                                                                               "
t[22]:="LACZNA WARTOSC BRUTTO .......                                                                                  "
t[23]:="OPOZNIONA PLATNOSC ..........                                                                                  "
t[24]:="WARTOSC BRUTTO W GOTOWCE ....                                                                                  "
t[25]:="                                                                                                               "
t[26]:="                                                                                                               "
t[27]:="                                                                                                               "
t[28]:="                                                                                                               "
t[29]:="SPORZADZIL:                                ........................                    ........................"
t[30]:="                                                    PODPIS                                      PIECZEC        "
t[31]:="                                                                                                               "
t[32]:="                                                                                                               "
t[33]:="                                                                                                               "
t[34]:="ZATWIERDZIL:                               ........................                                            "
t[35]:="                                                    PODPIS                 POZYCJA KSIEGOWANIA NR  ........... "




ltxn22=stuff("............",13-len(alltrim(str(fn22,12,2))),len(alltrim(str(fn22,12,2))),alltrim(str(fn22,12,2))) 
ltxn07=stuff("............",13-len(alltrim(str(fn07,12,2))),len(alltrim(str(fn07,12,2))),alltrim(str(fn07,12,2))) 
ltxn00=stuff("............",13-len(alltrim(str(fn00,12,2))),len(alltrim(str(fn00,12,2))),alltrim(str(fn00,12,2))) 
ltxnzw=stuff("............",13-len(alltrim(str(fnzw,12,2))),len(alltrim(str(fnzw,12,2))),alltrim(str(fnzw,12,2))) 
ltxv22=stuff("............",13-len(alltrim(str(fv22,12,2))),len(alltrim(str(fv22,12,2))),alltrim(str(fv22,12,2))) 
ltxv07=stuff("............",13-len(alltrim(str(fv07,12,2))),len(alltrim(str(fv07,12,2))),alltrim(str(fv07,12,2))) 
ltxb22=stuff("............",13-len(alltrim(str(lfb22,12,2))),len(alltrim(str(lfb22,12,2))),alltrim(str(lfb22,12,2))) 
ltxb07=stuff("............",13-len(alltrim(str(lfb07,12,2))),len(alltrim(str(lfb07,12,2))),alltrim(str(lfb07,12,2))) 

  t[5]=stuff(t[5],60,12,ltxn22)
  t[5]=stuff(t[5],73,12,ltxn07)
  t[5]=stuff(t[5],86,12,ltxn00)
  t[5]=stuff(t[5],99,12,ltxnzw)
  
  t[6]=stuff(t[6],15,15,fnum1)
  t[6]=stuff(t[6],31,15,fnum2)
  t[6]=stuff(t[6],60,12,ltxv22)
  t[6]=stuff(t[6],73,12,ltxv07)

  t[7]=stuff(t[7],60,12,ltxb22)
  t[7]=stuff(t[7],73,12,ltxb07)
  t[7]=stuff(t[7],86,12,ltxn00)
  t[7]=stuff(t[7],99,12,ltxnzw)

ltxn22=stuff("............",13-len(alltrim(str(rn22,12,2))),len(alltrim(str(rn22,12,2))),alltrim(str(rn22,12,2))) 
ltxn07=stuff("............",13-len(alltrim(str(rn07,12,2))),len(alltrim(str(rn07,12,2))),alltrim(str(rn07,12,2))) 
ltxn00=stuff("............",13-len(alltrim(str(rn00,12,2))),len(alltrim(str(rn00,12,2))),alltrim(str(rn00,12,2))) 
ltxnzw=stuff("............",13-len(alltrim(str(rnzw,12,2))),len(alltrim(str(rnzw,12,2))),alltrim(str(rnzw,12,2))) 
ltxv22=stuff("............",13-len(alltrim(str(rv22,12,2))),len(alltrim(str(rv22,12,2))),alltrim(str(rv22,12,2))) 
ltxv07=stuff("............",13-len(alltrim(str(rv07,12,2))),len(alltrim(str(rv07,12,2))),alltrim(str(rv07,12,2))) 
ltxb22=stuff("............",13-len(alltrim(str(lrb22,12,2))),len(alltrim(str(lrb22,12,2))),alltrim(str(lrb22,12,2))) 
ltxb07=stuff("............",13-len(alltrim(str(lrb07,12,2))),len(alltrim(str(lrb07,12,2))),alltrim(str(lrb07,12,2))) 

  t[9]=stuff(t[9],60,12,ltxn22)
  t[9]=stuff(t[9],73,12,ltxn07)
  t[9]=stuff(t[9],86,12,ltxn00)
  t[9]=stuff(t[9],99,12,ltxnzw)
  
  t[10]=stuff(t[10],15,15,rnum1)
  t[10]=stuff(t[10],31,15,rnum2)
  t[10]=stuff(t[10],60,12,ltxv22)
  t[10]=stuff(t[10],73,12,ltxv07)

  t[11]=stuff(t[11],60,12,ltxb22)
  t[11]=stuff(t[11],73,12,ltxb07)
  t[11]=stuff(t[11],86,12,ltxn00)
  t[11]=stuff(t[11],99,12,ltxnzw)

ltxn22=stuff("............",13-len(alltrim(str(pn22,12,2))),len(alltrim(str(pn22,12,2))),alltrim(str(pn22,12,2))) 
ltxn07=stuff("............",13-len(alltrim(str(pn07,12,2))),len(alltrim(str(pn07,12,2))),alltrim(str(pn07,12,2))) 
ltxn00=stuff("............",13-len(alltrim(str(pn00,12,2))),len(alltrim(str(pn00,12,2))),alltrim(str(pn00,12,2))) 
ltxnzw=stuff("............",13-len(alltrim(str(pnzw,12,2))),len(alltrim(str(pnzw,12,2))),alltrim(str(pnzw,12,2))) 
ltxv22=stuff("............",13-len(alltrim(str(pv22,12,2))),len(alltrim(str(pv22,12,2))),alltrim(str(pv22,12,2))) 
ltxv07=stuff("............",13-len(alltrim(str(pv07,12,2))),len(alltrim(str(pv07,12,2))),alltrim(str(pv07,12,2))) 
ltxb22=stuff("............",13-len(alltrim(str(lpb22,12,2))),len(alltrim(str(lpb22,12,2))),alltrim(str(lpb22,12,2))) 
ltxb07=stuff("............",13-len(alltrim(str(lpb07,12,2))),len(alltrim(str(lpb07,12,2))),alltrim(str(lpb07,12,2))) 

  t[13]=stuff(t[13],60,12,ltxn22)
  t[13]=stuff(t[13],73,12,ltxn07)
  t[13]=stuff(t[13],86,12,ltxn00)
  t[13]=stuff(t[13],99,12,ltxnzw)
  
  t[14]=stuff(t[14],15,15,pnum1)
  t[14]=stuff(t[14],31,15,pnum2)
  t[14]=stuff(t[14],60,12,ltxv22)
  t[14]=stuff(t[14],73,12,ltxv07)

  t[15]=stuff(t[15],60,12,ltxb22)
  t[15]=stuff(t[15],73,12,ltxb07)
  t[15]=stuff(t[15],86,12,ltxn00)
  t[15]=stuff(t[15],99,12,ltxnzw)
  
ltxn22=stuff("............",13-len(alltrim(str(lsn22,12,2))),len(alltrim(str(lsn22,12,2))),alltrim(str(lsn22,12,2))) 
ltxn07=stuff("............",13-len(alltrim(str(lsn07,12,2))),len(alltrim(str(lsn07,12,2))),alltrim(str(lsn07,12,2))) 
ltxn00=stuff("............",13-len(alltrim(str(lsn00,12,2))),len(alltrim(str(lsn00,12,2))),alltrim(str(lsn00,12,2))) 
ltxnzw=stuff("............",13-len(alltrim(str(lsnzw,12,2))),len(alltrim(str(lsnzw,12,2))),alltrim(str(lsnzw,12,2))) 
ltxv22=stuff("............",13-len(alltrim(str(lsv22,12,2))),len(alltrim(str(lsv22,12,2))),alltrim(str(lsv22,12,2))) 
ltxv07=stuff("............",13-len(alltrim(str(lsv07,12,2))),len(alltrim(str(lsv07,12,2))),alltrim(str(lsv07,12,2))) 
ltxb22=stuff("............",13-len(alltrim(str(lsb22,12,2))),len(alltrim(str(lsb22,12,2))),alltrim(str(lsb22,12,2))) 
ltxb07=stuff("............",13-len(alltrim(str(lsb07,12,2))),len(alltrim(str(lsb07,12,2))),alltrim(str(lsb07,12,2))) 

  t[17]=stuff(t[17],60,12,ltxn22)
  t[17]=stuff(t[17],73,12,ltxn07)
  t[17]=stuff(t[17],86,12,ltxn00)
  t[17]=stuff(t[17],99,12,ltxnzw)
  
  t[18]=stuff(t[18],60,12,ltxv22)
  t[18]=stuff(t[18],73,12,ltxv07)

  t[19]=stuff(t[19],60,12,ltxb22)
  t[19]=stuff(t[19],73,12,ltxb07)
  t[19]=stuff(t[19],86,12,ltxn00)
  t[19]=stuff(t[19],99,12,ltxnzw)  


ltxb=stuff("            ",13-len(alltrim(str(lsbrutto,12,2))),len(alltrim(str(lsbrutto,12,2))),alltrim(str(lsbrutto,12,2))) 
ltxniedop=stuff("            ",13-len(alltrim(str(niedoplata,12,2))),len(alltrim(str(niedoplata,12,2))),alltrim(str(niedoplata,12,2))) 
ltxg=stuff("            ",13-len(alltrim(str(lsgot,12,2))),len(alltrim(str(lsgot,12,2))),alltrim(str(lsgot,12,2))) 
t[22]=stuff(t[22],30,12,ltxb)
t[23]=stuff(t[23],30,12,ltxniedop)
t[24]=stuff(t[24],30,12,ltxg)


t[29]=stuff(t[29],14,30,rdsporzadzil)
t[34]=stuff(t[34],14,30,rdzatwierdzil)

if drukar
  w=prow()
  if grafik
    @ prow(),pcol() say &zdr_grubo+&zdr_kkond
  else
    @ prow(),pcol() say &zdr_kkond
  endif
endif
@ w,31 say rdmiasto
@ w,53 say "DNIA :"
@ w,60 say rddata
w=w+1
@ w,0 say text1
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
for i=1 to 35
  @ w+i,0 say t[i]
next
if drukar
  eject
endif
RETURN

PROCEDURE RDPARAM
parameters prdnum
do skom with "[ENTER],[PgDn] - zatwierdzenie        Esc - rezygnacja"
@ 15,33 to 23,77 double
@ 16,34 say "          PARAMETRY  ZESTAWIENIA           "
@ 17,34 say "==========================================="
@ 18,34 say "Numer........                              "
@ 19,34 say "Miasto.......                              "
@ 20,34 say "Data.........                              "
@ 21,34 say "Sporzadzil...                              "
@ 22,34 say "Zatwierdzil..                              "
set cursor on
@ 18,47 get prdnum picture "9999"
@ 19,47 get rdmiasto
@ 20,47 get rddata
@ 21,47 get rdsporzadzil
@ 22,47 get rdzatwierdzil
read
set cursor off
RETURN

PROCEDURE RDZER
fn22=0
fn07=0
fn00=0
fnzw=0
fv22=0
fv07=0
rn22=0
rn07=0
rn00=0
rnzw=0
rv22=0
rv07=0
pn22=0
pn07=0
pn00=0
pnzw=0
pv22=0
pv07=0
niedoplata=0
RETURN