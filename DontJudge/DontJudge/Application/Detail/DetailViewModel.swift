//
//  DetailViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

class DetailViewModel: ObservableObject {
  var book: BookDetail?
  @Published var errorText: String?
  @Published var detailRows: [DetailRowViewModel] = []
  let navTitle =  NSLocalizedString("Book Details", comment: "Home screen navigation bar title")
  
  private let id: String
  private let booksService: BooksServiceProtocol
  
  init(id: String,
       booksService: BooksServiceProtocol = BooksService()) {
    self.id = id
    self.booksService = booksService
  }
  
  var isLoading: Bool {
    book == nil && errorText == nil
  }
  
  var descriptionViewModel: DescriptionViewModel {
    DescriptionViewModel(
        title: NSLocalizedString("Description", comment: "Label for book description"),
        detail: book?.volumeInfo.description ?? NSLocalizedString("No Description", comment: "Empty label for book description")
    )
  }
  
  var thumbnailViewModel: ThumbnailViewModel {
    ThumbnailViewModel(imageUrlString: book?.volumeInfo.imageLinks?.thumbnail,
                       thumbnailStyle: .title,
                       onFocus: {},
                       onSelection: {})
  }
  
  private var titleRow: DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString("Title", comment: "Label for book title"),
      value: book?.volumeInfo.title ?? NSLocalizedString("No Title", comment: "Empty label for book title")
    )
  }

  private var subtitleRow: DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString("Subtitle", comment: "Label for book subtitle"),
      value: book?.volumeInfo.subtitle ?? NSLocalizedString("No Subtitle", comment: "Empty label for book subtitle")
    )
  }

  private var authorRow: DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString("Author", comment: "Label for book author"),
      value: book?.volumeInfo.authors?.first ?? NSLocalizedString("No Author", comment: "Empty label for book author")
    )
  }

  private var publisherRow: DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString("Publisher", comment: "Label for book publisher"),
      value: book?.volumeInfo.publisher ?? NSLocalizedString("No Publisher", comment: "Empty label for book publisher")
    )
  }

  private var publishedDateRow: DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString("Published Date", comment: "Label for book published date"),
      value: book?.volumeInfo.publishedDate ?? NSLocalizedString("No Published Date", comment: "Empty label for book published date")
    )
  }

  private var pageCountRow: DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString("Page Count", comment: "Label for book page count"),
      value: book?.volumeInfo.pageCount.map(String.init) ?? NSLocalizedString("No Page Count", comment: "Empty label for book page count")
    )
  }
  
  
  func createDetailRows() {
    detailRows = [
      titleRow,
      subtitleRow,
      authorRow,
      publisherRow,
      publishedDateRow,
      pageCountRow
    ]
  }
  
  @MainActor
  func loadData() async {
    do {
      errorText = nil
      book = try await booksService.fetchBookDetail(volumeId: id)
      createDetailRows()
    } catch {
      errorText = NSLocalizedString("There was a problem loading the book details.",
                                    comment: "Text displayed when books api call fails during search")
    }
  }
}
