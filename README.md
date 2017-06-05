**ReadMe**

This project has been implemented in Swift 3 and all the views and viewcontrollers are also implemented through code using Autolayout (No Storyboard file is used to make UI). 

This project contains a PageViewController inside a NavigationController and the PageViewController has a ProfileView in the left side, FriendsList in the center and a configMenu in the right all using MVVM pattern and demonstrates how MVVM helps in writing a more readable and maintainable code compared to typical MVC style.

The FriendsList contains all dummy values except a few url's used to download pictures from the internet. 

The ProfileView on the left is meant for UserProfile, the cells here are clickable and the values entered are being stored in UserDefaults/Keychain

The ConfigView on the right is just an example of updating UI based on different selected configuration types, Here also all the details edited/selected by user are being stored locally.

To run the example project, clone the repo, and run pod install.

## License ##

The MIT License (MIT)

Copyright (c) 2017 Pavan Kumar Valluru

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.