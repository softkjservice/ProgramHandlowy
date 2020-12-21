*******************************************************************************
* Procedura drukuje wszystkie widoczne dokumenty z odpowiedniego pliku        *
*******************************************************************************
local lms:=month(date())
local ls:=1
local ld1:=date()
local ld2:=date()
public fdat1:=date()
public fdat2:=date()
public fmies:=month(date())
daf=date()
set default to 1dok
restore from pam additive
clear
@ 0,0,24,79 box chr(176)
@ 0,2 say " Soft-KJ-Service "
@ 2,2 say "WYDRUK DOKUMENTOW Z WYLICZENIEM ZYSKU I SREDNIEJ MARZY"
zz=.t.
dd=.t.
set cursor on
@ 22,2 say "Wykonac ? " get zz
read
set cursor off
if lastkey()=27.or..not.zz
  return
endif
do dzmenu
*do anokres with 7,32,ls,lms,ld1,ld2,.F.
return


select 1
use dokument index dok_num
*set device to printer
*@ prow(),pcol() say &zdr_kond

do dokzysk
if dd
  run ne \kj.txt
else  
  set device to screen
endif  
RETURN

PROCEDURE DZMENU
parameters pmenu
local t[18],g[4],dk[4],wd[2]
local lms:=month(daf)         &&numer miesiaca do wydruku
local lmiesiac:=space(12)
local ls:=1                   &&numer pozycji menu wyboru okresu raportu
local ld1:=daf                &&raport za dzien lub poczatek przedzialu czasowego
local ld2:=daf                &&koniec przedzialu czasowego
local lfaktury:=.t.           &&wydruk faktur
local lrachunek:=.t.          &&wydruk rachunkow 
local lparagon:=.t.          &&wydruk paragonow
local lzbiorczy:=.t.          &&wydruk raportu zbiorczego      
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
private fzakup:=0,fsprzedaz:=0,fnaliczony:=0,fnalezny:=0
private rzakup:=0,rsprzedaz:=0,rnaliczony:=0,rnalezny:=0
private pzakup:=0,psprzedaz:=0,pnaliczony:=0,pnalezny:=0
private fnum1:=space(15),fnum2:=space(15),fd1:=date(),fd2:=date()
private rnum1:=space(15),rnum2:=space(15),rd1:=date(),rd2:=date()
private pnum1:=space(15),pnum2:=space(15),pd1:=date(),pd2:=date()
private dokument:=0,text1:=space(80),text2:=space(80),text3:=space(80)
public fdat1:=date()
public fdat2:=date()
public fmies:=month(date())
drukar=.t.
w=0
strona=1
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "°         R A P O R T :  DOKUMENT - ZYSK - MARZA           °"
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
DK[4]:="ûÞ ZBIORCZY   "
WD[1]:="ûÞ DRUKARKA  "
WD[2]:=" Þ EKRAN     "
text2="                                 DOKUMENTY OD NUMERU : ..............."
text3="                                           DO NUMERU : ..............."
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
        case ls=1                       &&raport  za dzien
	      lfiltr="datdok=fdat1"
		  text2="ZA DZIEN  :                                                                                  "          
          text2=stuff(text2,15,8,dtoc(ld1))          		  
          text3=stuff(text3,1,32,space(32)) 
	    case ls=2                       &&raport za miesiac
	      lfiltr="month(datdok)=fmies"
          do miesiac with lms,lmiesiac
		  text2="ZA MIESIAC :                                                                                 "          
          text2=stuff(text2,15,12,lmiesiac)          
	      text3=stuff(text3,1,32,space(32))
        case ls=3                       &&za okres od do
*	      lfiltr="max(fdat1-1,datdok)=datdok.and.min(fdat2,datdok)=datdok"
	      lfiltr="max(fdat1,datdok)=datdok.and.min(fdat2,datdok)=datdok"
		  text2="ZA OKRES OD DNIA :                                                                           "          
		  text3="         DO DNIA :                                                                           "          		  
          text2=stuff(text2,19,8,dtoc(ld1))          		  
          text3=stuff(text3,19,8,dtoc(ld2))          		  		  
      endcase
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
  
      select 1
      if lfaktury.or.lzbiorczy
        dokument=1
	    text1="  *_ZESTAWIENIE_FAKTUR_SPRZEDAZY_*       RAPORT :  DOKUMENT - ZYSK - MARZA      "
		use dokument index dok_num
	    set filter to &lfiltr
	    go top
        fnum1=ndok
		fd1=datdok
        text2=stuff(text2,56,15,ndok)
		go bottom
		fnum2=ndok
		fd2=datdok
		text3=stuff(text3,56,15,ndok)
		go top
		if lfaktury
          do dokzysk with lzakup,lsprzedaz,lnaliczony,lnalezny,.t.
	    else
	      do dokzysk with lzakup,lsprzedaz,lnaliczony,lnalezny,.f.
	    endif  
	    fzakup=lzakup
	    fsprzedaz=lsprzedaz
	    fnaliczony=lnaliczony
	    fnalezny=lnalezny
        close
      endif
  
      if lrachunek.or.lzbiorczy
        dokument=2
	    text1="  *_ZESTAWIENIE_RACHUNKOW_SPRZEDAZY_*      RAPORT :  DOKUMENT - ZYSK - MARZA    "
        use rachunek index rach_num
	    set filter to &lfiltr
	    go top
        rnum1=ndok
		rd1=datdok
        text2=stuff(text2,56,15,ndok)
		go bottom
		rnum2=ndok
		rd2=datdok
		text3=stuff(text3,56,15,ndok)
		go top		
	    if lrachunek
          do dokzysk with lzakup,lsprzedaz,lnaliczony,lnalezny,.t.
	    else
	      do dokzysk with lzakup,lsprzedaz,lnaliczony,lnalezny,.f.
	    endif  
	    rzakup=lzakup
	    rsprzedaz=lsprzedaz
	    rnaliczony=lnaliczony
	    rnalezny=lnalezny
        close
      endif
  
      if lparagon.or.lzbiorczy 
        dokument=3
	    text1="  *_ZESTAWIENIE_PARAGONOW_SPRZEDAZY_*      RAPORT :  DOKUMENT - ZYSK - MARZA    "
        use paragon index par_num
	    set filter to &lfiltr
	    go top
		pnum1=ndok
		pd1=datdok
        text2=stuff(text2,56,15,ndok)
		go bottom
		pnum2=ndok
		pd2=datdok
		text3=stuff(text3,56,15,ndok)
		go top
	    if lparagon
          do dokzysk with lzakup,lsprzedaz,lnaliczony,lnalezny,.t.
	    else
	      do dokzysk with lzakup,lsprzedaz,lnaliczony,lnalezny,.f.
	    endif  
	    pzakup=lzakup
	    psprzedaz=lsprzedaz
	    pnaliczony=lnaliczony
	    pnalezny=lnalezny
        close
      endif    
  
      if lzbiorczy
        dokument=0
	    text1=" *_ZESTAWIENIE_ZBIORCZE_DOKUMENTOW_SPRZEDAZY_*   RAPORT: DOKUMENT - ZYSK - MARZA"
        text2=stuff(text2,34,37,space(37))
        text3=stuff(text3,34,37,space(37))
        do zbiorczy
      endif
  
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
		  case d=4
		    @ row(),46 get lzbiorczy
			read
			if lzbiorczy
			  dk[4]=stuff(dk[4],1,1,"û")
			else
			  dk[4]=stuff(dk[4],1,1," ")			  
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


PROCEDURE DOKZYSK
parameters pzakup,psprzedaz,pnaliczony,pnalezny,pdruk
local lp:=1
local lt1:="|...|...............|........|...............|............|............|............|............|............|........|"
local lt2:="|   |               |        |               |            |            |            |            |            |        |"   
local lt3:="------------------------------------------------------------------------------------------------------------------------"
local lzn22:=0
local lzn07:=0
local lzv22:=0
local lzv07:=0
local lznetto:=0     &&wartosc dokumentu w cenie zakupu  netto
local lzvat:=0       &&vat naliczony
local lznsum:=0      &&suma zakupow w cenie netto
local lzvsum:=0     &&suma vatu dla wszystkich dok zakupu
local lsn22:=0
local lsn07:=0
local lsv22:=0
local lsv07:=0
local lsnetto:=0     &&wartosc dokumentu w cenie sprzedazy netto
local lsvat:=0       &&vat nalezny dla aktualnego dokumentu
local lsnsum:=0      &&suma sprzedazy netto
local lsvsum:=0      &&suma vatu naleznego

local ltxzn:=space(12)
local ltxzv:=space(12)
local ltxsn:=space(12)
local ltxsv:=space(12)
local ltxzyzk:=space(12)
local ltxmarza:=space(8)
local lzysk:=0
local lmarza:=0
local lndok:=space(15)
local lseek:=.t.
setprc(0,0)
w=prow()
*if drukar
**  w=prow()
*  w=0
*else
*  w=w+1
*endif  
do dzyskglow
if pdruk
  do dzysktyt						
endif  
go top
do while.not.eof()
  lndok=ndok
  lsn22=dnet_22
  lsn07=dnet_07
  do doklicz with lsn22,lsn07,lsv22,lsv07
  lsn22=round(lsn22,2)
  lsn07=round(lsn07,2)
  lsv22=round(lsv22,2)
  lsv07=round(lsv07,2)
  lsnetto=lsn22+lsn07+dnet_00+dnet_zw
  lsvat=lsv22+lsv07
  lsnsum=lsnsum+lsnetto
  lsvsum=lsvsum+lsvat
  do dokcenzak with lndok,lznetto,lzvat,lseek
  lznsum=lznsum+lznetto
  lzvsum=lzvsum+lzvat
  lzysk=lsnetto-lznetto
  lmarza=round((lzysk/lznetto)*100,2)
  if pdruk
    ltxsn=stuff("............",13-len(alltrim(str(lsnetto,12,2))),len(alltrim(str(lsnetto,12,2))),alltrim(str(lsnetto,12,2))) 
    ltxsv=stuff("............",13-len(alltrim(str(lsvat,12,2))),len(alltrim(str(lsvat,12,2))),alltrim(str(lsvat,12,2))) 
    ltxzn=stuff("............",13-len(alltrim(str(lznetto,12,2))),len(alltrim(str(lznetto,12,2))),alltrim(str(lznetto,12,2))) 
    ltxzv=stuff("............",13-len(alltrim(str(lzvat,12,2))),len(alltrim(str(lzvat,12,2))),alltrim(str(lzvat,12,2)))     
    if lseek
      ltxzysk=stuff("............",13-len(alltrim(str(lzysk,12,2))),len(alltrim(str(lzysk,12,2))),alltrim(str(lzysk,12,2))) 
      ltxmarza=stuff("........",9-len(alltrim(str(lmarza,8,2))),len(alltrim(str(lmarza,8,2))),alltrim(str(lmarza,8,2)))   
    else
      ltxzysk="   BRAK     "  
	  ltxmarza=" DANYCH "
    endif

    lt1=stuff(lt1,2,3,str(lp,3))
    if substr(ndok,12,1)$"fruC"
      lt1=stuff(lt1,6,15,zewndok)
    else
      lt1=stuff(lt1,6,15,ndok)
    endif	
    lt1=stuff(lt1,22,8,dtoc(datdok))
    lt1=stuff(lt1,31,len(alltrim(nskrot)),alltrim(nskrot))
    lt1=stuff(lt1,47,12,ltxzn)
    lt1=stuff(lt1,60,12,ltxsn)
    lt1=stuff(lt1,73,12,ltxzv)
    lt1=stuff(lt1,86,12,ltxsv)
    lt1=stuff(lt1,99,12,ltxzysk)
    lt1=stuff(lt1,112,8,ltxmarza)    
    @ w,0 say lt1
    w=w+1
    lt1:="|...|...............|........|...............|............|............|............|............|............|........|"
  endif
  skip
  if w>dlugosc-4.and..not.eof().and.drukar.and.pdruk
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
    do dzysktyt						
  endif
  lp=lp+1
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
pzakup=lznsum
psprzedaz=lsnsum
pnaliczony=lzvsum
pnalezny=lsvsum
RETURN


*******************************************************************************
* DRUKUJE NAGLOWEK RAPORTU : rodz dokumentu, okres ,od numeru do numeru       *
*******************************************************************************
PROCEDURE DZYSKGLOW
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
  @ w,0 say replicate(chr(205),80)
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




PROCEDUR DZYSKTYT

local lt1:="========================================================================================================================"
local lt2:="|Lp.|     NUMER     |  DATA  |   KONTRAHENT  |   WARTOSC NETTO W CENIE |         V  A  T         |  Z Y S K   |SREDNIA |"
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


PROCEDURE DZYSKSTOPA
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
* Procedura wylicza wartosc wskazanedo dokumentu w cenach zakupu netto oraz   *
* podaje VAT naliczony                                                        *
*******************************************************************************
PROCEDURE DOKCENZAK
parameters pndok,pnetto,pvat,pseek
local ln22:=0
local ln07:=0
local ln00:=0
local lnzw:=0
local lv22:=0
local lv07:=0
pnetto=0
pvat=0
pseek=.t.
use sprzedaz index sprzedaz new
seek pndok
if.not.found()
  pseek=.f.
  return
endif
do while tndok=pndok
  if substr(tster,1,1)="z"
    lnzw=lnzw+round(til*tcen_m,2)
  else
    do case
      case tstawka=22
        ln22=ln22+round(til*tcen_m,2)
      case tstawka=7
        ln07=ln07+round(til*tcen_m,2)
      case tstawka=0
        ln00=ln00+round(til*tcen_m,2)
    endcase	  
  endif
  
  skip
enddo
close
lv22=round(ln22*0.22,2)
lv07=round(ln07*0.07,2)
pnetto=ln22+ln07+ln00+lnzw
pvat=lv22+lv07
select 1
RETURN




PROCEDURE ZBIORCZY
local t[15]
local lzysk:=0
local lmarza:=0
local ltxzn:=space(12)
local ltxzv:=space(12)
local ltxsn:=space(12)
local ltxsv:=space(12)
local ltxzyzk:=space(12)
local ltxmarza:=space(8)
local lzakup:=0,lsprzedaz:=0,lnaliczony:=0,lnalezny:=0
local ld1:="      ZESTAWIENIE ZBIORCZE :    DOKUMENT - ZYSK - SREDNIA MARZA       "
local ld2:="----------------------------------------------------------------------"
t[1]:= "========================================================================================================================"
t[2]:= "|Lp.|DOKUMENT|   D  A  T  A  |     NUMER     |  WWARTOSC NETTO W CENIE |         V  A  T         |  Z Y S K   |SREDNIA |"
t[3]:= "|   |        |               |               |   ZAKUPU   | SPRZEDAZY  | NALICZONY  |  NALEZNY   |   NETTO    | MARZA  |"
t[4]:= "|===|========|===============|===============|============|============|============|============|============|========|"
t[5]:= "| 1 |FAKTURY |  OD:          |               |            |            |            |            |            |        |"
t[6]:= "|   |        |  DO:          |               |            |            |            |            |            |        |"
t[7]:= "|----------------------------------------------------------------------------------------------------------------------|"
t[8]:="| 2 |RACHUNKI|  OD:          |               |            |            |            |            |            |        |"
t[9]:="|   |        |  DO:          |               |            |            |            |            |            |        |"
t[10]:="|----------------------------------------------------------------------------------------------------------------------|"
t[11]:="| 3 |PARAGONY|  OD:          |               |            |            |            |            |            |        |"
t[12]:="|   |        |  DO:          |               |            |            |            |            |            |        |"
t[13]:="|----------------------------------------------------------------------------------------------------------------------|"
t[14]:="                             |   RAZEM :     |            |            |            |            |            |        |"
t[15]:="                             -------------------------------------------------------------------------------------------"


lzysk=fsprzedaz-fzakup
lmarza=round((lzysk/fzakup)*100,2)

ltxsn=stuff("............",13-len(alltrim(str(fsprzedaz,12,2))),len(alltrim(str(fsprzedaz,12,2))),alltrim(str(fsprzedaz,12,2))) 
ltxsv=stuff("............",13-len(alltrim(str(fnalezny,12,2))),len(alltrim(str(fnalezny,12,2))),alltrim(str(fnalezny,12,2))) 
ltxzn=stuff("............",13-len(alltrim(str(fzakup,12,2))),len(alltrim(str(fzakup,12,2))),alltrim(str(fzakup,12,2))) 
ltxzv=stuff("............",13-len(alltrim(str(fnaliczony,12,2))),len(alltrim(str(fnaliczony,12,2))),alltrim(str(fnaliczony,12,2)))     
ltxzysk=stuff("............",13-len(alltrim(str(lzysk,12,2))),len(alltrim(str(lzysk,12,2))),alltrim(str(lzysk,12,2))) 
ltxmarza=stuff("........",9-len(alltrim(str(lmarza,8,2))),len(alltrim(str(lmarza,8,2))),alltrim(str(lmarza,8,2)))   

  t[5]=stuff(t[5],22,8,dtoc(fd1))
  t[5]=stuff(t[5],31,15,fnum1)
  t[5]=stuff(t[5],47,12,ltxzn)
  t[5]=stuff(t[5],60,12,ltxsn)
  t[5]=stuff(t[5],73,12,ltxzv)
  t[5]=stuff(t[5],86,12,ltxsv)
  t[5]=stuff(t[5],99,12,ltxzysk)
  t[5]=stuff(t[5],112,8,ltxmarza)    
  
  t[6]=stuff(t[6],22,8,dtoc(fd2))
  t[6]=stuff(t[6],31,15,fnum2)  

lzysk=rsprzedaz-rzakup
lmarza=round((lzysk/rzakup)*100,2)

ltxsn=stuff("............",13-len(alltrim(str(rsprzedaz,12,2))),len(alltrim(str(rsprzedaz,12,2))),alltrim(str(rsprzedaz,12,2))) 
ltxsv=stuff("............",13-len(alltrim(str(rnalezny,12,2))),len(alltrim(str(rnalezny,12,2))),alltrim(str(rnalezny,12,2))) 
ltxzn=stuff("............",13-len(alltrim(str(rzakup,12,2))),len(alltrim(str(rzakup,12,2))),alltrim(str(rzakup,12,2))) 
ltxzv=stuff("............",13-len(alltrim(str(rnaliczony,12,2))),len(alltrim(str(rnaliczony,12,2))),alltrim(str(rnaliczony,12,2)))     
ltxzysk=stuff("............",13-len(alltrim(str(lzysk,12,2))),len(alltrim(str(lzysk,12,2))),alltrim(str(lzysk,12,2))) 
ltxmarza=stuff("........",9-len(alltrim(str(lmarza,8,2))),len(alltrim(str(lmarza,8,2))),alltrim(str(lmarza,8,2)))   

  t[8]=stuff(t[8],22,8,dtoc(rd1))
  t[8]=stuff(t[8],31,15,rnum1)
  t[8]=stuff(t[8],47,12,ltxzn)
  t[8]=stuff(t[8],60,12,ltxsn)
  t[8]=stuff(t[8],73,12,ltxzv)
  t[8]=stuff(t[8],86,12,ltxsv)
  t[8]=stuff(t[8],99,12,ltxzysk)
  t[8]=stuff(t[8],112,8,ltxmarza)    
  
  t[9]=stuff(t[9],22,8,dtoc(rd2))
  t[9]=stuff(t[9],31,15,rnum2)  

lzysk=psprzedaz-pzakup
lmarza=round((lzysk/pzakup)*100,2)

ltxsn=stuff("............",13-len(alltrim(str(psprzedaz,12,2))),len(alltrim(str(psprzedaz,12,2))),alltrim(str(psprzedaz,12,2))) 
ltxsv=stuff("............",13-len(alltrim(str(pnalezny,12,2))),len(alltrim(str(pnalezny,12,2))),alltrim(str(pnalezny,12,2))) 
ltxzn=stuff("............",13-len(alltrim(str(pzakup,12,2))),len(alltrim(str(pzakup,12,2))),alltrim(str(pzakup,12,2))) 
ltxzv=stuff("............",13-len(alltrim(str(pnaliczony,12,2))),len(alltrim(str(pnaliczony,12,2))),alltrim(str(pnaliczony,12,2)))     
ltxzysk=stuff("............",13-len(alltrim(str(lzysk,12,2))),len(alltrim(str(lzysk,12,2))),alltrim(str(lzysk,12,2))) 
ltxmarza=stuff("........",9-len(alltrim(str(lmarza,8,2))),len(alltrim(str(lmarza,8,2))),alltrim(str(lmarza,8,2)))   

  t[11]=stuff(t[11],22,8,dtoc(pd1))
  t[11]=stuff(t[11],31,15,pnum1)
  t[11]=stuff(t[11],47,12,ltxzn)
  t[11]=stuff(t[11],60,12,ltxsn)
  t[11]=stuff(t[11],73,12,ltxzv)
  t[11]=stuff(t[11],86,12,ltxsv)
  t[11]=stuff(t[11],99,12,ltxzysk)
  t[11]=stuff(t[11],112,8,ltxmarza)    
  
  t[12]=stuff(t[12],22,8,dtoc(pd2))
  t[12]=stuff(t[12],31,15,pnum2)  

lzakup=fzakup+rzakup+pzakup
lsprzedaz=fsprzedaz+rsprzedaz+psprzedaz
lnaliczony=fnaliczony+rnaliczony+pnaliczony
lnalezny=fnalezny+rnalezny+pnalezny

lzysk=lsprzedaz-lzakup
lmarza=round((lzysk/lzakup)*100,2)

ltxsn=stuff("............",13-len(alltrim(str(lsprzedaz,12,2))),len(alltrim(str(lsprzedaz,12,2))),alltrim(str(lsprzedaz,12,2))) 
ltxsv=stuff("............",13-len(alltrim(str(lnalezny,12,2))),len(alltrim(str(lnalezny,12,2))),alltrim(str(lnalezny,12,2))) 
ltxzn=stuff("............",13-len(alltrim(str(lzakup,12,2))),len(alltrim(str(lzakup,12,2))),alltrim(str(lzakup,12,2))) 
ltxzv=stuff("............",13-len(alltrim(str(lnaliczony,12,2))),len(alltrim(str(lnaliczony,12,2))),alltrim(str(lnaliczony,12,2)))     
ltxzysk=stuff("............",13-len(alltrim(str(lzysk,12,2))),len(alltrim(str(lzysk,12,2))),alltrim(str(lzysk,12,2))) 
ltxmarza=stuff("........",9-len(alltrim(str(lmarza,8,2))),len(alltrim(str(lmarza,8,2))),alltrim(str(lmarza,8,2)))   

  t[14]=stuff(t[14],47,12,ltxzn)
  t[14]=stuff(t[14],60,12,ltxsn)
  t[14]=stuff(t[14],73,12,ltxzv)
  t[14]=stuff(t[14],86,12,ltxsv)
  t[14]=stuff(t[14],99,12,ltxzysk)
  t[14]=stuff(t[14],112,8,ltxmarza)    

if drukar
  w=prow()
  if grafik
    @ prow(),pcol() say &zdr_grubo+&zdr_kkond
  else
    @ prow(),pcol() say &zdr_kkond
  endif
endif
@ w,0 say text1
w=w+1
@ w,0 say replicate(chr(205),80)
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
for i=1 to 15
  @ w+i,0 say t[i]
next
if drukar
  eject
endif
RETURN