//
//  LoginViewController.swift
//  social_project
//
//  Created by Saeed Ali on 10/4/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    static let sharedWebClient = WebClient.init(baseUrl: "http://46.101.1.128/api")

    @IBOutlet weak var student_number: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var loginView: UIView!
    
    var loginTask: URLSessionDataTask!
    var studentProfile : Records!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loginView.bindToKeyboard()
        let tbvc = self.tabBarController as! TabBarViewController!
        studentProfile = tbvc?.studentProfile
        // Do any additional setup after loading the view.
        
        //Make the login Button rounded
        loginButton.layer.cornerRadius = 8
        loginButton.layer.borderColor = UIColor(red: 0, green: 55, blue: 119, alpha: 1).cgColor
        loginButton.clipsToBounds = true
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        student_number.resignFirstResponder()
        password.resignFirstResponder() 
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let studentNumber = student_number.text
        let studentPassword = password.text
        
        //  Ensure that no field is empty 
        if( (studentNumber?.isEmpty)! || (studentPassword?.isEmpty)!)
        {
            //Display an alert message
            print("student number\(String(describing: studentNumber)) or password\(String(describing: password)) is empty")
            displayMessage(userMessage: "one of the required fields is empty")
            return
            
        }
        
        //call the function that does the HTTP Request
        DoLogin(studentNumber!, studentPassword!)
        
    }
    
    
    
    /* // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func DoLogin(_ username: String, _ password: String)
    {
        
        
    
        
        /* Create Activity indicator */
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        /* Position activity indicator at the center of thh main view */
        myActivityIndicator.center = view.center
        
        /* prevent activity indicator from hiding when stopAnimating() is called */
        myActivityIndicator.hidesWhenStopped = false
        
        /* start activity indicator */
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        loginTask = LoginViewController.sharedWebClient.load(path: "/student/login/", method: .post, params: ["student_number" : username, "password": password ]) { (data, error) in
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
        
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.handleError(error!)
                return
            }
            
            print(HTTPCookieStorage.shared.cookies)
            
            
            /*  Get records from parsed Data */
            guard let records = data?["records"] as? AnyObject else {
               print("There was an error parsing the data")
                return
            }
            
            /* Get access token from records data */
            guard let accessToken = records["access_token"] as? AnyObject else {
                print("Unable to get the access token")
                return
            }
            
        
            self.studentProfile = Records(dictionary: records as! NSDictionary)
            
            
        DispatchQueue.main.async {
            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            let appDelegate = UIApplication.shared.delegate
            homePage.studentProfile = self.studentProfile
            appDelegate?.window??.rootViewController = homePage
            
            
            }
        }
    }

    
    /*  Display alerts to the user */
   public func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default, handler:{(alert: UIAlertAction!)
                in
                print("OK button pressed")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    
    }
    
    
    /* handle any connection or service related errors */
    public func handleError(_ error: ServiceError) {
        switch error {
        case .noInternetConnection:
            displayMessage(userMessage: "The internet connection is lost")
        case .other:
            displayMessage(userMessage: "Unfortunately something went wrong")
        case .custom(let error):
            displayMessage(userMessage: error.description)
        }
    }
    
    //Function to remove the activity Indicator
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        
    }
    
}


