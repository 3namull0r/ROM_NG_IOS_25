//
//  BookItems.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import Foundation


struct BookItems: Decodable {
  let items: [BookItem]?
}

struct BookItem: Decodable, Identifiable {
  let volumeInfo: VolumeInfoLight
  let id: String
}

struct VolumeInfoLight: Decodable {
  let title: String?
  let imageLinks: ImageLinks?
}

struct ImageLinks: Decodable {
  @HttpsUrl
  var smallThumbnail: String?
  @HttpsUrl
  var thumbnail: String?
}
