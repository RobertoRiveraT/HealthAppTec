//
//  ProfileViewController.swift
//  HealthApp
//
//  Created by user189674 on 11/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var NombreLabel: UILabel!
    
    var ref: DatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.ref = Database.database().reference()
        
        //Leer
        self.ref.child(userID).observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            
            self.NombreLabel.text = value["Nombre"] as! String
            
            print("Readed value: \(value)")
            print("Readed value first: \(value["Nombre"])")
        })
        
    }
    
    @IBAction func cerrarSesión(_ sender: UIButton) {
        print((Auth.auth().currentUser?.email)! )
        try? Auth.auth().signOut()
        print(Auth.auth().currentUser)
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginView") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
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
