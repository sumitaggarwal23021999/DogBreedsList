import Foundation

let baseURL = "https://dog.ceo/"
let apiVersion = "api/"

enum DefaultStrings {
    case breeds, apiFailure, favouritePictures, filterBreads, noDataAvailable
    
    var string: String {
        switch self {
        case .breeds: return "Breeds"
        case .filterBreads: return "Filter Breeds"
        case .apiFailure: return "Something Went Wrong."
        case .favouritePictures: return "Favourite Pictures"
        case .noDataAvailable: return "No Data Available"
        }
    }
}

class Constant {
    static let appName = "DogBreeds"
}
