
import UIKit

public class PhotoBrowser: UIView {
    
    private lazy var collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        view.register(PhotoPage.self, forCellWithReuseIdentifier: cellIdentifier)
        view.dataSource = self
        view.delegate = self
        
        addSubview(view)
        
        return view
        
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
        
    }()
    
    private lazy var dotIndicator: DotIndicator = {
        
        let view = DotIndicator()
        view.color = configuration.dotIndicatorColor
        view.activeColor = configuration.dotIndicatorActiveColor
        view.gap = configuration.dotIndicatorGap
        view.radius = configuration.dotIndicatorRadius
        view.activeRadius = configuration.dotIndicatorActiveRadius
        
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -configuration.dotIndicatorMarginBottom),
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        return view
        
    }()
    
    private lazy var numberIndicator: NumberIndicator = {
        
        let view = NumberIndicator()
        view.separator = configuration.numberIndicatorSeparator
        view.gap = configuration.numberIndicatorGap
        view.textSize = configuration.numberIndicatorTextSize
        view.textColor = configuration.numberIndicatorTextColor
        
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -configuration.numberIndicatorMarginBottom),
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        return view
        
    }()
    
    private lazy var rawButton: SimpleButton = {
        
        let view = SimpleButton()
        
        view.setImage(configuration.rawButtonImage, for: .normal)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.onClick = {
            self.getCurrentPage().loadRawPhoto(configuration: self.configuration)
        }
        
        addSubview(view)
        
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -configuration.rawButtonMarginBottom),
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        return view
        
    }()
    
    private lazy var saveButton: SimpleButton = {
        
        let view = SimpleButton()

        view.setImage(configuration.saveButtonImage, for: .normal)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.onClick = {
            self.saveButton.isHidden = true
            self.getCurrentPage().savePhoto()
        }
        
        addSubview(view)
        
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -configuration.saveButtonMarginBottom),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -configuration.saveButtonMarginRight)
        ])
        
        return view
        
    }()
    
    private let cellIdentifier = "cell"
    
    private var configuration: PhotoBrowserConfiguration!
    
    public var delegate: PhotoBrowserDelegate!
    
    public var photos = [Photo]() {
        didSet {
            dotIndicator.count = photos.count
            numberIndicator.count = photos.count
            collectionView.reloadData()
            
            if photos.count > index {
                collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: false)
            }
        }
    }
    
    public var index = -1 {
        didSet {
            
            dotIndicator.index = index
            numberIndicator.index = index

            if photos.count > index {
                
                if index != getActualIndex() {
                    collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: false)
                }
                
                updateStatus(photo: photos[index])
                
            }
            
        }
    }
    
    public var pageMargin: CGFloat = 0 {
        didSet {
            flowLayout.minimumLineSpacing = pageMargin
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: pageMargin)
            collectionView.frame.size.width = bounds.width + pageMargin
        }
    }
    
    public var indicator = IndicatorType.none {
        didSet {
            switch indicator {
            case .dot:
                dotIndicator.isHidden = false
                numberIndicator.isHidden = true
                break
            case .number:
                dotIndicator.isHidden = true
                numberIndicator.isHidden = false
                break
            default:
                dotIndicator.isHidden = true
                numberIndicator.isHidden = true
            }
        }
    }
    
    public convenience init(configuration: PhotoBrowserConfiguration) {
        self.init()
        self.configuration = configuration
        // 在这先访问 collectionView，确保它是第一个创建
        collectionView.backgroundColor = configuration.backgroundColor
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let size = bounds.size
        flowLayout.itemSize = size
        collectionView.frame.size = CGSize(width: size.width + pageMargin, height: size.height)
        flowLayout.invalidateLayout()
    }

}

extension PhotoBrowser: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoPage
        let onUpdate: (Photo) -> Void = { photo in
            guard self.isCurrentPhoto(photo) else {
                return
            }
            self.updateStatus(photo: photo)
        }
        cell.onScaleChange = onUpdate
        cell.onLoadStart = onUpdate
        cell.onLoadEnd = onUpdate
        cell.onDragStart = onUpdate
        cell.onDragEnd = onUpdate
        cell.onTap = { photo in
            self.delegate.photoBrowserDidTap(photo: photo)
        }
        cell.onLongPress = { photo in
            self.delegate.photoBrowserDidLongPress(photo: photo)
        }
        cell.onSaveComplete = { photo, success in
            if !success {
                self.saveButton.isHidden = false
            }
            self.delegate.photoBrowserSavePhotoComplete(photo: photo, success: success)
        }
        cell.update(photo: photos[indexPath.item], configuration: configuration)
        return cell
    }

}

extension PhotoBrowser: UICollectionViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        index = getActualIndex()
    }
    
}

extension PhotoBrowser {
 
    private func getActualIndex() -> Int {
        return Int(round(collectionView.contentOffset.x / collectionView.bounds.width))
    }
    
    private func getCurrentPage() -> PhotoPage {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PhotoPage
    }
    
    private func isCurrentPhoto(_ photo: Photo) -> Bool {
        guard let index = photos.index(where: { $0 === photo }) else {
            return false
        }
        return index == self.index
    }
    
    private func updateStatus(photo: Photo) {
        if photo.isDragging {
            rawButton.isHidden = true
            saveButton.isHidden = true
            hideIndicator()
        }
        else {
            rawButton.isHidden = !photo.isRawButtonVisible
            saveButton.isHidden = !photo.isSaveButtonVisible
            showIndicator()
        }
    }
    
    private func showIndicator() {
        switch indicator {
        case .dot:
            dotIndicator.isHidden = false
            dotIndicator.setNeedsDisplay()
            break
        case .number:
            numberIndicator.isHidden = false
            numberIndicator.setNeedsDisplay()
            break
        default:
            break
        }
    }
    
    private func hideIndicator() {
        switch indicator {
        case .dot:
            dotIndicator.isHidden = true
            break
        case .number:
            numberIndicator.isHidden = true
            break
        default:
            break
        }
    }
    
    public enum IndicatorType {
        case dot, number, none
    }
    
}
