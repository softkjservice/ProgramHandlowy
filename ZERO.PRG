local ek,ek1,t[3]
local index:=.f.
t[1]:=" DOKUMENTY    "
t[2]:=" MAGAZYNY     "
t[3]:=" WSZYSTKO     "
*save screen to ek
zz=.f.
s=1
@ 11,47 to 15,63 double 
s=achoice(12,48,14,62,t,,,s)
do case
  case s=1
    do gkom with "UWaga !  Wszystkie dokumenty zostana usuniete. Zatwierdzic ?  [T/F] ",zz
    if zz.and.lastkey()#27
	  do zerdok
      do zernum
	  index=.t.
      zz=.f.
	  do gkom with "Usunac baze kontrahenta ?  [T/F] ",zz
	  if zz.and.lastkey()#27
	    zz=.f.
	    do gkom with "Uwaga !  Baza kontrahentow zostanie usunieta.  Zatwierdzic ?  [T/F] ",zz
	    if zz.and.lastkey()#27
	      do zerkon
	    endif	
	  endif	  
	endif  

  case s=2
    zz=.f.
	do gkom with "Uwaga!  Wszystkie pozycje magazynowe zostana usuniete.  Zatwierdzic?  [T/F]",zz
    if zz.and.lastkey()#27
	  do zermag
      index=.t.
	endif  
  case s=3
    zz=.f.
	do gkom with "Uwaga !  Wszystkie pozycje zostana usuniete.  Zatwierdzic ?  [T/F] ",zz 
    if zz.and.lastkey()#27
	  do zerdok
	  do zernum
	  do zerkon
	  do zermag
	  index=.t.
	endif  
endcase
if index
  do magindex
endif  
return

PROCEDURE ZERDOK
do dokdefault
select 1
if file("dok_anul.dbf")
  use dok_anul
  zap
endif  
if file("dokument.dbf")
  use dokument
  zap
endif  
if file("korekta.dbf")  
  use korekta
  zap
endif
if file("paragon.dbf")  
  use paragon
  zap
endif  
if file("pzdok.dbf")  
  use pzdok
  zap
endif  
if file("rachunek.dbf")  
  use rachunek
  zap
endif  
if file("sprzedaz.dbf")  
  use sprzedaz
  zap
endif  
if file("towanul.dbf")
  use towanul
  zap
endif  
if file("zakup.dbf")
  use zakup
  zap
endif  
if file("razem.dbf")
  use razem
  zap
endif  
if file("datyplat.dbf")
  use datyplat
  zap
endif
if file("odsetki.dbf")
  use odsetki
  zap
endif
if file("wplata.dbf")
  use wplata
  zap
endif
rdnum=0
save to pam
close
RETURN

PROCEDURE ZERMAG
select 1
for i=1 to wmagil
  do pmagdefault with i
  if file("asortym.dbf")
    use asortym
    zap
  endif
  if file("magazyn.dbf")
    use magazyn
    zap
  endif
  if file("opis.dbf")	
    use opis
    zap
  endif
  if file("archiw.dbf")	
    use archiw
    zap
  endif
  if file("zapas.dbf") 
    use zapas
    zap
  endif	
  if file("bo.dbf")
    use bo
    zap
  endif	
  use mpam
  replace mnumer with 0,mdex with 0,magnum with i,msprzedaz with .f.
  replace mszukaj with .f.,mlog1 with .f.,mlog2 with .f.,mlog3 with .f.
  close
next  
RETURN

PROCEDURE ZERKON
select 1
do kondefault
if file("trah.dbf")
  use trah
  zap
endif
if file("kontrah.dbf")  
  use kontrah
  zap
endif
if file("odebral.dbf")  
  use odebral
  zap
endif  
close
RETURN

PROCEDURE ZERNUM
local ek
save screen to ek
@ 12,13 to 17,47 double 
@ 13,14 say " Numer ostatnio zarejestrowanej  "
@ 14,14 say " FAKTURY..........               "
@ 15,14 say " RACHUNKU.........               "
@ 16,14 say " PARAGONU.........               "
use dpam
set cursor on
@ 14,32 get dnumfakt
@ 15,32 get dnumrach
@ 16,32 get dnumpar
read
set cursor off
close
RETURN