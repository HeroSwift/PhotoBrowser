//
//  ViewController.swift
//  Example
//
//  Created by zhujl on 2018/12/12.
//  Copyright © 2018年 finstao. All rights reserved.
//

import UIKit
import PhotoBrowser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let photoBrowser = PhotoBrowser()
        
        photoBrowser.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(photoBrowser)
        
        view.addConstraints([
                NSLayoutConstraint(item: photoBrowser, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 30),
                NSLayoutConstraint(item: photoBrowser, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: photoBrowser, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: photoBrowser, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
        ])
        
        photoBrowser.pageMargin = 20
        
        photoBrowser.append(photo: Photo(image: UIImage(named: "image")!))
        photoBrowser.append(photo: Photo(image: UIImage(named: "wide")!))
        photoBrowser.append(photo: Photo(image: UIImage(named: "long")!))
        photoBrowser.append(photo: Photo(image: UIImage(named: "avatar")!))

        
//        photoView.image = UIImage(named: "avatar")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

