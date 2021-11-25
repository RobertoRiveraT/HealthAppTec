//
//  RegisterViewController.swift
//  HealthApp
//
//  Created by user190113 on 11/2/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerBtnAction(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password){
                (result, error) in
                
                if let result = result, error == nil {
                
                    
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    
                    let inputToSting: String = self.nombreTextField.text!
                    
                    let object: [String: Any] = [
                        "Nombre": inputToSting as NSObject,
                        "parametro2": "yes"
                    ]
                    
                    self.ref = Database.database().reference()
                    self.ref.child(userID).setValue(object)
                    
                    //Leer
                    self.ref.child(userID).observeSingleEvent(of: .value, with: { snapshot in
                        guard let value = snapshot.value as? [String: Any] else {
                            return
                        }
                        
                        print("Readed value: \(value)")
                        print("Readed value first: \(value["Nombre"])")
                    })
                    
                    print("Auth correct")
                    print(inputToSting)
                    print(userID)
                    print("Auth correct")
                    let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homePage") as! UITabBarController
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController, animated:true, completion:nil)
                    
                }else{
                    print("Auth failed")
                    let alertController = UIAlertController(title: "Error",
                        message:
                            "Se produjo un error en el Login", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
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
