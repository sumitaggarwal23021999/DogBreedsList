import Foundation

// MARK: - Protocol DogListViewModelDelegate
protocol DogListViewModelDelegate: AnyObject {
    func reloadData()
}

// MARK: - Class DogListViewModel
class DogListViewModel {
    
    // MARK: - Internal Methods
    var apiManager = DogsImageListAPIManager()
    
    weak var dogsDelegate: DogListViewModelDelegate?
    var dogs: DogsListModel? {
        didSet {
            dogsDelegate?.reloadData()
        }
    }
    var selectedBreeds: String?
    
    // MARK: - Public Methods
    
    /// Method used to fetch Dogs List Based on selected Breed.
    @MainActor func fetchDogsList(breed: String) {
        Task {
            do {
                let dogsResponse: DogsListModel = try await apiManager.getDogBreedsImages(url: ApiEndpoints.dogsList(breed).url, breedName: breed)
                if let selectedBreeds = selectedBreeds {
                    DogsImageDataManager.shared.checkAndSaveDogList(breedName: selectedBreeds, images: dogsResponse.dogsList)
                }
                dogs = dogsResponse
            } catch {
                print(error)
            }
        }
    }
    
    func fetchDogsListFromDataBase() {
        if let selectedBreeds = selectedBreeds {
            let imageList: [String] = DogsImageDataManager.shared.fetchDogImageData(byBreedName: selectedBreeds)
            let dogsResponse = DogsListModel()
            dogsResponse.dogsList = imageList
            dogs = dogsResponse
        }
    }
}
