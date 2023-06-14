#!/bin/bash

# Initial curl command
result=$(curl -s -X GET 'https://search.censys.io/_search?resource=hosts&sort=RELEVANCE&per_page=50&virtual_hosts=EXCLUDE&q=location.country%3A+%22Israel%22+and+services.software.vendor%3A%22Hikvision%22+and+services.port%3A+80+and+%28services.port%3A+554+or+services.port%3A+8554%29&cursor=eyJ2ZXJzaW9uIjoxLCJzb3J0IjpbeyJfc2NvcmUiOnsib3JkZXIiOiJkZXNjIn19LHsiaXAiOnsib3JkZXIiOiJhc2MiLCJtb2RlIjoibWluIiwibWlzc2luZyI6Il9sYXN0In19LHsibmFtZS5fX3JhdyI6eyJvcmRlciI6ImFzYyIsIm1vZGUiOiJtaW4iLCJtaXNzaW5nIjoiX2xhc3QifX1dLCJzZWFyY2hfYWZ0ZXIiOlsyOS4xOTk5OTcsIjc3LjEyNy4xNy4yNiIsbnVsbF0sInJldmVyc2VkIjpmYWxzZX0=' \
-H 'Host: search.censys.io' \
-H 'Cookie: ""; ajs_anonymous_id=""; ajs_user_id=""; ajs_group_id=""; auth_v1=""; CENSYS-INTERNAL-JWT="";
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
-H 'Cookie: ""; ajs_anonymous_id=""; ajs_user_id=""; ajs_group_id=""; auth_v1=""; CENSYS-INTERNAL-JWT="";
-H 'Accept: */*' \
-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.5481.78 Safari/537.36')

  # Parse out the text within <strong> tags and output to a text file
  echo "$result2" | grep '<strong>' | sed -n 's/.*<strong>\(.*\)<\/strong>.*/\1/p' >> 2.txt


# ((iterations++))

#  sleep 10

#     done
