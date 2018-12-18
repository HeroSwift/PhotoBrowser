//
//  ViewController.swift
//  Example
//
//  Created by zhujl on 2018/12/12.
//  Copyright © 2018年 finstao. All rights reserved.
//

import UIKit
import PhotoBrowser
import Kingfisher

class Configuration: PhotoBrowserConfiguration {
    
    override func load(imageView: UIImageView, url: String, onLoadStart: @escaping (Bool) -> Void, onLoadProgress: @escaping (Int64, Int64) -> Void, onLoadEnd: @escaping (Bool) -> Void) {
        let url = URL(string: url)
        onLoadStart(true)
        imageView.kf.setImage(
            with: url,
            options: [.forceRefresh],
            progressBlock: { receivedSize, totalSize in
                onLoadProgress(receivedSize, totalSize)
            },
            completionHandler: { image, error, cacheType, imageURL in
                if let error = error {
                    print(error)
                    onLoadEnd(false)
                }
                else {
                    onLoadEnd(true)
                }
            }
        )
    }
    
    override func isLoaded(url: String) -> Bool {
        
        guard let url = URL(string: url) else {
            return false
        }

        let cache = KingfisherManager.shared.cache
        let result = cache.imageCachedType(forKey: url.cacheKey)
        
        switch result {
        case .none:
            break
        default:
            return false
        }
        
        return false
        
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = SimpleButton()
        button.setTitle("open", for: .normal)
        button.setBackgroundColor(.gray, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        view.addConstraints([
            NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60),
        ])
        
        let photos = [Photo](arrayLiteral:
            // 1200*2130
            Photo(thumbnailUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956348812&di=2168aaa69c5bbf570264851dcf330b9b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201408%2F26%2F20140826185524_jmvhB.jpeg", highQualityUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956348812&di=2168aaa69c5bbf570264851dcf330b9b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201408%2F26%2F20140826185524_jmvhB.jpeg", rawUrl: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4144150771,312493387&fm=26&gp=0.jpg"),
                
                // 2008*5896
            Photo(thumbnailUrl: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4144150771,312493387&fm=26&gp=0.jpg", highQualityUrl: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4144150771,312493387&fm=26&gp=0.jpg", rawUrl: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4144150771,312493387&fm=26&gp=0.jpg"),
            
            // 1200*799
            Photo(thumbnailUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956463854&di=34c10544974f5457609f2a52b7885c3e&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ffaf2b2119313b07eefa253db07d7912396dd8cc1.jpg", highQualityUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956463854&di=34c10544974f5457609f2a52b7885c3e&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ffaf2b2119313b07eefa253db07d7912396dd8cc1.jpg", rawUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956463854&di=34c10544974f5457609f2a52b7885c3e&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ffaf2b2119313b07eefa253db07d7912396dd8cc1.jpg"),
            
            // 1366*768
            Photo(thumbnailUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956532057&di=6afd317a94ab8cafe5ce5aaaa69c2021&imgtype=0&src=http%3A%2F%2Fimg5.hao123.com%2Fdata%2Fdesktop%2F7c6a7c2871d4127170ea05bcd2002d18_1366_768", highQualityUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956532057&di=6afd317a94ab8cafe5ce5aaaa69c2021&imgtype=0&src=http%3A%2F%2Fimg5.hao123.com%2Fdata%2Fdesktop%2F7c6a7c2871d4127170ea05bcd2002d18_1366_768", rawUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544956532057&di=6afd317a94ab8cafe5ce5aaaa69c2021&imgtype=0&src=http%3A%2F%2Fimg5.hao123.com%2Fdata%2Fdesktop%2F7c6a7c2871d4127170ea05bcd2002d18_1366_768")
        )
        
        button.onClick = {
            PhotoBrowserController(configuration: Configuration(), indicator: .dot, pageMargin: 30).show(photos: photos, index: 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

