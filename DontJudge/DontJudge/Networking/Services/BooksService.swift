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
  func fetchBookDetail(volumeId: String) async throws -> BookDetail
}

class BooksService: BooksServiceProtocol {
  private let apiKey = ProcessInfo.processInfo.environment["GOOGLE_BOOKS_API_KEY"] ?? ""
  private let baseURL = "https://www.googleapis.com/books/v1/volumes"
  
  func fetchBookItems(query: String) async throws -> [BookItem] {
    guard !query.isEmpty else { return [] }
    
    var parameters: [String: String] = [
      "q": query,
      "fields": "items(id,volumeInfo(title,imageLinks))",
      "maxResults": "20"
    ]
    if !apiKey.isEmpty {
      parameters["key"] = apiKey
    }
    
    return try await performRequest(url: baseURL, parameters: parameters, responseType: BookItems.self).items ?? []
  }
  
  func fetchBookDetail(volumeId: String) async throws -> BookDetail {
    let url = "\(baseURL)/\(volumeId)"
    var parameters: [String: String] = [:]
    if !apiKey.isEmpty {
      parameters["key"] = apiKey
    }
    
    return try await performRequest(url: url, parameters: parameters, responseType: BookDetail.self)
  }
  
  
  private func performRequest<T: Decodable>(url: String, parameters: [String: String], responseType: T.Type) async throws -> T {
    let request = AF.request(url, parameters: parameters).validate()
    Log.request(request)
    
    do {
      let raw = try await request.serializingString().value
      Log.response(raw)
      
      let data = Data(raw.utf8)
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      Log.error(error)
      throw error
    }
  }
}
