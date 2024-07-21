import Foundation
import CoreData

class DogsImageDataManager {
    
    static let shared = DogsImageDataManager()
    
    private init() {}
    
    func checkAndSaveDogList(breedName: String, images: [String]) {
        if fetchDogImageData(byBreedName: breedName).isEmpty {
            _ = images.map({
                saveDogImageData(breedName: breedName, imageName: $0)
            })
        }
    }
    
    // Save a new dog image data
    func saveDogImageData(breedName: String, imageName: String) {
        let newImageData: DogsImageData = CoreDataHelper.shared.create(entity: DogsImageData.self)
        newImageData.breedName = breedName
        newImageData.imageName = imageName
        CoreDataHelper.shared.saveContext()
    }
    
    // Fetch all dog image data
    func fetchAllDogImageData() -> [DogsImageData] {
        return CoreDataHelper.shared.fetch(entity: DogsImageData.self)
    }
    
    // Fetch specific dog image data by breed name
    func fetchDogImageData(byBreedName breedName: String) -> [String] {
        let predicate = NSPredicate(format: "breedName == %@", breedName)
        let dogsImageData = CoreDataHelper.shared.fetch(entity: DogsImageData.self, predicate: predicate)
        
        return dogsImageData.map({
            $0.imageName ?? ""
        })
    }
    
    // Delete a dog image data
    func deleteDogImageData(dogImageData: DogsImageData) {
        CoreDataHelper.shared.delete(object: dogImageData)
    }
}