import Foundation

// MARK: Class DogsModel
class DogsListModel {
    var dogsList: [String] = []
    
    init() {}
    
    init(apiData: [String: Any], breedName: String?) {
        if let dogsImages = apiData["message"] as? [String] {
            dogsList = dogsImages
        }
    }
}
