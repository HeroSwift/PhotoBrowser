
import UIKit

// 配置
open class PhotoBrowserConfiguration {
    
    // 背景色
    public var backgroundColor = UIColor.clear
    
    // 页码指示器到底部的距离
    public var indicatorMarginBottom: CGFloat = 20
    
    // 查看原图按钮的标题
    public var rawButtonImage = UIImage(named: "photo_browser_raw")
    
    // 查看原图按钮到底部的距离
    public var rawButtonMarginBottom: CGFloat = 40
    
    // 保存按钮的图标
    public var saveButtonImage = UIImage(named: "photo_browser_save")
    
    // 保存按钮到底部的距离
    public var saveButtonMarginBottom: CGFloat = 40
    
    // 保存按钮到右边的距离
    public var saveButtonMarginRight: CGFloat = 20
    
    
    public init() { }
    
    open func load(imageView: UIImageView, url: String, onLoadStart: @escaping (Bool) -> Void, onLoadProgress: @escaping (Int64, Int64) -> Void, onLoadEnd: @escaping (Bool) -> Void) {
        
    }
    
    open func isLoaded(url: String) -> Bool {
        return false
    }

}
