//
//  BookListView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct BookListView: View {
  var viewModel: BookListViewModel
  
  var body: some View {
    List(viewModel.rowViewModels) { rowViewModel in
      BookListRowView(viewModel: rowViewModel)
    }
  }
}
