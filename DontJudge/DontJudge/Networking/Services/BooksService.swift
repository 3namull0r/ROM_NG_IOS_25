//
//  BooksService.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import Foundation
import Alamofire

protocol BooksServiceProtocol {
  func fetchBookItems(query: String) async throws -> [BookItem]
}

class BooksService: BooksServiceProtocol {
  func fetchBookItems(query: String) async throws -> [BookItem] {
    let url = "https://www.googleapis.com/books/v1/volumes"
    //        let response = try await AF.request(url)
    //                .serializingDecodable(GoogleBooksResponse.self).value
    //
    //        return response.items ?? []
    //    }
    let parameters: [String: String] = [
        "q": query,
        "key": "",
        "fields": "items(volumeInfo(title,authors,imageLinks,industryIdentifiers))",
        "maxResults": "10"
    ]
    
    let response = try await AF.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: URLEncoding.default
    )
      //.serializingData().value
      .serializingDecodable(BookItems.self).value
    return response.items ?? []
    
//    // Convert Data to JSON dictionary
//    if let jsonObject = try JSONSerialization.jsonObject(with: response) as? [String: Any] {
//      print("✅ JSON Response:")
//      print(jsonObject)
//    }
  }
  
}
