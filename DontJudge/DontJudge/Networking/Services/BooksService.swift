//
//  BooksService.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import Foundation
import Alamofire

protocol BooksServiceProtocol {
  func fetchBookItems(query: String, startIndex: Int) async throws -> [BookItem]
  func fetchBookDetail(volumeId: String) async throws -> BookDetail?
}

class BooksService: BooksServiceProtocol {
  // API key loaded from environment
  private let apiKey = ProcessInfo.processInfo.environment["GOOGLE_BOOKS_API_KEY"] ?? ""
  private let baseURL = "https://www.googleapis.com/books/v1/volumes"
  private let maxResults = 20
  
  /// Fetches a list of books matching the search query.
  /// Fetches 20 results from the start index and returns basic info (id, title, imageLinks).
  func fetchBookItems(query: String, startIndex: Int = 0) async throws -> [BookItem] {
    guard !query.isEmpty else { return [] }
    
    var parameters: [String: String] = [
      "q": query,
      "fields": "items(id,volumeInfo(title,imageLinks))",
      "maxResults": "\(maxResults)",
      "startIndex": "\(startIndex)"
    ]
    if !apiKey.isEmpty {
      parameters["key"] = apiKey
    }
    
    return try await performRequest(url: baseURL, parameters: parameters, responseType: BookItems.self)?.items ?? []
  }
  
  /// Fetches detailed information for a single book by volume ID.
  func fetchBookDetail(volumeId: String) async throws -> BookDetail? {
    let url = "\(baseURL)/\(volumeId)"
    var parameters: [String: String] = [:]
    if !apiKey.isEmpty {
      parameters["key"] = apiKey
    }
    
    return try await performRequest(url: url, parameters: parameters, responseType: BookDetail.self)
  }
  
  /// Executes the network request and decodes the response into the specified type.
  private func performRequest<T: Decodable>(url: String, parameters: [String: String], responseType: T.Type) async throws -> T? {
    let request = AF.request(url, parameters: parameters).validate()
    Log.request(request)
    
    do {
      let raw = try await request.serializingString().value
      Log.response(raw)
      
      let data = Data(raw.utf8)
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      Log.error(error)
      // if the task is specifically cancelled we supress the error
      if let afError = error as? AFError, case .explicitlyCancelled = afError {
        return nil
      }
      throw error
    }
  }
}
