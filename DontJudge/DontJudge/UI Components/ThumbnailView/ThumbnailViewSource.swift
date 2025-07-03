//
//  ThumbnailViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//
import Foundation

extension ThumbnailView {
  struct Source: Identifiable {
    let id = UUID()
    var imageUrlString: String
    
    var imageUrl: URL? {
      URL(string: imageUrlString)
    }
  }
}
