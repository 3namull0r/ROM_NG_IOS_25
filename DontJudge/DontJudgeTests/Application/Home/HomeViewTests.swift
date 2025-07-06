//
//  HomeViewTests.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//

import XCTest
import SnapshotTesting
@testable import DontJudge

final class HomeViewSnapshotTests: XCTestCase {
  var mockService: MockBooksService!
  var viewModel: HomeViewModel!
  
  override func setUp() {
    super.setUp()
    mockService = MockBooksService()
    mockService.bookItemsToReturn = JSONLoader.load("BookItems", as: BookItems.self, in: Bundle(for: Self.self)).items ?? []
    viewModel = HomeViewModel(booksService: mockService)
  }
  
  override func tearDown() {
    viewModel = nil
    mockService = nil
    super.tearDown()
  }
  
  func testHomeViewSnapshot() {
    let view = HomeView(viewModel: viewModel)
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhoneSe)))
  }
  
  @MainActor
  func testHomeViewSearchResultsCarouselSnapshot() async throws {
    let view = HomeView(viewModel: viewModel)
    await viewModel.searchText(query: "123")
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhoneSe)))
  }
  
  @MainActor
  func testHomeViewSearchResultsListSnapshot() async throws {
    let view = HomeView(viewModel: viewModel)
    viewModel.selectedView = .list
    await viewModel.searchText(query: "123")
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhoneSe)))
  }
  
  @MainActor
  func testSearchTextFailureSetsErrorMessage() async {
    mockService.shouldThrowError = true
    let view = HomeView(viewModel: viewModel)
    await viewModel.searchText(query: "fail")
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhoneSe)))
  }
  
}
