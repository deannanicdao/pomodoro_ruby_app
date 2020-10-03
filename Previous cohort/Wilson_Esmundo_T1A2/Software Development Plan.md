# SOFTWARE DEVELOPMENT PLAN
### Written by: Wilson Esmundo

## Introduction
---
This Section describes a summary of essential information listed below:
* Statement of Purpose and Scope
* Features
* User Interaction and Experience
* Control Flow Diagram
* Implementation Plan
* Development Log
* Application Implementation
* Test Application Results
* Developers Operation

## Statement Purpose
---
The purpose of this Terminal Application is to help Bird enthusiast specifically collectors and breeders of Agapornis Roseicollis also known as Rosyfaced or Lovebirds managed, organised and tracked bird in hand.  It also provides access to Genetic Mutation calculator to enable the breeder the possible genetic outcome for any combination of breeding pair.<br>
<br>
Identifying birds are easy when there are only three to five pairs to begin with, however, when they start to hatch in which they are between one to seven, it starts to get complicated. Most likely, they will produce birds that are identical and will be hard to distinguish. After about three months, they may have a new batch of hatchlings and when you put them all together in one flight cage, you will no longer be able to keep track of their ages and remember which pair they came from.

This app is developed to help breeders have differentiation of birds in keeping and make this a valuable resource to the user by recording any vital information by using the journal option. Some breeders also look for specific colour so an access to genetic mutation calculator comes in handy. Having a database as such would allow the user to make sure that the bird is mature enough to breed.



## Features
---
<br>

* The Terminal Application functions as a database with specific characteristics to describe individual bird entry for record management. All data entered will be stored in a separate text file for future retrieval of information. Database of birds can be shown in a list sorted by the the moment they were encoded in the application. Each bird database can also be deleted in the application which subsequently updates the said text file. The said function is the first option in the main menu so users can easily add Bird information instantly with typing only the Bird Identification number as the initial input and the rest of it will be shown as menu choices.<br>

* Another vital function of the Terminal application is the ability to link the user to the website which is necessary to Bird breeders. New breeders issues were always the colour of the birds they want to produce.  Some will questioned how come the same colours of birds always shows up whenever they breed. Whenever the user chooses the Bird Colour Calculator, it will load a website which has a very simple interface for users to interact. They just need to enter information about the possible birds they want to breed and the website will list all the possible combination of colours and mutation incase they breed that said pair.<br>

* Final feature of the Terminal application is the Bird Journal.  All bird breeders encounters problem especially if their stocks were already large and often times overlook things because of the volume of birds they have. Problem such as running out of food, medication or supplements of birds, also situations like negligence because breeders failed to check something on their aviary. With the Bird Journal, they can add as many notes they want by going to the Bird Journal option and choose add Journal. They will also be provided an option to list every journals they've added and like the first feature, all data will be saved in a specific text file for future retrieval. Lastly, they have option to delete specific notes which will be updated in the text file. <br>

## User Interaction and Experience
---

The users of the Terminal Application were able to meet the following criteria:<br>

* Ease of Menu<br>
The Terminal application has a Menu choices so users will be able to visualize the functionality of the program by selection options.<br>

* Ease of Navigation<br>
Most users of the application were not familiar with the Terminal through their computer but since the app has built in Menu system, users will be able to use just arrow and enter key to navigate through the application which lessen typographical errors.<br>
* User Friendly<br>
The application wont complicate things for the users, since it has a clean menu and uses arrow keys for navigation, its simplicity and function will be suitable for non techy users.<br>
* Less Errors<br>
With is designed, end user will commit less mistakes thus preventing the application to run its function in addition to its error handling process set in place for those unseen bugs in the program.



* ## Control Flow Diagram
---
Please find attached pdf file of the Control Flow Diagram.<br>
<br>
![Control-Flow-Diagram](docs/control_flow_birdie.jpg)<br>


* ## Implementation Plan
---
We were given 12 days to finish the Terminal Application thus implementation of plan is essential in providing successful outcome.<br>
The priority for the project is the partial Documentation and the Bird Database feature and was given 2-3 days to complete. I choose to prioritize this feature because I believe this will be the blueprint of my application and other features can be with the same format. On the other hand documentation is important and as I go along with the project, bits and piece of information will be added to the documentation. As illustrated below in the Trello board, we provided checklist for both Documentation and Adding Database features.<br>
<br>
![trello1](docs/trello_1.png)<br>
<br>
![trello1](docs/trello_documentation.png)<br>
<br>
![trello1](docs/trello_add_database.png)<br>
<br>
The next task were Adding Journal and still continuing the Documentation and were given 2 days deadline. Since we already did the Add Database feature on the previous task, we will have a guidelines on how to do the Adding Journal feature and pretty much it will be the same concept as the previous feature. Trello board shown below.
![trello1](docs/trello_2.png)<br>
<br>
![trello1](docs/trello_documentation1.png)<br>
<br>
![trello1](docs/trello_add_database1.png)<br>
<br>
The next task was still Documentation and added Deleting function of Database and Journal and were given 2-3 days to complete. Like I said in the previous paragraph, Documentation will still be ongoing and this time it will be together with the Delete Database feature as shown in the Trello board below together will its individual checklist.
<br>
![trello1](docs/trello_3.png)<br>
<br>
![trello1](docs/trello_delete_database.png)<br>
<br>
![trello1](docs/trello_delete_database1.png)<br>
<br>
Finally the Bird Colour Calculator and Documentation were finished last. Since this feature is the easiest to do we put it on the last priority and also by this time we should be finishing the rest of the documentation as shown on the Trello board below.
<br>
![trello1](docs/trello_4.png)<br>
<br>
![trello1](docs/trello_calculator.png)<br>
<br>
 ## Development Log
---
Please see attached file <br>
Click [here](./development-log.md)<br>
<br>
## Application Implementation
---
Please see attached file <br>
Click [here](./help.md)<br>
<br>
## Test Application Results
---
* **Test 1** <br> 

Saving the User Input written in a yaml file called @collection.yml <br>
<br>
Check first if the file was empty afterwards run the program and user input all the data, checked the yaml file and all the data type where not saved. Code was shown below.<br>
<br>
### Test : Fail<br>

<br>code:<br>

```ruby
File.open("@collection.yml", "a") { |file| file.write(@collection.to_yaml) }
``` 
Run another test using different parameter this time instead of using append, we used write this time and do the same process as above and all the datas were saved this time. Code shown below.<br>
### Test : Pass<br>

<br>code:<br>


```ruby
File.open("@collection.yml", "w") { |file| file.write(@collection.to_yaml) }
```

* **Test 2** <br>
Deleting user input saved in a yaml file called @collection.yml<br>
<br>
Check first if theres data saved in the file, once done user execute the delete command and check the file if its deleted. All data still in placed. Code shown below.<br>
<br>

### Test : Fail<br>
<br>code:<br>

```ruby
user_input = gets.chomp
if user_input == "y" 
    File.open("@collection.yml", "a") { |file| file.write(@collection.to_yaml) }
else
    delete_stocks
end
```
Run another test using different parameter this time instead of using append, we used write this time and do the same process as above and all the datas were saved this time. Code shown below.<br>

### Test: Pass
<br>code:<br>

```ruby 
user_input = gets.chomp
if user_input == "y" 
    File.open("@collection.yml", "w") { |file| file.write(@collection.to_yaml) }
else
    delete_stocks
end
```
<br>

## Developers Operation
---
For the GitHub repository<br>
Please click [here](https://github.com/charliegucci/T1A2)







 
