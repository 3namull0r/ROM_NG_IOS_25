//
//  Log.swift
//  DontJudge
//
//  Created by 3namull0r on 06/07/2025.
//
import Foundation
import Alamofire
import OSLog

struct Log {
  private static let network = Logger(subsystem: "ROM.DontJudge", category: "Network")
  
  static func request(_ request: DataRequest) {
#if DEBUG
    request.cURLDescription { description in
      network.debug("🔍 Request:\n\(description, privacy: .private)")
    }
#endif
  }
  
  static func response(_ body: String) {
#if DEBUG
    network.debug("✅ Response:\n\(body, privacy: .public)")
#endif
  }
  
  static func error(_ error: Error) {
#if DEBUG
    network.error("❌ Error: \(String(describing: error), privacy: .public)")
#endif
  }
}
