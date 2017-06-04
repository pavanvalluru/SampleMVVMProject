**ReadMe**

This project has been implemented in Swift 3 and all the views and viewcontrollers are also implemented through code using Autolayout. 

This project contains a PageViewController inside a NavigationController and the PageViewController has a ProfileView in the left side, FriendsList in the center and a configMenu in the right all using MVVM pattern and demonstrates how MVVM helps in writing a more readable and maintainable code compared to typical MVC style.

The FriendsList contains all dummy values except a few url's used to download pictures from the internet. 

The ProfileView on the left is meant for UserProfile, the cells here are clickable and the values entered are being stored in UserDefaults/Keychain

The ConfigView on the right is just an example of updating UI based on different selected configuration types, Here also all the details edited/selected by user are being stored locally.

To run the example project, clone the repo, and run pod install.