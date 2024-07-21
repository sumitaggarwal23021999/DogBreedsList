import UIKit

// MARK: - Class DogsCVC
final class DogsCVC: UICollectionViewCell {
    
    // MARK: - UINib and Identifier
    static let identfier = "DogsCVC"
    static func nib() -> UINib {
        UINib(nibName: "DogsCVC", bundle: .main)
    }
    
    // MARK: - Private IBOutlet
    @IBOutlet private weak var btnFavourite: UIButton!
    @IBOutlet private weak var dogImageView: UIImageView!
    
    // MARK: Varibale
    var imageName: String? {
        didSet {
            setImage()
        }
    }
    
    // MARK: - Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dogImageView.layer.cornerRadius = 5.0 // Adjust the radius as needed
        dogImageView.layer.masksToBounds = true
        dogImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = nil // Reset the image or any other content
    }
    
    // MARK: - Private Internal Methods
    private func setImage() {
        if let imageName = imageName {
            dogImageView.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "dogPlaceHolderImage"))
        }
    }
}
