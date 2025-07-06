//
//  SearchViewModel.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//
import SwiftUI

class SearchViewModel: ObservableObject {
  @Published var query: String = ""
  var onDebouncedSearch: (@MainActor (String) async -> Void)?
  private var searchTask: Task<Void, Never>? = nil
  
  func search() {
    searchTask?.cancel()
    searchTask = Task {
      try? await Task.sleep(for: .milliseconds(500))
      guard !Task.isCancelled else { return }
      
      if let callback = onDebouncedSearch {
        await callback(query)
      }
    }
  }
}
