//
//  DescriptionRowView.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct DescriptionView: View {
  let viewModel: DescriptionViewModel
  
    var body: some View {
      VStack {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .top, spacing: 16) {
            Text(viewModel.title)
              .font(.body)
              .bold()
            Spacer()
          }
          HStack(alignment: .top, spacing: 16) {
            Text(viewModel.detail)
              .font(.body)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
        .padding(16)
        .background(Color.blue.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .clipped()
      }
    }
}

#Preview {
  DescriptionView(viewModel: DescriptionViewModel(title: "Title", detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
}
