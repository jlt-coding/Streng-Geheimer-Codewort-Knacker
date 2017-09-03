# Webscraper to obtain a list of words of the german language with 5 letters
# Problem was that the chosen website did not respond from time to time and threw an error message.
# This was solved by making the script write the result of every single page to a file.
# Exception handling would have been better, but fuck it for now.

from bs4 import BeautifulSoup
import urllib.request
import time
import os.path

# Construct the path to the outputfile
path = os.path.abspath('..')
print (path)

# Construct the URL for the request in a loop
page_number = ()
for page_number in range(55, 56):
    # After every successful loop, the result is written to the file, this way at least some progress is made in case of an error
    # Reset word_list after every page
    word_list = []
    # Request the site
    site = urllib.request.urlopen('http://www.wordmine.info/Search.aspx?stype=words-with&slang=de&sword=&letters=on&minletters=5&maxletters=5&page=' + str(page_number))
    soup = BeautifulSoup(site, 'html.parser')
    # Identify every tag in the code that contains a word of interest
    line_list = soup.find_all('span')
    # Extract the string of this tag, write it to a list
    for tag in line_list:
        word_list.append(tag.string)
    # Write the list to a file
    with open(path + '/data/five_letter_word_list_python.txt', 'a') as fh_wordlist_output:
        for word in word_list:
            fh_wordlist_output.write(word + '\n')
    # Print page_number to keep track where to start after a timeout
    print (page_number)
    # Timeout to not stress the server too much
    time.sleep(2)
