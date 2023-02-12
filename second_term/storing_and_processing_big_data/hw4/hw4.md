## HW4

Useful commands:
- Start mongodb: `$ brew services start mongodb-community@6.0`
- Stop mongodb: `$ brew services stop mongodb-community@6.0`
- List of running applications: `$ brew services list`
- Run mongodb shell: `$ mongosh`

Создайте авторскую базу MongoDb (в виде скрипта) в любой из доступных
песочниц. В базе должна быть коллекция, содержащая не менее 20 документов.

```
$ python3 generate_collections.py
$ cat generated_collection.json
$ mongosh
$ db.test.deleteMany()
$ db.test.insertMany(...)
```

1. Запрос, который выведет средний возраст:
```
$ db.test.aggregate([{ $group: { _id: null, age_avg: { $avg: "$worker_age" } } }])
```
2. Запрос, который выведет в виде списка все должности:
```
$ db.test.distinct("worker_title")
```
3. Запрос, который добавит некоторым работникам поле, показывающее получит ли работник премию в этом году; посчитайте их количество:
```
$ db.test.updateMany( { worker_age: { $gt: 50 } }, [ { $set: { deserved_bonus: true } } ] )
$ db.test.find( { deserved_bonus: true } ).count()
```
4. Запрос, который выведет в отсортированном по имени порядке всех работников, которые проживают на улице содержащей букву “о”:
```
$ db.test.find( { street_name: /O/i } ).sort( { name: 1 })
```
5. Запрос, который выведет всех работников, проживающих в квартирах с четными номерами:
```
$ db.test.find( { apartment_number: { $mod: [2, 0] } } )
```
