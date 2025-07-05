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
