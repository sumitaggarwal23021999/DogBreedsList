import UIKit

typealias NullableCompletion = (()->Void)?

enum AlertTitle {
    case appName
    
    var value: String {
        switch self {
        case .appName: return Constant.appName
        }
    }
}

enum AlertButton {
    case ok(NullableCompletion)
    
    var name: String {
        switch self {
        case .ok: return "Ok"
        }
    }
    
    var action: NullableCompletion {
        switch self {
        case .ok(let closure): return closure
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        default: return .default
        }
    }
}
