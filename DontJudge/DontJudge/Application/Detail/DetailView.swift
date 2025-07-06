//
//  DetailView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//

import SwiftUI

struct DetailView: View {
  @ObservedObject private var viewModel: DetailViewModel
  
  init(viewModel: DetailViewModel) {
    self.viewModel = viewModel
  }
  
  var infoView: some View {
    VStack {
      VStack(alignment: .leading, spacing: 0) {
        ForEach(viewModel.detailRows) { detailRow in
          DetailRowView(viewModel: detailRow)
        }
      }
      .padding(16)
      .background(Color.blue.opacity(0.15))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .clipped()
    }
    .navigationTitle(viewModel.navTitle)
    .accessibilityIdentifier("DetailView")
  }
  
  func errorView(text: String) -> some View {
    Text(text)
      .foregroundColor(.red)
  }
  
  var body: some View {
     ScrollView {
       VStack {
         if viewModel.isLoading {
           ProgressView()
         } else {
           Group {
             if let errorText = viewModel.errorText {
               errorView(text: errorText)
             } else {
               ThumbnailView(viewModel: viewModel.thumbnailViewModel)
               infoView
               DescriptionView(viewModel: viewModel.descriptionViewModel)
             }
           }
            .padding(.horizontal)
         }
       }
      }
     .task {
       await viewModel.loadData()
     }
  }
}

#Preview {
  DetailView(viewModel: DetailViewModel(id: "123"))
}
