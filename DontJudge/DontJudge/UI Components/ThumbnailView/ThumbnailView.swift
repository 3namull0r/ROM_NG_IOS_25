//
//  ThumbnailView.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import SwiftUI

struct ThumbnailView: View {
  var viewModel: ThumbnailViewModel
  
  var body: some View {
    VStack {
      Group {
        if let url = viewModel.imageUrl {
          AsyncImage(url: url) { phase in
            imageView(for: phase)
          }
          .id(viewModel.id)
        } else {
          placeholderView
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    .accessibilityIdentifier("Thumbnail_\(viewModel.id)")
    .onTapGesture {
      viewModel.onSelection?()
    }
  }
  
  @ViewBuilder
  private func imageView(for phase: AsyncImagePhase) -> some View {
    switch phase {
    case .empty:
      ZStack {
        baseImageBackground
        ProgressView()
      }
    case .success(let image):
      baseImageBackground
        .overlay(
          image
            .resizable()
            .scaledToFit()
        )
    case .failure:
      placeholderView
    @unknown default:
      EmptyView()
    }
  }
  
  private var baseImageBackground: some View {
    viewModel.thumbnailStyle.backgroundColor
      .aspectRatio(16/9, contentMode: .fit)
      .frame(maxWidth: viewModel.thumbnailStyle.maxWidth)
  }
  
  private var placeholderView: some View {
    ZStack {
      baseImageBackground
      Image(systemName: "book")
    }
  }
  
}

#Preview {
  ThumbnailView(viewModel: ThumbnailViewModel(imageUrlString: "", onFocus: {}, onSelection: {}))
  ThumbnailView(viewModel: ThumbnailViewModel(imageUrlString: "", thumbnailStyle: .inline, onFocus: {}, onSelection: {}))
  ThumbnailView(viewModel: ThumbnailViewModel(imageUrlString: "", thumbnailStyle: .title, onFocus: {}, onSelection: {}))
}
