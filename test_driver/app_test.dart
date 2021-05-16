/*import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/capture_screen.dart';
import 'package:screenshots/config.dart';
import 'package:test/test.dart';

void main() {
  final config = Config().config;

  group('MyApp', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Take home screenshot ', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.text('Flutter REST Starter'));
        await screenshot(driver, config, 'home_screen');
      });
    });

  });
}*/
