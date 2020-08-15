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

## What's next?
I set up a scheduled job to regularly scrape the collection box data. I will update this document as more files become available.

## LICENSE
I don't own any of this data. So, I have no right to put restrictions on their use. I also have no desire to put restrictions on their use. Have fun!

As for the source code and this documentation:
This project is licensed under the terms of the MIT license.
