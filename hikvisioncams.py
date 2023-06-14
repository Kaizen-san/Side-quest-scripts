from censys.search import CensysHosts
from censys.common.exceptions import CensysNotFoundException
import csv


# Your Censys API ID and Secret
API_ID = "YOUR-API-KEY"
API_SECRET = "YOUR-API-SECRET"

# Create a new IPv4 API instance
c = CensysHosts(api_id=API_ID, api_secret=API_SECRET)

# Specify the search criteria
search_criteria = 'services.software.vendor:"Hikvision" and services.port: 80 and (services.port: 554 or services.port: 8554)'


# Open the output file
with open('ipcamhikvision.txt', 'w') as file:
    try:
        # Search the Censys database
        for page in c.search(search_criteria, per_page=100):
            for result in page:
                # Extract the required fields
                ip = result.get('ip', '')

                # Write the fields to the file
                file.write(f'{ip}\n')
    except CensysNotFoundException:
        print("No results found for your search criteria.")


print("The results have been extracted to 'ipcamhikvision.txt' file.")
