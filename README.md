MushroomSpot iOS app used for mushroom spotting while hiking, traveling, etc. Users can check out different mushrooms, their details, and sightings as well as add their sightings.

Couple of notes:

- Used UIKit as I have more experience then with SwiftUI (using SwiftUI for the last 9 months), hope it's not a problem
- Used only 2 libraries which was added to project via SPM - SnapKit (for constraints) and SDWebImage (downloading images).
- Most of UI done in code (mushrooms list, details and user profile) by using SnapKit and login using XIB - in production app I wouldn't mix and match these 2 approaches but decided to do it this way just to show you expertise with creating UI both ways (programatically and using XIB/storyboard)
- Used MVVM-C which is basically MVVM with coordinators (coordinators are responsible for navigation between screens)
- Used Combine (worked with RxSwift but long time ago). Worked with async / await on the last project and I would probably rewrite network layer to use async / await instead Combine.
- Project structure - like to have a couple of main folders and put everything under them:
  - AppDelegate - contains only AppDelegate
  - Common - contains thing common to the whole app like protocols, extensions, property wrappers, reusable views, DAL and so on.
  - Resources - contains all resources (like assets, localization, data model etc)
  - Screens - contains app screens
