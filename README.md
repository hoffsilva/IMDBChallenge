
# Up Movies
Upcoming Movies is an iOS application that shows the upcomig movies from [The Movie Database (TMDb)](https://www.themoviedb.org/) Api.

## Project Description

   As a mobile engineer you've been tasked with the development of an app for cinephiles and movie hobbyists. This first version (MVP) of the app will be very simple and limited to show the list of upcoming movies. The app will be fed with content from The Movie Database ([TMDb])(https://www.themoviedb.org/). No design specs were given, so you're free to follow your UX and UI personal preferences. However the app should work both in landscape and portrait orientations. The choice of platform (iOS, Android, Xamarin) and development approach is also for you to decide based on previous experience and/or personal interest.

## Functional Requirements

   The first release of the app will be very limited in scope, but will serve as the foundation for future releases. It's expected that user will be able to:
* Scroll through the list of upcoming movies - including movie *name*, *poster or backdrop image*, *genre* and *release date*. List *should not be limited to show only the first 20 movies* as returned by the API.
* Select a specific movie to see details (name, poster image, genre, overview and release date).
* (Optional) Search for movies by entering a partial or full movie name.

## Technical Requirements
   You should see this project as an opportunity to create an app following modern development best practices (given your platform of choice), but also feel free to use your own app architecture preferences (coding standards, code organization, third-party libraries, etc).
   
   A TMDb API key is already available so you don't need to request your own: 1f54bd990f1cdfb230adb312546d765d.
   The API documentation and examples of use can be found here: * [https://developers.themoviedb.org/3](https://developers.themoviedb.org/3)
   Feel free to use package/dependency managers (ex: Maven, CocoaPods, etc) if you see fit.

## DELIVERABLES
   The project source code and dependencies should be made available in GitHub. Here are the steps you
should follow:
   1. Create a public repository on GitHub (create an account if you don't have one).
   2. Create a "development" branch and commit the code to it. Do not push the code to the master branch.
   3. Create a "screenshots" sub-folder and include at least two screenshots of the app.
   4. Include a README file that describes:
   * Special build instructions, if any
   * List of third-party libraries used and short description of why/how they were used
   5. Once the work is complete, create a pull request from "development" into "master" and send us the link. We will review your code and might ask you some questions directly on your pull request.

## Libraries

### Alamofire

* [Alamofire](https://github.com/Alamofire/Alamofire), I used Alamofire because it became the HTTP Requests manager easy.

### Unbox

* [Unbox](https://github.com/JohnSundell/Unbox), I used Unbox to help me work easily with JSON Objects.

### SDWebImage

* [SDWebImage](https://github.com/rs/SDWebImage), I used SDWebImage to do image cache.

### SwiftNotice

* [SwiftNotice](https://github.com/johnlui/SwiftNotice), I used SwiftNotice to show alerts with errors and informations messages for users.

### FCAlertView

* [FCAlertView](https://github.com/nimati/FCAlertView), I used FCAlertView to show alert with internet connection error message for users.

### FCAlertView

* [SwiftyPlistManager](https://github.com/rebeloper/SwiftyPlistManager), I used SwiftyPlistManager to help me work easily with plist persistence.


   
