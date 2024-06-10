import random
import json
import uuid

# Generate random properties
def generate_properties(num_keys):
    properties = []
    for i in range(num_keys):
        key = f'key_{i+1}'
        if random.choice([True, False]):
            value = {
                'key': key,
                'value': {
                    'value': f'value{random.randint(1, 100)}',
                    'numerical_value': None
                }
            }
        else:
            value = {
                'key': key,
                'value': {
                    'value': None,
                    'numerical_value': round(random.uniform(1, 100), 2)
                }
            }
        properties.append(value)
    return properties

# Inputs for records and keys
while True:
    try:
        num_records = int(input("How many records?: "))
        num_keys = int(input("How many keys?: "))
        break
    except ValueError:
        print("Invalid input. Please enter integers for both the number of records and the number of keys.")
data=[]

for i in range(num_records):
    record = {
        'uuid': str(uuid.uuid4()),
        'properties': generate_properties(num_keys)
    }
    data.append(record)

# Save to a JSON file in newline-delimited format
with open('sample_data.json', 'w') as f:
    for record in data:
        json.dump(record, f)
        f.write('\n')  

print("Test data generated and saved to sample_data.json")
