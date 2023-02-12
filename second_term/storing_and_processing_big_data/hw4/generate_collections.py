import json
import random

n_collections = 30

STREETS = [
    "Nevskiy prospekt",
    "Prospekt Kosygina",
    "Moskovskiy prospekt",
    "Hersonskaya street"
]

WORK_TITLES = [
    "developer",
    "analyst",
    "recruiter",
    "HR",
    "accountant",
    "courier"
]

NAME = [
    "Alice",
    "Maksim",
    "Nataliya",
    "Alexey",
    "Andrey",
    "Maria"
]

result = []
for idx in range(n_collections):
    current_collection = {
        "worker_id": idx,
        "worker_age": random.randint(18, 54),
        "apartment_number": random.randint(1, 400),
        "street_name": random.choice(STREETS),
        "worker_title": random.choice(WORK_TITLES),
        "name": random.choice(NAME)
    }
    result.append(current_collection)

with open("generated_collection.json", "w") as file:
    json.dump(result, file)
