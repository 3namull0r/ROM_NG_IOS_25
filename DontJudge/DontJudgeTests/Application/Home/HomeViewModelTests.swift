//
//  HomeViewModelTests.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//

import XCTest
@testable import DontJudge

final class HomeViewModelTests: XCTestCase {
  var mockService: MockBooksService!
  
  override func setUp() {
    super.setUp()
    mockService = MockBooksService()
    mockService.bookItemsToReturn = JSONLoader.load("BookItems", as: BookItems.self, in: Bundle(for: Self.self)).items ?? []
  }
  
  override func tearDown() {
    mockService = nil
    super.tearDown()
  }
  
  @MainActor
  func testSearchTextSuccessPopulatesViewModels() async {
    let viewModel = HomeViewModel(booksService: mockService)
    await viewModel.searchText(query: "test")
    
    XCTAssertEqual(viewModel.bookItems.count, 20)
    XCTAssertEqual(viewModel.carouselViewModel.thumbnailViewModels.count, 20)
    XCTAssertEqual(viewModel.bookListViewModel.rowViewModels.count, 20)
  }

  @MainActor
  func testSearchTextFailureSetsErrorMessage() async {
    let mockService = MockBooksService()
    mockService.shouldThrowError = true
    
    let viewModel = HomeViewModel(booksService: mockService)
    await viewModel.searchText(query: "fail")
    
    XCTAssertEqual(viewModel.carouselViewModel.subtitle, "We had a problem fetching the books")
  }
}
