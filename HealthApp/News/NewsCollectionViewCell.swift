//
//  NewsCollectionViewCell.swift
//  HealthApp
//
//  Created by user190113 on 10/4/21.
//

import UIKit


class NewsCollectionViewCell: UICollectionViewCell {
    
    var destinyURL: String = "www.google.com"
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var fuente: UILabel!
    @IBOutlet weak var titulo: UITextView!
    
    
    @IBAction func redirectURL(_ sender: UIButton) {
//        print(destinyURL)
        UIApplication.shared.open(URL(string: destinyURL)! as URL, options: [:], completionHandler: nil)
    }
    
}
