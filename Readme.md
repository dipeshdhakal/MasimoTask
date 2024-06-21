# Masimo assignment documentation

## Compatibility 
- Xcode 15
- iOS 17


## 📱 App Goal
Create an iOS app to list, select and play devices.


## Requirements:
1. As a user, I should be able to view my devices.
2. As a user, I should be able to select an invoice.
3. As a user, I should be able to see selected device in my "now playing" tab.
4. As a user, I should be able to see device state (play pause) in devices list.
5. As a user, I should be able to update device state (play pause) from "now playing" screen.
6. As a user, I should be able to view latest and consistent selection / state across screens.
7. As a user, I should be able to switch between real and mock data.


## Architecture:
I have decided to build this app with simplified version of MVVM and clean architecture (reference: https://nalexn.github.io/clean-architecture-swiftui/). I have not strictly followed this article but made own adjustments and interpretations based on the requirements.

**MVVM:** With Combine and SwiftUI, bindings are very easy without any third party libraries. It is very difficult to argue against MVVM specially after SwiftUI where ViewModel is supposed to be state of your view and view reacts to state changes automatically.

**Clean code architecture:** The idea is to make the app modular so that it can be loosely coupled and tested independently. We have 3 layers in this app (presentation, domain and data). Each layer only depends on abstraction of inner layer. This makes testing easy as we can mock abstractions and also maintainable.

# Presentation Layer:
**Views:** Plain SwiftUI views to display UI and take user actions.
**ViewModels:** Logic needed to render views like set states, format data etc.

# Domain Layer:
Core business logic. In this project, we are getting data from different async calls and combining them to form UI friendly model. This layer is also respobsible for updating states of the data.

# Data Layer:
Responsible for fetching and storing data, creating relationships. In this project we are simply doing API calls and fetching data. We might also do data caching etc in this layer.


## Limitations / TODOs:
- Beautify UI. The app is built on basic native components to save development time and make use of native accessibility support.
- Localization. The app is hardcoded with strings in the code.
- UI testing.


## Demo / Screenshots:

Please find files in the screenshots folder.

