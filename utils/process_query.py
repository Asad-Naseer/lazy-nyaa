import requests
from bs4 import BeautifulSoup

def process_query(user_input: str):

    user_input_formatted = user_input.replace(" ", "+")
    url = f"https://nyaa.si/?f=0&c=0_0&q={user_input_formatted}&s=seeders&o=desc"
    response = requests.get(url)

    results = []

    if response.status_code == 200:

        # Parse the raw HTML text.
        soup = BeautifulSoup(response.text, 'html.parser')

        # Target the rows of the table with the list of torrents.
        rows = soup.select('.torrent-list tbody tr')

        for row in rows:

            # Get Title
            title_element = row.select_one('td[colspan="2"] a:not([class])') # a:not([class]) means find the td with colspan=2 and the anchor that does not have a class
            title = title_element.text.strip() if title_element else "Error getting Title"

            # Get Seeders
            seeders_element = row.select_one('td:nth-of-type(6)')
            seeders = seeders_element.text.strip() if seeders_element else "Error getting Seeders"

            # Get Leechers
            leechers_element = row.select_one('td:nth-of-type(7)')
            leechers = leechers_element.text.strip() if leechers_element else "Error getting Leechers"


            # Get Publishing Date
            pb_date_element = row.select_one('td:nth-of-type(5)')
            pb_date = pb_date_element.text.strip() if pb_date_element else "Error getting PB Date"


            # Get Size
            size_element = row.select_one('td:nth-of-type(4)')
            size = size_element.text.strip() if size_element else "Error getting Size"


            # Get Magnet Link
            magnet_link_element = row.select_one('a[href^="magnet:"]')
            magnet_link = magnet_link_element['href'] if magnet_link_element else "Error getting magnet"


            new_entry = {
                'title': title,
                'seeders': seeders,
                'leechers': leechers,
                'pb_date': pb_date,
                'size': size,
                'magnet_link': magnet_link
            }

            results.append(new_entry)
            
    return results