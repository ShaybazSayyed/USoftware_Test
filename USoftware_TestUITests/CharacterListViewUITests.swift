import XCTest

final class CharacterListViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchEnvironment = ["UITesting": "true"] //  Ensures the app knows it's in UI test mode
        app.launch()

        let window = app.windows.firstMatch
        XCTAssertTrue(window.waitForExistence(timeout: 10), "App did not launch properly!")
    }


    func testCharacterSelectionNavigatesToDetailView() {
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "First list cell not found!")
        firstCell.tap()

        let detailTitle = app.staticTexts["Details"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 10), "Detail view did not appear!")
    }

  


}
