//
//  CarouselView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//

import SwiftUI
import Combine

struct CarouselView: View {
  @ObservedObject var viewModel: CarouselViewModel
  var onScrolledToEnd: (() -> Void)? = nil
  
  var body: some View {
    VStack(spacing: 8) {
      ScrollViewReader { _ in
        ScrollView(.horizontal) {
          HStack(spacing: 20) {
            ForEach(Array(viewModel.thumbnailViewModels.enumerated()), id: \.offset) { index, viewModel in
              ThumbnailView(viewModel: viewModel)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .id(index)
            }
          }
          .padding(.horizontal, 20)
          .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $viewModel.scrollIndex)
      }
      .frame(height: 150)
      PageControl(currentPage: $viewModel.scrollIndex, numberOfPages: viewModel.thumbnailViewModels.count)
      subtitleView
      Spacer()
    }
    .onChange(of: viewModel.scrollIndex) {
      guard let newIndex = viewModel.scrollIndex else { return }
      // Trigger paging when user scrolls to the last or second-to-last thumbnail
      if newIndex >= viewModel.thumbnailViewModels.count - 2 {
        onScrolledToEnd?()
      }
    }
  }
  
  @ViewBuilder
  private var subtitleView: some View {
    if let subtitle = viewModel.subtitle {
      Text(subtitle)
        .font(.title)
        .bold()
        .padding(.horizontal)
    }
  }
  
}

#Preview {
  let vm = CarouselViewModel()
  vm.thumbnailViewModels = [
    ThumbnailViewModel(imageUrlString: ""),
    ThumbnailViewModel(imageUrlString: ""),
    ThumbnailViewModel(imageUrlString: "")
  ]
  vm.subtitle = "Mock Subtitle"
  return CarouselView(viewModel: vm)
}
