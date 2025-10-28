********************************************************************************
* Zaladowanie pliku (w cudzyslowie podajemy sciezke pliku; 'firstrow' pobiera naglowki zmiennych)
clear all
import excel "/Users/...xlsx", firstrow

********************************************************************************
** Przygotowanie bazy (drop zmienna - usuwamy zmienna)

* Usuwanie zmiennych, w ktorych nic nie ma 
drop q8t1_A1_Z_czym_kojarzy_się_Pan q42t1_CM1_Kto_był_organizator q77t1_M2_Z_kim_prowadzi_Pani_
* Usuwanie pustych pytan & innych
drop q72s4_H5_Które_stałe_wydatki_s-q72s14_H5_Które_stałe_wydatki_
drop q83_


* Podajemy wszystkich zmienne do transformacji na zmienne zero-jedynkowe
ds q10s*_AM1_W_jakim_stopniu_zga q11_A2_Jak_ogólnie_ocenia_Pan ///
q13_A4_Czy_doświadczane_przez_-q22s7_A13_Na_ile_jest_Pani_za ///
q33_BM1_Czy_poza_pracą_zawodo q36_BM2_Czy_opiekując_się_nie ///
q39_C1_Proszę_pomyśleć_o_sobie-q41s6_C3_Jak_często_w_ciągu_os ///
q43_CM2_Czy_zajęcia_były_skie-q44s4_CM3_W_jaki_sposób_korzy ///
q46_C5_Jak_Pani_ocenia_swoją_-q57_EM2_Jak_ocenia_Pani_swój ///
q59s1i1_EM4_Jak_często_otrzym-q62s7_EM7_Jeśli_tak_to_komu_ ///
q64_EM9_Jeżeli_potrzebuje_Pan-q69_H2_Czy_w_porównaniu_z_sytu ///
q72s*_H5_Które_stałe_wydatki_s ///
q75_H7_Czy_jest_Pani_zadłużon q76_M1_Ile_osób_łącznie_z_Pan ///
q78_M3_Jaka_jest_Panai_sytuac-q80_M7_Jakie_jest_Panai_wyksz ///
q82_M10_Ile_wynoszą_łącznie_pr

*[] Tworzymy pętlę po znalezionych zmiennych
foreach var of varlist `r(varlist)' {
    tabulate `var', generate(`var')
}

