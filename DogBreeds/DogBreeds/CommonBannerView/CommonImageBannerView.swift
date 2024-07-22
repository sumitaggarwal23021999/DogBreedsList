import UIKit
import FSPagerView
import SDWebImage

// MARK: - Class CommonImageBannerViews
final class CommonImageBannerView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var pageControl: FSPageControl!
    @IBOutlet private weak var vwPager: FSPagerView!
    @IBOutlet private weak var pagerViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variable and Constants
    var dogsListModel: DogsListModel?
    
    // MARK: - Life Cycle Method
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Internal methods
    @objc public class func addCommonBannerView(_ superView: UIView) -> CommonImageBannerView? {
        let bannerView = UINib(nibName: "CommonImageBannerView", bundle: nil).instantiate(withOwner: self, options: nil).first as? CommonImageBannerView
        guard let bannerView = bannerView else { return nil }
        superView.addSubview(bannerView)
        bannerView.addConstaintsToSuperview()
        bannerView.initialise()
        return bannerView
    }
    
    @objc func initialise() {
        vwPager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        vwPager.delegate = self
        vwPager.dataSource = self
    }
    
    // MARK: - InitaialSetUp
    @objc private func initialSetUp(
        duration: Int,
        leadingMargin: CGFloat,
        trailingMargin: CGFloat
    ) {
        if !(dogsListModel?.dogsList.isEmpty ?? true) {

            /// Adding this because in some cases it is not able to get the correct layouts and not showing the banner image.
            self.layoutIfNeeded()
            
            pagerViewHeightConstraint.constant = 150.0
            vwPager.automaticSlidingInterval = CGFloat((duration/1000));
            vwPager.isInfinite = true;
            vwPager.itemSize = CGSize(width: frame.width - 40.0, height: vwPager.frame.size.height);
            pageControl.numberOfPages = dogsListModel?.dogsList.count ?? 0;
            pageControl.contentHorizontalAlignment = .center;
            pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20);
            vwPager.interitemSpacing = 12;
            vwPager.layer.cornerRadius = 10;
        } else {
            pagerViewHeightConstraint.constant = 0.0
        }
    }
    
    // MARK: - ConfigData
    func configData(
        dogsListModel: DogsListModel?,
        duration: Int,
        leadingMargin: CGFloat = 0.0,
        trailingMargin: CGFloat = 0.0
    ) {
        self.dogsListModel = dogsListModel
        
        /// Reloading before iniytal set up as in initial set up there is one function "self.layoutIfNeeded()" that is creating crash in iPhone 6 12.5.7(real device).
        vwPager.reloadData()
        initialSetUp(
            duration: duration,
            leadingMargin: leadingMargin,
            trailingMargin: trailingMargin
        )
    }
}

// MARK: - Extension FSPagerViewDelegate, FSPagerViewDataSource
extension CommonImageBannerView: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        dogsListModel?.dogsList.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if let image = dogsListModel?.dogsList[index], let imageURL = URL(string: image) {
            cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placehoder_image"))
        }
        cell.imageView?.layer.cornerRadius = 10
        cell.imageView?.contentMode = .scaleToFill;
        cell.imageView?.clipsToBounds = true;
        cell.imageView?.backgroundColor = .clear
        cell.backgroundColor = .clear
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        if (self.pageControl.currentPage != pagerView.currentIndex) {
            self.pageControl.currentPage = pagerView.currentIndex;
        }
    }
}
