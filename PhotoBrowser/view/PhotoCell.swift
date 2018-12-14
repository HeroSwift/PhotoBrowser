
import UIKit

class PhotoCell: UICollectionViewCell {
    
    private lazy var photoView: PhotoView = {
        let view = PhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        contentView.addConstraints([
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0),
        ])
        return view
    }()

    func update(photo: Photo) {
        photoView.image = photo.image
    }

}
