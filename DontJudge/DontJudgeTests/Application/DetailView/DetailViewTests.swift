//
//  HomeViewTests.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//

import XCTest
import SnapshotTesting
@testable import DontJudge

final class DetailViewTests: XCTestCase {
  var mockService: MockBooksService!
  var viewModel: DetailViewModel!
  
  override func setUp() {
    super.setUp()
    mockService = MockBooksService()
    mockService.bookDetailToReturn = JSONLoader.load("BookDetail", as: BookDetail.self, in: Bundle(for: Self.self))
    viewModel = DetailViewModel(id: "123", booksService: mockService)
  }
  
  override func tearDown() {
    mockService = nil
    super.tearDown()
  }
  
  @MainActor
  func testDetailViewSnapshot() async throws {
    let view = DetailView(viewModel: viewModel)
      .frame(width: 375, height: 812)
    await viewModel.loadData()
    assertSnapshot(of: view, as: .image)
  }
  
  @MainActor
  func testDetailFailureSetsErrorMessage() async throws {
    mockService.shouldThrowError = true
    let view = DetailView(viewModel: viewModel)
      .frame(width: 375, height: 812)
    await viewModel.loadData()
    assertSnapshot(of: view, as: .image)
  }
  
}
