import UIKit

// MARK: Protocol BreedListTVCDelegate
protocol BreedListTVCDelegate: AnyObject {
    func handleSelectionDeselection(breedModel: BreedModel)
}

// MARK: - Class BreedListTVC
final class BreedListTVC: UITableViewCell {

    // MARK: - IBOtlet
    @IBOutlet private weak var lblBreedName: UILabel!
    
    // MARK: - Variable
    var breedModel: BreedModel? {
        didSet {
            showData()
        }
    }
    
    // MARK: - Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private Functions
    private func showData() {
        if let breedModel = breedModel {
            lblBreedName.text = breedModel.breedName ?? ""
        }
    }
}
