//
//  ViewController.swift
//  VictorClassRoster
//
//  Created by Victor  Adu on 7/26/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()  //Created an instance (object/Copy) of the Person class
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        people = arrayToLoadFromPlist()
        
    }
    
    
    // -----imported 'arrayToLoadFromPlist' func over. How come method is not working if I let it be with Person.swift Model class?
    
    func arrayToLoadFromPlist() -> [Person] {
        
        var classRoster = [Person]()
        
        //Created a path for 'peopleInClass.plist' with NSBundle mtd and hooked it var 'personPathFromPlist'
        //We then stored the plist's contentsOfFile (an array of dictionaries of first and last names of people in class) in personFromPlistArray
        let personPathFromPlist = NSBundle.mainBundle().pathForResource("peopleInClass", ofType: "plist")
        let personFromPlistArray = NSArray(contentsOfFile: personPathFromPlist)
        
        //The 'For In' loop below allows us to step through our plist file and output each of our array. Each outputted array is stored in 'anyPerson'(Could be any name). Mind you,-here we only have one array <Root> to be outputted.
        //"With our 'if let..' we write a catch for our 'dictionary' objects (first, last,imagePic) within our <Root> array (else our 'For in' loop will skip it)
        for anyPerson in personFromPlistArray {
            
            if let person = anyPerson as? Dictionary<String, String> {
                let firstN = person["first"] as String    //Note here that 'first' matches our key from plist list
                let lastN = person["last"] as String      //'last' here matches our plist key.IT MUST MATCH!!!
                
                let personImage = person["imagePic"]     //'imagePic' matches same key from our dictionary
                
                let peopleInClassRoster = Person(fName: firstN, lName: lastN)
                peopleInClassRoster.picImage = UIImage(named: personImage)
               
                classRoster.append(peopleInClassRoster) //We then pass our dictionary stored properties from the <Root> array and append it to our classRoster (which bears an instance of an empty person array)
            }
        }
        return classRoster
    }
    
    // --------------------------------------
    
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData() //Reloads data into cell every time we visit TableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //From UITABLEVIEWDATASOURCE: Populating Tableview with plist data
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CustomPersonCell //'Cell' should always match the name you give it in storyboard.
        //The 'dequeueReusableCellWithIdentifier' method holds a 'reference to'(think of it as a 'pointer to' in Objective-C) top cells and stacks them to the bottom of  table cells as user scroll down through a tableView, allowing other external data to be passed onto them.
        
        let personInRow = people[indexPath.row]
        cell.personNameCellCustom.text = personInRow.fullName()
       /* cell.detailTextLabel.text = personInRow.lastName    /This will work if you change the display style of you 'Table View Cell' in storyboard. */
        
        cell.imagePicCustom.image = personInRow.picImage  //This works if all we want to show is images besides fullName in our tableView cells. Note that I have intentionally omitted Brad's photo. So lets take it a step further and create an 'if else' statement to catch any person without a photo image
        
        if !personInRow.picImage { //Or you can replace 'if !personInRow.picImage' with 'if personInRow.picImage? == nil'
         //   cell.imageView.hidden = true  //You do '.hidden = true' if there is no image at all to show
            cell.imagePicCustom.image = UIImage(named: "placeholder") //Note here that we didnt add .png. Swift and Objective-C recognizes .png files. if any other image file, append its extension to it.
        } else {
            cell.imagePicCustom.image = personInRow.picImage
        }

        
        println("Deque reusable cell")
        return cell
        
    }
    
    
    //From UITABLEVIEWDELEGATE: Responsible for appearance and interactions with Tableview cells
    
    //Function deselect highlighted cells when we return to them
    func tableView(tableView: UITableView!,
        didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //Provides Delete function
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade) //Note that you can comment this line out if you dont want any animation as your cell rows upon deletion. But be warned that should you comment this line out, you'll need to add 'tableView.reloadData()' line as below for code to work.
            //tableView.reloadData()
        }
    }
    
    //Setup Segue to transition from PeoplTableViewController to DetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if segue.identifier == "showPersonDetails" {
            
            let destination = segue.destinationViewController as DetailViewController
            destination.person = people[tableView!.indexPathForSelectedRow().row]
        } else if segue.identifier == "addNewPerson" { //Adds new person to our array
            let destination = segue.destinationViewController as DetailViewController
            var person = Person (fName: " ", lName: " ")
            people.append(person)
            destination.person = person
            
        }
    }
}
    


