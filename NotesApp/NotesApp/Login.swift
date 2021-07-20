//
//  Login.swift
//  NotesApp
//
//  Created by Krishna Bhatt on 15/07/21.
//
import UIKit

class Login: UIViewController {
    
    private let usernameTextField:UITextField = {
           let textfield = UITextField()
           textfield.placeholder = "Username"
           textfield.textAlignment = .center
           textfield.borderStyle = .roundedRect
           textfield.backgroundColor = .systemFill
           return textfield
       }()
       
       private let passwordTextField:UITextField = {
           let textfield = UITextField()
           textfield.placeholder = "Password"
           textfield.textAlignment = .center
           textfield.borderStyle = .roundedRect
           textfield.backgroundColor = .systemFill
           textfield.isSecureTextEntry = true
           return textfield
       }()
       
       private let mybutton:UIButton = {
           let button = UIButton()
           button.setTitle("Login", for: .normal)
           button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
           button.backgroundColor = .black
           button.layer.cornerRadius = 6
           return button
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Notes2")!)
               view.addSubview(usernameTextField)
               view.addSubview(passwordTextField)
               view.addSubview(mybutton)
    }
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
        usernameTextField.frame = CGRect(x: 20, y: 400, width:view.width-40, height: 40)
        passwordTextField.frame = CGRect(x: 20, y: usernameTextField.bottom + 20, width: view.width - 40, height: 40)
        mybutton.frame = CGRect(x: 20, y: passwordTextField.bottom + 20, width: view.width - 40, height: 40)
      }
      
      let username = "Admin123"
      let password = "Admin@123"
      @objc func loginTapped(){
              if username == usernameTextField.text! && password == passwordTextField.text! {
                  UserDefaults.standard.set(usernameTextField.text!, forKey: "email")
                  let vc = File()
                  navigationController?.pushViewController(vc, animated: true)
              } else {
                  let alert = UIAlertController(title: "Alert!", message: "Email and Password didn't match", preferredStyle: .alert)
                  let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                  alert.addAction(ok)
                  present(alert, animated: true, completion: nil)
              }
          }
  }
