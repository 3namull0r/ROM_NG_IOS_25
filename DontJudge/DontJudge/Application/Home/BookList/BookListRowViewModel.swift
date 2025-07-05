//
//  BookListRowViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct BookListRowViewModel: Identifiable {
  let id = UUID()
  let title: String
  let thumbnailViewModel: ThumbnailViewModel
  var onSelection: (@MainActor () -> Void)
}
