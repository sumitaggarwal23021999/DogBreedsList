import Foundation

// MARK: - Class DogsBreedListAPIManager
class DogsImageListAPIManager {
    
    // MARK: - Variables
    private var apiHandler: APIHandler
    
    // MARK: - Custom Constructor
    init(apiHandler: APIHandler = APIHandler()) {
        self.apiHandler = apiHandler
    }
    
    /// Method used to fetch dog images for specific breed.
    func getDogBreedsImages(url: String, breedName: String?) async throws -> DogsListModel {
        let data = try await apiHandler.getDataFromAPI(url: url)
        return DogsListModel(apiData: data as? [String: Any] ?? [:], breedName: breedName)
    }
}