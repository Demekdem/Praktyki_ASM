********************************************************************************
** Definicja zmiennych (po 'local zmienne' (w wierszach) 
*					'local grupy' (metryczkowe/ w kolumnach) wpisz odpowiednie zmienne )

* 'q8i*_A1_Z_czym_kojarzy_się_Pan' oznacza wez wszystko co odpowia nazwie w ktorej moze zmienic sie czwarta liczba
* Stata bierze wtedy: 'q8i1_A1_Z_czym_kojarzy_się_Pan q8i2_A1_Z_czym_kojarzy_się_Pan' itp.

* q8i1_A1_Z_czym_kojarzy_się_Pan-q10s9_AM1_W_jakim_stopniu_zga (oznacza wez w kolejnosci wszystkie zmienne w *  kolejnosci w ktorej sa w bazie od 'q8i.. do q10s..')

local zmienne q8i*_A1_Z_czym_kojarzy_się_Pan ///
q10s1_AM1_W_jakim_stopniu_zga1-q11_A2_Jak_ogólnie_ocenia_Pan5 ///
q12i*_A3_Czy_w_ciągu_ostatnich ///
q13_A4_Czy_doświadczane_przez_1-q22s7_A13_Na_ile_jest_Pani_za5 ///
q23i1_A14_Jakie_są_Panai_głów-q31i12_B2_Co_Panaią_motywuje_ ///
q33_BM1_Czy_poza_pracą_zawodo* ///
q34i*_B3_Dlaczego_obecnie_nie_ ///
q36_BM2_Czy_opiekując_się_nie* ///
q37i*_BM3_Jakiego_wsparcia_oc ///
q39_C1_Proszę_pomyśleć_o_sobie1-q41s6_C3_Jak_często_w_ciągu_os4 ///
q42i*_CM1_Kto_był_organizator ///
q43_CM2_Czy_zajęcia_były_skie1-q44s4_CM3_W_jaki_sposób_korzy3 ///
q45i1_C4_Co_ogranicza_Panai_o-q45i12_C4_Co_ogranicza_Panai_ ///
q46_C5_Jak_Pani_ocenia_swoją_1-q57_EM2_Jak_ocenia_Pani_swój4 ///
q58s1i1_EM3_Czy_w_ciągu_ostat-q58s6i5_EM3_Czy_w_ciągu_ostat ///
q59s1i1_EM4_Jak_często_otrzym1-q62s7_EM7_Jeśli_tak_to_komu_6 ///
q63s1i1_EM8_Jakiego_rodzaju_w-q63s7i12_EM8_Jakiego_rodzaju_ ///
q64_EM9_Jeżeli_potrzebuje_Pan1-q69_H2_Czy_w_porównaniu_z_sytu4 ///
q70i1_H3_Z_jakiego_powodu_Pana-q71i18_H4_Z_jakiego_powodu_Pan ///
q72s1_H5_Które_stałe_wydatki_s1-q72s3_H5_Które_stałe_wydatki_s14 ///
q74i1_H6_Na_co_przeznacza_Pan-q74i14_H6_Na_co_przeznacza_Pan 


* -- Wpisz po 'local grupy' zmienne w kolumnach (np. Plec Wiek Wojewodztwo..)

local grupy q4_1_Płeć_jeśli_to_możliwe_a q3_wiek_kwota q5_M4_Czy_mieszka_Pani ///
q6_kwota_miasto_wieś q7_M5_Województwo

********************************************************************************

* 1) 'stat(mean total count)' mozna dodawac tutaj dane statystyki 
local i = 1
foreach g of local grupy{
	dtable, by(`g') ///
		cont(`zmienne', stat(mean total count)) ///
		nosample ///
		nformat(%2.0f total) ///
		name(a`i')
		
	local tabele `tabele' a`i'
	local ++i
	
	local layoutvars `layoutvars' `g'#result
}

collect combine all = `tabele'

* 2) 'collect composite define column1 = count' (tworzymy kolumny danej statystyk poprzez nadanie nazwy)

collect composite define column1 = count
collect composite define column2 = total
collect composite define column3 = mean
collect style autolevels result column1 column2 column3, clear

collect label levels result column1 "Dane" ///
							column2 "N" ///
							column3 "%", modify
							
collect layout (var) (`layoutvars')


********************************************************************************
* Eksport danych do excela (w cudzyslowie wpisz nazwe pliku z dodatkiem (excel))

collect export "tabela_wynikow.xlsx", replace


