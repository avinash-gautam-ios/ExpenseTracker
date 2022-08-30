# ExpenseTracker

## About
Expense Tracker is an application, which helps you keep track of expenses. You can add your income or expense made on a particular day. 
This can also help in keeping track of all the expenses and viewing summary of all the expenses.

The features which you can use as part of the application inlcudes:

#### 1. Adding Expense
- You can use the add expense button on the home screen to add new transaction
- Simply, click on the `Add Transaction` button and it will take you to add transaction screen
- You can now see `Add Transaction` screen. On this screen, select the transaction type, add description and amount for your transaction
- Once done, press the `Save Transaction` button
- You can see your new transaction added on the home screen

![Simulator Screen Shot - iPhone 12 - 2022-08-31 at 02 32 54](https://user-images.githubusercontent.com/12506196/187550088-515c7343-452d-4eae-bf9d-d6d9dc1ed4dc.png)

![Simulator Screen Shot - iPhone 12 - 2022-08-31 at 02 27 18](https://user-images.githubusercontent.com/12506196/187550100-facab91a-c380-482c-a296-496b1e0d2b46.png)


#### 2. Deleting Expense
- You can simply left swipe on any transaction item on the homescreen to delete it. Please see the screenshot attached below

![Simulator Screen Shot - iPhone 12 - 2022-08-30 at 01 47 12](https://user-images.githubusercontent.com/12506196/187290859-175a79ab-f9b5-4029-9693-8e2637fbe2bd.png)


## Technical Decisions

### Architecture
VIPER was choosen as the overall architecture of the application. 
VIPER was given precedence over other architectures like MVVM was because of testability and its features such as single responsibility, etc.

Major components implemented as part of VIPER includes:
 - Presenter
 - Router
 - View
 - Interactor
 - Entity

The VIPER modules communicate with each other in the diagram shown below:

![component_interaction](https://user-images.githubusercontent.com/12506196/187287515-bd022937-20a2-4ea7-8ff0-94e4a30ffeae.png)

### Modules
#### Expense List
Expense list VIPER module is responsbile for listing the expenses. The communication between entities is shown below:

![expense_list_component](https://user-images.githubusercontent.com/12506196/187288985-b28f643e-a296-4f9b-82f9-4b3e0cee9448.png)

#### Add Expense
Add expense VIPER module is responsbile for adding transaction. The communication between entities is shown below:

![addexpense_component](https://user-images.githubusercontent.com/12506196/187289616-3ea35f84-3846-49f4-a4d6-af44445e4109.png)

### Classes
#### DatabaseHelper
This class works like a helper class to fetch or perform common operations on the database.

#### PersistenceContainer
This class takes care of loading the database into the memory.

### Future Scope of the application
Some new features can be added as part of the application such as:
- Sorting by amount
- Filter for a specific date
- Filter for a specific type of transaction

### Technical Improvements
Some items which can be worked upon and improved, there by increasing the overall app performance includes:
- Using NSFetchedResultsController for fetching transactions with tableview for smooth adding and deleting the transactions
- Some way to optimize summary computation, like not fetching all the records and running through them
- Using fetchLimit on fetching the transactions to not load a lot of data into memory, which might not be required
- Using some sort of currency formatter to format amount to display currencies. 
- Localization support to the app
 
