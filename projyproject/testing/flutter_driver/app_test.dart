// import 'package:flutter_driver/driver_extension.dart';
// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   enableFlutterDriverExtension();

//   group('Flutter Driver demo', () {
//     FlutterDriver driver;

// // Connect to the Flutter driver before running any tests.
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });

// // Close the connection to the driver after the tests have completed.
//     tearDownAll(() async {
//       if (driver != null) {
//         await driver.close();
//       }
//     });

//     test('Flutter drive methods demo', () async {
//       await driver.tap(find.byValueKey('inputKeyString'));
//       await driver.enterText('Hello !');
//       await new Future.delayed(const Duration(seconds: 5));
//       await driver.waitFor(find.text('Hello !'));
//       await driver.enterText('World');
//       await new Future.delayed(const Duration(seconds: 5));
//       print('World');
//       await driver.tap(find.byValueKey('button'));
//       print('Button clicked');
//       await driver.waitFor(find.byValueKey('ScrollUntillHere'));
//       await driver.scrollIntoView(find.byValueKey('ScrollUntillHere'));
//       await driver.waitFor(find.text('Scroll till here'));
//       print('I found you buddy !');
//     });
//   });
// }
