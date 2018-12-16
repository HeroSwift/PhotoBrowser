
import Foundation

public protocol PhotoBrowserDelegate {
    
    // 保存图片完成
    func photoBrowserSavePhotoComplete(photo: Photo, success: Bool)
    
}

public extension PhotoBrowserDelegate {

    func photoBrowserSavePhotoComplete(photo: Photo, success: Bool) { }
    
}

