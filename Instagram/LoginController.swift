//
//  ViewController.swift
//  Instagram
//
//  Created by Kyle Ohanian on 2/6/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import Parse

class LoginController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        // set user properties
        
        let usernameA = usernameTextField.text ?? ""
        let passwordA = passwordTextField.text ?? ""
        
        newUser.username = usernameA
        newUser.password = passwordA
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let alert = UIAlertController(title: "Sign up failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                PFUser.logInWithUsername(inBackground: usernameA, password: passwordA) { (user: PFUser?, error: Error?) in
                    if let error = error {
                        let alert = UIAlertController(title: "My Alert", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                        self.present(alert, animated: true, completion: nil)
                        print("User log in failed: \(error.localizedDescription)")
                    } else {
                        print("User logged in successfully")
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    }
                }
            }
        }
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alert = UIAlertController(title: "Login Failed", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

