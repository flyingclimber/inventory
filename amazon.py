'''amazon.py - Simple amazon lookup tool'''

import time
import argparse
from amazonproduct import API
from amazonproduct import errors

PARSER = argparse.ArgumentParser(description='Amazon lookup tool')

PARSER.add_argument('-t', '--title', help='title')

ARGS = PARSER.parse_args()

API = API(locale='us')

try:
    for item in API.item_search('VideoGames', Title=ARGS.title,
                                Availability='Available', OfferSummary='New',
                                MerchantId='Amazon'):
    
        print '%s: %s' % (item.ItemAttributes.Title,
                          item.ASIN)
except errors.NoExactMatchesFound, e:
    print time.strftime("%c") + ": " + "Nothing yet .."