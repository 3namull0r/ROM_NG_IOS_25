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
  var book: BookDetail?
  var errorText: String?
  @Published var detailRows: [DetailRowViewModel] = []
  
  init(id: String,
       booksService: BooksServiceProtocol = BooksService()) {
    self.id = id
    self.booksService = booksService
  }
  
  var isLoading: Bool {
    book == nil
  }
  
  var descriptionViewModel: DetailRowViewModel {
    DetailRowViewModel(
        title: NSLocalizedString("Description", comment: "Label for book description"),
        value: description ?? NSLocalizedString("No Description", comment: "Empty label for book description")
    )
  }
  
  private var title: String? {
    book?.volumeInfo.title ?? ""
  }
  
  private var subtitle: String? {
    book?.volumeInfo.subtitle
  }
  
  var thumbnailViewModel: ThumbnailViewModel {
    ThumbnailViewModel(imageUrlString: imageUrlString, onFocus: {}, onSelection: {})
  }
  
  private var imageUrlString: String? {
    book?.volumeInfo.imageLinks?.thumbnail
  }
  
  private var author: String? {
    book?.volumeInfo.authors?.first
  }
  
  private var publisher: String? {
    book?.volumeInfo.publisher
  }
  
  private var publishedDate: String? {
    book?.volumeInfo.publishedDate
  }
  
  private var description: String? {
    book?.volumeInfo.description
  }
  
  private var pageCount: String? {
    String(book?.volumeInfo.pageCount ?? 0)
  }
  
  
  func createDetailRows() {
    detailRows = [
        DetailRowViewModel(
            title: NSLocalizedString("Title", comment: "Label for book title"),
            value: title ?? NSLocalizedString("No Title", comment: "Empty label for book title")
        ),
        DetailRowViewModel(
            title: NSLocalizedString("Subtitle", comment: "Label for book subtitle"),
            value: subtitle ?? NSLocalizedString("No Subtitle", comment: "Empty label for book subtitle")
        ),
        DetailRowViewModel(
            title: NSLocalizedString("Author", comment: "Label for book author"),
            value: author ?? NSLocalizedString("No Author", comment: "Empty label for book author")
        ),
        DetailRowViewModel(
            title: NSLocalizedString("Publisher", comment: "Label for book publisher"),
            value: publisher ?? NSLocalizedString("No Publisher", comment: "Empty label for book publisher")
        ),
        DetailRowViewModel(
            title: NSLocalizedString("Published Date", comment: "Label for book published date"),
            value: publishedDate ?? NSLocalizedString("No Published Date", comment: "Empty label for book published date")
        ),
        DetailRowViewModel(
            title: NSLocalizedString("Page Count", comment: "Label for book page count"),
            value: pageCount ?? NSLocalizedString("No Page Count", comment: "Empty label for book page count")
        )
    ]
  }
  
  @MainActor
  func loadData() async {
    do {
      book = try await booksService.fetchBookDetail(volumeId: id)
      createDetailRows()
    } catch {
      errorText = NSLocalizedString("There was a problem loading the book details.",
                                    comment: "Text displayed when books api call fails during search")
    }
  }
}
