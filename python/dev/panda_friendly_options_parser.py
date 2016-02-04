#!/usr/bin/python
'''
Parse the XML efficiently and time effectively
'''
#import
from lxml import etree
from lxml import html
import datetime

"""
<tr data-row="3" data-row-quote="_" class="in-the-money odd">
<td>
<strong data-sq=":value" data-raw=""><a href="/q/op?s=GOOG&strike=662.50">662.50</a></strong>
</td>
<td>
<div class="option_entry Fz-m" ><a href="/q?s=GOOG160304C00662500">GOOG160304C00662500</a></div>
</td>
<td>
<div class="option_entry Fz-m" >65.60</div>
</td>
<td>
<div class="option_entry Fz-m" >68.40</div>
</td>
<td>
<div class="option_entry Fz-m" >71.50</div>
</td>
<td>
<div class="option_entry Fz-m" >0.00</div>
</td>
<td>
<div class="option_entry Fz-m">0.00%</div>
</td>
<td>
<strong data-sq=":volume" data-raw="1">1</strong>
</td>
<td>
<div class="option_entry Fz-m" >1</div>
</td>
<td>
<div class="option_entry Fz-m" >35.23%</div>
</td>
</tr>
"""

def main():
    print ("HTML Options Parser")
    #HTML Fetch equivalent for development
    input_file = open("yahoo_stock_response.html", "r")
    input_data = input_file.read()
    #print input_data
    #Actual HTML parsing
    tree = html.fromstring(input_data)
    print "Working"
    strike_name = tree.xpath('//div[@class="option_entry Fz-m"]/text()')
    print strike_name
    strike_titles = tree.xpath('//*[@id="optionsCallsTable"]/div[2]/div/table/thead/tr[1]/th[1]/div[1]/div[1]/text()')
    print strike_titles
    print "Not Working"
    strike_titles = tree.xpath('//*[@id="yui_3_17_2_1_1454534963844_1109"]/text()')
    print strike_titles
    strike_titles = tree.xpath('//*[@id="optionsCallsTable"]/div[2]/div/table/thead/tr[1]/th[2]/div[@class="D-ib"]/text()')
    print strike_titles
    strike_price = tree.xpath('//*[@id="yui_3_17_2_1_1454534963844_842"]/tr[73]/td[3]/div')
    print strike_price
    print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()
		
