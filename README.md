# tvm
A test app based on TVMaze API.

The project was created using XCode 15.4 for iOS 15.0+.
I used MVVM-C ( with coordinators ), because it's the most confortable to me and I think it's apropriate for this kind of small project, 
which allows implement tests and reactive programming easily.
Due to the short time, I didn't put neither of them. 
I used UIKit, because it's the most confortable to me. I've been working with SwiftUI in some projects in the last 4 years, but, still 
feeling more confortable using UKit for quick solutions in a short time like tests.
My option was to use code-view design, because I think it's the best way to work with UIKit.

The View classes are responsible to create the UI, set properties and receive user interactions.
The ViewModel classes get user interations from Views, request data from lower levels, prepare the responses and deliver the results to the View.
The Models define the domain struct and deliver some computed properties.
The Service layer execute the requests from the API and deliver the results to ViewModels.
The Cordinator class is responsible to the app navigation.

Tha ViewModels are injected in the ViewControllers to make easy create mockups for tests.
UIColor extension and Loading component were reused from previous projects. All other classes were created from scratch for this project.
