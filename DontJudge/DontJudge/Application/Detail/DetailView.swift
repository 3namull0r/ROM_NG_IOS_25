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
  }
  
  var body: some View {
     ScrollView {
       VStack {
         if viewModel.isLoading {
           ProgressView()
         } else {
           Group {
             ThumbnailView(viewModel: viewModel.thumbnailViewModel)
             infoView
             DescriptionView(viewModel: viewModel.descriptionViewModel)
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
  DetailView(id: "nlk_EAAAQBAJ")
}
