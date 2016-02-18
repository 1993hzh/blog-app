//
//  ViewController.swift
//  blog
//
//  Created by Leo on 22/1/2016.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // do nothing
    }
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
}

