//
//  CarouselViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI
import Combine

class CarouselViewModel: ObservableObject {
  @Published var thumbnailViewModels = [ThumbnailViewModel]()
  @Published var scrollIndex: Int? = 0
  @Published var subtitle: String?
  private var cancellables = [AnyCancellable]()
  
  init() {
    $scrollIndex.sink {[weak self] index in
      guard let self else { return }
      self.focusOnThumbnail(withIndex: index)
    }.store(in: &cancellables)
  }
  
  func focusOnThumbnail(withIndex index: Int?) {
    if let viewModel = thumbnailViewModels[safe: index] {
      Task {
        await viewModel.onFocus()
      }
    }
  }
  
  func updateCarouselData(thumbnailViewModels: [ThumbnailViewModel]) {
    self.thumbnailViewModels = thumbnailViewModels
    self.scrollIndex = 0
    if thumbnailViewModels.isEmpty {
      self.subtitle = ""
    }
  }
  
}
