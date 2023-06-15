```

    )  (                           
 ( /(  )\ )   (                    
 )\())(()/(   )\   (   (   (   (   
((_)\  /(_))(((_)  )\  )\  )\  )\  
 _((_)(_))  )\___ ((_)((_)((_)((_) 
| || ||_ _|((/ __|\ \ / / \ \ / /  
| __ | | |  | (__  \ V /   \ V /   
|_||_||___|  \___|  \_/     \_/    
                                   
```

# Hikvision IP cam vulnerability verifier

A straightforward script that scans Hikvision IP cameras for a widely recognized backdoor.

## Description

* hicvv.py - the Hikvision IP cam vulnerability verifier script
* hikvisioncams.py - the hikvision ip cam finder on Censys.io (API-KEY Required) 
* ipscraper.sh - an attempt to scrape more the 100 results from censys.io. However, it is important to note that successful functionality or desired outcomes are not guaranteed as it needs a premium API-KEY from censys.

### Requirements
* In order to ensure the functionality of the hikvisioncams.py script, it is essential to possess a valid API-KEY and API-SECRET for censys, as well as the censys Python library.
The library can be installed using `pip`.

```sh
pip install censys
```
* To ensure the ipscraper.sh script operates correctly, it is necessary to edit the script and provide the missing parameter (any value within the quotation marks). Modify the script by filling in the following information:
```
-H 'Cookie: ""; ajs_anonymous_id=""; ajs_user_id=""; ajs_group_id=""; auth_v1=""; CENSYS-INTERNAL-JWT="";
```
### Installing
```
git clone https://github.com/Kaizen-san/Side-quest-scripts.git
```
### Executing program

* To ensure proper execution of the script, please run it initially with the "-h" option to access the help menu. This will provide you with instructions and guidance on how to use the script effectively.
```
python3 hicvv.py -h
```


## Version History

* 0.1
    * Initial Release

## Disclaimer

These scripts have been developed solely for educational purposes, aiming to raise awareness about potential security vulnerabilities. It is important to note that unauthorized usage or any form of malicious intent is strongly discouraged. Users are advised to exercise responsible and ethical behavior when utilizing this script or any security-related tool. The primary intention behind creating this script is to promote understanding and knowledge in the field of cybersecurity, encouraging users to prioritize the protection of their systems and respect the boundaries of lawful and ethical practices.
