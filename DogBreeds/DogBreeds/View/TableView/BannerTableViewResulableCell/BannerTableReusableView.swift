
import UIKit

final class BannerTableReusableView: UITableViewHeaderFooterView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var vwContainer: UIView!
    
    // MARK: - Variable and Constanst
    private var bannerView: CommonImageBannerView?
    var dogsListModel: DogsListModel? {
        didSet {
            showData()
        }
    }
    
    // MARK: - UINib and Identifier
    static func nib() -> UINib {
        return UINib(nibName: "BannerTableReusableView", bundle: nil)
    }
    static let identifier = "BannerTableReusableView"
    
    // MARK: - LifeCycleMethods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - AddBannerView
    private func addBannerView() {
        if bannerView == nil {
            bannerView = CommonImageBannerView.addCommonBannerView(vwContainer)
        }
    }
    
    // MARK: - ShowData
    private func showData() {
        if let dogsListModel {
            addBannerView()
            bannerView?.configData(dogsListModel: dogsListModel, duration: 5000)
        }
    }
}
