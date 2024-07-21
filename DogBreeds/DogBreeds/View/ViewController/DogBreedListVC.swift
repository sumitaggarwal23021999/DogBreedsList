import UIKit

// MARK: - Protocol DogBreedListVCDelegate
protocol DogBreedListVCDelegate: AnyObject {
    func handleApplyFilter(selectedFilter: [String])
}

// MARK: - Class DogBreedListVC
final class DogBreedListVC: UIViewController {
    
    // MARK: - Private IBOutlet
    @IBOutlet private weak var tblvwBreeds: UITableView!
    
    // MARK: - Variables
    var breedViewModel = BreedListViewModel()
    var breedListType: BreedListType = .breedList
    weak var delegate: DogBreedListVCDelegate?
    var breedNameForBannerData: String = "african"
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegateAndDataSource()
        fetchBreedList()
        fetchBannerData()
    }
    
    // MARK: Private Internal Methods
    private func setDelegateAndDataSource() {
        tblvwBreeds.dataSource = self
        tblvwBreeds.delegate = self
        tblvwBreeds.estimatedRowHeight = UITableView.automaticDimension
        tblvwBreeds.register(BannerTableReusableView.nib(), forHeaderFooterViewReuseIdentifier: BannerTableReusableView.identifier)
        tblvwBreeds.register(SearchTableHeaderView.nib(), forHeaderFooterViewReuseIdentifier: SearchTableHeaderView.identifier)
        breedViewModel.dogDelegate = self
    }
    
    private func fetchBreedList() {
        breedViewModel.fetchDogsBreedFromDatabase()
        breedViewModel.fetchDogsBreedList()
    }
    
    private func fetchBannerData() {
        breedViewModel.fetchDogsListFromDatabase(breed: breedNameForBannerData)
        breedViewModel.fetchDogsList(breed: breedNameForBannerData)
    }
    
    private func navigateToDogsList(breed: String?) {
        let vc : DogsListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DogsListVC") as! DogsListVC
        vc.breedString = breed
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension UITableViewDelegate, UITableViewDataSource
extension DogBreedListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return breedViewModel.breedsListCopy?.breedModel.count ?? 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblvwBreeds.dequeueReusableCell(withIdentifier: "BreedListTVC", for: indexPath) as! BreedListTVC
        cell.breedModel = breedViewModel.breedsListCopy?.breedModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if breedListType == .breedList {
            navigateToDogsList(breed: breedViewModel.breedsList?.breedModel[indexPath.row].breedName ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            // Case 0 is for showing of banners.
            // Have created new section as we do not want to stick this to top when map view is being scrolled.
            // Also we can not turn off this scrolling property as we need to have location view stick to top.
        case 0:
            guard !(breedViewModel.bannerData?.dogsList.isEmpty ?? true)
            else {
                return nil
            }
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BannerTableReusableView.identifier) as? BannerTableReusableView
            header?.dogsListModel = breedViewModel.bannerData
            return header
            // For Map view we do not need any header view.
        case 1:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchTableHeaderView.identifier) as? SearchTableHeaderView
            headerView?.delegate = breedViewModel
            return headerView
        default: return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            // Case 0 is for showing of banners.
            // Have created new section as we do not want to stick this to top when map view is being scrolled.
            // Also we can not turn off this scrolling property as we need to have location view stick to top.
        case 0:
            return (breedViewModel.bannerData?.dogsList.isEmpty ?? true) ? 0.0 : 150.0
            // For Search view we do not need any header view.
        case 1:
            return 40.0
        default: return 0.0
        }
    }
}

// MARK: - Extension BreedViewModelDelegate
extension DogBreedListVC: BreedViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tblvwBreeds.reloadData()
        }
    }
}

