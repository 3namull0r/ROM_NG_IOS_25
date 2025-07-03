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
  let volumeInfo: VolumeInfo
  
  var id: String {
    volumeInfo.industryIdentifiers?.first?.identifier ?? UUID().uuidString
  }
}

struct VolumeInfo: Decodable {
  let title: String?
  var authors: [String]?
  let imageLinks: ImageLinks?
  let industryIdentifiers: [IndustryIdentifiers]?
}

struct ImageLinks: Decodable {
  @HttpsUrl
  var smallThumbnail: String?
  @HttpsUrl
  var thumbnail: String?
}

struct IndustryIdentifiers: Decodable {
  let type: String?
  let identifier: String?
}
