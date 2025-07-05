//
//  DetailView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct DetailRowView: View {
  let viewModel: DetailRowViewModel
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Text(viewModel.title)
        .font(.body)
        .bold()
        .frame(maxWidth: 120, alignment: .leading)
      Text(viewModel.value)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.body)
    }
  }
}


#Preview {
  DetailRowView(viewModel: DetailRowViewModel(title: "Title",
                                              value: "Value"))
}
