import Foundation

// MARK: - Protocol BreedViewModelDelegate
protocol BreedViewModelDelegate: AnyObject {
    func reloadData()
}

// MARK: - Class BreedViewModel
class BreedListViewModel {
    
    // MARK: Varibales
    private let apiManager = BreedListAPIManager()
    weak var dogDelegate: BreedViewModelDelegate?
    var breedsList: DogBreedModel?
    var breedsListCopy: DogBreedModel? {
        didSet {
            dogDelegate?.reloadData()
        }
    }
    var bannerData: DogsListModel? {
        didSet {
            dogDelegate?.reloadData()
        }
    }
    var searchText: String? {
        didSet {
            filterDogBreed()
        }
    }
    
    // MARK: Custom Constructor
    init(
        dogDelegate: BreedViewModelDelegate? = nil,
        dogs: DogBreedModel? = nil
    ) {
        self.dogDelegate = dogDelegate
        self.breedsListCopy = dogs
    }
    
    // MARK: - Public Methods
    
    /// Method used to fetch the dogs Breed List.
    @MainActor func fetchDogsBreedList() {
        Task {
            do {
                let breedListResponse: DogBreedModel = try await apiManager.getDogBreeds()
                self.breedsList = breedListResponse
                DogsBreedsManager.shared.checkAndSaveDogsBreed(dogBreedModel: breedListResponse)
                breedsListCopy = breedListResponse.copy() as? DogBreedModel
            } catch {
                print(error)
            }
        }
    }
    
    func fetchDogsBreedFromDatabase() {
        let dogBreedList = DogsBreedsManager.shared.fetchAllDogBreeds()
        let breedListResponse = DogBreedModel()
        breedListResponse.breedModel = dogBreedList
        self.breedsList = breedListResponse
        DogsBreedsManager.shared.checkAndSaveDogsBreed(dogBreedModel: breedListResponse)
        breedsListCopy = breedListResponse.copy() as? DogBreedModel
    }
    
    /// Method used to fetch Dogs List Based on selected Breed.
    @MainActor func fetchDogsList(breed: String) {
        Task {
            do {
                let bannerData: DogsListModel = try await apiManager.getDogBreedsImages(url: ApiEndpoints.dogsList(breed).url, breedName: breed)
                self.bannerData = bannerData
                if bannerData.dogsList.count > 10 {
                    self.bannerData?.dogsList = Array(bannerData.dogsList[0...10])
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func filterDogBreed() {
        breedsListCopy = breedsList?.copy() as? DogBreedModel
        if 
            let searchText = searchText,
            !searchText.isEmpty
        {
            breedsListCopy?.filterBreedList(searchText: searchText)
        }
    }
}

// MARK: - Extension SearchTableHeaderViewDelegate
extension BreedListViewModel: SearchTableHeaderViewDelegate {
    func seachBreed(searchText: String) {
        self.searchText = searchText
    }
}
