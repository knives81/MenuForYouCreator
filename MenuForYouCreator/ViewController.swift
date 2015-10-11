//
//  ViewController.swift
//  MenuForYouCreator
//
//  Created by Maurizio Pinzi on 07/10/15.
//  Copyright © 2015 Maurizio Pinzi. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            print("Logged in..")
        }
        
        var loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            print("error")
        }
        else if result.isCancelled {
            print("cancelled")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                print("email")
                let accessToken = FBSDKAccessToken.currentAccessToken()
                let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
                    req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                    if(error == nil)
                    {
                        print("result \(result)")
                    }
                    else
                    {
                        print("error \(error)")
                    }
                })
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func test(sender: AnyObject) {
        Alamofire.request(.GET, "http://localhost:8082/menuforyou/ingredients/2000?language=IT")
        print("Hello, world");
    }


}

