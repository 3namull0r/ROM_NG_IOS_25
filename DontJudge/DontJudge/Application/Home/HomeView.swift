//
//  HomeView.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import SwiftUI

struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  
  var body: some View {
    VStack {
      SearchView(viewModel: viewModel.searchViewModel)
      List(viewModel.bookItems) { result in
        HStack {
          ThumbnailView(source: .init(imageUrlString: result.volumeInfo.imageLinks?.smallThumbnail ?? ""))
          Text(result.volumeInfo.title ?? "")
        }
      }
    }
  }
}

#Preview {
  HomeView()
}
