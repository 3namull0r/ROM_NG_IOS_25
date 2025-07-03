//
//  HomeViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
  private let booksService: BooksServiceProtocol
  @Published var bookItems: [BookItem] = []
  let searchViewModel = SearchViewModel()
  var errorText: String?
  
  init (booksService: BooksServiceProtocol = BooksService()) {
    self.booksService = booksService
    searchViewModel.onDebouncedSearch = { [weak self] query in
      guard let self = self else { return }
      await self.searchText(query: query)
    }
  }
  
  @MainActor
  func searchText(query: String) async {
    do {
      bookItems = try await booksService.fetchBookItems(query: query)
      errorText = nil
    } catch {
      errorText = NSLocalizedString("We had a problem fetching the books",
                                    comment: "Text displayed when books api call fails")
    }
  }
  
  
}
