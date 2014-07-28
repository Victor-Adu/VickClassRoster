//
//  DetailViewController.swift
//  VictorClassRoster
//
//  Created by Victor  Adu on 7/27/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//


//'UITexfieldShouldReturn' method is not working. Why?
//Bounds dont work either. Why?

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var person : Person!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var justPersonImage: UIImageView!
    
    @IBOutlet weak var githubHandle: UITextField!
    @IBOutlet weak var twitterHandle: UITextField!
 
    
    let textFieldPadding = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //made a 'justPersonImage' outlet variable in our DetailControllerVC and passed our images (picImage) to it.
        if person.picImage == nil {
            justPersonImage.image = UIImage(named: "placeholder")
        } else {
            justPersonImage.image = person.picImage
        }

    }
    
    //Set cornerRadius and border Color of our Image
    override func viewWillAppear(animated: Bool) {
        //You can insert'self.' infront of 'justPersonImage' if you want.
        justPersonImage.layer.cornerRadius = justPersonImage.frame.width * 0.25
        justPersonImage.layer.borderColor = UIColor.greenColor().CGColor
        justPersonImage.layer.borderWidth = 7
        justPersonImage!.layer.masksToBounds = true //Dont forget to end with the maskToBounds method. Very important
        
    }
    
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated) //Dont forget to always call 'super'method on most functions when you override. (the 'super' steps into the Superclass of the current class and makes its properties and methods accessible.
        
        firstNameTextField.text = person.firstName //"firstNameTextField' stores our Person's firstName Property on our DetailViewController
        lastNameTextField.text = person.lastName    //"lastNameTextField' stores our Person's lastName Property on our DetailViewController
        
        githubHandle.text = person.githubHandler    //"githubHandle' stores our Person's github handle Property on our DetailViewController
        twitterHandle.text = person.twitterHandler  //"twitterHandle' stores our Twitter handle Property on our DetailViewController
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        //the 2 lines below allow our set property IBOutlets in 'viewDidAppear' to be edited.
        person.firstName = firstNameTextField.text
        person.lastName = lastNameTextField.text
        
        person.githubHandler = githubHandle.text
        person.twitterHandler = twitterHandle.text
    }
    

    //------IOS TEXTFIELD TOUCH FUNCTIONS
   
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        /*   for control in self.view.subviews {
        if let theControl = control as? UITextField {
        theControl.resignFirstResponder()
        }
        }   */ //Above is same as below
        
        self.view.endEditing(true) //Forces Keyboard to disappear when user clicks outside the Textfield
    }
    
        //implementing UITEXTFIELDDELEGATE METHODS--
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //Setting bounds for our textfield when user begins editing. Basically, we are moving our textfield IBOutlets out of the way to not be covered by our keyboard.
    func textFieldDidBeginEditing(textField: UITextField!) {
        println("began editing")
        
        let curWidth = self.view.bounds.width
        let curHeight = self.view.bounds.height
        let newY = 0.0 + textField.frame.origin.y - self.textFieldPadding
        let currentX = self.view.bounds.origin.x
        
        UIView.animateWithDuration(0.3, animations:{ () -> Void
            in
            
            self.view.bounds = CGRect(x: currentX, y: newY, width: curWidth, height:curHeight)
            //self.view.transform = CGAffineTransformTranslate(self.view.transform, 0.0, -120.0)
            
            })
    }
    
    //Revert our UITextfields to normal after we done editing
    func textFieldDidEndEditing(textField: UITextField!) {
        println("did end editing")
        
        let currentWidth = self.view.bounds.width
        let currentHeight = self.view.bounds.height
                  UIView.animateWithDuration(0.3, animations:{ () -> Void
                      in
        
                      self.view.bounds = CGRect(x: 0, y: 0, width: currentWidth, height:currentHeight)
        
                      })
        
        // "AnimateWithDuration" method variation below
        
        /* UIView.animateWithDuration(0.3) {
            self.view.bounds = CGRect(x: 0, y: 0, width: currentWidth, height:currentHeight)
            //self.view.transform = CGAffineTransformTranslate(self.view.transform, 0.0, 120.0)
            //Note that you can use 'CGAffineTransformTranslate' method to achieve same settings for the bounds.
        }   */
        
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
