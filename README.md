# Collection Boxes
This is documentation of my efforts to figure out what the hell is going on with USPS collection boxes. The theory and hope here is that, if a collection box is removed, that removal will eventually be reflected in the data provided by USPS.

Please please please, if you have the skills and desire to make something good out of what's posted here, do so! Map it out, analyze it, etc. etc.

## FOIA Dataset
I made a request to USPS in August 2019 for a list of all collection boxes and post offices. I used that data to populate my website [MailboxLocate](https://mailboxlocate.com/).  They kindly responded with two spreadsheets containing both those lists.

That response is available to download here: [foia_2019-09-27.zip](https://collectionboxes.nyc3.digitaloceanspaces.com/foia_2019-09-27.zip)

## Scraped Dataset
I ran a scrape of the [USPS PO Locator](https://tools.usps.com/find-location.htm) on August 15, 2020. This scrape produced a zip file containing 32,977 JSON documents. The zip file is available here: [collection_boxes_2020-08-15.zip](https://collectionboxes.nyc3.digitaloceanspaces.com/collection_boxes_2020-08-15.zip)

If you want to use the JSON files directly, note that a collection box may appear in multiple files. You need to de-dup the collection boxes using the locationID.

I hacked up a script [parse_all_collection_boxes.rb](parse_all_collection_boxes.rb) which converts the mess of JSON files into a CSV file. For consistency, the CSV file uses the same column headers as the `coll report.xlsx` file from the FOIA data. You can download the CSV file here: [collection_boxes_2020-08-15.csv](https://collectionboxes.nyc3.digitaloceanspaces.com/collection_boxes_2020-08-15.csv)

## 2019 to 2020 Added and Removed
I hacked up a script [diff.rb](diff.rb) to compare the collection boxes in the FOIA dataset vs the scraped one. See the script for details regarding the algorithm. You can download the results here:

[removed_2019_to_2020.csv](https://collectionboxes.nyc3.digitaloceanspaces.com/removed_2019_to_2020.csv) collection boxes that appear in the FOIA dataset but not the 8/15/2020 scraped dataset

[added_2019_to_2020.csv](https://collectionboxes.nyc3.digitaloceanspaces.com/added_2019_to_2020.csv) collection boxes that appear in the 8/15/2020 scraped dataset but not the FOIA dataset

Below is an analysis showing the difference in # of collection boxes between the FOIA and scraped data. There is a large drop in the number of reported boxes in DC. This is because many of the boxes in DC are not currently listed in the [USPS PO Locator tool](https://tools.usps.com/find-location.htm) (maybe due to a software error with that tool?)

foia state|2019 count|2020 count|change|change pct
----------|----------|----------|------|----------
DC|792|115|-677|-85%
AK|424|395|-29|-7%
OR|2618|2445|-173|-7%
NE|2131|2063|-68|-3%
MT|1447|1404|-43|-3%
CA|16199|15729|-470|-3%
ND|932|905|-27|-3%
WA|3630|3531|-99|-3%
RI|991|967|-24|-2%
UT|1128|1104|-24|-2%
MA|7815|7649|-166|-2%
MD|5092|4992|-100|-2%
VA|4966|4870|-96|-2%
NM|1480|1453|-27|-2%
GA|3763|3695|-68|-2%
OH|8883|8737|-146|-2%
NH|1584|1558|-26|-2%
KY|3350|3296|-54|-2%
MN|4488|4417|-71|-2%
AZ|2590|2553|-37|-1%
NJ|6344|6254|-90|-1%
VI|71|70|-1|-1%
WI|4306|4249|-57|-1%
TX|9863|9745|-118|-1%
FL|6104|6031|-73|-1%
NV|1020|1008|-12|-1%
IN|4492|4445|-47|-1%
HI|615|609|-6|-1%
IL|10869|10769|-100|-1%
KS|2483|2461|-22|-1%
WY|524|520|-4|-1%
PR|850|844|-6|-1%
VT|1095|1089|-6|-1%
NY|18273|18173|-100|-1%
AR|2824|2810|-14|0%
TN|2721|2709|-12|0%
IA|3667|3652|-15|0%
PA|13378|13324|-54|0%
ME|2026|2018|-8|0%
MI|6511|6487|-24|0%
LA|2282|2274|-8|0%
OK|2607|2598|-9|0%
WV|2630|2621|-9|0%
CO|3223|3212|-11|0%
AL|2937|2927|-10|0%
NC|4873|4857|-16|0%
MS|1766|1761|-5|0%
ID|1093|1090|-3|0%
MO|4927|4918|-9|0%
CT|2847|2844|-3|0%
DE|618|618|0|0%
SD|964|964|0|0%
SC|2286|2290|4|0%

## What's next?
I set up a scheduled job to regularly scrape the collection box data. I will update this document as more files become available.

## LICENSE
I don't own any of this data. So, I have no right to put restrictions on their use. I also have no desire to put restrictions on their use. Have fun!

As for the source code and this documentation:
This project is licensed under the terms of the MIT license.
