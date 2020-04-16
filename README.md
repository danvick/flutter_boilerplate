# Flutter Rest Starter

My Flutter starter application for projects with a REST backend. 
* **NOTE**: May be a bit opinionated in the packages and style being used

## Getting Started
TODO


## Packages used 
* [Dio](https://pub.dev/packages/dio) - The best HTTP Client for Flutter IMO. Reusable interceptors, amirite?

* [dio_http_cache](https://pub.dev/packages/dio_http_cache) - Dio interceptor to cache requests. Intercepts requests to respond with cached data and responses to cache received remote data. Very configurable.

* [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) - Dio interceptor that prettily prints to console HTTP requests and responses going through Dio

* [flutter_stetho](https://pub.dev/packages/flutter_stetho) - Enables you to inspect http calls the way you would for web apps - in Chrome Dev Tools. Wraps all http calls and report information to the Chrome Dev Tools via the Stetho package from Facebook. It's a shame it only works for Android and not iOS.

* [dio_log](https://pub.dev/packages/dio_log) - would be a great alternative to Stetho. It's a Dio Interceptor that presents your requests/responses on your app UI

* [freezed](https://pub.dev/packages/freezed) - Simple yet powerful code generator for immutable classes with all the good stuff like unions/pattern-matching/copy etc. Made by [Remi Rousselet](https://github.com/rrousselGit), the creator & maintainer of Provider. Can work with [json_serializable](https://pub.dev/packages/json_serializable) for all your `fromJson()` and `toJson()` needs.