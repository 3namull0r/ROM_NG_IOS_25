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
//      if let url = viewModel.imageUrl {
//        AsyncImage(url: url) { phase in
//          switch phase {
//          case .empty:
//            ZStack {
//              Color.gray
//                .aspectRatio(16/9, contentMode: .fit)
//                .frame(maxWidth: 300)
//              overlay(
//                ProgressView()
//              )
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//          case .success(let image):
//            Color.gray
//              .aspectRatio(16/9, contentMode: .fit)
//              .frame(maxWidth: 300)
//              .overlay(
//                image
//                  .resizable()
//                  .scaledToFit()
//              )
//              .clipShape(RoundedRectangle(cornerRadius: 8))
//          case .failure:
//            ZStack {
//              Color.gray
//                .aspectRatio(16/9, contentMode: .fit)
//                .frame(maxWidth: 300)
//              Image(systemName: "book")
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//          @unknown default:
//            EmptyView()
//          }
//        }
//      } else {
        VStack {
          ZStack {
            Color.gray
              .aspectRatio(16/9, contentMode: .fit)
              .frame(maxWidth: 300)
            Image(systemName: "book")
          }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
  //    }
    }.onTapGesture {
      viewModel.onSelection()
    }
  }
}

#Preview {
  ThumbnailView(viewModel: ThumbnailViewModel(imageUrlString: "", onFocus: {}, onSelection: {}))
}
