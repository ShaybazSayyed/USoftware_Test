import XCTest

final class ContentViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testCharacterListTextExists() {
        let characterListText = app.staticTexts["Characters"] // Updated to match navigation title
        XCTAssertTrue(characterListText.waitForExistence(timeout: 5), "'Characters' text not found!")
    }

    func testNavigationTitleIsCharacters() {
        let navTitle = app.navigationBars["Characters"]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 5), "Navigation title 'Characters' not found!")
    }
}
