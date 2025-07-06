//
//  DontJudgeUITests.swift
//  DontJudgeUITests
//
//  Created by 3namull0r on 03/07/2025.
//

import XCTest

final class DontJudgeUITests: XCTestCase {
  
  private var app: XCUIApplication!
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }
  
  func testSearchAndTapOnResult() {
    // 1. Find and tap the search bar
    let searchBar = app.textFields["SearchBar"]
    XCTAssertTrue(searchBar.waitForExistence(timeout: 5))
    searchBar.tap()
    searchBar.typeText("Harry Potter")
    
    // 2. Wait for thumbnails to appear
    let thumbnails = app.images.matching(NSPredicate(format: "identifier CONTAINS %@", "Thumbnail_"))
    let firstResult = thumbnails.firstMatch
    XCTAssertTrue(firstResult.waitForExistence(timeout: 5), "Thumbnail did not appear")
    
    // 3. Tap using coordinate
    let coordinate = firstResult.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    coordinate.tap()
    
    // 4. Verify detail screen appears
    let detailTitle = app.staticTexts["DetailView"] // Make sure DetailView has this identifier set
    XCTAssertTrue(detailTitle.waitForExistence(timeout: 5), "Failed to navigate to detail view")
  }
}
