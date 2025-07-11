//
//  HomeViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import SwiftUI

enum Route: Hashable {
  case bookDetail(id: String)
}

enum ContentViewType: String, CaseIterable, Identifiable {
  case carousel = "Carousel"
  case list = "List"
  
  var id: String { rawValue }
}


class HomeViewModel: ObservableObject {
  @Published var bookItems: [BookItem] = []
  @Published var path = [Route]()
  @Published var selectedView: ContentViewType = .carousel
  @Published var errorText: String?
  
  let searchViewModel = SearchViewModel()
  let carouselViewModel = CarouselViewModel()
  var bookListViewModel = BookListViewModel()
  
  private let booksService: BooksServiceProtocol
  
  init (booksService: BooksServiceProtocol = BooksService()) {
    self.booksService = booksService
    searchViewModel.onDebouncedSearch = { [weak self] query in
      guard let self = self else { return }
      await self.searchText(query: query)
    }
  }
  
  let navTitle =  NSLocalizedString("Dont Judge", comment: "Home screen navigation bar title")
  
  var descriptionViewModel: DescriptionViewModel {
    DescriptionViewModel(title: NSLocalizedString("Welcome to DontJudge", comment: "Welcome text title"),
                         detail: NSLocalizedString("Search for books in the bar above to see their covers but don't judge them based on that! Tap on the cover to get more information.",
                                                   comment: "Welcome screen subtitle"))
  }
  
  @MainActor
  var hasResults: Bool { !bookItems.isEmpty }
  
  @MainActor
  func searchText(query: String) async {
    do {
      let newBookItems = try await booksService.fetchBookItems(query: query)
      // the only case we want to set an empty list of books is if the query is empty
      if !newBookItems.isEmpty || query.isEmpty {
        bookItems = newBookItems
        updateChildViewModels(with: bookItems)
        self.errorText = nil
      }
    } catch {
      self.errorText = NSLocalizedString("We had a problem fetching the books",
                                                          comment: "Text displayed when books api call fails during search")
    }
  }
  
  private func updateChildViewModels(with items: [BookItem]) {
    let carouselThumbnails = createThumbnailViewModels(bookItems: items, thumbnailStyle: .carousel)
    carouselViewModel.updateCarouselData(thumbnailViewModels: carouselThumbnails)

    let listViewModels = createListRowViewModels(bookItems: items)
    bookListViewModel.rowViewModels = listViewModels
  }
  
  private func makeThumbnailViewModel(from bookItem: BookItem,
                                      style: ThumbnailViewModel.ThumbnailStyle) -> ThumbnailViewModel {
    ThumbnailViewModel(
      imageUrlString: bookItem.volumeInfo.imageLinks?.thumbnail,
      thumbnailStyle: style,
      onFocus: { [weak self] in
        guard let self else { return }
        self.carouselViewModel.subtitle = bookItem.volumeInfo.title
      },
      onSelection: { [weak self] in
        guard let self else { return }
        self.path.append(.bookDetail(id: bookItem.id))
      }
    )
  }
  
  func createThumbnailViewModels(bookItems: [BookItem],
                                 thumbnailStyle: ThumbnailViewModel.ThumbnailStyle = .carousel
  ) -> [ThumbnailViewModel] {
    bookItems.map { makeThumbnailViewModel(from: $0, style: thumbnailStyle) }
  }
  
  func createListRowViewModels(bookItems: [BookItem]) -> [BookListRowViewModel] {
    bookItems.map { bookItem in
      let thumbnailViewModel = makeThumbnailViewModel(from: bookItem, style: .inline)
      return BookListRowViewModel(title: bookItem.volumeInfo.title ?? NSLocalizedString("No Title", comment: ""),
                                  thumbnailViewModel: thumbnailViewModel) {
        self.path.append(.bookDetail(id: bookItem.id))
      }
    }
  }
}
