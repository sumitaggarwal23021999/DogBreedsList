import Foundation

enum AlertMessages {
    case custom(String)
    case apiFailed
    case noDataAvailable
    
    var value: String {
        switch self {
        case .custom(let message): return message
        case .apiFailed: return DefaultStrings.apiFailure.string
        case .noDataAvailable: return DefaultStrings.noDataAvailable.string
        }
    }
}
