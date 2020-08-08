import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Add Projects", () {
    FlutterDriver driver;
    final sideDrawer = find.byValueKey('drawer');
    final drawerProjects = find.byValueKey('drawerProjects');
    final addProject = find.byValueKey('addProject');
    final titleAddProject = find.byValueKey('titleAddProject');

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Test Add Project screen display on click of Add Project button',
        () async {
      await driver.tap(sideDrawer);
      await driver.tap(drawerProjects);
      await driver.tap(addProject);
      expect(await driver.getText(titleAddProject), "Add Project");
      //Need to clear the page from stack else give problem with other tests
      await driver.tap(find.pageBack());
    });

    test('Enter Project Details and verify on Side drawer screen', () async {
      await driver.tap(sideDrawer);
      await driver.tap(drawerProjects);
      await driver.tap(addProject);

      var addProjectNameField = find.byValueKey('textFormProjectName');
      await driver.tap(addProjectNameField);
      await driver.enterText("Personal");

      var addProjectButton = find.byValueKey('addProjectButton');
      await driver.tap(addProjectButton);

      await driver.tap(sideDrawer);
      await driver.tap(drawerProjects);

      var personalProject = find.byValueKey('Personal_2');
      expect(await driver.getText(personalProject), "Personal");
      //TODO Match the project color as well
    });
  });
}