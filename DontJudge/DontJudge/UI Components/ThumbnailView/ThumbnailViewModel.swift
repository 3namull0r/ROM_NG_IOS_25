//
//  ThumbnailViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//
import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

struct ThumbnailViewModel: Identifiable {
  let id = UUID()
  var imageUrlString: String?
  var thumbnailStyle: ThumbnailStyle = .carousel
  var onFocus: (@MainActor () -> Void)
  var onSelection: (@MainActor () -> Void)
  
  var imageUrl: URL? {
    guard let imageUrlString else { return nil }
    return URL(string: imageUrlString)
  }

}

extension ThumbnailViewModel {
  enum ThumbnailStyle {
    case inline
    case carousel
    case title
    
    var maxWidth: CGFloat {
      switch self {
      case .inline:
        return 50
      case .carousel:
        return 300
      case .title:
        return .infinity
      }
    }
    
    var backgroundColor: Color {
      switch self {
      case .title, .carousel:
        return Color.blue.opacity(0.15)
      case .inline:
        return .clear
      }
    }
  }
}
