#!/bin/bash

# Initial curl command
result=$(curl -s -X GET 'https://search.censys.io/_search?resource=hosts&sort=RELEVANCE&per_page=50&virtual_hosts=EXCLUDE&q=location.country%3A+%22Israel%22+and+services.software.vendor%3A%22Hikvision%22+and+services.port%3A+80+and+%28services.port%3A+554+or+services.port%3A+8554%29&cursor=eyJ2ZXJzaW9uIjoxLCJzb3J0IjpbeyJfc2NvcmUiOnsib3JkZXIiOiJkZXNjIn19LHsiaXAiOnsib3JkZXIiOiJhc2MiLCJtb2RlIjoibWluIiwibWlzc2luZyI6Il9sYXN0In19LHsibmFtZS5fX3JhdyI6eyJvcmRlciI6ImFzYyIsIm1vZGUiOiJtaW4iLCJtaXNzaW5nIjoiX2xhc3QifX1dLCJzZWFyY2hfYWZ0ZXIiOlsyOS4xOTk5OTcsIjc3LjEyNy4xNy4yNiIsbnVsbF0sInJldmVyc2VkIjpmYWxzZX0=' \
-H 'Host: search.censys.io' \
-H 'Cookie: _ga=GA1.2.1073780760.1685540848; _gid=GA1.2.1704346653.1685540848; ajs_anonymous_id=61f463ec-f29c-4b5d-941c-dc017dbd15cc; ajs_user_id=3b692209dd8e4777be0bcd7906642410; ajs_group_id=63f687cfba854eb894fbe92505f8f6e6; auth_v1=MTY4NTYzMzI0NXxqa0w3T0lGdkMyNnlFZTFsd05VTDBadlByZWNYY3BRcGFxc0ZQWG9nSGVaRUF1NEpDcnNNTHVQOE93dk45RFRvT0V3dFEzRmZtbzdRNXJOM3dNUHJ4SGZWcTZYNlRpdUM3SmU3WTZma1B4SHBxWkU3SVFadks0WFROQnRDdUJMcVM3eXdIQ3ZWU3c9PXzDdPO16KWu0707yDRHbDYxYo-6e6fQ6PG83qNCs8e8pg==; CENSYS-INTERNAL-JWT=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJNaWtlIEtlcmkiLCJ1c2VyX3V1aWQiOiIzYjY5MjIwOWRkOGU0Nzc3YmUwYmNkNzkwNjY0MjQxMCIsInRlYW1fbmFtZSI6IlNlY1N5cyAoTWlrZSBLZXJpKSIsInRlYW1fdXVpZCI6IjYzZjY4N2NmYmE4NTRlYjg5NGZiZTkyNTA1ZjhmNmU2IiwiZ3JvdXBzIjpbXSwiY3NyZl90b2tlbiI6IjQ5NDRhMTI0LWYyMmQtNGE2ZC1iMTI5LWQ5OGI0ZmQwZmFhOCIsImV4cCI6MTY4NTY5ODA0Nn0.sqJbI0xlPBU8IgcpC5lzVQNhwgFWoij8j8zMkDaVLD8; X-CSRF=4944a124-f22d-4a6d-b129-d98b4fd0faa8; _gat=1' \
-H 'Accept: */*' \
-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.5481.78 Safari/537.36')

# Parse out the text within <strong> tags and output to a text file
echo "$result" | grep '<strong>' | sed -n 's/.*<strong>\(.*\)<\/strong>.*/\1/p' >> 2.txt

# iterations=0
# while [ $iterations -le 210 ]; do
  # Get the last string from the output file
  last_string=$(tail -n 1 2.txt)

  # Create the JSON template with the last string inserted
  json_template=$(echo "{\"version\":1,\"sort\":[{\"_score\":{\"order\":\"desc\"}},{\"ip\":{\"order\":\"asc\",\"mode\":\"min\",\"missing\":\"_last\"}},{\"name.__raw\":{\"order\":\"asc\",\"mode\":\"min\",\"missing\":\"_last\"}}],\"search_after\":[29.199997,\"$last_string\",null],\"reversed\":false}")

  # Encode the JSON in Base64
  base64_encoded=$(echo "$json_template" | base64)

  # Run the curl command again with the new encoded string
  result2=$(curl -s -X GET 'https://search.censys.io/_search?resource=hosts&sort=RELEVANCE&per_page=50&virtual_hosts=EXCLUDE&q=location.country%3A+%22Israel%22+and+services.software.vendor%3A%22Hikvision%22+and+services.port%3A+80+and+%28services.port%3A+554+or+services.port%3A+8554%29&cursor=\"$base64_encoded\"' \
-H 'Host: search.censys.io' \
-H 'Cookie: _ga=GA1.2.1073780760.1685540848; _gid=GA1.2.1704346653.1685540848; ajs_anonymous_id=61f463ec-f29c-4b5d-941c-dc017dbd15cc; ajs_user_id=3b692209dd8e4777be0bcd7906642410; ajs_group_id=63f687cfba854eb894fbe92505f8f6e6; auth_v1=MTY4NTYzMzI0NXxqa0w3T0lGdkMyNnlFZTFsd05VTDBadlByZWNYY3BRcGFxc0ZQWG9nSGVaRUF1NEpDcnNNTHVQOE93dk45RFRvT0V3dFEzRmZtbzdRNXJOM3dNUHJ4SGZWcTZYNlRpdUM3SmU3WTZma1B4SHBxWkU3SVFadks0WFROQnRDdUJMcVM3eXdIQ3ZWU3c9PXzDdPO16KWu0707yDRHbDYxYo-6e6fQ6PG83qNCs8e8pg==; CENSYS-INTERNAL-JWT=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJNaWtlIEtlcmkiLCJ1c2VyX3V1aWQiOiIzYjY5MjIwOWRkOGU0Nzc3YmUwYmNkNzkwNjY0MjQxMCIsInRlYW1fbmFtZSI6IlNlY1N5cyAoTWlrZSBLZXJpKSIsInRlYW1fdXVpZCI6IjYzZjY4N2NmYmE4NTRlYjg5NGZiZTkyNTA1ZjhmNmU2IiwiZ3JvdXBzIjpbXSwiY3NyZl90b2tlbiI6IjQ5NDRhMTI0LWYyMmQtNGE2ZC1iMTI5LWQ5OGI0ZmQwZmFhOCIsImV4cCI6MTY4NTY5ODA0Nn0.sqJbI0xlPBU8IgcpC5lzVQNhwgFWoij8j8zMkDaVLD8; X-CSRF=4944a124-f22d-4a6d-b129-d98b4fd0faa8; _gat=1' \
-H 'Accept: */*' \
-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.5481.78 Safari/537.36')

  # Parse out the text within <strong> tags and output to a text file
  echo "$result2" | grep '<strong>' | sed -n 's/.*<strong>\(.*\)<\/strong>.*/\1/p' >> 2.txt


# ((iterations++))

#  sleep 10

#     done
