
import UIKit

public class PhotoBrowser: UIView {
    
    private lazy var collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        
        view.register(PhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .gray
        
        addSubview(view)
        
        return view
        
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
        
    }()
    
    private let cellIdentifier = "cell"
    
    public var photos = [Photo]()
    
    public var index = -1
    
    public var pageMargin: CGFloat = 0 {
        didSet {
            flowLayout.minimumLineSpacing = pageMargin
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: pageMargin)
            collectionView.frame.size.width = bounds.width + pageMargin
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = bounds.size
        collectionView.frame.size = CGSize(width: bounds.width + pageMargin, height: bounds.height)
    }
    
    public func append(photo: Photo) {
        photos.append(photo)
        collectionView.reloadData()
    }
    
}

extension PhotoBrowser {

    private func updateScrollX(_ x: CGFloat) {
        index = Int(ceil(x / bounds.width))
    }

}

extension PhotoBrowser: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCell
        cell.update(photo: photos[indexPath.item])
        return cell
    }

}

extension PhotoBrowser: UICollectionViewDelegate {

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        updateScrollX(scrollView.contentOffset.x)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateScrollX(scrollView.contentOffset.x)
    }
    
}

