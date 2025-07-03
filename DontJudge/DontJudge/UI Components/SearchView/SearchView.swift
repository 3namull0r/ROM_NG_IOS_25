//
//  SearchView.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//
import SwiftUI

struct SearchView: View {
  @ObservedObject var viewModel: SearchViewModel
  
  var body: some View {
    VStack {
      TextField("Search books", text: $viewModel.query)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .onChange(of: viewModel.query) {
          viewModel.search()
        }
    }
  }
}

#Preview {
  SearchView(viewModel: SearchViewModel())
}
