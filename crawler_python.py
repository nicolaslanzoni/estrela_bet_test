import requests
cookie_url = "https://estrelabet.com/api-v2/left-menu/d/23/estrelabet/eyJyZXF1ZXN0Qm9keSI6e319"
referer = "https://estrelabet.com/ptb/bet/search/cruzeiro"
url = "https://estrelabet.com/api-v2/name-search/d/23/estrelabet/cruzeiro"

payload = {
    "requestBody": {
        "name": "cruzeiro",
        "bragiUrl": "https://bragi.sportingtech.com/"
    },
    "device": "d",
    "languageId": 23
}
headers = {
    "cookie": "NCC=PTB",
    "Accept": "application/json, text/plain, */*",
    "Connection": "keep-alive",
    "Content-Type": "application/json",
    "HttpOnly; Secure; SameSite=Lax": "",
    "Origin": "https://estrelabet.com",
    "Referer": referer,
    "Sec-Fetch-Dest": "empty",
    "Sec-Fetch-Mode": "cors",
    "Sec-Fetch-Site": "same-origin",
    "sec-ch-ua": '"Opera";v="95", "Chromium";v="109", "Not;A=Brand";v="24"',
    "sec-ch-ua-mobile": "?0",
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 OPR/95.0.0.0",
    "bragiurl": "https://bragi.sportingtech.com/",
    "sec-ch-ua-platform": '"Linux"'
}
r1 = requests.request("GET", cookie_url)
requests.request("GET", referer)
response = requests.request("POST", url, json=payload, headers=headers, cookies=r1.cookies)
body = response.json()
data = body['data'][0]['cs'][0]['sns'][0]['fs'][0]
a = data['hcN']
b = data['acN']

res = data['btgs'][0]['fos']
odds = [res[0]['hO'],res[1]['hO'],res[2]['hO']]
print(a + " vs " + b)

print(f"""
{a} => odds de {odds[0]}
empate => odds de {odds[1]}
{b} => odds de {odds[2]}
""")