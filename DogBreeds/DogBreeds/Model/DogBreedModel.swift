import Foundation
import UIKit

// MARK: - Enum BreedListType
enum BreedListType {
    case breedList, breedListForFilter
    
    var navigationTitle: String {
        switch self {
        case .breedList: return DefaultStrings.breeds.string
        case .breedListForFilter: return DefaultStrings.filterBreads.string
        }
    }
}

// MARK: - Class DogBreedModel
class DogBreedModel: NSObject, NSCopying {
    // MARK: Variables
    var breedModel: [BreedModel] = []
    
    // MARK: Constructors
    override init() {}
    
    // MARK: - Custom Constructor
    init(apiData: [String: Any]) {
        if let breedNames = apiData["message"] as? [String] {
            breedModel = breedNames.map({
                BreedModel(breedName: $0)
            })
        }
    }
    
    // MARK: - Public Methods
    func filterBreedList(searchText: String) {
        breedModel = breedModel.filter({
            if let name = $0.breedName {
                return name.range(of: searchText, options: .caseInsensitive) != nil
            } else {
                return false
            }
        })
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let dogBreedModel = DogBreedModel()
        dogBreedModel.breedModel = breedModel.map({
            $0.copy() as! BreedModel
        })
        return dogBreedModel
    }
}

// MARK: - Class BreedModel
class BreedModel: NSObject, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        BreedModel(breedName: breedName)
    }
    
    // MARK: - Variables
    var breedName: String?
    
    // MARK: - Custom Constructor
    init(breedName: String? = nil) {
        self.breedName = breedName
    }
}



