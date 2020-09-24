CREATE TABLE pracownicy (
    id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    imie VARCHAR(30) NOT NULL,
    nazwisko VARCHAR(60) NOT NULL,
    pesel NUMERIC(11) NOT NULL,
    plec VARCHAR(1) check(plec in('M', 'K')) NOT NULL,
    data_urodzenia DATE NOT NULL,
    pensja NUMERIC NOT NULL
);

CREATE TABLE produkty (
    id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nazwa_produktu VARCHAR(100) NOT NULL,
    typ_produktu VARCHAR(30) NOT NULL,
    cena_sprzedazy NUMERIC NOT NULL,
    cena_zakupu NUMERIC NOT NULL,
    stawka_podatku NUMERIC NOT NULL
);

CREATE TABLE departamenty (
    kod_departamentu NUMERIC NOT NULL,
    nazwa_departamentu VARCHAR(40) NOT NULL,
    id_kierownika int NOT NULL,
    miejscowosc VARCHAR(50) NOT NULL
);

/* wprowadzanie danych do tabeli */
INSERT into pracownicy (imie, nazwisko, pesel, plec, data_urodzenia, pensja)
VALUES 
('Jan', 'Kowalski', 88020512345, 'M', '1988/02/05', 4000),
('Krzysztof', 'Kapusta', 70122012345, 'M', '1970/12/20', 2500 ),
('Magdalena', ' Dzwonkowska', 92081612345, 'K', '1992/08/16', 5000),
('Karol', 'Krawczyk', 82010112345, 'M','1982/01/01', 3000),
('Joanna', 'Bak', 90121212345, 'K', '1990/12/12', 2700),
('Robert', 'Psikuta', 95070812345, 'M', '1995/07/08', 4200),
('Stefan', 'Siarzewski', 60051212345, 'M', '1960/05/12', 4550),
('Zofia', 'Brzydal', 84021612345, 'K', '1984/02/16', 2400),
('Julia', 'Niedziela', 81050212345, 'K', '1981/05/02', 7000),
('Bartosz', 'Karmel', 58031212345, 'M', '1958/02/12', 5120);

INSERT INto produkty (nazwa_produktu, typ_produktu, cena_sprzedazy, cena_zakupu, stawka_podatku)
VALUES
('Baton "Mars"', 'słodycz', 2.5, 1.5, 23),
('chleb', 'pieczywo', 3, 1.2, 23),
('płatki owsiane 0.5kg', 'nasiona', 2.25, 1.45, 23),
('płatki owskiane 1kg', 'nasiona', 4, 2.4, 23),
('mleko', 'nabiał', 3.5, 2, 23),
('jogurt "Danone"', 'nabiał', 3.5, 2, 23),
('woda gazowana', 'napoje', 1.9, 1, 23),
('woda niegazowana', 'napoje', 1.9, 1 , 23),
('oranżada', 'napoje', 2.49, 2, 23),
('bułka pszenna', 'pieczywo', 0.5, 0.3, 23),
('bułka żytnia', 'pieczywo', 0.7, 0.5, 23),
('balsam do ciała', 'kosmetyki', 20, 14, 23),
('krem do rąk', 'kosmetyki', 8, 6.4, 23),
('dezodorant', 'kosmetyki', 9, 4.4, 23),
('piwo', 'alkohol', 4, 2.8, 30),
('wódka polska', 'alkohol', 25, 14, 30),
('whiskey', 'alkohol', 60, 40, 30),
('czekolada', 'słodycz', 5, 2 , 23),
('ryż', 'nasiona', 3, 1.5, 23),
('kasza gryczana', 'nasiona', 3, 1.7, 23);

INSERT INto departamenty(kod_departamentu, nazwa_departamentu, id_kierownika, miejscowosc)
VALUES
(1, 'księgowość', 3, 'Gdańsk Oliwa'),
(2, 'produkcja', 6, 'Gdańsk Kokoszki'),
(3, 'administracja', 1, 'Gdańsk Oliwa'),
(4, 'IT', 7, 'Gdańsk Oliwa'),
(5, 'Sprzedaż', 10, 'Gdańsk Wrzeszcz');

ALTER TABLE departamenty
add CONSTRAINT fk_dep_pracownik FOREIGN KEY (id_kierownika)
REFERENCES pracownicy(id);

ALTER TABLE departamenty
add CONSTRAINT pk_dep_pracownik PRIMARY KEY (kod_departamentu);
