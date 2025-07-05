//
//  DetailViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

class DetailViewModel: ObservableObject {
  private let id: String
  private let booksService: BooksServiceProtocol
  @Published var book: BookDetail?
  var errorText: String?
  
  init(id: String,
       booksService: BooksServiceProtocol = BooksService()) {
    self.id = id
    self.booksService = booksService
  }
  
  var isLoading: Bool {
    book == nil
  }
  
  var title: String? {
    book?.volumeInfo.title ?? ""
  }
  
  var subtitle: String? {
    book?.volumeInfo.subtitle
  }
  
  var thumbnailViewModel: ThumbnailViewModel {
    ThumbnailViewModel(imageUrlString: imageUrlString, onFocus: {}, onSelection: {})
  }
  
  private var imageUrlString: String? {
    book?.volumeInfo.imageLinks?.thumbnail
  }
  
  var author: String? {
    book?.volumeInfo.authors?.first
  }
  
  var publisher: String? {
    book?.volumeInfo.publisher
  }
  
  var publishedDate: String? {
    book?.volumeInfo.publishedDate
  }
  
  var description: String? {
    book?.volumeInfo.description
  }
  
  var pageCount: String? {
    String(book?.volumeInfo.pageCount ?? 0)
  }
  
  @MainActor
  func loadData() async {
    do {
      book = try await booksService.fetchBookDetail(volumeId: id)
    } catch {
      errorText = NSLocalizedString("There was a problem loading the book details.",
                                    comment: "Text displayed when books api call fails during search")
    }
  }
}
