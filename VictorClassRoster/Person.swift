//
//  Person.swift
//  VictorClassRoster
//
//  Created by Victor  Adu on 7/26/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var firstName:String
    var lastName:String
    var picImage : UIImage?
    
    var twitterHandler : String?
    var githubHandler : String?
    
    init(fName:String, lName:String){
    
        firstName = fName
        lastName = lName
    
    }
    
    func fullName() -> String {
    
    return self.firstName + " " + self.lastName
    }
    
    func arrayToLoadFromPlist() -> [Person] {
    
        var classRoster = [Person]()
        
    //Created a path for 'peopleInClass.plist' with NSBundle mtd and hooked it var 'personPathFromPlist'
    //We then stored the plist's contentsOfFile (an array of dictionaries of first and last names of people in class) in personFromPlistArray
    let personPathFromPlist = NSBundle.mainBundle().pathForResource("peopleInClass", ofType: "plist")
    let personFromPlistArray = NSArray(contentsOfFile: personPathFromPlist)
        
    //The 'For In' loop below allows us to step through our plist file and output each of our array. Each outputted array is stored in 'anyPerson'(Could be any name). Mind you,-here we only have one array <Root> to be outputted.
       //"With our 'if let..' we write a catch for our 'dictionary' objects (first, last) within our <Root> array (else our 'For in' loop will skip it)
    for anyPerson in personFromPlistArray {
        
        if let person = anyPerson as? Dictionary<String, String> {
            let firstN = person["first"] as String    //Note here that 'first' matches our key from plist list
            let lastN = person["last"] as String      //'last' here matches our plist key.IT MUST MATCH!!!
            
            classRoster.append(Person(fName: firstN, lName: lastN)) //We then pass our dictionary stored properties from the <Root> array and append it to our classRoster (which bears an instance of an empty person array)
        }
    }
    return classRoster
 }

}
