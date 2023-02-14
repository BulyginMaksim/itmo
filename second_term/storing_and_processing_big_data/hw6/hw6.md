Откройте официальную песочницу (https://sandbox.neo4j.com/) Neo4j, зарегистрируйтесь.
- Установите демонстрационную БД “Network and IT Management” (можно запустить в
браузере для удобства);
- Посмотрите на метаданные графа (схему);
  - `$ call db.schema.visualization()`
- Создайте новую стойку (Rack) c несколькими маршрутизаторами (Switch). Свяжите
с датацентром. Выведите результат
  ```
  MATCH(dc: DataCenter{name:"DC1"})
  CREATE (rk: Rack{name:"NewRack"}),
  (sw1: Switch{name:"NewSwitchFirst"}),
  (sw2: Switch{name:"NewSwitchSecond"}),
  (rk)-[:HOLDS]->(sw1),
  (rk)-[:HOLDS]->(sw2),
  (dc)-[:CONTAINS]->(rk)
  Return *
  ```
- Найдите суммарный объём оперативной памяти (ram) на стойке (rack) “DC1-RCK-1-
10” 
  ```
  MATCH(rk: Rack{name:"DC1-RCK-1-10"})-[:HOLDS]->(m:Machine)
  -[:TYPE]->(t) RETURN SUM(t.ram)
  ```
- Выведите названия (name) операционных систем (os) без повторений. 
  - `$ MATCH (n:OS) RETURN DISTINCT n.name`
- Найдите сервисы (service), которые запущены на сервере (machine) ‘DC1-RCK-1-1-
M-24’ 
  - `MATCH(m:Machine{name:"DC1-RCK-1-1-M-24"})-[:RUNS]->(s:Service) RETURN s`
- Найдите максимальную длину цепей версий (длина массива) для сервисов
  - `MATCH(s:Service) return MAX(SIZE(s.versions))`