*******************************************************************************
* MENU PROGRAMU "FIRMA"                                                       *
****************************************************************************** 
local t1[3],t2[1],t3[2],T4[2],t5[3],t10[4],t11[3],T6[3],T7[2],T8[6],t9[3],t12[5],t13[3]
local s:=1
local last:=lastkey()
local em:=savescreen(0,0,24,79)
local em1:=savescreen(0,0,24,79)
local em2:=savescreen(0,0,24,79)
local em3:=savescreen(0,0,24,79)
local lmnaz:=space(32)
*local pozm:=1
declare t[5]
hel="firma"
t6[1]:="WYDANO DO MAG."
t6[2]:="PRZYJETO Z MAG"
t6[3]:="ROZLICZENIE   "
t10[1]:="1. RACHUNKI  "
t10[2]:="2. PARAGONY   "
t10[3]:="4. Z A K U P. "
t10[4]:="5.PRZESUNIECIE"
t11[1]:="1. FAKTURY   "
t11[2]:="2. RACHUNKI  "
t11[3]:="3. PARAGONY   "
t1[1]:="FAKTURA-FIRMY"
t1[2]:="FAKTURA-OSOBY"
t1[3]:="P A R A G O N"
*t1[5]:="5.PRZESUNIECIE"
if.not.vvt
  t1[1]:="*.           "
endif  
t2[1]:="1. FAKT/RACH. "
t3[1]:="1. SPRZEDAZ   "
t3[2]:="2. ZAKUP      "
*t3[4]:="4.BIL.OTWARCIA"
t4[1]:="1. MAGAZYNY   "
t4[2]:="2. KONTRAHENT "
*t5[1]:=" A N A L I Z A"
t5[1]:=" PARAMETRY    "
t5[2]:=" INDEKSACJA   "
*t5[4]:=" ZEROWANIE BAZ"
t5[3]:=" NOWY ROK     "
*t5[6]:="EKSPORT DO KR_"

t[1]:="  SPRZEDAZ   "
t[2]:="    ZAKUP    "
t[3]:="   MAGAZYN   "
t[4]:=" KONTRAHENT  "
t[5]:="   I N N E  "
t7[1]:=" R A P O R T  "
t7[2]:=" R E J E S T R"
t12[1]:=" Z A K U P    "
t12[2]:=" SPRZEDAZ     "
t12[3]:=" FAKTURY - SP."
t12[4]:=" RACHUNKI- SP."
t12[5]:=" UTARGI -  SP."
t13[1]:="SPRZEDAZ-ZEST."
t13[2]:="TOWAR - ZYSK  "
t13[3]:="HISTOR.TOWAROW"
t8[1]:="   RAPORTY    "
t8[2]:=" REJESTRY VAT "
t8[3]:="   DOKUMENTY  "
t8[4]:="    TOWARY    "
t8[5]:=" BIL. OTWARCIA"
t8[6]:="MAGAZYNY RAZEM"
t9[1]:="FAKTURA NETTO"
t9[2]:="FAKTURA BRUTT"
t9[3]:="RACHUNEK     "
aspozyc=10
set color to
set cursor off
*@ 4,0 clear to 6,79
*@ 4,0 to 6,79 double
@ 5,2 say t[1]
@ 5,17 say t[2]
@ 5,33 say t[3]
@ 5,49 say t[4]
@ 5,65 say t[5]
do kreska with 4,15
do kreska with 4,31
do kreska with 4,47
do kreska with 4,63
*@ 4,0 say chr(204)
*@ 6,0 say chr(204)
*@ 4,79 say chr(185)
*@ 6,79 say chr(185)
*@ 4,16 say chr(207)
*@ 4,63 say chr(216)
@ 0,60 say chr(205)
@ 0,61 say chr(205)
@ 0,62 say chr(205)

do pole2 with pozm

do while .t.
  close databases
  do while .t.
    last=inkey(0)
    if last=27.or.last=13.or.last=19.or.last=4.or.last=1.or.last=6.or.last=68.or.last=100.or.last=77.or.last=109.or.last=75.or.last=107.or.last=87.or.last=119.or.last=73.or.last=105.or.last=-1 
      exit
    endif
    if last=-9
	  do robak
	endif
  enddo
  do case
        case last=-1
          do gmag
  		  inkey(0)
		  do haslo with 10,25 
		  if.not.dostep
            clear
            return
          endif  
		  pozm=1
    case last=19     &&strzalka w lewo
	      if pozm>1
		    pozm=pozm-1
          else
		    pozm=5
		  endif
    case last=4
	      if pozm<5
		    pozm=pozm+1
		  else
		    pozm=1
		  endif
    case last=83.or.last=115   &&Sprzedaz
	      pozm=1
    case last=90.or.last=122   &&Zakup 
	      pozm=2
	case last=77.or.last=109   &&Magazyn
		  pozm=3		  
    case last=75.or.last=107   &&Kontrahent
		  pozm=4
    case last=73.or.last=105   &&Inne    
		  pozm=5		  
    case last=27
          @ 21,1 clear to 23,78
          zm=.t.
          set cursor on
          @ 21,27 to 23,48 double
          set color to w/n*
          @ 22,29 say "K O N I E C  ?  "get zm
          read
          set cursor off
          set color to
          if zm
            return
          endif	
          return

    case last=13
          do pole2 with pozm	  
		  exit			    	    
 endcase
 do pole2 with pozm
enddo
save screen to em
do case
  case pozm=1
     analiza=.f.
     d=1
     do while .t.
       set color to
           if vvt
		     @ 6,0 TO 10,15 double   
		     d=achoice(7,1,9,14,t1,,,d)   
		   else
		     @ 6,0 TO 9,15 double   
		     d=achoice(7,1,8,14,t10,,,d-1)   		   
			 if d#0
			   d=d+1        &&wykorzystanie menu dla vatowcow
			 endif		   
           endif
		   do case 
             case d=1.and..not.in11		   
			   do wersja
             case d=1.and.fakturtyp=1.and.in11
	           if wlasny1    &&jesli faktury tylko z haslem zarzadcy
			     if magpraw
			       ztyp="WZ/F"
	               do kartdok				 
				 else
				   do tkom with "Brak uprawnien !  Nacisnij dowolny klawisz."
				 endif
			   else
			     ztyp="WZ/F"
	             do kartdok
			   endif	 
             case d=1.and.fakturtyp=2.and.in11
	           if wlasny1    &&jesli faktury tylko z haslem zarzadcy
			     if magpraw
			       ztyp="WZ/U"
	               do kartdok				 
				 else
				   do tkom with "Brak uprawnien !  Nacisnij dowolny klawisz."
				 endif
			   else
			     ztyp="WZ/U"
	             do kartdok
			   endif	 			 
	         case d=2.and.rachuntyp=1.and..not.in12			   
			   do wersja
	         case d=2.and.(rachuntyp=1.or.rachuntyp=3).and.in12
	           ztyp="WZ/N"
	           do kartdok	 
	         case d=2.and.rachuntyp=2.and..not.in12			   
			   do wersja
	         case d=2.and.rachuntyp=2.and.in12
	           ztyp="WZ/R"
	           do kartdok	 
	         case d=3.and..not.in13			   			   
			   do wersja
	         case d=3.and.paragtyp=1.and.in13
	           ztyp="WZ/P"
	           do kartdok	 
	         case d=3.and.paragtyp=2.and.in13
	           ztyp="WZ/T"
	           do kartdok	 			   

			 case d=5.and..not.in15			   
			   do wersja
			 case d=5.and.in15
                 dp=1
                 save screen to em1
			     do while .t.
                   set color to
                   @ 10,16 TO 14,32 double   
                   dp=achoice(11,17,13,31,t6,,,dp)   
                   do case 
                     case dp=1
                       ztyp="MM/B"
                       do kartdok
                     case dp=2
                       ztyp="MM/C"
                       do kartdok	 
					 case dp=3
					   if przestyp=2
					     do rozliczenie      && w pliku kartdok.prg
					   else
					     do tkom with "Dostepne dla przesuniec typ-2. Zmien ustawienie parametrow i ponow probe. OK!" 
					   endif	 
                     case dp=0
                       exit 
                  endcase
                enddo
				restore screen from em1
			  
             case d=0
               exit 
           endcase
     enddo

   case pozm=2
     analiza=.f.
     save screen to em1
     dz=1
	 do while.t.
	   set color to
	   @ 6,15 TO 10,31 double   
	   dz=achoice(7,16,9,30,T9,,,dz)   
       do case
	     case dz=1
	       ztyp="PZ/f"
	       do kartdok
		 case dz=2
		   ztyp="PZ/u"
		    do kartdok
		 case dz=3
		   ztyp="PZ/r"
		   do kartdok				   				   
         case dz=0
		   exit  
	   endcase
	 enddo	 
	 restore screen from em1   


   case pozm=3
*     do while.t.
*       if wmag
*         do WyborMag
*       else
	     do magdefault
*       endif
*           if lastkey()=27.or.lastkey()=19.or.lastkey()=4
*             restore screen from em
*             do dokdefault
*			 exit
*           endif	   
           pdok=.f.
           asmenu=.t.
           cena=" "
           do mag with lmnaz,space(7),.f.
		   lmnaz=zmnaz
           restore screen from em
*     enddo 
	 restore screen from em

   case pozm=4
            pksiega=.f.
			pdok=.f.
           do kontrah with space(30) 
	 

 case pozm=5
     dd=1
     do while .t.
	 restore screen from em
	   do tx with 0,22,"<STRZALKI> - wybor  <ENTER> - zatwierdzenie   <ESC> - rezygnacja"
*       if in47
*	     do txt213 with 23, "F2 - WYBOR MAGAZYNU GLOWNEGO"
*	   endif
	   set color to
       @ 6,63 TO 10,79 double   
       dd=achoice(7,64,9,78,t5,,,dd)   
       do case 
*         case dd=1
*           do while.t.
*	         do tx with 0,22,"Zatwierdz rodzaj analizy."		   
*		     @ 9,48 to 16,64 double 
*             z=achoice(10,49,15,63,t8)
*			 save screen to em1
*			   do case
*			      case z=1
*		            s=1
*		            do while.t.
*			          @ 14,34 to 18,50 double
*			          s=achoice(15,35,17,49,t13,,,s)
*			          do case
*				        case s=1.and.in49
*				          do dzien
*				        case s=1.and..not.in49
*				          do wersja					 				 
 *                       case s=2.and.in48
*			              do htmenu
*                        case s=2.and.in48
*				          do wersja
*			            case s=3.and.in46
*			             * do dzmenu
*						   do maganmenu
*			            case s=3.and..not.in46
*			              do wersja
*			            case s=0
*				          restore screen from em1			 
*					      exit
*			          endcase
*				      set color to 
*			        enddo
*			   
*		          case z=2
*		            s=1
*		            do while.t.
*			          @ 12,39 to 18,55 double
*			          s=achoice(13,40,17,54,t12,,,s)
*			          do case
 *                       case s=1
 *                         do kmbuf with 4
*			              if lastkey()#27
*			                do ksdruk with 3        &&rej.zakupu
*			              endif	 				 
*                        case s=2
*                          do kmbuf with 0
*			              if lastkey()#27
*			                do ksdruk with 2        &&rej.sprzedazy   			 
*			              endif	 	 				 			   				 
*                        case s=3
*                          do kmbuf with 1
*			              if lastkey()#27
*			                do ksdruk with 2        &&rej.sprzedazy   
*			              endif	 	 				 
 *                       case s=4
 *                         do kmbuf with 2
*			              if lastkey()#27
*			                do ksdruk with 2        &&rej.sprzedazy   			 
*			              endif	 	 				 
*			            case s=5
*                          do kmbuf with 3
*			              if lastkey()#27
*			                do ksdruk with 2        &&rej.sprzedazy   			 
*			              endif	 	 				 				 
*			            case s=0
*                          restore screen from em1			  
*				          exit
 *                       endcase
*					  enddo	
*				  
 *                 case z=3.and..not.in30   
*				    do wersja
 *                case z=3.and.in30   
  *                 analiza=.t.
*                   if vvt
*				     d=1
*				   else
*				     d=2
*				   endif	 
*				   do while.t.
*				     set color to (coldef)
*				     @ 14,31 to 17,47 double 
 *                    s=achoice(15,32,16,46,t3)
*					 save screen to em2
 *                      do case
*                         case s=1
*                           do while .t.
*                             set color to
*					         do tx with 0,22,"Zatwierdz typ analizowanych dokumentow."
*                             @ 6,0 TO 10,15 double   
*                             d=achoice(7,1,9,14,t1,,,d)   
*                             do case 
*                               case d=1.and.vvt
*                                 ztyp="WZ/F"
*                                 do kartdok
*                               case d=2.and.rachuntyp=1
*                                 ztyp="WZ/N"
*                                 do kartdok	 
*                               case d=2.and.rachuntyp=2
*                                 ztyp="WZ/R"
*                                 do kartdok	 			   
*                               case d=3
*                                 ztyp="WZ/P"
*                                 do kartdok	 		   
*                               case d=0
*					             restore screen from em2
*                                 exit 
*					         endcase	 
*                           enddo
*                         case s=2
*                           ztyp="PZ/f"
*                           do kartdok
*        			     case s=0
*						   restore screen from em1
*		        	       exit	 
*        		       endcase	
*				    enddo
*
*
*
*
*			     case z=4.and..not.in31			 				   
*				   do wersja
*			     case z=4.and.in31			 
*				   do while.t.
*				     @ 14,31 to 17,47 double 
 *                    s=achoice(15,32,16,46,t3)
*					 save screen to em2
 *                      do case
*                         case s=1
*                           do rejestr with 1
*                         case s=2
*                           do rejestr with 2
*
*        			     case s=0
*						   restore screen from em1
*		        	       exit	 
*        		       endcase	
*				    enddo
*                  case z=5
*                    save screen to em2
*			        if wmag
*                      do tx with 0,22,"Zatwiedz magazyn."
*					  do WyborMag
*                    else
*	                  do magdefault
*                    endif
*        			do mag with "","",.f.,"BO"
*					do dokdefault
*		        	restore screen from em2					 
*					
*                  case z=6
*                    save screen to em2
*			        if wmagil=1
*                      do tkom with "Funkcja dostepna w wersji wielomagazynowej.  OK!"
*                    else
*                      mag_sum()
*					  do magdefault
*					  do mag with "","",.f.,"SUM"
*					  do dokdefault
*					endif
*					restore screen from em2					 					
*					
*                  case z=0
*				    restore screen from em1
*				    exit
*				endcase	
*		   enddo	 
         

*        case dd=2
*          do case
*            case dysk="A:\"
*              do tx with 0,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie A:"
*            case dysk="B:\"
*              do tx with 0,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie B:"	*
*          endcase  
*          do march
*       dd=2
*	   pozm=5 
 
         case dd=1
           do param_m	
		 case dd=2
           do magindex		   	   
*        case dd=5.and.in32
*          do tx with 0,21,"<ENTER> - zatwierdzenie przedzialu czasowego  <ESC> - rezygnacja."
*          do tx with 1,22,"W wyniku dzialania modulu objete zadeklarowanym przedzialem czsowym dokumenty "   
*          do tx with 1,23,"przaniesione zostana na dyskietke i dostepne  poprzez funkcje REKONSTRUKCJA   "
*	   do haslo with 15,34
*	   if magpraw.and.haslo#space(10).and.shaslo#space(10).and.lastkey()#27
*	     do dziel
*	   endif	 
*        case dd=5.and..not.in32
*	   do wersja		   
*         case dd=4
*           do tx with 0,21," UWAGA!  W wyniku dzialania modulu zatwierdzone do zerowania grupy baz danych "
*           do tx with 1,22,"                       zostana bezpowrotnie utracone.                         "   
*           do tx with 1,23,"       OPERACJE ZEROWANIA NALEZY POPRZEDZIC ARCHIWIZACJA BAZ DANYCH !!        "
*		   do haslo with 15,34
*		   if magpraw.and.haslo#space(10).and.shaslo#space(10).and.lastkey()#27
*		     do zero
*		   endif	 
         case dd=3
		   do nowyrok
*         case dd=6
*		   do march
		 case dd=0
            exit 
       endcase
     enddo
endcase
restore screen from em
RETURN

PROCEDURE POLE2
parameters ppoz
do case
  case ppoz=1
    set color to n/w
    @ 5,2 say t[1]
	set color to
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=2
    @ 5,2 say t[1]
	set color to n/w
    @ 5,17 say t[2]
	set color to
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=3
    @ 5,2 say t[1]
    @ 5,17 say t[2]
	set color to n/w
    @ 5,33 say t[3]
	set color to
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=4
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
	set color to n/w
    @ 5,49 say t[4]
	set color to
    @ 5,65 say t[5]
  case ppoz=5
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
	set color to n/w
    @ 5,65 say t[5]				
	set color to
endcase  
do tx with 0,22,"<STRZALKI> - wybor  <ENTER> - zatwierdzenie   <ESC> - rezygnacja"
*if in47
*  do txt213 with 23, "F2 - WYBOR MAGAZYNU GLOWNEGO"
*endif
RETURN
