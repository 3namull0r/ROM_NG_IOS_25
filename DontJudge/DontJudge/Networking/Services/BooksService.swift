//
//  BooksService.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import Foundation
import Alamofire
import OSLog

struct Log {
  private static let network = Logger(subsystem: "ROM.DontJudge", category: "Network")
  
  static func logRequest(_ request: DataRequest) {
#if DEBUG
    request.cURLDescription { description in
      network.debug("🔍 Raw Request:\n\(description, privacy: .private)")
    }
#endif
  }
  
  static func logResponse(_ rawResponse: String) {
#if DEBUG
    network.debug("👍 Raw Response:\n\(rawResponse, privacy: .public)")
#endif
  }
  
  static func logError(_ error: Error) {
#if DEBUG
    network.debug("❌ Error occurred: \(String(describing: error), privacy: .public)")
#endif
  }
}

protocol BooksServiceProtocol {
  func fetchBookItems(query: String) async throws -> [BookItem]
  func fetchBookDetail(volumeId: String) async throws -> BookDetail
}

class BooksService: BooksServiceProtocol {
  private let booksAPIKey = ProcessInfo.processInfo.environment["GOOGLE_BOOKS_API_KEY"] ?? ""
  private let endpoint = "https://www.googleapis.com/books/v1/volumes"
  
  func fetchBookItems(query: String) async throws -> [BookItem] {
    let url = "\(endpoint)"
    let parameters: [String: String] = [
      "q": query,
      "key": booksAPIKey,
      "fields": "items(id,volumeInfo(title,imageLinks))",
      "maxResults": "20"
    ]
    
    guard query.isEmpty == false else {
      return []
    }
    
    do {
      let request = AF.request(url,
                               method: .get,
                               parameters: parameters,
                               encoding: URLEncoding.default)
        .validate()
      
      Log.logRequest(request)
      let rawResponse = try await request.serializingString().value
    
      Log.logResponse(rawResponse)
      let data = Data(rawResponse.utf8)
      let decoded = try JSONDecoder().decode(BookItems.self, from: data)
      
      return decoded.items ?? []
    } catch {
      Log.logError(error)
      throw error
    }
    
  }
  
  func fetchBookDetail(volumeId: String) async throws -> BookDetail {
    let url = "\(endpoint)/\(volumeId)"
    let parameters: [String: String] = [
      "key": booksAPIKey,
    ]
    
    do {
      let request = AF.request(url,
                               method: .get,
                               parameters: parameters,
                               encoding: URLEncoding.default)
        .validate()
      
      Log.logRequest(request)
      let rawResponse = try await request.serializingString().value
    
      Log.logResponse(rawResponse)
      let data = Data(rawResponse.utf8)
      let decoded = try JSONDecoder().decode(BookDetail.self, from: data)
      
      return decoded
    } catch {
      Log.logError(error)
      throw error
    }
    
  }
  
}
