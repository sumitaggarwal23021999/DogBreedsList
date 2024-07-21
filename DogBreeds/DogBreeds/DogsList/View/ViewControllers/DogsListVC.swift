import UIKit
import SDWebImage

// MARK: - Class DogsListVC
final class DogsListVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var barBtnFilterBreed: UIBarButtonItem!
    @IBOutlet private weak var collectionVwDogImageList: UICollectionView!
    
    // MARK: - Variables
    private let viewModel = DogListViewModel()
    var breedString: String?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.selectedBreeds = breedString
        setNavigationTitle()
        registerCellsForDogsList()
        viewModel.dogsDelegate = self
        fetchData()
    }
    
    private func setNavigationTitle() {
        /// Setting Navigation Header Title.
        if let breedString = breedString
        {
            navigationItem.title = "\(breedString)"
            barBtnFilterBreed.isHidden = true
        }
    }
    
    private func fetchData() {
        if
            let breedString = breedString
        {
            viewModel.fetchDogsListFromDataBase()
            viewModel.fetchDogsList(breed: breedString)
        }
    }
    
    private func registerCellsForDogsList() {
        collectionVwDogImageList.register(DogsCVC.nib(), forCellWithReuseIdentifier: DogsCVC.identfier)
        collectionVwDogImageList.delegate = self
        collectionVwDogImageList.dataSource = self
    }
}

// MARK: - Extension UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
extension DogsListVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dogs?.dogsList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DogsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: DogsCVC.identfier, for: indexPath) as! DogsCVC
        cell.imageName = viewModel.dogs?.dogsList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 40.0 // Adjust as needed
        let width = (collectionView.bounds.width - spacing) / 3.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0 // Adjust as needed
    }
}

// MARK: - Extension DogListViewModelDelegate
extension DogsListVC: DogListViewModelDelegate {
    func checkAndShowAlertForDogsData(dogs: DogsListModel?) {
        if let dogs = dogs {
            if dogs.dogsList.isEmpty {
                showAlertControllerWith(message: .noDataAvailable, buttons: .ok(nil))
            }
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionVwDogImageList.reloadData()
        }
    }
}


