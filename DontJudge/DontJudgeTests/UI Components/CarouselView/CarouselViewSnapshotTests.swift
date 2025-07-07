//
//  CarouselViewSnapshotTests.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import DontJudge

final class CarouselViewSnapshotTests: XCTestCase {
  
  func testCarouselViewEmpty() {
    let viewModel = CarouselViewModel()
    viewModel.thumbnailViewModels = []
    viewModel.subtitle = nil
    let view = CarouselView(viewModel: viewModel)
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
  }
  
  func testCarouselViewSingleThumbnail() {
    let viewModel = CarouselViewModel()
    viewModel.thumbnailViewModels = [
      ThumbnailViewModel(imageUrlString: nil, thumbnailStyle: .carousel)
    ]
    viewModel.subtitle = "Single Book"
    let view = CarouselView(viewModel: viewModel)
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
  }
  
  func testCarouselViewMultipleThumbnails() {
    let viewModel = CarouselViewModel()
    viewModel.thumbnailViewModels = [
      ThumbnailViewModel(imageUrlString: "", thumbnailStyle: .carousel),
      ThumbnailViewModel(imageUrlString: "", thumbnailStyle: .carousel),
      ThumbnailViewModel(imageUrlString: "", thumbnailStyle: .carousel)
    ]
    viewModel.subtitle = "Multiple Books"
    let view = CarouselView(viewModel: viewModel)
    assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
  }
}
