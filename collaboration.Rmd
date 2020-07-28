# Collaboration

## Working with others

## Working with yourself

## Code review

### Style guidelines

### Tests

## Documentation

### Comments

All the way back in Section \@ref(using-rstudio) we introduced comments, which are essentially notes about the code that you include in an R script (by starting a line with the pound key #) that isn't run. They are just "comments" to yourself or anyone else reading the code to explain what that code does. As is often repeated in explaining the benefit of comments, the main collaborator you will have is yourself in the future.^[I recently worked on a follow-up paper to one I had done a year ago. For some reason, past me decided to name some functions based on the authors of a paper that created that particular method, and didn't leave comments explaining what the code did or why. Past me caused a lot of problems for current me. Please comment your code!] 

### Vignettes

Vignettes are essentially a document that explains how to do something with the code you have written. This is common when someone has written an R package and they want to explain in detail important functions from the package. You can think of chapters of this book as vignettes covering particular topics - PDF scraping, webscraping, regular expressions, etc. To make a vignette, you can simply make an R Markdown file (for more information on R Markdown please see Chapter \@ref(r-markdown)) detailing that topic.

One increasingly prominent method of using R for research is to do everything in an R Markdown file. This allows you to explain your approach - including context on why you did something - and each step you took in plain language in the text of the R Markdown file while still including the code directly in the file - and you can still include comments on that code in the code chunks. Whether you include the code in the output, or just the result of the code, depends on your audience and how far along you are in the project. If this is for a presentation to update collaborators, for example, it is useful to include the code as they may notice an issue or give advice based on the code. Including code can also teach your audience something new (I've certainly learned a lot by watching people present using code I wasn't familiar with). If the document is for an audience unfamiliar with R (or programming more generally), or where time to present is limited, you probably won't want to include code.

