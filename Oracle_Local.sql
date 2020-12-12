SELECT * FROM STUDENCI WHERE kierunek='INFORMATYKA';

--Wstep--

select nr_indeksu, nazwisko, imiona, kierunek, przedmioty.stopien, przedmioty.semestr, nazwa, ocena, data_wystawienia from studenci 
    join oceny using(nr_indeksu) 
        join przedmioty using(id_przedmiotu) 
            order by nr_indeksu, semestr, data_wystawienia;

W celu uzyskania dostepu do informacji o nazwisku lowcy (wedkarza), nazwie zlowionego gatunku, nazwie lowiska na którym dokonano polowu oraz identyfikacji zarzadcy tego lowiska
nalezy wykorzystac dane przechowywane kolejno w tabelach Rejestry, Wedkarze, Gatunki i Lowiska. Szczególowe dane zwiazane z zaznaczonym na Rys. 18 wpisem zaprezentowano na Rys. 19.

select nazwisko, gatunki.nazwa "Nazwa gatunku", waga  "Waga zlowionej ryby",
lowiska.nazwa "Nazwa lowiska", id_okregu, rekord_waga "Rekord Polski [kg]"
from rejestry join gatunki using(id_gatunku) join wedkarze
using(id_wedkarza)  join lowiska using(id_lowiska)
where czas = to_date('2016-06-21 10:15', 'yyyy-mm-dd hh24:mi') and id_wedkarza=10004 and
id_gatunku=9;

--Laboratorium 1 -- INFO

SELECT * FROM STUDENCI WHERE rok=1 OR rok=2 OR rok=3;
SELECT * FROM STUDENCI WHERE rok BETWEEN 1 AND 3;
SELECT * FROM STUDENCI WHERE rok IN (1,2,3);
SELECT * FROM STUDENCI WHERE rok BETWEEN 1 AND 3 AND (gr_dziekan=1 OR gr_dziekan=3);
SELECT * FROM STUDENCI WHERE kierunek='INFORMATYKA';
SELECT * FROM STUDENCI WHERE kierunek LIKE 'INFORMATYKA';
SELECT nazwisko, imiona, kierunek, rok FROM STUDENCI WHERE kierunek LIKE 'INFORMATYKA' ORDER BY nazwisko, 2 DESC;
SELECT DISTINCT(kierunek) FROM STUDENCI WHERE kierunek NOT LIKE 'INFORMATYKA';
SELECT DISTINCT(imiona) FROM STUDENCI WHERE imiona LIKE 'A_a%a';
SELECT DISTINCT(imiona) FROM STUDENCI WHERE imiona BETWEEN 'K%' AND 'Mb%' ORDER BY 1 DESC;
w zakresie imiona BETWEEN 'K%' AND 'M%' to M stanowi górn? granic? przedzia?u -> Ma jest ju? poza ni? -> prosz? sprawdzi? dzia?anie imiona BETWEEN 'K%' AND 'Mb%' wówczas pojawi? si? imiona typu Marta, Marek
SELECT imiona FROM STUDENCI WHERE imiona BETWEEN 'K%' AND 'M%';
SELECT imiona from studenci where imiona like 'M%';
SELECT nazwisko||' '||imiona||' studiuje na kierunku '||kierunek Opis FROM STUDENCI;
SELECT nazwisko||' '||imiona||' studiuje na kierunku '||kierunek as "Podpis kolumny" FROM STUDENCI;
SELECT nazwisko, dod_funkcyjny, dod_staz FROM PRACOWNICY WHERE dod_funkcyjny IS NULL AND dod_staz IS NOT NULL;
SELECT nazwisko, NVL(dod_funkcyjny,0)/placa * 100 as "dodatek/placa w %", dod_funkcyjny,placa FROM PRACOWNICY;

NVL lets you replace null (returned as a blank) with a string in the results of a query. If expr1 is null, then NVL returns expr2. If expr1 is not null, then NVL returns expr1.

-- Laboratorium 1 -- Zadania

Atrybuty tabeli studenci:
desc studenci;

Wszystkie wiersze tabeli studenci
select * from studenci;

select nazwisko,imiona from studenci;

select distinct (kierunek) from studenci;

SELECT nazwisko, imiona, tryb, rok, gr_dziekan, zakres FROM studenci 
    ORDER BY rok, 1 desc;

SELECT * FROM studenci where rok=3 and gr_dziekan=2; 

select * from studenci where srednia is null;

--Zadanie 3.6--
SELECT nazwisko, imiona, rok from studenci where stopien=1 and rok between 2 and 4 order by nazwisko;

SELECT nazwisko, imiona from studenci where imiona like '%a';

SELECT nazwisko, imiona from studenci where imiona not like '%a';

select * from studenci where imiona='Adam' OR imiona='Magdalena' OR imiona='Konrad';

select * from studenci where nazwisko='Kowalski' OR nazwisko='Nowak' ;

SELECT imiona from studenci where imiona between 'Do' and 'Mi' order by imiona;

DESC Pracownicy;

select * from pracownicy;

select nazwisko, placa/20 "DNIOWKA" from pracownicy;

NVL JEST WAZNE GDY NULL w OBLICZENIACH
select nazwisko, nr_akt, placa+((placa*dod_staz)/100) + NVL(dod_funkcyjny,0) - NVL(koszt_ubezpieczenia,0) as "PENSJA", dod_staz,placa,dod_funkcyjny,data_zwol,koszt_ubezpieczenia from pracownicy where data_zwol is null order by PENSJA;


select nazwisko, stanowisko,nr_akt, (placa+((placa*dod_staz)/100) + NVL(dod_funkcyjny,0) - NVL(koszt_ubezpieczenia,0))*12 as "ROCZNA PENSJA", dod_staz,placa,dod_funkcyjny,data_zwol,koszt_ubezpieczenia 
    from pracownicy where data_zwol is null AND stanowisko != 'Dyrektor' AND stanowisko !='Prezes' order by "ROCZNA PENSJA" desc;

desc pojazdy;

= EXACT MATCH, LIKE ANYTHING ELSE

select * from pojazdy where nr_rejestracyjny like 'SC%5' AND (pojemnosc not between 1500 and 2000) AND kolor like '%R%' or kolor like '%r%';


--laboratorium 2 -- INFO 

 Concat(str1, str2) - zwraca ciag znaków bedacy z??czeniem ciagu str1 z ciagiem str2,
 Initcap(str) - zwraca sformatowany ciog wejsciowy, tak, ze pierwsza litera kazdego wyrazu ciagu jest duza a pozosta?e s? ma?e,
 Instr(str1, str2 [,pos [, n]]) - zwraca pozycje ciagu znaków str2, w str1, szukanie rozpoczyna sie od pos, a konczy na n-tym wystapieniu
 szukanego ci?gu. Jesli pos < 0 przeszukiwanie przebiega od ko?ca. Jesli ciag str2 nie zostanie znaleziony to funkcja zwraca wartosc 0,
 The INSTR function returns a numeric value. The first position in the string is 1.   SELECT dbo.INSTR('Boston', 'o', 1, 2);
 INSTR('Tech on the net', 'e') Result: 2   (the first occurrence of 'e')
 Length(str) - zwraca d?ugo?? str,
 Lower(str) - zwraca ?a?cuch str przekszta?cony na ma?e litery,
 Lpad(str, len [, pad_str]) - uzupelnia z lewej strony ci?g str ci?giem pad_str, a? do uzyskania przez ci?g wynikowy d?ugo?ci len; domy?lnie pad_str jest spacj?,
 LPAD('tech on the net', 16, 'z');  Result: 'ztech on the net'  LPAD('tech', 7); Result: '   tech'
 Ltrim(str [, set_str]) - poczynaj?c z lewej strony odcina kolejne znaki ciagu str, az do napotkania pierwszego znaku nie nale??cego do zbioru set_str (domy?lnie spacja),
 LTRIM('   tech') Result: 'tech'  LTRIM('123123Tech123', '123') Result: 'Tech123'  LTRIM('xyxzyyyTech', 'xyz') Result: 'Tech'
 Replace(str1, str2 [, str3]) - zwraca ci?g str1 ze wszystkimi wyst?pieniami ci?gu str2 zast?pionymi przez ci?g str3; brak str3 oznacza usuniecie str2,
 REPLACE('123tech123', '123');  Result:'tech'  REPLACE('222tech', '2', '3'); Result: '333tech'
 Rpad(str, len [, pad_str]) - uzupe?nia z prawej strony ci?g str ci?giem pad_str, a? do uzyskania przez ci?g wynikowy d?ugo?ci len; domy?lnie pad_str jest spacj?,
 RPAD('tech', 7) Result: 'tech   '  RPAD('tech', 8, '0')   Result: 'tech0000'
 Rtrim(str [, set_str]) - poczynaj?c z prawej strony odcina kolejne znaki ci?gu str, a? do napotkania pierwszego znaku nie nale??cego do zbioru set_str (domy?lnie spacja),
 RTRIM('123000', '0')  Result: '123'  RTRIM('Tech123123', '123') Result: 'Tech'
 Substr(str, pos [,len]) - zwraca podciag ciagu str o dlugosci len zaczynajac od pos; jesli pos < 0 przeszukiwanie przebiega od konca; domyslnie przebiega do ko?ca,
 SUBSTR('This is a test', 6, 2)  Result: 'is'  SUBSTR('TechOnTheNet', -6, 3)  Result: 'The'
 Translate(str1, str2, str3) - funkcja dziala podobnie jak funkcja replace, tylko ze zamienia wszystkie wystapienia pojedynczych liter z ciagu str2 na odpowiednie litery z ciagu str3
 TRANSLATE('1tech23', '123', '456')  Result: '4tech56'  TRANSLATE('222tech', '2ec', '3it') Result: '333tith'
 Trim([[LEADING|TRAILING|BOTH] str1 FROM] str2) - usuwa pierwsze wyst?pienia ci?gu str1 w ci?gu str2, zaczynaj?c od pocz?tku - LEADING, ko?ca - TRAILING, b?d? z obu stron - BOTH;
 domy?lnie obcinane s? spacje z obu stron,
 TRIM('   tech   ')  Result: 'tech'   TRIM(' '  FROM  '   tech   ')  Result: 'tech'   TRIM(LEADING '0' FROM '000123')  Result: '123'
 TRIM(TRAILING '1' FROM 'Tech1')  Result: 'Tech'  TRIM(BOTH '1' FROM '123Tech111') Result: '23Tech'
 Upper(str) - przekszta?ca wszystkie litery w str na du?e.


SELECT nazwisko, imiona, nazwisko || ' ' || imiona Personalia_1, 
Concat(nazwisko, Concat(' ', imiona)) Personalia_2 from studenci;

SELECT id_gatunku, Initcap(nazwa) Nazwa from gatunki; 

Select id_gatunku, Concat(Upper(Substr(nazwa,1,1)),
       Lower(Substr(nazwa,2,Length(nazwa)-1))) Nazwa FROM gatunki;

Select 'abcdefghijk' ciag, length('abcdefghijk') kol1,
    substr('abcdefghijk', 2, 4) kol2,
    substr('abcdefghijk', length('abcdefghijk')-2,3) kol3,
    substr('abcdefghijk', 4, length('abcdefghijk')-3) kol4
from dual;

dual - 
It's a sort of dummy table with a single record used for selecting when you're not actually interested in the data, but instead want the results of some system function in a select statement:

select distinct(imiona) imiona,
    Initcap( Translate( lower(imiona),'a', 'x') ) kol2,
    Initcap( Translate( lower(imiona), 'ea', 'yx') ) kol3
    from studenci where Lower(imiona) like '%a%' and
    Lower(imiona) like '%e%' and imiona not like '%a' order by 1;


SELECT distinct(imiona), Trim(BOTH 'A' FROM imiona) Kol1,
Replace(upper(imiona),'AD', 'X_') Kol2,
Lpad(imiona,10,'123456789') Kol3, Ltrim(imiona, 'ndARG') Kol4
FROM studenci order by 1;

 Abs(n) - zwraca warto?? bezwzgl?dna z n,
 Ceil(n) - zwraca najmniejsza liczb? ca?kowit? wi?ksz? lub równa n,
 Cos(n) - zwraca cosinus kata n (wyra?onego w radianach),
 Floor(n) - zwraca najwi?ksza liczb? ca?kowita mniejsza lub równa n,
 Ln(n) - zwraca logarytm naturalny z n,
 Log(n, m) - zwraca logarytm z liczby m przy podstawie n,
 Mod(m, n) - zwraca reszt? z dzielenia liczby m przez n,
 Power(m, n) - zwraca warto?? liczby m podniesionej do pot?gi n,
 Round(m [, n]) - zwraca liczb? m zaokr?glon? do n miejsc po przecinku; dla n < 0, okre?la liczb? miejsc przed przecinkiem; domy?lnie n = 0,
 Sign(n) - zwraca ?1 dla n < 0, 0 dla n = 0 oraz 1 dla n > 0,
 Sin(n) - zwraca sinus kata n (wyra?onego w radianach),
 Sqrt(n) - zwraca pierwiastek kwadratowy z liczby n,
 Tan(n) - zwraca tangens kata n (wyra?onego w radianach),
 Trunc(m [,n]) - zwraca liczb? m po obci?ciu do n miejsc po przecinku; dla n < 0, okre?la liczb? miejsc przed przecinkiem; domy?lnie n = 0.
 TRUNC(125.815) Result: 125

select floor(3.46) kol1, floor(3.97) kol2, floor(-3.12) kol3, 
round(3.46) kol4, round(3.46, 1) kol5, round(17.46, -1) kol6,
trunc(3.46) kol7, trunc(3.46, 1) kol8, trunc(17.46, -1) kol9,
ceil(3.46) kol10, Power(2,-1) kol11, abs(-1.23) kol12
from dual;

 Decode(wyr, s1, r1, s2, r2, ... [,wyr_domy?lne]) - porównuje wyra?enie wyr do kolejnych s1, s2, ... Je?eli wyr jest równe któremu? z tych wyra?e?, 
 w wyniku zwracana jest odpowiadaj?ca jemu warto?? ri. Je?eli ?adna z warto?ci s1, s2, ... nie jest równa wej?ciowemu wyra?eniu funkcja zwraca warto?? domy?ln? (wyr_domy?lne) 
 - je?li jest ona pomini?ta wówczas funkcja zwraca warto?? NULL.
 NVL(wyr1, wyr2) - je?eli wyr1 ma warto?? NULL, to funkcja zwraca wyr2, w przeciwnym przypadku funkcja zwraca wyr1.
 NVL2(wyr1,wyr2, wyr3) - je?eli parametr wyr1 przyjmuje warto?? ró?n? od pustej (NULL) to funkcja zwraca warto?? wyr2 a w przeciwnym przypadku (wyr1 is NULL) zwraca warto?? wyr3.
 GREATEST(wyr1, wyr2, ..., wyrX) – funkcja zwraca najwi?ksz? warto?? (na podstawie z listy wyra?e?).
 LEAST(wyr1, wyr2, ..., wyrX) – funkcja zwraca najmniejsz? warto?? (na podstawie z listy wyra?e?).
 Uid - zwraca unikalny numer u?ytkownika.
 User - zwraca nazw? u?ytkownika.

DECODE -- INFO
SELECT supplier_name,
DECODE(supplier_id, 10000, 'IBM',
                    10001, 'Microsoft',
                    10002, 'Hewlett Packard',
                    'Gateway') result
FROM suppliers;
The above DECODE statement is equivalent to the following IF-THEN-ELSE statement:

IF supplier_id = 10000 THEN
   result := 'IBM';

ELSIF supplier_id = 10001 THEN
   result := 'Microsoft';

ELSIF supplier_id = 10002 THEN
   result := 'Hewlett Packard';

ELSE
   result := 'Gateway';

END IF;

Decode(id_dzialu, NULL, 'Brak', id_dzialu) -- je?eli jest NUll to zastap 'Brak' a domyslnie przepisz id_dzialu 

SELECT nazwisko, imiona, Decode(id_dzialu, NULL, 'Brak', id_dzialu) id_dzialu,

Decode(NVL(id_dzialu, 0), 0, nazwisko|| ' brak zaszeregowania',
                          10, nazwisko||' pracuje w dziale 10',
                          70, nazwisko||' pracuje w dziale 70',
                          nazwisko||' pracuje w innym dziale') INFO
FROM pracownicy ORDER BY 1;


 Avg([DISTINCT] wyr) - oblicza ?redni? ze zbioru (opcjonalnie ró?nych) warto?ci wyra?enia (pomijaj?c wyst?pienia NULL),
 Count(*|[DISTINCT] wyr) - wywo?anie Count(*) zwraca liczb? wszystkich wierszy uzyskanych w wyniku zapytania. 
 Podanie argumentu w postaci wyra?enia spowoduje zwrócenie liczby wierszy, w których wybrane wyra?enie nie przyj??o warto?ci NULL,
 Max([DISTINCT] wyr) - zwraca najwi?ksz? warto?? ze zbioru (opcjonalnie pozbawionego powtórze?) pomijaj?c NULL,
 Min([DISTINCT] wyr) - zwraca najmniejsza warto?? ze zbioru (opcjonalnie pozbawionego powtórze?) pomijaj?c NULL,
 Stdev([DISTINCT] wyr) - wylicza odchylenie standardowe na zbiorze (opcjonalnie pozbawionym powtórze?) pomijaj?c NULL,
 Sum([DISTINCT] wyr) - wylicza sum? warto?ci ze zbioru (opcjonalnie pozbawionego powtórze?) pomijaj?c NULL,
 Variance(*|[DISTINCT] wyr) - Oblicza wariancje warto?ci ze zbioru (opcjonalnie pozbawionego powtórze?) pomijaj?c NULL.


BD_Info_GroupBy.pdf ????

Je?eli chcemy uzyska? dane statystyczne w zakresie poszczególnych podzbiorów np. liczby studentów na danym roku to wówczas musimy zastosowa? klauzul?
group by czyli musimy dokona? grupowania po kolumnie rok (patrz plik BD_Info_GroupBy.pdf; zakres materia?u realizowany na dalszych etapach).

select * from studenci;

select count(*) kol1, sum(srednia) kol2, round(avg(srednia),2) kol3,
round(avg(nvl(srednia,0)),2) kol4, round(sum(srednia)/count(*),2) kol5,
min(data_urodzenia) kol6, max(data_urodzenia) kol7,
count(Distinct imiona) kol8, count(Distinct data_urodzenia) kol9 from studenci;

----Laboratorium 2 ---- Zadania
select * from studenci

select count(imiona) as "Liczba studentek 3r INF SS" from studenci where imiona like '%a' and stopien = 1 and rok = 3 and kierunek = 'INFORMATYKA';

select * from studenci where imiona like '%a' and stopien = 1 and rok = 3 and kierunek = 'INFORMATYKA';

select * from studenci where kierunek = 'INFORMATYKA';

select count(nazwisko) from studenci where lower(nazwisko) like 'nowakowski' or upper(nazwisko) like 'NOWAKOWSKA';

1.3

select count(imiona) "Liczba studentow na litere M", count(distinct(imiona)) "Liczba roznych imion na M" from studenci where imiona like 'M%' and imiona not like '%a';

select nazwisko|| ' ' || imiona as "Personalia studenta" from studenci where (stopien = 1 and rok = 4) OR (stopien = 2 and rok =2);
select concat(nazwisko, concat(' ', imiona)) as "Personalia studenta" from studenci where (stopien = 1 and rok = 4) OR (stopien = 2 and rok =2);

1.5

select substr(imiona,1,3) from studenci where zakres like 'OGOLNY';
select substr(imiona,1,3) "3 litery imienia", substr(nazwisko,-3,3) "3 ostatnie litery nazwiska", imiona, nazwisko from studenci where zakres like 'OGOLNY';

select substr(imiona,1,1)|| '.' || substr(nazwisko,1,1)||'.' "Inicjaly",imiona,nazwisko,length(imiona)+length(nazwisko) "Liczba liter" from studenci 
    where (length(imiona)+length(nazwisko))= 9 or (length(imiona)+length(nazwisko))= 11 or (length(imiona)+length(nazwisko))= 13;

1.7

select Initcap(TRANSLATE(kierunek, '_', ' ')) "Kierunek" from studenci;

select concat(Initcap(substr((Lower(TRANSLATE(kierunek, '_', ' '))),1,1)),substr((Lower(TRANSLATE(kierunek, '_', ' '))),2)) "Kierunek" from studenci;

1.8

select LTRIM(nazwisko, 'Ko') "nazwisko bez KO", RTRIM(imiona,'sz') "imie bez SZ", imiona|| ' '|| nazwisko "PERSONALIA" from studenci where nazwisko like 'Ko%' and imiona like '%sz';

select * from studenci;

select nazwisko, length(nazwisko) "Liczba liter", INSTR(nazwisko, 'a') "Pozycja A w nazwisku" from studenci 
    where rok=2 and (length(nazwisko) between 6 and 9) and ((INSTR(nazwisko, 'a')>0) or (INSTR(nazwisko, 'A')>0))
        order by length(nazwisko) desc;

select nazwisko,  concat('Start',LTRIM(nazwisko, 'Ba'))  "po zmianie",  imiona, concat(RTRIM(imiona,'a'),'End') "po zmianie im" from studenci where imiona like '%a' and INSTR(nazwisko,'Ba')>0; 

select Rpad(Lpad(imiona, length(imiona)+3,'*' ),length(imiona)+7,'+') " " from studenci;

2.1

select * from pojazdy where (nr_rejestracyjny like 'SC %0 ' or nr_rejestracyjny like 'SC %1 ' or nr_rejestracyjny like 'SC %2 '  or nr_rejestracyjny like 'SC %3 ' 
     or nr_rejestracyjny like 'SC %4 ' or  nr_rejestracyjny like 'SC %5 ' or nr_rejestracyjny like 'SC %6 ' or nr_rejestracyjny like 'SC %7 ' 
         or nr_rejestracyjny like 'SC %8 ' or nr_rejestracyjny like 'SC %9 ') and  pojemnosc between 1000 and 2000;

select nr_rejestracyjny, marka, modell, pojemnosc,substr(pojemnosc, 3,2) "liczba", kolor from pojazdy where (marka like 'FORD') and (kolor like 'Black Red')
    and  (mod(substr(pojemnosc, 3,2),3 ) = 0) and (substr(pojemnosc, 3,2) not like '00'); 

2.3

select * from pojazdy where (typ like 'MOTOCYKL') and ((nr_rejestracyjny like '%6%6') or (nr_rejestracyjny like '%66%')) and (kolor like '% %');

select marka, modell, typ, pojemnosc,
    Decode(pojemnosc, 1000, 'maly pojazd',
    1500, 'sredni pojazd',
    2000, 'duzy pojazd') KOMENTARZ
 from pojazdy where typ not like 'SAM_CIEZAROWY' and (pojemnosc = 1000 or pojemnosc = 1500 or pojemnosc = 2000);

2.5

select substr(nr_rejestracyjny,1,2) from pojazdy;


select nr_rejestracyjny, modell, pojemnosc,
    Decode(substr(nr_rejestracyjny,1,2), 'SC', 'Slaskie',
    'PO', 'wielkopolskie',
    'EL', 'lodzkie',
    'GD','pomorskie', 'Niezidentyfikowane') Wojewodztwo
from pojazdy where marka like 'OPEL' and pojemnosc between 1600 and 2000;


Zadanie 3 

select 'Od '|| substr(min(czas),1,9)|| ' do '||substr(max(czas),1,9)||' odnotowano '||count(*)||
    ' polowow w tym udanych '|| count(id_gatunku)|| ' na wodach '|| count(distinct(id_lowiska))||' zarzadcow'   from rejestry;

3.2

select * from rejestry where id_gatunku in (1,3,9,10) and substr(id_lowiska,1,1) like 'C' and dlugosc between 40 and 60 
    and (instr(waga, '.') = 0 or substr(waga,-2,1) like '.' ) ;

3.3

select count(*) "Liczba ryb", count(distinct(id_wedkarza)) "Liczba lowcow", count(distinct(id_lowiska)) "Liczba lowisk",
    sum(waga) "Laczna waga", round(avg(waga),3) "Srednia waga", round(avg(dlugosc),0) "Srednia dlugosc"
from rejestry where id_gatunku = 1;

select * from rejestry;

select substr(czas,1,9) "Dzien polowu", id_gatunku,
 Decode(id_gatunku, 2, 'Lin',
    4, 'Amur',
    15, 'Okon',
    17,'Ploc', 'Brak polowu') Gatunek
from rejestry where id_gatunku in (2,4,15,17) or id_gatunku is null;

----Laboratorium 3 ---- Info 
 DATE - data w formacie: YYYY-MM-DD (w Oracle przechowuje równie? czas),
 TIME - czas w formacie: HH:MM:SS.p (nieu?ywany w Oracle),
 TIMESTAMP - data wraz z czasem - znacznik czasu w formacie: YYYY-MM-DD HH:MM:SS.p,
 INTERVAL - przedzia? czasu
 INTERVAL YEAR TO MONTH: YYYY-MM,
 INTERVAL DAY TO SECOND: DD HH:MM:SS.p

Pobranie aktualnej daty i czasu:
 Current_date (w Oracle i MySQL dodatkowo Sysdate),
 Current_timestamp (w Oracle dodatkowo Systimestamp).
 Przedzia? czasu
 INTERVAL POCZATEK [(precision)] [TO KONIEC [(precision)]]
 S?owa kluczowe: YEAR [(precision)], MONTH, DAY [(precision)], HOUR, MINUTE, SECOND [(precision)],





























LISTA 5
--zad1 nie pelne
SELECT nazwisko, data_urodzenia FROM studenci 
    where data_urodzenia = 
        (SELECT Min(data_urodzenia) FROM studenci);
--zad2 

SELECT Extract(YEAR FROM CZAS) "Rok ", Gatunki.nazwa, dlugosc, To_char(Czas,'yyyy-mm-dd') "KIEDY", Nazwisko, lowiska.nazwa "Lowisko"
from rejestry join wedkarze using(ID_wedkarza) join lowiska using(id_lowiska) join gatunki using(id_gatunku)
where (Extract(year from czas),gatunki.nazwa, dlugosc) in
(
select extract(year from czas),gatunki.nazwa, max(dlugosc)
from rejestry join gatunki using(id_gatunku)
group by id_gatunku, gatunki.nazwa, extract(year from czas)
)
order by extract(year from czas), gatunki.nazwa;

--zad3 