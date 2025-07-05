//
//  DetailView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//

import SwiftUI

struct DetailView: View {
  @StateObject private var viewModel: DetailViewModel
  
  init(id: String) {
    _viewModel = StateObject(wrappedValue: DetailViewModel(id: id))
  }
  
  var body: some View {
     ScrollView {
       VStack {
         if viewModel.isLoading {
           ProgressView()
         } else {
           ThumbnailView(viewModel: viewModel.thumbnailViewModel)
           if let title = viewModel.title {
             Text(title)
           }
           if let subtitle = viewModel.subtitle {
             Text(subtitle)
           }
           if let description = viewModel.description {
             Text(description)
           }
           if let author = viewModel.author { 
             Text(author)
           }
           if let publisher = viewModel.publisher {
             Text(publisher)
           }
           if let publishedDate = viewModel.publishedDate {
             Text(publishedDate)
           }
           if let description = viewModel.description {
             Text(description)
           }
           if let pageCount = viewModel.pageCount {
             Text(pageCount)
           }
         }
       }
      }
     .task {
       await viewModel.loadData()
     }
  }
}

#Preview {
  HomeView()
}
