Data Science Capstone
========================================================
author: Hao YU
date: JUL. 6th 2016
autosize: true

Outline
========================================================

For more detailed reference and source code, please visit:
<https://github.com/TeddyTiome/>

- **Word Database** 
- **Pharse Process and Prediction**
- **Shiny Application**

Word Database
========================================================

For a much more esay way to process the natural language,
I have tried to serach the database for N-grams and dirty words.<br><br>
Followed by these websites underlying, I have contributed 1 to 3 grams database as well as bad words.

- <http://www.ngrams.info/>
- <http://storage.googleapis.com/books/ngrams/books/datasetsv2.html>
- <https://gist.github.com/jamiew/1112488>
- Other pages on GitHub and searched by Google
Pharse Process and Prediction
========================================================

Based on these database, the work is much easier, and the procedures include:

- **Clean typed text with Non-alphabet characters.**
- **Filter bad words and set defualt to tokened tags.**
- **Get words in phrase and predict the next with most possibility.** 

Shiny Application
========================================================
Sorry that my shiny application is simple and concise.<br> 
So does the instructions: <br>

- *Type pharse, sentence, word without punctuation.*
- *Then the would do the prediction.*
- *A word would appear in the last text box.*
<br><br>
(I would say lazy-made and crude)
