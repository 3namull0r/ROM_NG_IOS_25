//
//  Untitled.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//

import Foundation

final class JSONLoader {
  static func load<T: Decodable>(_ filename: String, as type: T.Type, in bundle: Bundle) -> T {
    guard let url = bundle.url(forResource: filename, withExtension: "json") else {
      fatalError("🚨 Failed to locate \(filename).json in bundle.")
    }
    
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    } catch {
      fatalError("🚨 Failed to decode \(filename).json: \(error)")
    }
  }
}
