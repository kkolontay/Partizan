//
//  MainViewController.swift
//  Partisan
//
//  Created by kkolontay on 5/3/16.
//  Copyright © 2016 kkolontay.test.com. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonGreen: UIButton!
    @IBOutlet weak var buttonBlue: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    private var oldShow:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
       // WarningClass.warning("Hello world", viewController: self)
        oldShow = true
        passwordTextField.delegate = self
        emailTextField.delegate = self
        let image = UIImage(named: "MainScreen")
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard)))
       imageView.image = image
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        borderBottom(emailTextField)
        borderBottom(passwordTextField)
       // WarningClass.warning("hello", viewController: self)

    }

    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func borderBottom (textField: UITextField) {
        let border = CAShapeLayer()
        border.lineJoin = kCALineJoinRound
        border.path = UIBezierPath(roundedRect: CGRectMake(0.0, textField.frame.size.height - 5, textField.frame.size.width, textField.frame.size.height ), cornerRadius: 0).CGPath
        border.lineDashPattern = [6, 3]
        border.strokeColor = UIColor.grayColor().CGColor
        border.fillColor = nil
        border.borderWidth = 1
              textField.layer.addSublayer(border)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func dismissKeyboard() {
       
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    func keyboardWillShow(notification: NSNotification) {
        if  oldShow! {
            adjustKeyboardShow(true, notification: notification)
            oldShow = false
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if !oldShow! {
        adjustKeyboardShow(false, notification: notification)
            oldShow = true
        }
    }
    
    func adjustKeyboardShow(show: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    @IBAction func buttonGreenPressed(sender: AnyObject) {
         buttonGreen.setBackgroundImage(UIImage(named: "Button_green_pressed"), forState: .Normal)
        let trigerredTime = (Int64(NSEC_PER_SEC) * 1)
        let time = dispatch_time(DISPATCH_TIME_NOW, trigerredTime/2)
        dispatch_after(time, dispatch_get_main_queue(), {
       self.buttonGreen.setBackgroundImage(UIImage(named: "Button_green_unpressed"), forState: .Normal)
        })
    }
    @IBAction func buttonBluePressed(sender: AnyObject) {
        buttonBlue.setBackgroundImage(UIImage(named: "Button_blue_pressed"), forState: .Normal)
        let trigerredTime = (Int64(NSEC_PER_SEC) * 1)
        let time = dispatch_time(DISPATCH_TIME_NOW, trigerredTime/2)
        dispatch_after(time, dispatch_get_main_queue(), {
        self.buttonBlue.setBackgroundImage(UIImage(named: "Button_blue_unpressed"), forState: .Normal)
        })
    }
}

