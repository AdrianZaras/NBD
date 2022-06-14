//Uwaga: Tak, zapytania czasem zwrócą puste wyniki. W takim wypadku nadal przesyłamy wygenerowany plik JSON, SVG nie jest wymagane. W zapytaniach generujących listy wystarcza wynikowy JSON, SVG nie jest wymagany
//Część 1 – Filmy
//1. Zaimportuj dane uruchamiając zapytania zgodnie z instrukcjami wyświetlanymi po wpisaniu polecenia :play movie-graph. Przeanalizuj i uruchom przykładowe zapytania. Następnie napisz następujące zapytania:
//2. Wszystkie filmy, w których grał Hugo Weaving
MATCH (hugoWeaving: Person {name: "Hugo Weaving"})-[:ACTED_IN]->(hugoWeavingMovies) RETURN hugoWeavingMovies

//3. Reżyserzy filmów, w których grał Hugo Weaving
MATCH (hugoWeaving: Person {name: "Hugo Weaving"})-[:ACTED_IN]->(hugoWeavingMovies) <-[:DIRECTED]-(directors) RETURN directors

//4. Wszystkie osoby, z którymi Hugo Weaving grał w tych samych filmach
MATCH (hugoWeaving:Person {name:"Hugo Weaving"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors) RETURN coActors

//5. Listę aktorów (aktor = osoba, która grała przynajmniej w jednym filmie) wraz z ilością filmów, w których grali
MATCH (actor: Person)-[:ACTED_IN]-> (movies) return actor, COUNT(movies)

//6. Listę osób, które napisały scenariusz filmu, które wyreżyserowały wraz z tytułami takich filmów (koniunkcja – ten sam autor scenariusza i reżyser)
MATCH (person:Person)-[:WROTE]->(movie:Movie) MATCH (person)- [:DIRECTED]->(movie) RETURN person,movie

//7. Listę filmów, w których grał zarówno Hugo Weaving jak i Keanu Reeves
MATCH (hugoWeaving: Person {name: "Hugo Weaving"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(keanuReeves: Person {name: "Keanu Reeves"}) RETURN m

//8. Zestaw zapytań powodujących uzupełnienie bazy danych o film Captain America: The First Avenger 
//wraz z uzupełnieniem informacji o reżyserze, scenarzystach i odtwórcach głównych ról 
//(w oparciu o skrócone informacje z IMDB - http://www.imdb.com/title/tt0458339/) 
//+ zapytanie pokazujące dodany do bazy film wraz odtwórcami głównych ról, scenarzystą i reżyserem. 
//Plik SVG ma pokazywać wynik ostatniego zapytania.
//film
CREATE (captainAmericaMovie :Movie {title:'Captain America: The First Avenger', released:2011, tagline:'When patriots become heroes'})
//aktorzy
CREATE (chrisEvansPerson:Person {name: "Chris Evans", born: 1981 })
CREATE (samuelLJacksonPerson:Person {name: "Samuel L. Jackson", born: 1948 })
CREATE (hayleyAtwellPerson:Person {name: "Hayley Atwell", born: 1982 })
//reżyserze
CREATE (joeJohnstonPerson:Person {name: "Joe Johnston", born: 1950 })
//pisarze
CREATE (christopherMarkusPerson:Person {name: "Christopher Markus", born: 1970 })
CREATE (stephenMcFeelyPerson:Person {name: "Stephen McFeely", born: 1969 })
CREATE (joeSimonPerson:Person {name: "Joe Simon", born: 1913 })
//relacje
CREATE 
(chrisEvansPerson)-[:ACTED_IN {roles:['Captain America']}]->(captainAmericaMovie),
(samuelLJacksonPerson)-[:ACTED_IN {roles:['Nick Fury']}]->(captainAmericaMovie),
(hayleyAtwellPerson)-[:ACTED_IN {roles:['Peggy Carter']}]->(captainAmericaMovie),
(joeJohnstonPerson)-[:DIRECTED]->(captainAmericaMovie),
(christopherMarkusPerson)-[:WROTE]->(captainAmericaMovie),
(stephenMcFeelyPerson)-[:WROTE]->(captainAmericaMovie),
(joeSimonPerson)-[:WROTE]->(captainAmericaMovie)
MERGE (hugoWeavingPerson:Person {name:"Hugo Weaving"}) 
CREATE (hugoWeavingPerson)-[:ACTED_IN {roles:['Johann Schmidt']}]->(captainAmericaMovie)
//rezultat:
MATCH (actres:Person)-[:ACTED_IN]->(movie:Movie {title: "Captain America: The First Avenger"}),  (directers:Person)-[:DIRECTED]->(movie), (wroters:Person)-[:WROTE]->(movie) 
RETURN actres, directers, wroters,movie

//Uwaga: W wypadku zadania 7 dopuszczalne jest wykorzystanie większej niż 1 ilości zapytań
//Część 2 – Wycieczki górskie
//1. Zaimportuj dane uruchamiając skrypt task2.cypher. Napisz następujące zapytania:
//2. Znajdź wszystkie trasy którymi można dostać się z Darjeeling na Sandakphu
MATCH (fromCity:town {name:"Darjeeling"}),(toCity:peak {name:"Sandakphu"}) MATCH way = (fromCity)-[*]->(toCity) RETURN way

//3. Znajdź trasy którymi można dostać się z Darjeeling na Sandakphu, mające najmniejszą ilość etapów
MATCH (fromCity:town {name:"Darjeeling"}),(toCity:peak {name:"Sandakphu"}) MATCH way = allShortestPaths((fromCity)-[*]->(toCity)) RETURN way

//4. Znajdź mające najmniej etapów trasy którymi można dostać się z Darjeeling na Sandakphu i które mogą być wykorzystywane zimą
MATCH (fromCity:town {name:"Darjeeling"}),(toCity:peak {name:"Sandakphu"}) MATCH way = allShortestPaths((fromCity)-[*]->(toCity)) WHERE ALL (r in relationships(way) where r.winter = "true")  RETURN way

//5. Uszereguj trasy którymi można dostać się z Darjeeling na Sandakphu według dystansu
MATCH (fromCity:town {name: "Darjeeling"}),(toCity:peak {name: "Sandakphu"})
MATCH way = (fromCity)-[r*]->(toCity)
UNWIND r as rel
WITH way, reduce(s = 0, d in (COLLECT(rel.distance)) | s + d) as distance
RETURN way, distance ORDER BY distance ASC

//6. Znajdź wszystkie trasy dostępne latem, którymi można poruszać się przy pomocy roweru (twowheeler) z Darjeeling
MATCH way = (:town {name:"Darjeeling"})-[r:twowheeler*]->(toSomewhere) WHERE all (relation in relationships(way) where relation.summer ="true") RETURN way

//7. Znajdź wszystkie miejsca do których można dotrzeć przy pomocy roweru (twowheeler) z Darjeeling latem
MATCH way = (:town {name:"Darjeeling"})-[r:twowheeler*]->(toSomewhere) WHERE all (relation in relationships(way) where relation.summer ="true") RETURN distinct(toSomewhere)


//Część 3 – Połączenia lotnicze
//1. Zaimportuj dane uruchamiając skrypt task3.cypher. Napisz następujące zapytania:
//2. Uszereguj porty lotnicze według ilości rozpoczynających się w nich lotów
MATCH (:Flight)-[:ORIGIN]->(airport:Airport) RETURN airport, count(*) as flyCount ORDER BY flyCount desc

//3. Znajdź wszystkie porty lotnicze, do których da się dolecieć (bezpośrednio lub z przesiadkami) z Los Angeles (LAX) wydając mniej niż 3000
MATCH way = (:Airport {name:"LAX"})<-[:ORIGIN]-(:Flight)-[:ORIGIN|DESTINATION*]->(:Airport)
WHERE REDUCE(s = 0, x IN [y IN NODES(way) WHERE 'Flight' IN LABELS(y)] |  s + [(x)<-[:ASSIGN]-(ticket) | ticket.price][0]  ) < 3000
RETURN way

//4. Uszereguj połączenia, którymi można dotrzeć z Los Angeles (LAX) do Dayton (DAY) według ceny biletów
MATCH way = (:Airport {name:"LAX"})<-[:ORIGIN]-(:Flight)-[:ORIGIN|DESTINATION*]->(:Airport{name: "DAY"})
WITH way, REDUCE(s = 0, x IN [y IN NODES(way) WHERE 'Flight' IN LABELS(y)] |  s + [(x)<-[:ASSIGN]-(ticket) | ticket.price][0]) as cost
RETURN way, cost ORDER BY cost desc

//5. Znajdź najtańsze połączenie z Los Angeles (LAX) do Dayton (DAY)
MATCH way = (:Airport {name:"LAX"})<-[:ORIGIN]-(:Flight)-[:ORIGIN|DESTINATION*]->(:Airport{name: "DAY"})
WITH way, REDUCE(s = 0, x IN [y IN NODES(way) WHERE 'Flight' IN LABELS(y)] |  s + [(x)<-[:ASSIGN]-(ticket) | ticket.price][0]) as cost
RETURN way, cost ORDER BY cost desc LIMIT 1

//6. Znajdź najtańsze połączenie z Los Angeles (LAX) do Dayton (DAY) w klasie biznes
MATCH way = (:Airport {name:"LAX"})<-[:ORIGIN]-(:Flight)-[:ORIGIN|DESTINATION*]->(:Airport{name: "DAY"})
WITH way, REDUCE(s = 0, x IN [y IN NODES(way) WHERE 'Flight' IN LABELS(y)] |  s + [(x)<-[:ASSIGN]-(ticket {class:"business"}) | ticket.price][0]) as cost
RETURN way, cost ORDER BY cost desc LIMIT 1

//7. Uszereguj linie lotnicze według ilości miast, pomiędzy którymi oferują połączenia (unikalnych miast biorących udział w relacjach :ORIGIN i :DESTINATION węzłów typu Flight obsługiwanych przez daną linię)
MATCH way = (flight:Flight)-[:DESTINATION|ORIGIN]->(airPort:Airport)
WITH flight.airline as airLine , count(distinct(airPort)) as cityCount
RETURN airLine, cityCount order by cityCount desc

//8. Znajdź najtańszą trasę łączącą 3 różne porty lotnicze
MATCH (fromCity:Airport), (stopCity:Airport), (toCity:Airport)
MATCH way = (fromCity)<-[:ORIGIN]-(:Flight)-[:DESTINATION]->(stopCity)<-[:ORIGIN]-(:Flight)-[:DESTINATION]->(toCity)
WITH way, REDUCE(s = 0, x IN [y IN NODES(way) WHERE 'Flight' IN LABELS(y)] |  s + [(x)<-[:ASSIGN]-(ticket) | ticket.price][0]) as cost
WHERE NOT(toCity=fromCity)
RETURN way, cost ORDER BY cost asc LIMIT 1


//Uwaga w tych zadaniach wskazane jest wykorzystanie możliwości stworzenia dodatkowych relacji pomiędzy miastami. Można stworzyć relację i wykonywać ewentualne operacje pomocnicze przy pomocy dodatkowych zapytań, wynikowe SVG/JSON mają dotyczyć zapytania głównego (zwracającego wynik wskazany w zadaniu). We wszystkich zadaniach z tej części można ograniczyć się do 2 przesiadek.