# Flutter Rest Starter

My Flutter starter application for projects with a REST backend.

The main aim of this package is to get you up and running as fast as possible on your next Flutter project without all the hassle of initial project setup.

* **NOTE**: May be a bit opinionated in the packages and style being used

## Getting Started
1. Clone this repo

2. Run `flutter pub get` to fetch dependencies

3. Now to change your app's package name / bundle identifier in both Android and iOS manifests, run `flutter run change_app_package_name:main <com.new.package.name>`. 

    * This step makes use of [change_app_package_name](https://pub.dev/packages/change_app_package_name), go give the package some love.

4. Next you'll need to change your app's `CFBundleName` (for iOS) and `android:label` (for Android). I'm afraid this step is manual; would be cool if `change_app_package_name` could do this for you. I'm considering submitting a PR to the package's repo.

5. Then we'll auto generate your app lancher icons using [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package.
    * Copy the image you want to make your launcher icons out of to `assets/icon/icon.png`
    * Now run `flutter pub run flutter_launcher_icons:main`. This command will auto generate Android and iOS launcher icons for the different DPIs and place them in their respective resource directories.

* **NOTE**: Check the package documentation for more configuration options on how to generate launcher icons and update your `pubspec.yaml` accordingly. For example, you may want to have different icons for different platforms since Android allows you to use a transparent icon and iOS doesn't. 

6. We'll then generate native splash screens for both of our platforms to be shown before our app loads, and for this we'll use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash).
    * Copy the image you want to be shown at the center of your splash screen to `assets/splash/splash.png`
    * To change the background color of your splash screen go to your `pubspec.yaml` under `flutter_native_splash -> color` and put your prefered color code. Default is white.
    * Finally run `flutter pub pub run flutter_native_splash:create` to generate your resources and update your manifest files.

7. Before releasing your app, make sure to sign it by:
    * [Generate a keystore file](https://flutter.dev/docs/deployment/android#create-a-keystore).
    * Go to `android/key.properties` and include your kestore path, alias and password.

8. Now go start working on your app.

9. Profit!

    <img height=200 src="https://melmagazine.com/wp-content/uploads/2019/07/Screen-Shot-2019-07-31-at-5.47.12-PM.png">


## Packages used 
* [change_app_package_name](https://pub.dev/packages/change_app_package_name) - Change App Package Name with single command. It makes the process very easy and fast.

* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - A command-line tool which simplifies the task of updating your Flutter app's launcher icon.

* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) - Automatically generates native code for adding splash screens in Android and iOS. Customize with specific platform, background color and splash image.

* [dio](https://pub.dev/packages/dio) - The best HTTP Client for Flutter IMO. Reusable interceptors, amirite?

* [dio_http_cache](https://pub.dev/packages/dio_http_cache) - Dio interceptor to cache requests. Intercepts requests to respond with cached data and responses to cache received remote data. Very configurable.

* [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) - Dio interceptor that prettily prints to console HTTP requests and responses going through Dio

* [flutter_stetho](https://pub.dev/packages/flutter_stetho) - Enables you to inspect http calls the way you would for web apps - in Chrome Dev Tools. Wraps all http calls and report information to the Chrome Dev Tools via the Stetho package from Facebook. It's a shame it only works for Android and not iOS.
[dio_log](https://pub.dev/packages/dio_log) - would be a great alternative to Stetho. It's a Dio Interceptor that presents your requests/responses within your app UI

* [freezed](https://pub.dev/packages/freezed) - Simple yet powerful code generator for immutable classes with all the good stuff like unions/pattern-matching/copy etc. Made by [Remi Rousselet](https://github.com/rrousselGit), the creator & maintainer of Provider. Can work with [json_serializable](https://pub.dev/packages/json_serializable) for all your `fromJson()` and `toJson()` needs.