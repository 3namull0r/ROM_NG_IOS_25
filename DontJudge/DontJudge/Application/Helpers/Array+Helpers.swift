//
//  Array+Helpers.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//

extension Array {
  subscript(safe index: Int?) -> Element? {
    guard let index else { return nil }
    return indices.contains(index) ? self[index] : nil
  }
}
