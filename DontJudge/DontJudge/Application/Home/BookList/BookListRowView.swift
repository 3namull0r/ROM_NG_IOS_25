//
//  BookListRowView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct BookListRowView: View {
  var viewModel: BookListRowViewModel
  
  var body: some View {
    HStack {
      ThumbnailView(viewModel: viewModel.thumbnailViewModel)
      Text(viewModel.title)
        .lineLimit(2)
    }
    .onTapGesture {
      viewModel.onSelection()
    }
  }
}
