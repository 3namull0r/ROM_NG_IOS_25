//
//  DetailViewModelTest.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//
@testable import DontJudge
import XCTest

final class DetailViewModelTests: XCTestCase {
  var mockService: MockBooksService!
  let longDescription = """
    The Harry Potter books are the bestselling books of all time. In this fascinating study, Susan Gunelius analyzes every aspect of the brand phenomenon that is Harry Potter. Delving into price wars, box office revenue, and brand values, amongst other things, this is the story of the most incredible brand success there has ever been.
    """
  
  override func setUp() {
    super.setUp()
    mockService = MockBooksService()
    mockService.bookDetailToReturn = JSONLoader.load("BookDetail", as: BookDetail.self, in: Bundle(for: Self.self))
  }
  
  override func tearDown() {
    mockService = nil
    super.tearDown()
  }
  
  func testLoadDataSuccessSetsBookAndRows() async {
    let viewModel = DetailViewModel(id: "123", booksService: mockService)
    await viewModel.loadData()
    
    XCTAssertNil(viewModel.errorText)
    XCTAssertEqual(viewModel.detailRows.count, 6)
    XCTAssertEqual(viewModel.descriptionViewModel.detail, longDescription)
  }
  
  func testLoadDataFailureSetsErrorText() async {
    let mockService = MockBooksService()
    mockService.shouldThrowError = true
    
    let viewModel = DetailViewModel(id: "123", booksService: mockService)
    await viewModel.loadData()
    
    XCTAssertEqual(viewModel.errorText, "There was a problem loading the book details.")
  }
}
