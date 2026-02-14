import re

with open('Drawing_1.qml', 'r', encoding='utf-8') as f:
    lines = f.readlines()

result = []
id_counts = {}

for line in lines:
    match = re.search(r'(\s+)id:\s*(\w+)', line)
    if match:
        indent = match.group(1)
        id_name = match.group(2)
        
        if id_name in id_counts:
            count = id_counts[id_name] + 1
            id_counts[id_name] = count
            new_id = f'{id_name}_{count}'
            line = line.replace(f'id: {id_name}', f'id: {new_id}')
        else:
            id_counts[id_name] = 1
    
    result.append(line)

with open('Drawing_1.qml', 'w', encoding='utf-8') as f:
    f.writelines(result)

print('Fixed duplicate IDs')
