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
  var onFocus: (@MainActor () -> Void)
  var onSelection: (@MainActor () -> Void)
  //var thumbnailStyle: ThumbnailStyle = .carousel
  
  var imageUrl: URL? {
    guard let imageUrlString else { return nil }
    return URL(string: imageUrlString)
  }

}
//
//extension ThumbnailViewModel {
//  enum ThumbnailStyle {
//    case inline
//    case carousel
//    case title
//  }
//}
