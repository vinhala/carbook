# Carful Epics
The Carful mobile application is meant to be the ultimate companion app for people who like to work on their own car. It allows its users to keep track of regular maintenance work, plan and document repairs, plan and document modifications as well as consulting a specialised AI assistant on car related questions.

## E.1 Initial Setup
The owner of a car (user) should be able to install the application from a the Play Store or App Store and perform an initial setup to tailor the app to their car.

### US.1.1 Installation
As a user I would like to be able to visit the Play Store or App Store and install the mobile application on my phone or tablet so that I can use it.

## E.2 Car Profiles
Car owners (users) should be able to create profiles for each of their cars to organise work and knowledge about them.

### US.2.1 List Car Profiles
As a user I would like to see a list of existing car profiles when launching the app so that I can select the one I want to document work for.

#### Main Flow
1. User launches the app
2. App loads existing car profiles
3. For each existing profile app shows make, model, engine and year as well as a picture if provided

### US.2.2 Create Car Profile
As a user I want to be able to create a profile for one of my cars so that I can start documenting and planning work on the car.

#### Requires
- US.2.1

#### Main Flow
1. User launches the app
2. App loads list of existing profiles
3. User asks app to create new profile
4. App asks the user for the make, model, month and year of first registration, engine, vin, distance unit (miles or kilometers) and current mileage of the car to add
5. User enters details
6. App asks user if they want to add a picture
7. User selects an image from their image gallery
8. App asks user how often they want to be reminded about updating the mileage
9. User selects weekly, monthly, quarterly or never
10. App stores information and creates profile
11. App displays created vehicle's profile

### US.2.3 Display Car Profile
As a user I want to be able to see the profile for one of my cars so that I can quickly access the related work, documents and AI assistant for that specific car.

#### Requires
- US.2.2

#### Preconditions
- User on car profile list

#### Main Flow
1. User selects a car profile
2. App displays make, model, engine, year, vin as well as a picture if provided
3. App displays mileage along with date of last edited and a control to update the mileage

### US.2.4 Edit Car Profile
As a user I want to be able to edit the profile for one of my cars so that I can update wrong or outdated information.

#### Requires
- US.2.3

#### Preconditions
- User on car profile

#### Main Flow
1. User enables edit mode
2. App shows controls for each of the car profile fields
3. User edits make, model, engine, year, mileage, distance unit, vin or picture
4. User asks app to save changes
5. App saves changes and shows profile in read only mode

### US.2.5 Delete Car Profile
As a user I want to be able to delete car profile that I no longer need so that I can focus on the ones that are important to me.

#### Requires
- US.2.4

#### Preconditions
- In car profile edit mode

#### Main Flow
1. App displays control for deleting car profile at end of profile
2. User asks app to delete profile
3. App asks user to confirm deletion and reminds them that this is not reversible
4. User confirms and app deletes all data related to the profile

### US.2.6 Mileage Update Notifications
As a user I want to be able to control when and if I am reminded about updating the mileage for a car so that I remember to keep the mileage updated and receive notifications about due maintenance items.

#### Requires
- US.2.4

#### Preconditions
- In car profile edit mode

#### Main Flow
1. App displays control for mileage reminders next to mileage field
2. User opens reminders settings
3. User selects weekly, monthly, quarterly or never
4. If user selects quarterly or never, app warns about danger of forgetting about crucial maintenance work
5. App stores new reminders settings

## E.3 Maintenance Schedule
As owner of a car (user) I want to be able to manage a schedule of regular maintenance work that needs to be performed on my car so that I can ensure it is performed whenever needed.

### Requires
- US.2.3

### US.3.1 List Maintenance Items
As a user I want to be able to see all existing maintenance items for a selected car so that I can keep track of upcoming maintenance work.

#### Preconditions
- User viewing car profile

#### Main Flow
1. User asks app to show all maintenance items for the current car
2. App loads maintenance items for car
3. For each maintenance item the app displays description, schedule in terms of each xy miles or xy weeks/months/years and a badge if maintenance is overdue
4. App sorts items in descending order by days/miles overdue


### US.3.2 Create Maintenance Item
As a user I want to be able to add new maintenance items to keep track of open maintenance work.

#### Requires
- US.3.1

#### Preconditions
- User viewing maintenance items

#### Main Flow
1. User selects control for creating new item
2. App asks user to enter description, miles/time schedule for item
3. App creates item and marks as overdue since date of registration
4. App shows item in list of items with badge for being overdue

### US.3.3 Show Past Work for Maintenance Item
As a user I want to be able to see the past performed work for a selected maintenance item so that I can understand its next required iteration of work.

#### Requires
- US.3.1

#### Preconditions
- User viewing maintenance items

#### Main Flow
1. User selects maintenance item
2. App loads past performed work for the maintenance item
3. For each performed work the app shows date, mileage and optional note
4. App shows time/miles till next required work for item
5. If item is overdue, app displays miles/time the item is overdue

### US.3.4 Add Performed Work for Maintenance Item
As a user I want to be able to log performed work on a maintenance item so that the app can determine when to next remind me of performing the maintenance.

#### Requires
- US.3.3

#### Preconditions
- User viewing maintenance item

#### Main Flow
1. User selects to log work
2. App asks user for date, mileage and an optional note for the performed work
3. User enters date, mileage and optional note
4. App stores performed work for item and updates time/miles till next work

## E.4 Repairs
The owner of a car should be able to track and plan repairs on the car so that they can quickly assess the current state of their car and what needs to be worked on next. This knowledge can also be helpful when selling the car as it helps to create the listing.

### US.4.1 List Past Repairs
As the owner of a car (user) I would like to be able to list past repairs that have been performed on the car so that I can predict when a part may fail again and include the information in the listing if I sell the car.

#### Requires
- US.2.3

#### Preconditions
- User viewing profile of car

#### Main Flow
1. User goes to repairs section for car
2. App loads past repairs
3. App shows for each repair the title, the date and the area of the car (engine, chassis, body, suspension, electrics, interior, other)
4. App orders repairs by date in descending order

### US.4.2 Track Past Repair
As the owner of a car (user) I would like to be able to track a repair that has been performed on the car so that I can predict when it may fail again inform potential buyers about the state of the part in question.

#### Requires
- US.4.1

#### Preconditions
- User viewing repairs section of car profile

#### Main Flow
1. Selects to track past repair
2. User enters short description, date of completion, area of car, optional detailed description
3. Optionally user adds for each part used during the repair a title and an optional web-link
4. Optionally user adds files and images relevant to the repair
5. User asks app to save information
6. App uses information to create new past repair

### US.4.3 View Past Repair Details
As the owner of a car (user) I would like to be able see the details for a repair in case I need to repeat the repair.

#### Requires
- US.4.1

#### Preconditions
- User viewing repairs section of car profile

#### Main Flow
1. User selects a repair they want to know more about
2. App loads repair details
3. App shows title, date of completion, area of car, description, list of parts and images and files

### US.4.4 Edit Past Repair
As the owner of a car (user) I would like to be able to edit an existing past repair to rectify errors or add additional information.

#### Requires
- US.4.3

#### Preconditions
- User viewing repair details

#### Main Flow
1. User asks app to edit repair
2. App enables editing for repair
3. User alters title, date of completion, description, area of vehicle, adds or removes parts and adds or removes files and images
4. User asks app to save updated information
5. App saves information and disables editing for repair

### US.4.5 Delete Past Repair
As the owner of a car (user) I would like to be able to delete an existing past repair to rectify errors.

#### Requires
- US.4.4

#### Preconditions
- User viewing repair details

#### Main Flow
1. User asks app to edit repair
2. App enables editing for repair
3. User asks app to delete repair
4. App asks user to confirm
5. User confirms
6. App removes information related to repair
7. App shows user updated list of past repairs

### US.4.6 List Planned Repairs
As the owner of a car (user) I would like to be able to list all the repairs I have planned for a car so that I can take on the most urgent ones.

#### Extends
- US.4.1

#### Preconditions
- User viewing repair section

#### Main Flow
1. App loads past and planned repairs
2. App shows planned repairs followed by past repairs
3. App shows for each planned repair the title, area of the car and urgency level (low, medium, high)
4. App sorts planned repairs descending by urgency from high to low

### US.4.7 Plan Repair
As the owner of a car (user) I would like to be able to plan a new repair so that I can prepare for the repair and remember to perform it.

#### Requires
- US.4.6

#### Preconditions
- User viewing repair section

#### Main Flow
1. User asks app to plan a new repair
2. User enters title, area of car, urgency of repair and optional description
3. Optionally for each part required for the repair the user enters a title and an optional web-link
4. User adds optional pictures and files.
5. User asks app to save information
6. App saves provided information as new planned repair

### US.4.8 View Planned Repair Details
As the owner of a car (user) I would like to see the details of a planned repair so that I can use the included information to help me perform it.

#### Requires
- US.4.6

#### Preconditions
- User viewing repair section

#### Main Flow
1. User selects planned repair
2. App loads details for planned repair
3. App shows title, date of last update, area of car, urgency of repair, optional description, optional list of parts and optional pictures and files.

### US.4.9 Edit Planned Repair
As the owner of a car (user) I would like to edit the details of a planned repair so that I can extend and rectify its related information.

#### Requires
- US.4.8

#### Preconditions
- User viewing planned repair details

#### Main Flow
1. User asks app to edit details
2. App enables editing of information
3. User edits title, area of car, urgency of repair, optional description, adds or removes parts and adds or removes pictures and files.
4. User asks app to save updated information
5. App saves information and updates date of last update
6. App shows updated details for planned repair

### US.4.10 Delete Planned Repair
As the owner of a car (user) I would like to delete a planned repair in case it is no longer required.

#### Requires
- US.4.9

#### Preconditions
- User viewing planned repair details in edit mode

#### Main Flow
1. User asks app to delete planned repair
2. App asks for confirmation
3. User confirms
4. App deletes planned repair and all its related information
5. App shows list of planned and past repairs

### US.4.11 Complete Planned Repair
As the owner of a car (user) I would like to complete a planned repair and convert it to a past repair so that I can easily reuse the existing information to track the repair.

#### Requires
- US.4.8

#### Preconditions
- User viewing planned repair details

#### Main Flow
1. User asks app to mark repair as completed 
2. App asks for confirmation
3. User confirms
4. App marks the repair as complete and uses current date as date for the repair completion
5. App shows details of tracked past repair

### US.4.12 Reopen Past Repair
As the owner of a car (user) I would like to reopen a past repair and convert it to a planned repair so that I do not have to reenter all the information in case a repair turns out to not have been completed successfully.

#### Requires
- US.4.4
- US.4.8

#### Preconditions
- User viewing past repair details in edit mode

#### Main Flow
1. User asks app to reopen repair
2. App asks for confirmation
3. User confirms
4. App marks repair as not complete and uses current date as date of last update
5. App shows details of planned repair

### US.4.13 Mark Past Repair as Modification
As the owner of a car (user) I want to mark a past repair as a modification so that I can distinguish between the alterations to the vehicle that preserve it and the ones that enhance it.

#### Extends
- US.4.3
- US.4.4

#### Preconditions
- User viewing past repair details in edit mode

#### Main Flow
1. User marks repair as modification
2. User asks app to save updated repair
3. App saves repair as marked as modification
4. App shows repair details with badge indicating that it is a modification

### US.4.14 Mark Planned Repair as Modification
As the owner of a car (user) I want to mark a planned repair as a modification so that I can distinguish between the alterations to the vehicle that preserve it and the ones that enhance it.

#### Extends
- US.4.8
- US.4.9

#### Preconditions
- User viewing planned repair details in edit mode

#### Main Flow
1. User marks repair as modification
2. User asks app to save updated repair
3. App saves repair as marked as modification and updates date of last update
4. App shows repair details with badge indicating that it is a modification

### US.4.15 List Planned and Past Repairs and Modifications
As the owner of a car (user) I want to see all past and planned repairs and modifications in one place while grouped by planned, past and repair, modification so that I can easily track the work on my car.

#### Extends
- US.4.6

#### Preconditions
- User views repair section

#### Main Flow
1. App loads past and planned repairs and modifications
2. App shows planned repairs followed by past repairs
3. App shows control to switch between repairs and modifications
4. User switches to modifications
5. App shows planned modifications followed by past modifications
6. App shows for each planned modification the title, area of the car and urgency level (low, medium, high)
7. App shows for each past modification the title, area of the car and date of completion 
8. App sorts planned modifications descending by urgency from high to low and past modifications descending by date of completion

## E.5 AI Assistant
The Carful AI assistant helps car owners to easily create maintenance schedules for their cars, generate step-by-step instructions for maintenance tasks, repairs and modifications and uses the maintenance and repair history as well as provided workshop manuals to provide detailed answers to questions by the owner.

### US.5.1 Add Workshop Manuals
As the owner of a car (user) I want to provide workshop manuals for a car so that I and the AI assistant can access them easily and use them during repairs and maintenance tasks.

#### Requires
- US.2.3

#### Preconditions
- User viewing car profile

#### Main Flow
1. User goes to files section
2. User selects to add workshop manuals to the profile
3. App opens file picker
4. User selects one or more pdf files containing workshop manuals for the car
5. App stores the files and makes them accessible to the AI assistant
6. App shows files under workshop manuals section

### US.5.2 View Workshop Manuals
As the owner of a car (user) I want to view workshop manuals I have added to a car profile so that I can use it to help me during repairs and maintenance.

#### Requires
- US.5.1

#### Preconditions
- User has added a workshop manual
- User viewing a car profile

#### Main Flow
1. User selects a workshop manual to view
2. App opens the pdf viewer for the selected manual
3. User reads the workshop manual
4. User closes the pdf viewer
5. App shows car profile

### US.5.3 Remove Workshop Manuals
As the owner of a car (user) I want to remove outdated or false workshop manuals so that the information for my car is correct.

#### Requires
- US.5.1

#### Preconditions
- User has added a workshop manual

#### Main Flow
1. User selects workshop manual to delete
2. App asks for confirmation
3. User confirms
4. App removes workshop manual from profile
5. App shows car profile without the manual

### US.5.4 Generate Maintenance Schedule
As the owner of a car (user) I want the AI assistant to generate a maintenance schedule for a car based on the provided workshop manuals so that I do not have to create the schedule myself.

#### Requires
- US.5.1

#### Preconditions
- User has added workshop manuals for the car
- User viewing car profile

#### Main Flow
1. User opens maintenance section for profile
2. User asks app to generate maintenance schedule for the car
3. App asks AI assistant to generate remaining maintenance schedule based on workshop manuals and existing maintenance schedule items
4. AI assistant generates remaining schedule
5. App shows suggested maintenance items
6. User selects maintenance items to add to the schedule
7. App updates maintenance schedule and displays it

### US.5.5 Ask AI Assistant
As the owner of a car (user) I want the AI assistant to answer me questions about my car using the workshop manuals, repair history and maintenance schedule so that I can quickly determine the state of my vehicle and plan work on it.

#### Requires
- US.5.1

#### Preconditions
- User has added workshop manuals for the car
- User viewing car profile

#### Main Flow
1. User opens AI assistant
2. App generates context for assistant using profile, past repairs, maintenance schedule and workshop manuals
3. User asks question to assistant
4. AI assistant uses context and web search to answer question if possible
5. User asks follow up questions
6. Repeat 4 and 5 until user closes the assistant
7. App shows profile

## E.6 Onboarding Guide
As a user who has just installed the Carful app I want to be guided through the setup of the first car and learn about the functioning of the app by going through a brief onboarding guide in order to be able to quickly start using the app.

### Requires
- E.1, E.2, E.3, E.4, E.5

### US.6.1 Enter Vehicle Details
As a user who has just installed the Carful app I want to be guided through adding my first car so that I can start extending its profile.

#### Preconditions
- Carful app installed

#### Main Flow
1. User launches the app
2. App welcomes the user
3. App asks the user for the Make, Model, Year, Engine and current mileage of the first car to add
4. User enters details in through text fields and date selector
5. App asks user if they want to add a picture
6. User selects an image from their image gallery
7. App displays created vehicle's profile

### US.6.2 Setup AI features
As a user I want to be able to enable AI features so that I can quickly generate plans and ask questions about my vehicles.

#### Requires
- US.6.1

#### Main Flow
1. App asks user if they want to enable AI features
2. User confirms
3. App asks user if they want to provide documents for customising the AI
4. User selects workshop manual from file picker
5. App uses provided documents to customise the AI

### US.6.3 Generate Maintenance Schedule
As a user I want to be guided through the generation of a maintenance schedule so that I know how to document future maintenance work.

#### Requires
- US.6.2

#### Main Flow
1. App asks the user if they want the AI to generate a maintenance schedule
2. User confirms or skips
3. If user confirms, app asks AI to generate remaining maintenance schedule based on workshop manuals
4. If AI succeeds, app presents maintenance schedule to the user
5. App asks user if they want to update the schedule with past work that has been performed
6. User documents date and mileage for one or more maintenance works that have been performed

### US.6.4 Document Past Repair
As a user I want to be guided through the documentation of a past repair so that I know how to document other repairs.

#### Requires
- US.6.3

#### Main Flow
1. App asks user if they want to document a past repair they have performed
2. User confirms, enters a title, selects area of vehicle (engine, chassis, body, suspension, electrics, interior, other), enters date of completion and optional detailed description
3. App displays documented repair

### US.6.5 Plan Future Repair
As a user I want to be guided through the planning of a future repair so that I know how to plan other future repairs.

#### Requires
- US.6.4

#### Main Flow
1. App asks if user wants to plan a future repair
2. User confirms, enters a title, selects area of vehicle (engine, chassis, body, suspension, electrics, interior, other), selects urgency (low, medium, high) and enters optional description
3. App asks user if they want to add any parts that will be required during the repair
4. User adds one or more parts including title and optional web-link
5. App asks user if they want to add files or images
6. User adds files and images to the planned repair
7. App displays the planned repair including area of vehicle, description, parts list, files and images

### US.6.6 Complete Onboarding
As a user I want to be notified that I have completed the onboarding and access the application.

#### Main Flow
1. App congratulates the user for completing the onboarding
2. App asks user if they want to start using the app
3. User confirms
4. App closes onboarding and shows list of car profiles