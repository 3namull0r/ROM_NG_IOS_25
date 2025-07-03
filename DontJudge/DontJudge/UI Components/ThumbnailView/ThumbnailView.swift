//
//  ThumbnailView.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import SwiftUI

struct ThumbnailView: View {
  var source: ThumbnailView.Source
  
  var body: some View {
    AsyncImage(url: source.imageUrl) { image in
      image
        .resizable()
        .scaledToFill()
        .frame(maxWidth: 100)
        .aspectRatio(16/9, contentMode: .fill)
        .clipped()
    } placeholder: {
      Color.gray
        .frame(maxWidth: 100)
        .aspectRatio(16/9, contentMode: .fill)
        .clipped()
    }
  }
}
