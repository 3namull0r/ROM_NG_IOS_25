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
  
  var body: some View {
      VStack(spacing: 8) {
        ScrollViewReader { _ in
          ScrollView(.horizontal) {
            HStack(spacing: 20) {
              ForEach(Array(viewModel.thumbnailViewModels.enumerated()), id: \.offset) { index, viewModel in
                ThumbnailView(viewModel: viewModel)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                  .cornerRadius(8)
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
        if let subtitle = viewModel.subtitle {
          Text("\(subtitle)")
        }
        Spacer()
      }
  }
}
