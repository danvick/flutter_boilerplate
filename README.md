# Flutter Boilerplate

My Flutter starter application for projects with a REST backend.

The main aim of this package is to get you up and running as fast as possible on your next Flutter project without all the hassle of initial project setup.

* **NOTE**: May be a bit opinionated in the packages and style being used

## Getting Started
1. Create your project using this repo by either:

    * On Github click "Use this template" button which will allow you to create your project using this repo as your baseline, or
    * Clone this repo to your local machine

2. Run `flutter pub get` to fetch dependencies

3. Now to change your app's package name / bundle identifier in both Android and iOS manifests, run `flutter pub run change_app_package_name:main <com.new.package.name>`. 

    * This step makes use of [change_app_package_name](https://pub.dev/packages/change_app_package_name), go give the package some love.

4. Next you'll need to change your app's user-readable label - the `CFBundleName` and/or `CFBundleDisplayName` within `Info.plist` (for iOS) and `android:label` field in your application node in `AndroidManifest.xml` (for Android). 

    I'm afraid this step is manual; would be cool if `change_app_package_name` could do this for you. I'll consider submitting a PR to the package's repo if this repo gets to 25 Stars - so get busy smashing that Star Button.

    **NOTE**: You'll also need to change your package `name` and `description` within `pubspec.yaml`

5. Then we'll auto generate your app launcher icons using [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package.
    * Copy the image you want to make your launcher icons out of to `assets/icon/icon.png`
    * Now run `flutter pub run flutter_launcher_icons:main`. This command will auto generate Android and iOS launcher icons for the different DPIs and place them in their respective resource directories.

    **NOTE**: Check the [package documentation](https://pub.dev/packages/flutter_launcher_icons#book-guide) for more configuration options on how to generate launcher icons and update your `pubspec.yaml` accordingly. 
   For example, you may want to have different icons for different platforms since Android allows you to use a transparent icon and iOS doesn't. 
   However, the default configuration included in this template will be sufficient in most cases

6. We'll then generate native splash screens for both of our platforms to be shown before our app loads, and for this we'll use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash).
    * Copy the image you want to be shown at the center of your splash screen to `assets/splash/splash.png`
    * To change the background color of your splash screen go to your `pubspec.yaml` under `flutter_native_splash -> color` and put your preferred color code. Default is white.
    * Finally run `flutter pub pub run flutter_native_splash:create` to generate your resources and update your manifest files.
   
7. Environment variables
   
   We'll make use of [flutter_dotenv package](https://pub.dev/packages/flutter_dotenv) to store and retrieve our app configuration from `.env` files. 
   This will allow us to easily switch between different app configurations when running the app under different environments like production, staging, or debug mode.
   
   All `.env` files are stored in `environment/` directory at the root of your project.
   To set up a new environment create an new file with a `.env` extension under `environment` directory (e.g. `.env` or `dev.env` or `staging.env`) then copy the contents of `.env-sample` and populate as needed

   Loading your environment file is as easy as: 
    ```dart
    import 'package:flutter_dotenv/flutter_dotenv.dart';
    ...
    await dotenv.load('.env');
    ```

    And make use of environment variables like so:
    ```dart
    import 'package:flutter_dotenv/flutter_dotenv.dart';
    ...
    final serverUrl = dotenv.env['SERVER_URL'];
    ```

   **NOTE:** All `.env` files are `.gitignored` by default since they may contain sensitive information such as paths, keys and such. 
   
8. Firebase Reporting. 

    In this step we are going to integrate different Firebase Reporting Tools into your app including [Firebase Analytics](https://firebase.google.com/products/analytics), [Firebase Performance](https://firebase.google.com/products/performance/) and [Crashlytics](https://firebase.google.com/products/crashlytics/).
   
    * Create your Firebase project
    * Download your `GoogleService-Info.plist` & `google-services.json` and drop them into their corresponding folders for iOS and Android. I've `.gitignore'd` these files so that you won't by any chance have them checked into your VCS by mistake.
    * Well, that's it. You're done! No configuration needed, I've already done that for you.

    **NOTES:**
   * All the Firebase Services we're making use of in this project are free of charge - at least at the time of writing - so they will not attract any charges.
   * With this step, we'll also have integrated [Firebase Performance Monitoring](https://firebase.google.com/products/performance/) into your HTTP Client using [dio_firebase_performance](https://pub.dev/packages/dio_firebase_performance) which is a [Dio Interceptor](https://pub.dev/packages/dio#interceptors) that will measure the  performance of all your HTTP calls and report the stats to Firebase. 

9. Hunt down any `TODOs` within the lib folder and get that sorted.

10. Now go start working on your app.

11. Before releasing your Android app, make sure to sign it by:
   * [Generating a keystore file](https://flutter.dev/docs/deployment/android#create-a-keystore) if you don't already have one. If you do, go to the next step.
   * Go to `android/key.properties` and include your keystore path, alias and password.

12. Profit!

     <img height=200 src="https://melmagazine.com/wp-content/uploads/2019/07/Screen-Shot-2019-07-31-at-5.47.12-PM.png">

### Taking automated screenshots - work in progress
Included in this template, is the [screenshots command-line utility and package](https://pub.dev/packages/screenshots) for automatically capturing screenshot images of your app during integration testing to be uploaded to the different app stores for your app. The package plays nice with [fastlane](https://fastlane.tools) but can also be used indipendently.

1. Follow the [instructions here](https://pub.dev/packages/screenshots#installation) to install the screenshots command-line utility on your computer.
2. Go to `screenshots.yaml` file to configure how your app screenshots will be taken. The configuration options available include but are not limited to: which devices to user for Android and iOS, Device orientations, Locales etc. Find more config options [here](https://pub.dev/packages/screenshots#configuration). 
3. In your integration tests:
    * Import screenshots functions:
    ```dart
    import 'package:screenshots/capture_screen.dart';
    import 'package:screenshots/config.dart';
    ```
    * Get screenshots utility configuration: `final config = Config().config;`
    * To take a screenshot at different stages of the integration tests, call the screeshot function passing in the driver, screenshots config and name of the screenshot. e.g. 
    ```dart
    await screenshot(driver, config, 'home_screen');
    ```
4. In your terminal, execute the `screenshots` to get your screenshots.

## Packages used 
* [change_app_package_name](https://pub.dev/packages/change_app_package_name) - Change App Package Name with single command. It makes the process very easy and fast.
* [dio](https://pub.dev/packages/dio) - The best HTTP Client for Flutter IMO. Reusable interceptors, amirite?
* [dio_firebase_performance](https://pub.dev/packages/dio_firebase_performance) - Dio's Interceptor implementation that sends http request metric data to Firebase.
* [dio_http_cache](https://pub.dev/packages/dio_http_cache) - Dio interceptor to cache requests. Intercepts requests to respond with cached data and responses to cache received remote data. Very configurable.
* [dio_log](https://pub.dev/packages/dio_log) - It's a Dio Interceptor that presents your request & response logs within your app's UI
* [firebase_analytics](https://pub.dev/packages/firebase_analytics) - Flutter plugin for Google Analytics for Firebase, an app measurement solution that provides insight on app usage and user engagement on Android and iOS.
* [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) - Flutter plugin for Firebase Crashlytics. It reports uncaught errors to the Firebase console.
* [firebase_performance](https://pub.dev/packages/firebase_performance) - Flutter plugin for Google Performance Monitoring for Firebase, an app measurement solution that monitors traces and HTTP/S network requests on Android and iOS.
* [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) - Load configuration at runtime from a `.env` file which can be used throughout the application.
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - A command-line tool which simplifies the task of updating your Flutter app's launcher icon.
* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) - Automatically generates native code for adding splash screens in Android and iOS. Customize with specific platform, background color and splash image.
* [freezed](https://pub.dev/packages/freezed) - Simple yet powerful code generator for immutable classes with all the good stuff like unions/pattern-matching/copy etc. Made by [Remi Rousselet](https://github.com/rrousselGit), the creator & maintainer of Provider. Can work with [json_serializable](https://pub.dev/packages/json_serializable) for all your `fromJson()` and `toJson()` needs.
* [screenshots](https://pub.dev/packages/screenshots) - Screenshots is a standalone command line utility and package for capturing screenshot images for Flutter.
* [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) - Dio interceptor that prettily prints to console HTTP requests and responses going through Dio

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png)](https://buymeacoff.ee/wb5M9y2Sz)

