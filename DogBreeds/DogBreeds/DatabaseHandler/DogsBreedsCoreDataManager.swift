import Foundation
import CoreData

class DogsBreedsManager {
    
    static let shared = DogsBreedsManager()
    
    private init() {}
    
    func checkAndSaveDogsBreed(dogBreedModel: DogBreedModel) {
        if fetchAllDogBreeds().isEmpty {
            _ = dogBreedModel.breedModel.map({
                saveDogBreed(breedName: $0.breedName ?? "")
            })
        }
    }
    
    // Save a new dog breed
    func saveDogBreed(breedName: String) {
        let newBreed: DogsBreeds = CoreDataHelper.shared.create(entity: DogsBreeds.self)
        newBreed.breedName = breedName
        CoreDataHelper.shared.saveContext()
    }
    
    // Fetch all dog breeds
    func fetchAllDogBreeds() -> [BreedModel] {
        let dogBreeds = CoreDataHelper.shared.fetch(entity: DogsBreeds.self)
        return dogBreeds.map({
            BreedModel(breedName: $0.breedName)
        })
    }
    
    // Fetch specific dog breed by name
    func fetchDogBreed(byName breedName: String) -> [DogsBreeds] {
        let predicate = NSPredicate(format: "breedName == %@", breedName)
        return CoreDataHelper.shared.fetch(entity: DogsBreeds.self, predicate: predicate)
    }
    
    // Delete a dog breed
    func deleteDogBreed(dogBreed: DogsBreeds) {
        CoreDataHelper.shared.delete(object: dogBreed)
    }
}

