
import UIKit

public class Photo {
    
    // 缩略图
    // 当用户点击一张缩略图打开 photo browser 时，默认显示的站位图
    // 因为一般会共用图片缓存，所以可认为此图无需加载
    var thumbnailUrl = ""
    
    // 高清图
    // 打开 photo browser 后自动加载的第一张图片
    var highQualityUrl = ""
    
    // 原图
    // 当高清图加载完成后，如果原图，会显示【查看原图】按钮
    var rawUrl = ""
    
    var image: UIImage!
    
    public init(thumbnailUrl: String, highQualityUrl: String, rawUrl: String) {
        self.thumbnailUrl = thumbnailUrl
        self.highQualityUrl = highQualityUrl
        self.rawUrl = rawUrl
    }
    
    public convenience init(image: UIImage) {
        self.init(thumbnailUrl: "", highQualityUrl: "", rawUrl: "")
        self.image = image
    }
    
}
