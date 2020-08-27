# Flutter Rest Starter

My Flutter starter application for projects with a REST backend.

The main aim of this package is to get you up and running as fast as possible on your next Flutter project without all the hassle of initial project setup.

* **NOTE**: May be a bit opinionated in the packages and style being used

## Getting Started
1. Clone this repo

2. Run `flutter pub get` to fetch dependencies

3. Now to change your app's package name / bundle identifier in both Android and iOS manifests, run `flutter pub run change_app_package_name:main <com.new.package.name>`. 

    * This step makes use of [change_app_package_name](https://pub.dev/packages/change_app_package_name), go give the package some love.

4. Next you'll need to change your app's user-readable label - the `CFBundleName` and/or `CFBundleDisplayName` within `Info.plist` (for iOS) and `android:label` field in your application node in `AndroidManifest.xml` (for Android). 

    I'm afraid this step is manual; would be cool if `change_app_package_name` could do this for you. I'll consider submitting a PR to the package's repo if this repo gets to 25 Stars - so get busy smashing that Star Button.

    **NOTE**: You'll also need to change your package `name` and `description` within `pubspec.yaml`
    
5. Then we'll auto generate your app launcher icons using [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package.
    * Copy the image you want to make your launcher icons out of to `assets/icon/icon.png`
    * Now run `flutter pub run flutter_launcher_icons:main`. This command will auto generate Android and iOS launcher icons for the different DPIs and place them in their respective resource directories.

    **NOTE**: Check the package documentation for more configuration options on how to generate launcher icons and update your `pubspec.yaml` accordingly. For example, you may want to have different icons for different platforms since Android allows you to use a transparent icon and iOS doesn't. 

6. We'll then generate native splash screens for both of our platforms to be shown before our app loads, and for this we'll use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash).
    * Copy the image you want to be shown at the center of your splash screen to `assets/splash/splash.png`
    * To change the background color of your splash screen go to your `pubspec.yaml` under `flutter_native_splash -> color` and put your preferred color code. Default is white.
    * Finally run `flutter pub pub run flutter_native_splash:create` to generate your resources and update your manifest files.

7. Before releasing your Android app, make sure to sign it by:
    * [Generating a keystore file](https://flutter.dev/docs/deployment/android#create-a-keystore) if you don't already have one. If you do, go to the next step.
    * Go to `android/key.properties` and include your keystore path, alias and password.

8. Firebase Reporting (OPTIONAL - though strongly suggested). 

    In this step we are going to integrate different Firebase Reporting Tools into your app including [Firebase Analytics](https://firebase.google.com/products/analytics), [Firebase Performance](https://firebase.google.com/products/performance/) and [Crashlytics](https://firebase.google.com/products/crashlytics/).
    
    * Merge branch `firebase_reporting` into your main branch. Feel free to delete the branch after this step.
    * Create your Firebase project
    * Download your `GoogleService-Info.plist` & `google-services.json` and drop them into their corresponding folders for iOS and Android. I've `.gitignore'd` these files so that you won't by any chance have them checked into your VCS by mistake.
    * Well, that's it. You're done! No configuration needed, I've already done that for you.
    
    **NOTE:** With this step, we'll also have integrated into your HTTP Client [dio_firebase_performance](https://pub.dev/packages/dio_firebase_performance) which is a [Dio Interceptor](https://pub.dev/packages/dio#interceptors) that will measure the  performance of all your HTTP calls to the server and report the stats to Firebase. 

9. Hunt down any `TODOs` within the lib folder and get that sorted.

10. Now go start working on your app.

11. Profit!

    <img height=200 src="https://melmagazine.com/wp-content/uploads/2019/07/Screen-Shot-2019-07-31-at-5.47.12-PM.png">


## Packages used 
* [change_app_package_name](https://pub.dev/packages/change_app_package_name) - Change App Package Name with single command. It makes the process very easy and fast.

* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - A command-line tool which simplifies the task of updating your Flutter app's launcher icon.

* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) - Automatically generates native code for adding splash screens in Android and iOS. Customize with specific platform, background color and splash image.

* [dio](https://pub.dev/packages/dio) - The best HTTP Client for Flutter IMO. Reusable interceptors, amirite?

* [dio_http_cache](https://pub.dev/packages/dio_http_cache) - Dio interceptor to cache requests. Intercepts requests to respond with cached data and responses to cache received remote data. Very configurable.

* [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) - Dio interceptor that prettily prints to console HTTP requests and responses going through Dio

* [flutter_stetho](https://pub.dev/packages/flutter_stetho) - Enables you to inspect http calls the way you would for web apps - in Chrome Dev Tools. Wraps all http calls and report information to the Chrome Dev Tools via the Stetho package from Facebook. It's a shame it only works for Android and not iOS.
[dio_log](https://pub.dev/packages/dio_log) - would be a great alternative to Stetho. It's a Dio Interceptor that presents your request & response logs within your app's UI

* [freezed](https://pub.dev/packages/freezed) - Simple yet powerful code generator for immutable classes with all the good stuff like unions/pattern-matching/copy etc. Made by [Remi Rousselet](https://github.com/rrousselGit), the creator & maintainer of Provider. Can work with [json_serializable](https://pub.dev/packages/json_serializable) for all your `fromJson()` and `toJson()` needs.

* [firebase_analytics](https://pub.dev/packages/firebase_analytics) (OPTIONAL) - Flutter plugin for Google Analytics for Firebase, an app measurement solution that provides insight on app usage and user engagement on Android and iOS.

* [firebase_performance](https://pub.dev/packages/firebase_performance) (OPTIONAL) - Flutter plugin for Google Performance Monitoring for Firebase, an app measurement solution that monitors traces and HTTP/S network requests on Android and iOS.

* [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) (OPTIONAL) - Flutter plugin for Firebase Crashlytics. It reports uncaught errors to the Firebase console.

* [dio_firebase_performance](https://pub.dev/packages/dio_firebase_performance) (OPTIONAL) - Dio's Interceptor implementation that sends http request metric data to Firebase.