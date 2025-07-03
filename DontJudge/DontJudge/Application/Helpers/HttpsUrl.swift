//
//  HttpsUrl.swift
//  DontJudge
//
//  Created by 3namull0r on 03/07/2025.
//
import Foundation

@propertyWrapper
struct HttpsUrl: Decodable {
    var wrappedValue: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawURL = try container.decode(String.self)
        let httpsURL = rawURL.replacingOccurrences(of: "http://", with: "https://")
        self.wrappedValue = httpsURL
    }
}
