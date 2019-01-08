//
//  ViewController.swift
//  To-Do List
//
//  Created by Richard Eisele on 2019-01-02.
//  Copyright © 2019 Richard Eisele. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        input.text = list[myIndex]
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var input: UITextField!

    @IBAction func primaryActionTriggered(_ sender: UITextField)
    {
        if (input.text != "")       //Make sure user actually input something
        {
            list.remove(at: myIndex)                         //deletes the exact item user wants to delete
            list.append(input.text!)     //add the item that's in the ui text field
            UserDefaults.standard.set(list, forKey: "myList")
            input.text = ""         //let user input new text after
        }
    }

}
