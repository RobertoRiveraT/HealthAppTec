//
//  startViewController.swift
//  HealthApp
//
//  Created by user190113 on 10/26/21.
//

import UIKit

class startViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "isSecondTime") == true {
            print("Second+")
            defaults.setValue(true, forKey:"isSecondTime")
            
        }else{
            print("First")
            defaults.setValue(true, forKey:"isSecondTime")
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
