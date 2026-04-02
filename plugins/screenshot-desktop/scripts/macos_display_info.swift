import AppKit
import Foundation

struct Response: Encodable {
  let count: Int
  let displays: [Int]
}

let screenCount = max(NSScreen.screens.count, 1)
let displays = Array(1...screenCount)
let response = Response(count: screenCount, displays: displays)

let encoder = JSONEncoder()
encoder.outputFormatting = [.sortedKeys]

if let data = try? encoder.encode(response),
   let json = String(data: data, encoding: .utf8) {
  print(json)
} else {
  fputs("{\"error\":\"failed to encode display info\"}\n", stderr)
  exit(1)
}
