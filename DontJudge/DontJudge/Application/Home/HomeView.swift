//
//  HomeView.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import SwiftUI

struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel
  
  init(viewModel: HomeViewModel = HomeViewModel()) {
      _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    NavigationStack(path: $viewModel.path) {
      VStack {
        SearchView(viewModel: viewModel.searchViewModel)
        if let errorMessage = viewModel.errorText {
          errorView(text: errorMessage)
        }
        DescriptionView(viewModel: viewModel.descriptionViewModel)
          .padding(.horizontal)
        
          if viewModel.hasResults {
            segmentControl
              .padding(.horizontal)
            switch viewModel.selectedView {
            case .list:
              BookListView(viewModel: viewModel.bookListViewModel)
            case .carousel:
              CarouselView(viewModel: viewModel.carouselViewModel)
            }
          }
          Spacer()
        }
      .ignoresSafeArea(.container, edges: .bottom)
      .navigationTitle(viewModel.navTitle)
      .navigationDestination(for: Route.self) { route in
        switch route {
        case .bookDetail(let id):
          DetailView(viewModel: DetailViewModel(id: id))
        }
      }
    }
  }
  
  
  func errorView(text: String) -> some View {
    Text(text)
      .foregroundColor(.red)
  }
  
  var segmentControl: some View {
    Picker("View", selection: $viewModel.selectedView) {
      ForEach(ContentViewType.allCases) { viewType in
        Text(viewType.rawValue).tag(viewType)
      }
    }
    .pickerStyle(.segmented)
  }
  
}


#Preview {
  HomeView()
}
