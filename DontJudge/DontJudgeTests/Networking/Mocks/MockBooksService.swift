//
//  MockBooksService.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//

@testable import DontJudge
import Foundation

class MockBooksService: BooksServiceProtocol {
  var bookItemsToReturn: [BookItem] = []
  var bookDetailToReturn: BookDetail?
  var shouldThrowError = false
  
  func fetchBookItems(query: String) async throws -> [DontJudge.BookItem] {
    if shouldThrowError { throw URLError(.badServerResponse) }
    return bookItemsToReturn
  }
  
func fetchBookDetail(volumeId: String) async throws -> BookDetail? {
    if shouldThrowError { throw URLError(.badServerResponse) }
    return bookDetailToReturn!
  }
}
