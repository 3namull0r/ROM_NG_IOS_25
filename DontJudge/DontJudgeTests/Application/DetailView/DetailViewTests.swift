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
    await viewModel.loadData()
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhoneSe)))
  }
  
  @MainActor
  func testDetailFailureSetsErrorMessage() async throws {
    mockService.shouldThrowError = true
    let view = DetailView(viewModel: viewModel)
    await viewModel.loadData()
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhoneSe)))
  }
  
}
