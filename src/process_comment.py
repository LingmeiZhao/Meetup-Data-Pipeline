import json
import sys

text = sys.stdin.read()
comment = json.loads(text)
print(comment["member"]["member_id"], comment["member"]["member_name"])
