//
//  BookListView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct BookListView: View {
  var viewModel: BookListViewModel
  var onScrolledToBottom: (() -> Void)? = nil
  
  var body: some View {
    List(viewModel.rowViewModels.indices, id: \ .self) { index in
      BookListRowView(viewModel: viewModel.rowViewModels[index])
        .onAppear {
          if index == viewModel.rowViewModels.count - 1 {
            onScrolledToBottom?()
          }
        }
    }
  }
}
