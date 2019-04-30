//
//  extensions.swift
//  YouTubeClone
//
//  Created by ibrahim zakarya on 7/8/17.
//  Copyright © 2017 ibrahim zakarya. All rights reserved.
//

import UIKit


extension UIView {
    
    func addConstraintsFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCahce = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlSting: String) {
        
        imageUrlString = urlSting
        
        let url = URL(string: urlSting)
        image = nil
        if let imageFromCahce = imageCahce.object(forKey: urlSting as AnyObject) as? UIImage {
            self.image = imageFromCahce
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlSting {
                    self.image = UIImage(data: data!)
                }
                imageCahce.setObject(imageToCache!, forKey: urlSting as AnyObject)
                
            })
            
        }).resume()
        
    }
}






