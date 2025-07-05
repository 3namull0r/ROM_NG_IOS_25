//
//  BookDetail.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import Foundation

struct BookDetail: Decodable, Identifiable {
  let volumeInfo: VolumeInfo
  let id: String
}

struct VolumeInfo: Decodable {
  let title: String?
  let subtitle: String?
  let imageLinks: ImageLinks?
  let authors: [String]?
  let publisher: String?
  let publishedDate: String?
  let description: String?
  let pageCount: Int?
}

