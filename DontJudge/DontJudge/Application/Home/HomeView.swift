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
    NavigationStack(path: $viewModel.path) {
      VStack {
        SearchView(viewModel: viewModel.searchViewModel)
        //      List(viewModel.bookItems) { result in
        //        HStack {
        //          ThumbnailView(viewModel: .init(imageUrlString: result.volumeInfo.imageLinks?.smallThumbnail))
        //          Text(result.volumeInfo.title ?? "")
        //        }
        //      }
        CarouselView(viewModel: viewModel.carouselViewModel)
      }
      .navigationDestination(for: Route.self) { route in
        switch route {
        case .bookDetail(let id):
          DetailView(id: id)
        }
      }
    }
  }
}

#Preview {
  HomeView()
}
