import Foundation

enum ApiEndpoints {
    case breedList
    case dogsList(String)
    
    var url: String {
        switch self {
        case .breedList: baseURL + apiVersion + "breeds/list"
        case .dogsList(let breedName): baseURL + apiVersion + "breed/\(breedName)/images"
        }
    }
}
