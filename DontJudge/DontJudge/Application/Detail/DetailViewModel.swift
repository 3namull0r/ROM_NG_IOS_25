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
  
  private let id: String
  private let booksService: BooksServiceProtocol
  
  init(id: String,
       booksService: BooksServiceProtocol = BooksService()) {
    self.id = id
    self.booksService = booksService
  }
  
  var navTitle: String {
    book?.volumeInfo.title ?? NSLocalizedString("Book Details", comment: "Detail screen fallback title")
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
                       thumbnailStyle: .title)
  }
  
  private func creatDetailRowViewModel(titleKey: String, value: String?) -> DetailRowViewModel {
    DetailRowViewModel(
      title: NSLocalizedString(titleKey, comment: "Label for \(titleKey.lowercased())"),
      value: value ?? NSLocalizedString("No \(titleKey)", comment: "Empty label for \(titleKey.lowercased())")
    )
  }
  
  func createDetailRows() {
    guard let volumeInfo = book?.volumeInfo else {
      detailRows = []
      return
    }

    detailRows = [
      creatDetailRowViewModel(titleKey: "Title", value: volumeInfo.title),
      creatDetailRowViewModel(titleKey: "Subtitle", value: volumeInfo.subtitle),
      creatDetailRowViewModel(titleKey: "Author", value: volumeInfo.authors?.first),
      creatDetailRowViewModel(titleKey: "Publisher", value: volumeInfo.publisher),
      creatDetailRowViewModel(titleKey: "Published Date", value: volumeInfo.publishedDate),
      creatDetailRowViewModel(titleKey: "Page Count", value: volumeInfo.pageCount.map(String.init))
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
