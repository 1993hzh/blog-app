//
//  ViewController.swift
//  blog
//
//  Created by Leo on 22/1/2016.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let loginURL = NSURL(string: Global.server + Global.loginURL)

    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        
        login.addTarget(self, action: "login:", forControlEvents: .TouchDown)
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
    
    func login(button: UIButton) {
//        let params:[String: String] = [
//            "name" : username.text!,
//            "password" : password.text!
//        ]
//        doLogin(params)
        let refreshAlert = UIAlertController(title: "TODO", message: "Currently the login module is not enabled, will work on this later.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            //TODO
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func doLogin(params: [String: String]) {
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: loginURL!)
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        
        session.dataTaskWithRequest(request, completionHandler:{(data, response, error) -> Void in
            if error != nil {
                NSLog(error!.localizedDescription)
                return
            }
            
            do {
                let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options:[])
                print("Array: \(jsonArray)")
                //TODO
            }
            catch {
                NSLog("Login failed with error: \(error)")
            }
        }).resume()
    }
    
    @IBOutlet var login: UIButton!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
}

