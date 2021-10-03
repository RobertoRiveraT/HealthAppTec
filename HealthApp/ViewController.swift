//
//  ViewController.swift
//  HealthApp
//
//  Created by user189674 on 9/29/21.
//

//Test github

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageview.image = UIImage(named: "Overview")
        imageview.contentMode = .scaleToFill
    }


}

