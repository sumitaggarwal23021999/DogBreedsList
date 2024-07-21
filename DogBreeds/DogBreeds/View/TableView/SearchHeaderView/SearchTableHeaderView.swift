import UIKit

protocol SearchTableHeaderViewDelegate: AnyObject {
    func seachBreed(searchText: String)
}

final class SearchTableHeaderView: UITableViewHeaderFooterView {

    // MARK: - IBOutlet
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - UINib and Identifier
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableHeaderView", bundle: nil)
    }
    static let identifier = "SearchTableHeaderView"
    
    // MARK: - Varibale and Constants
    var delegate: SearchTableHeaderViewDelegate?
    
    // MARK: - LifeCycleMethods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        doInitalSetUp()
    }
    
    private func doInitalSetUp() {
        searchBar.delegate = self
    }
}

// MARK: - Extension UISearchBarDelegate
extension SearchTableHeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.seachBreed(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
