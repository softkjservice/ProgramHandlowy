*program kp, kw
FUNCTION KPW(psposzap_pytaj)
local ek,lpoz:=1,lkop:=1
zpapier_typ=orginal
zflad()

save screen to ek
    k_w=2
	k_k=12
if psposzap_pytaj
  g_tlo()
  if zsposzap="P"
    lpoz=2
  endif
  lpoz=przelgot_menu(lpoz)
  do case
    case lpoz=1
      zsposzap="G"
	  zdsposzap="G"
    case lpoz=2
      zsposzap="P"
	  zdsposzap="P"	
  endcase
  if lastkey()=27
    do dokdefault
    select 1
    restore screen from ek
    return
  endif
endif

zleg_sh_lic()
k_dane()
newold_lad()

kasa_tlo()
k_dop_tlo()
k_say()
if empty(zknaz1).and.empty(zknaz2).and.empty(zkmiasto).and.empty(zkulica).and.empty(zknip)
  k_get()
endif
dokkasa()

if lastkey()=27
  do dokdefault
  select 1
  restore screen from ek
  return
endif
zap_dok()
if kj_gkom(12," ","Wydrukowa† dokument kasowy ? ","",.t.,5)
  if.not.pstart_druk()
    do dokdefault
    select 1
    restore screen from ek
    return  
  endif
  set device to printer
  w=prow()
  @ prow(),pcol() say &zdr_kond  
  
  kasa_druk(lkop)    
  set device to screen
endif
*
do dokdefault
select 1
replace kwota with (kwota - ztcen)
*
restore screen from ek
RETURN 

FUNCTION ZAP_DOK()
local lsukces:=.f.,ltil:=0,lwzor:=.F.
*close_all("SH")
  if.not.nowy_numdok(.F.)
    return
  endif
  nowy_kon()
  ztndow=zdndow
  ztdatdow=zddatdow
  ztil=1
**

  if dok_use()
      if kj_append(3)
	    dok_replac()
        unlock
	  else
	    return
	  endif	    
    close
  else
    return
  endif
  if tow_use()
      if kj_append(3)
	    tow_replac()
        unlock
	  else
	    return
	  endif	    
    close
  else
    return
  endif  
RETURN


** stary - nowy laduj
FUNCTION NEWOLD_LAD()
zdgrup="5"
zdndok:=zndok
zdndow:=zndok
zddatdok=zdatdok
zdtermin=ztermin
zdkontrah=znplat
zdnskrot=znskrot
zdniedop=zkwota
zdsposzap=zsposzap
zdksiegowy=zksiegowy
zddatsp=zdatsp
zddatzal=zdatzal
***
zknaz1=znaz1
zknaz2=znaz2
zkmiasto=zmiasto
zkulica=zulica
zkkod=zkod
zktel=ztel
zkfax=zfax
zknip=znip
zkgrupa=zgrupa
zkrabat=zrabat
zknum=znr_kontr

***
ztil=1
ztstawka=0
ztkormag=.f.
***
  if substr(ztyp,4,1)$"FURNfurn"
    ztnaz="Za faktur©                      "
  else
    ztnaz="Za paragon                      "
  endif	
  if substr(ztyp,4,1)$"FURNPT"
    ztnaz=stuff(ztnaz,12,15,zdndok)
	zdkordok=zdndok
  else
    ztnaz=stuff(ztnaz,12,15,zzewndok)
	zdkordok=zzewndok
  endif	
  zdnzam=zdndow
  
ztcen=zkwota
do case
  case substr(ztyp,4,1)$"FURNPT".and.ztcen>=0
    zdtyp="G"
	zdznak="G"
    zdsymbol="ZG"
  case substr(ztyp,4,1)$"FURNPT".and.ztcen<0
    zdtyp="g"
	zdznak="g"
	zdsymbol="zg"
    ztcen=-1*ztcen
  case substr(ztyp,4,1)$"furnpt".and.ztcen>=0
    zdtyp="g"
	zdznak="g"	
	zdsymbol="zg"	
  case substr(ztyp,4,1)$"furnpt".and.ztcen<0
    zdtyp="G"
	zdznak="G"	
	zdsymbol="ZG"	
	ztcen=-1*ztcen	
endcase
RETURN

*** Public
FUNCTION PUBLIC_SEL()
public dokum_sel:=101
public tow_sel:=102
public buf_sel:=103
public kon_sel:=104
public gmag_sel:=105
public pmag_sel:=106
public num_sel:=107
public sh_sel:=108
public wystaw_sel:=109
public num_sel:=110
public dokdef_sel:=111
public tnum_sel:=112
public gbo_sel:=113
public pbo_sel:=114
public magi_sel:=115
public grupy_sel:=116
public has_sel:=117
public anal_sel:=118
public rap_sel:=119
public rap1_sel:=120
public param_sel:=121
public wmagi_sel:=122
public wkonto_sel:=123
public groz_sel:=124
public topis_sel:=125
public magnumer_sel:=126
public kasopis_sel:=127
public kasa_sel:=128
public stowary_sel:=129
public anal_sel:=130
public archiw_sel:=131
public archdok_sel:=132
public archtow_sel:=133
public archdokkas_sel:=134
public archtowkas_sel:=135
***
public kormag_gr:="FUNRPTfunrptoK1234E"
public sprzedaz_gr:="FUNRPTK24EZY"
public zakup_gr:="frpurtijo13z"
public dowod_gr:="1234"
public dok_brut_gr:="URTutr34"
public dok_net_gr:="FNPIpfnio12"
public defnum_gr:="furnptijo"
public bezkontrah_gr:="PTp"
public przes_gr:="BC"
public przerob_gr:="A"
public stopabezvat_gr:=""
public opis1_gr:="K"
public fiskal_gr:="RNPT"
public zkordok_znak:="K"
public zkordok_symbol:="K"
public odebral_podpis_gr:="FURNKE"
public export_gr:="ELX"
public import_gr:="elx"
public importsad_gr:="s"
public eksportsad_gr:="LX"
public proform_gr:="Zz"
public kasa_gr:="Gg"
RETURN

FUNCTION PUBLIC_KON()
public zknaz1:=space(56),zknaz2:=space(56),zkmiasto:=space(30)
public zkulica:=space(30),zkkod:=space(6),zktel:=space(15),zkfax:=space(15)
public zkkonto:=space(90),zknip:=space(13),zkgrupa:=space(5)
public zkrabat:=0.0,zknum:=0,zkodebral:=space(30),zklimit:=0,zkgrup_kod:=0
public zuzyt_last:=space(10),zdat_last:=date(),ztime_last:=space(8)
RETURN nil

FUNCTION ZLEG_SH_PUBLIC()
public zlic1:=flic1,zlic2:=flic2,zlic3:=substr(flic6,1,6)
public zlic4:=flic3,zlic5:=flic4,zlic6:=substr(flic5,1,13)
public zlic0:=space(15)
public zleg_kod:=space(5),zlz1:=.f.,zlz2:=.f.,zlz3:=.f.,zl123:=.f.
public zlkod:=0,zldat:=date(),zld:=14
public zlic_regon:=space(10),zlic_pesel:=space(11),zlic_konto:=space(60)
public zlic_tel:=space(15),zlic_fax:=space(15)
RETURN nil

FUNCTION ZLEG_SH_LIC()
zlic1=flic1
zlic2=flic2
zlic3=substr(flic6,1,6)
zlic4=flic3
zlic5=flic4
zlic6=substr(flic5,1,13)
zlic0=space(15)
zleg_kod=space(5)
zlz1=.f.
zlz2=.f.
zlz3=.f.
zl123=.f.
zlkod=0
zldat=date()
zld=14
zlic_regon=space(10)
zlic_pesel=space(11)
zlic_konto=space(60)
zlic_tel=space(15)
zlic_fax=space(15)
RETURN nil

FUNCTION PUBLIC_DOK()
public zdgrup:=space(1)
public zdtyp:=space(1)
public zdznak:=space(1)
*public zdidentyfik:=space(2)
public zdsymbol:=space(2)
public zdndow:=space(15)
public zdndok:=space(15)
public zdnzam:=space(15)
public zddatdow:=date()
public zddatdok:=date()
public zdtermin:=ctod("")
public zdkordat:=ctod("")
public zdkordok:=space(15)
public zdkontrah:=0
public zdnskrot:=space(15)
public zdniedop:=0
public zdsposzap:="G"
public zdrabat:=0
public zdkonto:=" "
public zdg_magazyn:=space(3)
public zdp_magazyn:=space(3)
public zdkormag_ok:=.f.
public zdwystawil:=space(30)
public zdodebral:=space(30)
public zdakwizytor:=0
public zdksiegowy:=.f.
public zddatsp:=date()
public zddatzal:=date()
public zddatsad:=ctod("")
public zddatgranic:=ctod("")
public zdster:=space(3)
public zd1_lamany:=space(3) 
public zdwaluta:=space(3)
public zdkurs:=1
public zdanul:=.f.
public zdopis1:=space(80)
public zdopis2:=space(80)
public zdopis3:=space(80)
public zdpom:=space(30)
*import_eksport
public zsad_numer:=space(30)
public zkursnbp_numer:=space(30)
public zwaluta:=space(10)
public zprzelicznik:=1
*
**
public zdnumer_zam:=space(15)
RETURN nil

*******************************************************************************
* Nadanie wartosci poczatkowych zmiennym wykorzystywanym do obliczen          *
* wartosci plikow typu towbuf.dbf                                             *
*******************************************************************************
FUNCTION PUBLIC_TPLIK()
public ztnet_a:=0,ztnet_b:=0,ztnet_c:=0,ztnet_d:=0,ztnet_e:=0,ztnet_f:=0,ztnet_z:=0
public ztvat_a:=0,ztvat_b:=0,ztvat_c:=0,ztvat_d:=0,ztvat_e:=0,ztvat_f:=0,ztvat_z:=0
public ztbrut_a:=0,ztbrut_b:=0,ztbrut_c:=0,ztbrut_d:=0,ztbrut_e:=0,ztbrut_f:=0
public ztnet_all:=0,ztvat_all:=0,ztbrut_all:=0,ztvat_z:=0,ztbrut_z:=0
RETURN nil

FUNCTION PUBLIC_TOW()
public ztndow:=space(15)
public ztnaz:=space(32)
public ztkod:=space(7)
public ztnum:=0
public ztmindex:=0
public ztdatdow:=date()
public ztkormag:=.t.
public ztil:=0
public ztjm:=space(3)
public ztcen:=0
public ztcen_ew:=0
public ztcen_dewiz:=0
public ztstawka:=0
public ztsymbol:=space(10)
public ztzwolniony:=.f.
public ztwyroznik:=space(1)
public ztwykonal:=.f.
public ztster:=space(3)
public ztmagaz:=space(1)
public ztgrup:=space(3)
public ztdekret:=space(10)
public ztanul:=.f.
RETURN nil

FUNCTION DOK_DEF_PUBLIC()
public zdokdef_recno:=recno()
public zgrupa_dok:=space(1)
public ztyp_dok:=space(1)
public zznak_dok:=space(1)
public zznak_dow:=space(1)
public znaz_dok:=space(10)
public ztyt_dok:=space(30)
public zlaman_dok:=space(3)
public zmagaz_dok:=space(2)	
public zmg_dok:=space(3)
public zmp_dok:=space(3)
public zwalut_dok:=space(3)
public zopis_dok:=space(80)
public zopis1_dok:=space(80)
public zopis2_dok:=space(80)
public zopis3_dok:=space(80)
*public identyfik:=space(2)
public zsymbol_dok:=space(2)
RETURN nil


***

FUNCTION NOWY_KASA_DOK(pkontrah,pdok,pautomat)
local ek,ltyt:=substr(zopis_dok,1,80),lpoz:=1,ltryb:=1
local lknaz1:="",ldtyp:=zdtyp,ldgrup:=zdgrup,ldndow:=zdndow
*dokdef(1)
zdpom:="Got¢wka"
zdgrup:=5
za_dokument=pdok
if pdok
  ztcen=zdniedop
  ztnaz="Za faktur©                      "
  ztnaz=stuff(ztnaz,12,15,zdndok)
  zdnzam=zdndow
  zdkordok=zdndok
endif
save screen to ek

do while.t.
  
  zdndow=space(15)
  z_zdok_def_lad()

  kasa_tlo()

  if.not.lpoz=5.and.pkontrah
    kontrah(zk_serwer,.t.,lknaz1,1,.T.,ltryb)
  else
    set color to n/w,w/n
  endif	
  if lastkey()=27
    exit
  endif
  ltryb=1
  lknaz1=zknaz1
  k_w=2
  k_k=12
  vksiega=.t.

  k_dop_tlo()
  k_say()

  dokkasa()
  if lastkey()=27.and..not.pautomat
    exit
  endif
 * wystawil(.f.)
  buf_use()
  go top
  tplik_sum(".not.eof()")
  zkwota=ztbrut_all
  set color to  
  @ 0,0 say space(80)
  if pkontrah.or..not.pdok
    lpoz=rozlicz_menu(0,0,lpoz)
  else
*	if.not.lastkey()=27

	  zap_dok(.f.)
	  vdok_plik=.f.
	  select &buf_sel	 
	  if pdok
        if kj_gkom(12,"","Drukowa†  ? ","",.t.,5) 
		  dok_druk(vdok_plik,.t.)	  
		endif	    
	  else
	    dok_druk(vdok_plik,.t.)	  
	  endif	
	  exit    
*	endif  
  endif	
  do case
    case lastkey()=27
	  exit
	case lpoz=1
	  zap_dok(.f.)
	  vdok_plik=.f.
	  select &buf_sel	 
	  dok_druk(vdok_plik,.t.)
	  exit
    case lpoz=2
	  zap_dok(.f.)
	  exit
    case lpoz=3
	  zap_dok(.f.)	  
      d_zer()	
      k_zer()
      tow_zer()
    case lpoz=4
	  zap_dok(.f.)	  
      ltryb=2
    case lpoz=5
	  zap_dok(.f.)	  
    case lpoz=6
      ltryb=2	  
    case lpoz=7
      exit	  	  
  endcase
  close_all("SH")
enddo
close_all("SH")
restore screen from ek
zdtyp=ldtyp
zdgrup=ldgrup
zdndow=ldndow
*dokdef(0)
RETURN 

FUNCTION KASA_DRUK(pilosc)
local lilosc:=1
w=prow()
k=0

do while.t.
  kas_dr()
  lilosc=lilosc+1
  if lilosc>pilosc
    exit
  endif
enddo
RETURN

FUNCTION KAS_DR()
local lkol,llic4,ltyt,len
local loryginal:="oryginaˆ",lkop:=1
zdrmiasto=pammiasto
ztbrut_all=ztcen
do case
  case zdznak="G".and.zdsposzap="G"
    ztyt_dok="Dow¢d wpˆaty  KP r"
  case zdznak="G".and.zdsposzap="P"
    ztyt_dok="Przelew "	
  case zdznak="g".and.zdsposzap="G"
    ztyt_dok="Dow¢d wypˆaty  KW "	
  case zdznak="g".and.zdsposzap="P"
    ztyt_dok="Przelew  "		
endcase

w=prow()
*k=0
k=zkas_margin
@ w,k say &zdr_kond
do while.t.
  lkol=65-len(alltrim(zdrmiasto))-15
  @ w,lkol say alltrim(zdrmiasto)+"   "+dtoc(zddatdok)    
  if.not.empty(zlic1)
    w=w+1
    lkol=(65-len(alltrim(zlic1)))/2
    @ w,lkol say alltrim(zlic1)
  endif 
  if.not.empty(zlic2)
    w=w+1
    lkol=(65-len(alltrim(zlic2)))/2
    @ w,lkol say alltrim(zlic2)
  endif 
  if.not.empty(zlic5)
    w=w+1
    lkol=(65-len(alltrim(zlic5)))/2
    @ w,lkol say alltrim(zlic5)
  endif 
  *if.not.empty(zlic4)
  llic4=stuff(space(50),1,6,zlic3)
  llic4=stuff(llic4,9,42,substr(zlic4,1,42))
  w=w+1
  lkol=(65-len(alltrim(llic4)))/2
  @ w,lkol say alltrim(llic4)+&zdr_kkond+&zdr_grubo
  *endif 
  w=w+2
  len=len(alltrim(ztyt_dok))
  ltyt=stuff(space(40),1,len,alltrim(ztyt_dok))
    ltyt=ztyt_dok
  ltyt=stuff(ltyt,len+1,4," nr ")

  ltyt=stuff(ltyt,len+7,len(alltrim(zdndok)),alltrim(zdndok))
  lkol=(40-len(alltrim(ltyt)))/2
  @ w,lkol say ltyt+&zdr_kond+&zdr_kgrubo
  w=w+1
  do case
    case zpapier_typ=1
	  @ w,29 say loryginal
    case zpapier_typ=2
	  @ w,18 say "oryginaˆ biaˆy / kopia kolor"
  endcase
  w=w+1
  @ w,k say "Kontrahent:"
  w=w+1
  @ w,k+3 say zknaz1  
  w=w+1
  @ w,k+3 say zknaz2
  w=w+1
  @ w,k+3 say zkulica
  w=w+1
  @ w,k+3 say zkkod + "  "+zkmiasto
  w=w+1
  @ w,k say "Tytuˆem:  "+ztnaz
  w=w+1
  @ w,k say "Kwota:    "+alltrim(str(ztbrut_all,12,2))+" zˆ"
  w=w+1

  k_slownie()
  w=w+2
  @ w,k say "Powy¾sz¥ kwot© otrzymaˆem"
  w=w+4
  @ w,k say "..................................."			    
  w=w+1
  @ w,k say "             podpis                "
  w=w+1
  do case
    case  zdtyp$sprzedaz_gr
      @ w,k say "Wystawiaj¥cy: "+zdwystawil  
    case  zdtyp$zakup_gr
      @ w,k+5 say "Powy¾sz¥ kwot© otrzymaˆem"
  endcase  
  	
  

  if zpapier_typ=1.and.lkop<2
    loryginal="kopia"
	lkop=lkop+1
	w=w+5
    @ w,k say replicate("-",65)
	w=w+5
  else
    exit
  endif	

enddo
if.not.zpapier_typ=1.or.loryginal="kopia" 
  eject
endif  

RETURN





FUNCTION ROZLICZ_MENU(pw,pk,ppoz1)
local topis[7],ek
local lbelka:="° Drukuj ° Zapami©taj ° Nowy ° A_wz¢r ° B_wz¢r ° Popraw ° Zrezygnuj °"
local lliter:="  D        Z            N      A        B        P          Z          "
topis[1]:="Zapami©taj i wydrukuj dokument."
topis[2]:="Zapami©taj dokument bez drukowania."
topis[3]:="Zapami©taj bie¾¥cy dokument i utw¢rz nowy."
topis[4]:="Zapami©taj i utw¢rz nowy dokument na wz¢r poprzedniego."
topis[5]:="Zapami©taj i utw¢rz nowy dokument na wz¢r poprzedniego bez zmiany kontrahenta."
topis[6]:="Popraw aktualnie redagowany dokument."
topis[7]:="Anuluj ostatni dokument."
ppoz1=menu_poziom(pw,pk,7,lbelka,lliter,topis,ppoz1,.f.,.f.)
RETURN ppoz1






FUNCTION KASA_TLO()
local ltyt:=substr(zopis_dok,1,80)
*ks_tlo()
kj_okno(0,0,24,ltyt,2)
g_tlo()
RETURN


FUNCTION DOKKASA()
local ltcen:=0
ltnaz:=space(32)
  kas_tlo() 
  kas_get()
  ltcen=ztcen
  if ztcen<0
    ztcen=-1*ztcen
  endif	
  if buf_use()
    zap
	pack
	append blank
	replace tnaz with ztnaz, til with 1, tcen with ztcen
	close
  endif
  ztcen=ltcen
RETURN

FUNCTION KAS_TLO()
local ltyt:="                   D O K U M E N T                     "
set color to n/w,w/n
kj_okno(13,12,10,ltyt,2)
@ 15,15 say "Data ....."
@ 17,15 say "Warto˜† .."
@ 19,15 say "Opis ....."
RETURN

FUNCTION KAS_GET()
local lcolor:=setcolor(),select:=select(),ek
zddatdow=date()
set cursor on
set color to n/w,w/n
@ 15,25 get zddatdow when s_kom("Wpisz dat© wystawienia dokumentu.  Esc - rezygnacja")
@ 17,25 get ztcen picture "9999999.99" when s_kom("Wpisz warto˜† dokumentu w ni¾ej podanej walucie. Esc - rezygnacja")
@ 19,25 say ztnaz 
if zdsposzap="P"
  zdndok=space(15)
  @ 21,15 say "Numer przelewu: "
  @ 21,32 get zdndok  when s_kom("Wpisz numer dokumentu bankowego.  Esc - rezygnacja")
endif
read
zddatdok=zddatdow
set cursor off
setcolor(lcolor)
RETURN

FUNCTION SLOWNIK_KAS()
local lcolor:=setcolor(),select:=select(),t[1],q[1],ek
t[1]:="mnaz"
q[1]:=""
  save screen to ek
  dok_default()
  if file("magaz.dbf")
    select &kasopis_sel
	if kj_use("magaz",.f.,3)
	  kj_okno(11,44,12," O p i s    dokumentu kasowego      ",2)
	  dbedit(13,46,22,77,t,"K_FU1","",q,"ß",,"ß")
	  keyboard chr(205)
	  inkey(.1)
	  restore screen from ek
	  @ 19,25 say ztnaz
	  close
	endif
	select &select
  endif
RETURN

FUNCTION K_FU1()
local last:=lastkey(),lmnaz:=space(32)

do case
  case last=27
    return 0
  case last=13
    ztnaz=mnaz
	return 0
  case chr(last)$"Dd"
    set cursor on
	@ 23,46 get lmnaz when s_kom("Nowy opis")
	read
	if.not.lastkey()=27
      if kj_append(3)
	    replace mnaz with lmnaz
        unlock
	  endif	
	endif
	set cursor off
    keyboard chr(205)
	return 2
  case chr(last)$"Pp"
    set cursor on
	lmnaz=mnaz
	@ 23,46 get lmnaz when s_kom("Modyfikacja opisu")
	read
	if.not.lastkey()=27
      if reclock(5)      
	    replace mnaz with lmnaz
        unlock
	  endif	
	endif
	set cursor off	
    keyboard chr(205)
	return 2	
  case chr(last)$"Kk"
	lmnaz=mnaz
	@ 23,46 say lmnaz 
	if kj_gkom(12,"","Usun¥† ? ","",.t.,5) 
      if reclock(5)      
	    delete
        unlock
	  endif	
	endif
	set cursor off	
    keyboard chr(205)
	return 2		

endcase
s_kom("Dopisz   Popraw   Kasuj   [Enter]-zatwierd« wyb¢r    [Esc]-zrezygnuj")
RETURN 1

FUNCTION KAS_SAY()
local lcolor:=setcolor()
set cursor on
set color to n/w,w/n
@ 15,25 say zddatdow
@ 17,25 say ztcen
@ 19,25 say ztnaz
setcolor(lcolor)
RETURN


FUNCTION POPRAW_KASA_DOK()
local recno:=recno(),ek
save screen to ek
za_dokument=.f.
vksiega=.t.
k_w=2
k_k=12
zdok_lad()
kj_dok_say(.f.)
zkwota=ztbrut_all
kasa_tlo()
k_dop_tlo()
kas_tlo() 
k_say()
*kas_get()
dokkasa()
if.not.lastkey()=27
  if.not.lastkey()=3
    *wystawil(.f.)
    if kj_gkom(12,"","Czy chcesz poprawi† dane kontrahenta ? ","",.t.,5) 
      kontrah(zk_serwer,.t.,zknaz1,1,.T.,1)
    endif	
  endif

  close_all("SH")
  dok_default()
  if tow_use(.f.)
    seek zdndow
    if found()
      if reclock(5)      
        tow_replac()
        unlock
      else
        return
      endif 
    else
      kj_tkom(12,"Uwaga","","","",5)
    endif
    close
  endif
  select &dokum_sel
*  select &kasa_sel
  if kj_use("dokum",.f.,3)
    set index to dok_ident,dok_num,dow_num
              if zdok_filtr
				set filter to alltrim(dsymbol)==alltrim(zdsymbol)
                go top
				go recno
              else
                seek zdsymbol
              endif  	
  endif  
    if zsiec
      if reclock(5)      
        dok_replac()  
        unlock
      else
        return
      endif 
    else
      dok_replac()
    endif 
else
  dok_default()
  select &dokum_sel
*  select &kasa_sel
  if kj_use("dokum",.f.,3)
    set index to dok_ident,dok_num,dow_num
              if zdok_filtr
				set filter to dsymbol=zdsymbol
                go top
				go recno
              else
                seek zdsymbol
              endif  	
  endif  
endif
keyboard chr(205)
set cursor off
restore screen from ek
RETURN	  
	  
	  
FUNCTION KASA_PREZENT(ptryb)
local ek
save screen to ek
vksiega=.t.
k_w=2
k_k=12
zdok_lad()
kj_dok_say(.f.)
zkwota=ztbrut_all
kasa_tlo()
k_dop_tlo()
kas_tlo() 
k_say()
kas_say()
s_kom("Naci˜nij dowolny klawisz !")
inkey(0)
do case
  case ptryb=1
  anul_dok()	
endcase
vksiega=.F.
restore screen from ek
RETURN	  

FUNCTION ENTER_KAS_MENU(ppoz)
local ltnaz[5],ltlit[5],ltopis[5],lbelka:="",lpoz:=ppoz,lile:=5
ltnaz[1]:=" Prezentacja "
ltnaz[2]:=" Wydruk      "
ltnaz[3]:=" Anulowanie  "
ltnaz[4]:=" Rozliczenie "
ltnaz[5]:=" Poprawianie "
ltlit[1]:=" P"
ltlit[2]:=" W"
ltlit[3]:=" A"
ltlit[4]:=" R" 
ltlit[5]:=" P" 
ltopis[1]:="Prezentacja wybranego dokumentu"
ltopis[2]:="Wydruk dokumentu kasowego"
ltopis[3]:="Anulowanie wskazanego kursorem dokumentu kasowego"
ltopis[4]:="Prezentacja dokument¢w kasowych dotycz¥cych wybranego rozliczenia"
ltopis[5]:="Poprawianie dokumentu wskazanego kursorem"
if.not.zanul_up
  ltnaz[3]:="-Anulowanie  "
  ltopis[3]:="Brak uprawnieä do anulowania  dokument¢w"
endif
if.not.zpopraw_up
  lile=4
endif
  @ 7,33,10+lile,49 box chr(176)
  lpoz=men_pion(8,34,lile,lbelka,ltnaz,ltlit,ltopis,lpoz)
RETURN lpoz


FUNCTION KASLICZ_MENU(ppoz)
local ltnaz[2],ltlit[2],ltopis[2],lbelka:="",lpoz:=ppoz
ltnaz[1]:=" Ekran    "
ltnaz[2]:=" Drukarka "
ltlit[1]:=" E"
ltlit[2]:=" D"
ltopis[1]:="Prezentacja na ekranie"
ltopis[2]:="Wydruk rozliczenia"
  lpoz=men_pion(12,46,2,lbelka,ltnaz,ltlit,ltopis,lpoz)
RETURN lpoz



FUNCTION KAS_ROZLICZ(pnumdow,prap)
local lkj_kasa:=zkj_kasa,lnumdow:=pnumdow,recno:=recno(),ltbrut_all:=0
local ltyt:="",lnumdok:="",ldtyp:=zdtyp,sk, t[3],q[3],lkas_all:=0,lndok,k:=5
local l_dtyp:="",ldtyp1:=""
local lnum:=0
local ldarchiwum:=zdarchiwum
vnumdow:=pnumdow
t[1]:="dndok"
t[2]:="ddatdok"
t[3]:="dwystawil"
q[1]:="Numer"
q[2]:="Data"
Q[3]:="Dokument wystawiˆ"
save screen to ek
zdkordok=dkordok
set filter to dkordok=zdkordok
go top
      kj_okno(9,23,13,"  Wykaz dokument¢w kasowych         ",2)
      dbedit(10,24,20,56,t,"K_FU2","",q,"ß",,"ß")
      
set filter to 
go top
go recno
restore screen from ek

RETURN

FUNCTION K_FU2()
local last:=lastkey()
lnumdow=dndow
dok_licz(lnumdow,.f.)
@ 21,26 say "Warto˜† wpˆaty:"
@ 21,41 say ztbrut_all picture "999 999 999.99"
do case
  case last=27
    return 0
endcase
RETURN 1



FUNCTION KAS_RAP()
local ek, lcolor:=setcolor()
save screen to ek
set device to screen
if empty(zan_txt)
  zdtyp="G"
else
  zdtyp=substr(zan_txt,1,1)
endif
zdznak=zdtyp
do while.t.
  if r_parametry()
    kasrap_druk()  
  else
    exit
  endif
enddo
select &rap_sel
restore screen from ek
setcolor(lcolor)
RETURN

*****************************

FUNCTION KASRAP_DRUK()
local ek,lcolor:=setcolor()
public rapwar:=".t."
private vpoz:=0
private vilosc_sum:=0,vcen_zak:=0,vcen_sp:=0,vwart_zak:=0,vwart_sp:=0
private vzak_all:=0,vsp_all:=0
public zdoktyp:=alltrim(substr(zan_txt,1,20))
public_rap()
public_srap()
zrap_zer()
zsrap_zer()
save screen to ek
dok_use()
set order to 3
tow_use(.f.)
if.not.empty(zdoktyp)
  if zdtyp$dowod_gr
    do case
      case zokres_def=1
        rapwar="f_datdow(f_tdat1).and.f_dtyp(zdoktyp)"
      case zokres_def=2
	    rapwar="f_miesdow(f_tmiesiac).and.f_dtyp(zdoktyp)"	
      case zokres_def=3
        rapwar="f_2datdow(f_tdat1,f_tdat2).and.f_dtyp(zdoktyp)"
    endcase
  else
    do case
      case zokres_def=1
        rapwar="f_datdok(f_tdat1).and.f_dtyp(zdoktyp)"
      case zokres_def=2
	    rapwar="f_miesdok(f_tmiesiac).and.f_dtyp(zdoktyp)"	
      case zokres_def=3
        rapwar="f_2datdok(f_tdat1,f_tdat2).and.f_dtyp(zdoktyp)"
    endcase
  endif
else
  if zdtyp$dowod_gr
    do case
      case zokres_def=1
        rapwar="f_datdow(f_tdat1)"
      case zokres_def=2
	    rapwar="f_miesdow(f_tmiesiac)"	
      case zokres_def=3
        rapwar="f_2datdow(f_tdat1,f_tdat2)"
    endcase  
  else
    do case
      case zokres_def=1
        rapwar="f_datdok(f_tdat1)"
      case zokres_def=2
	    rapwar="f_miesdok(f_tmiesiac)"	
      case zokres_def=3
        rapwar="f_2datdok(f_tdat1,f_tdat2)"
    endcase
  endif
endif
if.not.zknum=0
  rapwar=rapwar+".and.f_kontrah()"
endif



kj_okno(4,20,4, "  C z e k a j  ! !                      ",2)
set color to n/w*
@ 6,28 say "Trwaj¥ operacje dyskowe."
setcolor(lcolor)

select &tow_sel
set filter to &rapwar
go top
set device to printer

if zdruk_def=1
  if.not.pstart_druk()
    set device to screen
 	return .f.
  endif
  *set printer to
else
  plik="wydruki\kas_rap.txt"
  set printer to &plik
endif

set device to printer

do case
  case zan_def2=0
    kasrap_szcz(.t.)    

  case zan_def2=1
    kasrap_szcz(.t.)    
	eject
    set device to screen
	if kj_gkom(12," ","Drukowa† posdsumowanie ?","",.t.,5)	
	  set device to printer
	  kas_sum(1)
      eject
	endif	
  case zan_def2=2
    kasrap_szcz(.t.)    
	eject
	kas_sum(1)
	eject    
  case zan_def2=3
    kasrap_szcz(.f.)    
	kas_sum(1)    	
	eject
endcase

    set device to screen
    if.not.zdruk_def=1
      edi=edit+" wydruki\kas_rap.txt"
      run &edi 
      restore screen from ek
      set cursor off   
    endif
**


restore screen from ek
RETURN


FUNCTION KASRAP_SZCZ(pdruk)
local lraz:=1
private vpoz:=0
public kpg_all:=0,kpp_all:=0,kwg_all:=0,kwp_all:=0


select &tow_sel
for lraz=1 to 2
  go top
  
  vpoz=0
  if pdruk
    kas_szcz_tyt(lraz)
  endif	
  do while.not.eof()
    do case
	  case lraz=1.and.zdtyp=substr(kasa_gr,1,1)
	  	if pdruk
		  vpoz=vpoz+1
          kas_szcz_wiersz()
		endif  
		do case
		  case zdsposzap="G"
		    kpg_all=kpg_all+tcen
		  case zdsposzap="P"
		    kpp_all=kpp_all+tcen			
		endcase
		
	  case lraz=2.and.zdtyp=substr(kasa_gr,2,1)
	  	if pdruk
		  vpoz=vpoz+1
          kas_szcz_wiersz()
		endif  
		do case
		  case zdsposzap="G"
		    kwg_all=kwg_all+tcen
		  case zdsposzap="P"
		    kwp_all=kwp_all+tcen			
		endcase
	endcase
    skip
  enddo
  if lraz=1.and.pdruk
    kas_szcz_stopa(1)
    eject
  endif
next
close
if.not.pdruk
  return
endif
kas_szcz_stopa(2)
w=w+5
kas_sum(0)
end_rap()
eject
RETURN

FUNCTION KAS_SZCZ_WIERSZ()
w=w+1
@ w,1 say vpoz picture "99999"
@ w,8 say zdndok
@ w,26 say zddatdok
@ w,42 say tnaz
do case
  case zdsposzap="G"
    @ w,77 say tcen picture "999 999 999.99"
  case zdsposzap="P"
    @ w,93 say tcen picture "999 999 999.99"	
endcase

RETURN

FUNCTION KAS_SZCZ_TYT(ptryb)
local k:=0
local ltxt1:="Zestawienie dokument¢w typu KP - przyj©cie got¢wki do kasy lub rejestracja wpˆaty przelewowej"
local ltxt2:="============================================================================================================"
local ltxt3:="  Lp.   Numer dokumentu   Data            Tytuˆ pˆatno˜ci                    Got¢wka           Przelew      "
if ptryb=2
  ltxt1:="Zestawienie dokument¢w typu KW - wydanie got¢wki z kasy lub rejestracja zapˆaty przelewem"
endif
r_tyt()
@ prow(),pcol() say &zdr_kond
w=w+3
@ w,0 say ltxt1+&zdr_kond
w=w+2
@ w,k say ltxt2
w=w+2
@ w,k say ltxt3
w=w+2
@ w,k say ltxt2
RETURN 

FUNCTION KAS_SZCZ_STOPA(ptryb)
local k:=0
local ltxt1:="============================================================================================================"
local ltxt2:="                                                                 ==========================================="
w=w+1
@ w,k say ltxt1
w=w+1
@ w,k+65 say "Razem:"
do case
  case ptryb=1
    @ w,77 say kpg_all picture "999 999 999.99"
    @ w,93 say kpp_all picture "999 999 999.99"
  case ptryb=2
    @ w,77 say kwg_all picture "999 999 999.99"	
	@ w,93 say kwp_all picture "999 999 999.99"	
endcase
w=w+1
@ w,k say ltxt2
RETURN  

FUNCTION KAS_SUM(ptryb)
local ltxt1:="KP - przyj©cie got¢wki do kasy "
local ltxt2:="KW - wydanie got¢wki z kasy    "
if ptryb=1
  r_tyt()
  w=w+4
endif
@ w,0 say &zdr_kkond+ltxt1
w=w+1
@ w,0 say ltxt2
w=w+3
@ w,0 say "¥czna warto˜† dokument¢w typu KP ........"
@ w,42 say kpg_all picture "999 999 999.99"
w=w+2
@ w,0 say "¥czna warto˜† dokument¢w typu KW ........"
@ w,42 say kwg_all picture "999 999 999.99"
w=w+1
@ w,43 say "-------------"
w=w+1
@ w,0 say "Warto˜† got¢wki w kasie .................."
@ w,42 say kpg_all-kwg_all picture "999 999 999.99"
w=w+3
@ w,0 say "¥czna warto˜† przelew¢w przyj©tych ......"
@ w,42 say kpp_all picture "999 999 999.99"
w=w+2
@ w,0 say "¥czna warto˜† przelew¢w wysˆanych ......."
@ w,42 say kwp_all picture "999 999 999.99"
w=w+1
@ w,43 say "-------------"
w=w+1
@ w,0 say "Warto˜† got¢wki w banku .................."
@ w,42 say kpp_all-kwp_all picture "999 999 999.99"
w=w+3
@ w,0 say "Razem przychody (got¢wka + przelewy) ....."
@ w,42 say kpg_all+kpp_all picture "999 999 999.99"
w=w+2
@ w,0 say "Razem wydatki (got¢wka + przelewy) ......."
@ w,42 say kwg_all+kwp_all picture "999 999 999.99"
w=w+1
@ w,43 say "-------------"
w=w+1
@ w,0 say "Warto˜† got¢wki w kasie i w banku ........"
@ w,42 say kpg_all+kpp_all-kwg_all-kwp_all picture "999 999 999.99"
RETURN 

FUNCTION KAS_MENU1(ppoz)
local ltnaz[2],ltlit[2],ltopis[2],lbelka:="",lpoz:=1
ltnaz[1]:=" Drukarki    "
ltnaz[2]:=" Opcje       "

ltlit[1]:=" D           "
ltlit[2]:=" O           "
ltopis[1]:="Wyb¢r drukarki domy˜lnej"
ltopis[2]:="Definiowane przez U¾ytkownika opcje programu."
save screen to ek
  lpoz=men_pion(6,37,2,lbelka,ltnaz,ltlit,ltopis,lpoz)
RETURN lpoz

FUNCTION KASA_DOK()
*dokdef(1)
     vdtyp=zdtyp
	 kj_dok_say(.f.)
	 lcolor=setcolor()
	 dok_filtr=dbfilter()
	 dok_recno=recno()
	 do case
	   case zdtyp$sprzedaz_gr
	     zdtyp=substr(kasa_gr,1,1)
	   case zdtyp$zakup_gr
	     zdtyp=substr(kasa_gr,2,1)		 
	 endcase
     ldokdef_recno=zdokdef_recno
	 if dokdef_use()	 
	   locate for typ_dok=zdtyp
	   if found()
         zdok_def_lad()	     
	   endif
	   close
	 endif
     select &dokum_sel	 
	 dok_default()
     nowy_kasa_dok(.f.,.t.,.t.)      
     zdtyp=vdtyp
	 if dokdef_use()	 
	   go ldokdef_recno
       zdok_def_lad()	     
	   close
	 endif	 
	 *tow_use(.f.)
	 *dok_use()
	 *set filter to &dok_filtr
	 *go top
	 *go dok_recno
	 *zdok_lad()
	 setcolor(lcolor)
RETURN 



FUNCTION KAS_INST()
select 100
if.not.kj_use("kas_def",.t.,3)
  kj_tkom(12,"Uwaga","","Wyst¥piˆ problem przy pr¢bie doinstalowania programu kasowego.","",5)
  return
endif
if dokdef_use()	 
  set index to dok_def
else
  kj_tkom(12,"Uwaga","","Wyst¥piˆ problem przy pr¢bie doinstalowania programu kasowego.","",5)
  return  
endif
s_kom("Czekaj !   Trwa instalacja programu kasowego.")
select 100
do while.not.eof()
  zdok_def_lad()
  select &dokdef_sel
  locate for typ_dok==ztyp_dok
  if.not.found()
    if kj_append(3)
	  dokdef_replac()
      unlock
    endif  
  endif
  select 100
  skip
enddo
close_all("SH")
erase kas_def.dbf
indeksacja()
kj_tkom(12,"Ok!","","Program kasowy doinstalowano poprawnie.","",5)
RETURN

FUNCTION PRZELGOT_MENU(ppoz)
local ltnaz[5],ltlit[5],ltopis[5],lbelka:="",lpoz:=ppoz,lile:=2
ltnaz[1]:=" Got¢wka     "
ltnaz[2]:=" Przelew     "
ltlit[1]:=" G"
ltlit[2]:=" P"
ltopis[1]:="Wpˆata got¢wkowa"
ltopis[2]:="Wpˆata przelewem"
  @ 7,33,10+lile,49 box chr(176)
  lpoz=men_pion(8,34,lile,lbelka,ltnaz,ltlit,ltopis,lpoz)
RETURN lpoz

FUNCTION S_KOM(ptxt,pcolor)
local lcolor:=setcolor()
local kol:=0
do case
  case pcolor=1
    set color to n/w,w/n
  case pcolor=2
    set color to 
  case pcolor=3
    set color to R+/W,W/R+		
  case pcolor=4
    set color to BG+/W,W/BG+
  case pcolor=5
    set color to R/W,W/R						
endcase
ptxt=alltrim(ptxt)
if len(ptxt)>80
  ptxt=substr(ptxt,1,80)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
setcolor("N/W,W/N")
@ 24,0 say space(80)
@ 24,kol say ptxt
setcolor(lcolor)
RETURN .t.


FUNCTION K_DOP_TLO()
local ltytul:="              *   K O N T R A H E N T   *              "   
local lcolor:=setcolor(),lile_wierszy:=9
kj_okno(k_w,k_k,lile_wierszy,ltytul,7)	
set color to gr+	
@ k_w+2,k_k+4 say "Numer identyfikacyjny   NIP:"  &&28
@ k_w+3,k_k+4 say "Nazwa......."                  &&10
@ k_w+5,k_k+4 say "Ulica /nr..."                  &&12
@ k_w+6,k_k+4 say "Kod pocztowy"                  &&12
@ k_w+7,k_k+4 say "Miasto ....."                  &&12
setcolor(lcolor)
RETURN nil

FUNCTION K_SAY()
local lcolor:=setcolor()
set color to W+	
@ k_w+2,k_k+38 say zknip
@ k_w+3,k_k+20 say substr(zknaz1,1,30)
@ k_w+4,k_k+20 say substr(zknaz2,1,30)
@ k_w+5,k_k+20 say zkulica
@ k_w+6,k_k+20 say zkkod  
@ k_w+7,k_k+20 say zkmiasto
setcolor(lcolor)
RETURN nil


FUNCTION K_DANE()
*do zflad     &&nadanie zmiennym dokumentu wartosci aktualnego rekordu
*** dane kontrahenta (pracownika)
    do kondefault
    select 5
    use kontrah index kont_nr
    seek znplat
    if .not. found()
      use trah index trah_nr
        seek znplat
          if .not. found()
*          do tkom with "PROBLEM! 1  Indeksuj i ponow probe.   Nacisnij dowolny klawisz"  
          do zkzer
          use  
              do dokdefault
            return
        endif
    endif         
    do zklad
      zrabat=zdrabat
      zkontrahkonto=zkkonto
    close  
do dokdefault
***
select 1
RETURN


FUNCTION BUF_USE()
      *set default to shset
	  set default to &zset_serwer
      select &buf_sel
	  if.not.used()
        if.not.kj_use("towbuf",.t.,3)
	      return .F.
		else
		  set index to towbuf
		endif
		set index to towbuf
      else
	    set index to towbuf
	  endif
RETURN .T.



FUNCTION KON_USE()
lexlusive:=.f.
set default to &zk_serwer
select &kon_sel
if.not.used()
  if.not.kj_use("kon",lexlusive,3)
    return .f.
  endif
  set index to k_naz,k_nip,k_num
endif
RETURN .t.

FUNCTION TOW_USE()
set default to &zd_serwer
select &tow_sel
if.not.used()
    if.not.kj_use("towary",.f.,3)
      return .f.
    endif
    set index to t_dow,t_index,t_nazkod
endif
RETURN .t.

FUNCTION DOK_USE()
set default to &zd_serwer
select &dokum_sel
if.not.used()
  if kj_use("dokum",.F.,3)
    set index to dok_ident,dok_num,dow_num
  else	
    return .f.
  endif
endif
RETURN .t.



do while .t.
  set default to shset
  set default to &set_serwer
  select &buf_sel
  if.not.used()
    if.not.kj_use("towbuf",.t.,3)
      exit
    else
	  set index to towbuf
	endif
  endif
  if zdznak $ zkordok_znak
    reduk_buf()
  endif  
***  
  if.not.dok_use()
    exit
  endif
*** 
  if.not.nowy_numdok(lwzor)
    exit
  endif
  dok_default()
**
  select &buf_sel
  go top
  tplik_sum(".not.eof()")  
  zdniedop=ztbrut_all-zkwota
	    if kasa_glowna.and.zdtyp$kasadok_gr.and.zdsposzap="G"
		  zdniedop=ztbrut_all 
		endif  
**
  select &dokum_sel
  if kj_append(3)
    dok_replac()  
    unlock
  else
    exit
  endif  
  select &tow_sel
  if.not.tow_use(.f.)
    exit
  endif
  select &buf_sel
	if zdtyp$import_gr.or.zdtyp$eksport_gr
	  go top
	  do while.not.eof()
	    replace tcen_dewiz with tcen
		replace tcen with kj_round(tcen*zdkurs/zprzelicznik,2)
		skip
	  enddo	
	endif
  go top
  do while.not.eof()
    ztow_lad()
*	if zdtyp $ zakup_gr
*	  ztnum=tnum_new()
*	endif  

	select &tow_sel
    if zsiec
      if kj_append(3)
	    tow_replac()
        if.not.zdtyp$kormag_gr
		  replace tkormag with .f.
		endif
        unlock
	  else
        kj_tkom(12," Uwaga! ","System wykryˆ problem w dost©pie do baz danych.","Operacj© zapisu przerwano - dokument nie b©dzie zapami©tany.","Usuä problemy i ponow pr¢b©!",5)
        close_all("SH")
        *dok_default()
		*set default to shset
		set default to &set_serwer
        select &buf_sel
		if.not.used()
          kj_use("towbuf",.t.,3)
		  set index to towbuf
        endif
		dok_default()
        RETURN lsukces	  
	   endif	
	else
	  append blank
	  tow_replac()
        if.not.zdtyp$kormag_gr
		  replace tkormag with .f.
		endif
	endif
    commit
	select &buf_sel
	skip
  enddo	
  lsukces=.t.
  exit
enddo
if.not.lsukces
  kj_tkom(12," Uwaga! ","System wykryˆ problemy w dost©pie do baz danych.","Operacj© zapisu przerwano - dokument nie b©dzie zapami©tany.","Usuä problemy i ponow pr¢b©!",5)
endif  
set default to &(zk_serwer+"KONTRAH")
select &kon_sel
if kon_use()
  set order to 3
  seek zdkontrah
  if found()
		    if zsiec
	          if reclock(5)      
	            replace kodebral with  zdodebral 
		        unlock
	            lzapisano=.t.
	          endif	
	        else
	            replace kodebral with  zdodebral 			
	        endif			  
  endif
endif



close_all("SH")
*dok_default()
*set default to shset
set default to &set_serwer
select &buf_sel
if.not.used()
  if kj_use("towbuf",.t.,3)
    set index to towbuf
    if druk_fiskalna.and.zdtyp $ fiskal_gr
      if kj_gkom(12," Uwaga!","","Wydrukowa† paragon fiskalny ?",.t.,5)
	    do fis with fis_com 
	  endif	
    endif  
  else
    lsukces=.f.
  endif  
endif
close_all("SH")
if zdtyp$kasa_gr.and..not.empty(zdnzam)
  zdarchiwum=ldarchiwum
  kas_rozlicz(zdnzam,0)
endif
RETURN lsukces

FUNCTION NOWY_NUMDOK()
local lsukces:=.f.,lndok:=0
set default to &zdnum_serwer
  select &num_sel
  if kj_use("dpam",.F.,6)
    locate for znak=zdgrup
	lndok=numer+1
	if found()
        if reclock(5)      
	      replace numer with lndok 
          unlock
          commit
		endif  	  
	else
      close
	  return .f.	
	endif
	zdndow=stuff(space(15),9-len(alltrim(str(lndok))),len(alltrim(str(lndok))),alltrim(str(lndok)))
    zdndow=stuff(zdndow,9,2,"/"+znak)
    zdndow=stuff(zdndow,11,4,"/"+ALLTRIM(STR(year(zddatdow))))	  
	***
	if zdsposzap="G"
	  locate for znak=zdznak
	  lndok=numer+1
	  if found()
        if reclock(5)      
	      replace numer with lndok 
          unlock
          commit
		endif  	  
	  else
        close
	    return .f.	
	  endif
	  zdndok=stuff(space(15),9-len(alltrim(str(lndok))),len(alltrim(str(lndok))),alltrim(str(lndok)))
      zdndok=stuff(zdndok,9,2,"/"+znak)
      zdndok=stuff(zdndok,11,4,"/"+ALLTRIM(STR(year(zddatdok))))	  	
    endif
  endif
close
lsukces=.t.
RETURN lsukces



FUNCTION NOWY_KON()
local ljest:=.f.
if kon_use()
  seek zknaz1
  if found()
    do while knaz1=zknaz1
	  if knaz2=zknaz2.and.kmiasto=zkmiasto.and.kulica=zkulica.and.knip=zknip
	    ljest=.t.
        exit
	  endif
	  skip
	enddo
  endif
  if ljest
    zknum=knum
	close
	return
  else
    k_numerpoz()
    kj_append(3)
    k_replac() 
    unlock        	
  endif
endif
close
RETURN

FUNCTION K_REPLAC()
	    replace knaz1 with zknaz1,knaz2 with zknaz2,kmiasto with zkmiasto,kulica with zkulica
	    replace kkod with zkkod,ktel with zktel,kfax with zkfax,kkonto with zkkonto
	    replace knip with zknip,kgrupa with zkgrupa,kodebral with zkodebral
	    replace krabat with zkrabat,knum with zknum,klimit with zklimit
		replace kgrup_kod with zkgrup_kod,uzyt_last with zuzyt_last
		replace dat_last with date(),time_last with time()
RETURN nil

FUNCTION K_NUMERPOZ()
local recno:=recno()
public numwar:=dbfilter()
set filter to
go top
        set order to 3
	    go bottom
	    zknum=knum+1
	    set order to 1
set filter to &numwar
go top
go recno	
RETURN

FUNCTION DOK_REPLAC()
zddatdok=zddatdow
zdnskrot=substr(zknaz1,1,15)
zdkontrah=zknum
zdniedop=0
*
replace dgrup with zdgrup
replace dtyp with zdtyp
replace dznak with zdznak
replace dsymbol with zdsymbol
replace dndow with zdndow
replace dndok with zdndok
replace dnzam with zdnzam
replace ddatdow with zddatdow
replace ddatdok with zddatdok
replace dtermin with zdtermin
replace dkordat with zdkordat
replace dkordok with zdkordok
replace dkontrah with zdkontrah
replace dnskrot with zdnskrot
replace dniedop with zdniedop
replace dsposzap with zdsposzap
replace drabat with zdrabat
replace dkonto with zdkonto
replace dg_magazyn with zdg_magazyn
replace dp_magazyn with zdp_magazyn
replace dkormag_ok with zdkormag_ok
*replace dwystawil with zdwystawil
replace dwystawil with zdwystawil
replace dodebral with zdodebral
replace dakwizytor with zdakwizytor
replace dksiegowy with zdksiegowy
replace ddatsp with zddatsp
replace ddatzal with zddatzal
replace ddatsad with zddatsad
replace ddatgranic with zddatgranic
replace dster with zdster
replace d1_lamany with zd1_lamany
replace dwaluta with zdwaluta
replace dkurs with zdkurs
replace danul with zdanul
replace dopis1 with zdopis1
replace dopis2 with zdopis2
replace dopis3 with zdopis3
replace dpom with zdpom
RETURN nil

FUNCTION TOW_REPLAC()
ztndow=zdndow
ztdatdow=zddatdow
replace tndow with ztndow
replace tnaz with ztnaz
replace tkod with ztkod
replace tnum with ztnum
replace tmindex with ztmindex
replace tdatdow with ztdatdow
replace tkormag with ztkormag
replace til with ztil
replace tjm with ztjm
replace tcen with ztcen
replace tcen_ew with ztcen_ew
replace tcen_dewiz with ztcen_dewiz
replace tstawka with ztstawka
replace tsymbol with ztsymbol
replace tzwolniony with ztzwolniony
replace twyroznik with ztwyroznik
replace twykonal with ztwykonal
replace tster with ztster
replace tmagaz with ztmagaz
replace tgrup with ztgrup
replace tdekret with ztdekret
replace tanul with ztanul
RETURN nil


FUNCTION START_DRUK()
local ldruk:=.t.
if.not.empty(zdr_port).and..not.(alltrim(zdr_port)="LPT1".or.alltrim(zdr_port)="lpt1".or.alltrim(zdr_port)="Lpt1")
  set device to printer
  set printer to 
 do case
   case alltrim(zdr_port)="LPT2".or.alltrim(zdr_port)="lpt2".or.alltrim(zdr_port)="Lpt2"
      set printer to lpt2
    case alltrim(zdr_port)="LPT3".or.alltrim(zdr_port)="lpt3".or.alltrim(zdr_port)="Lpt3"
      set printer to lpt3
    case alltrim(zdr_port)="LPT4".or.alltrim(zdr_port)="lpt4".or.alltrim(zdr_port)="Lpt4"
      set printer to lpt4
    case alltrim(zdr_port)="LPT5".or.alltrim(zdr_port)="lpt5".or.alltrim(zdr_port)="Lpt5"
      set printer to lpt5			
  endcase
  set device to screen
else
  do while.not. isprinter()
    do tkom with "Przygotuj drukarke i nacisnij dowolny klawisz.  Esc-Rezygnacja"
    if lastkey()=27
      ldruk=.f.  
	  exit
    endif
  enddo
endif  
RETURN ldruk

FUNCTION PSTART_DRUK()
local ldruk:=.t.
*port_def()
  do while.not. isprinter()
    set device to screen
	do tkom with "Przygotuj drukarke i nacisnij dowolny klawisz.  Esc-Rezygnacja"
    if lastkey()=27
      ldruk=.f.  
	  exit
    endif
*	port_def()
  enddo
RETURN ldruk


FUNCTION K_SLOWNIE()
local kwota:=ALLTRIM(str(ztbrut_all))
local cyfra:=" "
@ w,0 say "Sˆownie : "
for i=1 to len(kwota)
  do case
    case substr(kwota,i,1)="0"
	  cyfra="*zero"
    case substr(kwota,i,1)="1"
	  cyfra="*jeden"
    case substr(kwota,i,1)="2"
	  cyfra="*dwa"
    case substr(kwota,i,1)="3"
      cyfra="*trzy"
    case substr(kwota,i,1)="4"
	  cyfra="*cztery"
    case substr(kwota,i,1)="5"
      cyfra="*pi©†"
    case substr(kwota,i,1)="6"
	  cyfra="*sze˜†"
    case substr(kwota,i,1)="7"
	  cyfra="*siedem"
    case substr(kwota,i,1)="8"
	  cyfra="*osiem"
    case substr(kwota,i,1)="9"
	  cyfra="*dziewi©†"
    case substr(kwota,i,1)="."
	  cyfra="*Zˆ "	  
  endcase
  @ prow(),pcol() say cyfra
next
  @ prow(),pcol() say " GR "
RETURN


PROCEDURE ZKZER
  znaz1=space(30)
  znaz2=space(30)
  zmiasto=space(30)
  zulica=space(30)
  zkod="  -   "
  ztel=space(15)
  zfax=space(15)
  zpager=space(15)
  zkkonto=space(60)
  zgrupa=space(5)
  znskrot=space(15)
  zrabat=0.0
  znr_kontr=0
  zkontrahkonto=space(40)
  znip=space(13)
RETURN  


FUNCTION K_GET()
local lcolor:=setcolor(),las,las1,lget
local lkonto1:=substr(zkkonto,1,30),lkonto2:=substr(zkkonto,31,30)
local lkonto3:=substr(zkkonto,61,30)
public vrow:=k_w+2
*set confirm off
set color to n/w,w/n	
set cursor on
      @ k_w+2,k_k+38 get zknip
      @ k_w+3,k_k+20 get zknaz1 picture "@!"
	    @ k_w+4,k_k+20 get zknaz2 picture "@!"
      @ k_w+5,k_k+20 get zkulica picture "@!"
      @ k_w+6,k_k+20 get zkkod  
      @ k_w+7,k_k+20 get zkmiasto picture "@!"	  
  read
  k_say()
set cursor off
setcolor(lcolor)
RETURN 
