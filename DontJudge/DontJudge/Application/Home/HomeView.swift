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
        DescriptionView(viewModel: viewModel.descritionViewModel)
          .padding(.horizontal)
        if viewModel.hasResults {
          segmentControl
          .padding(.horizontal)
          switch viewModel.selectedView {
          case .list:
            listView
          case .carousel:
            CarouselView(viewModel: viewModel.carouselViewModel)
          }
        }
        Spacer()
      }
      .navigationTitle(viewModel.navTitle)
      .navigationDestination(for: Route.self) { route in
        switch route {
        case .bookDetail(let id):
          DetailView(id: id)
        }
      }
    }
  }
  
  var segmentControl: some View {
    Picker("View", selection: $viewModel.selectedView) {
      ForEach(ContentViewType.allCases) { viewType in
        Text(viewType.rawValue).tag(viewType)
      }
    }
    .pickerStyle(.segmented)
  }
  
  var listView: some View {
    List(viewModel.bookItems) { result in
      HStack {
        Text(result.volumeInfo.title ?? "")
      }
    }
  }
  
}


#Preview {
  HomeView()
}
