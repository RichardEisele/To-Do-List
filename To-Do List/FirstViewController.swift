//
//  FirstViewController.swift
//  To-Do List
//
//  Created by Richard Eisele on 2018-12-21.
//  Copyright © 2018 Richard Eisele. All rights reserved.
//

import UIKit

var list = [String]()
//var list = ["string"]
//fileprivate var sourceIndexPath: IndexPath?
//fileprivate var snapshot: UIView?
var myIndex = 0

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var input: UITextField!
    
    //Add item triggered from return key
    @IBAction func primaryActionTriggered(_ sender: Any)
    {
        if (input.text != "")       //Make sure user actually input something
        {
            list.append(input.text!)     //add the item that's in the ui text field
            UserDefaults.standard.set(list, forKey: "myList")
            input.text = ""         //let user input new text after
            myTableView.reloadData() //refresh page
        }
    }
    
    //Saves user data to UserDefaults
    override func viewDidAppear(_ animated: Bool)
    {
        if let x = UserDefaults.standard.object(forKey: "myList") as? [String]
        {
            list = x
        }
        myTableView.reloadData()
    }
    
    //Clears all items from the list
    @IBAction func clearList(_ sender: Any)
    {
            list.removeAll()            //Clear all items from list
            UserDefaults.standard.set(list, forKey: "myList")
            myTableView.reloadData()    //refreshes the list
    }
    
    //Enable editing
    @IBAction func edit(_ sender: UIButton)
    {
        myTableView.isEditing = !myTableView.isEditing
    }
    
    @IBOutlet weak var myTableView: UITableView!
    //Sets rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = list[indexPath.row]
        return cell!
    }
    
    //Allows you to delete items by swiping left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete      //If this was a 'delete' swipe
        {
            list.remove(at: indexPath.row)                          //deletes the exact item user wants to delete
            UserDefaults.standard.set(list, forKey: "myList")
            myTableView.reloadData()                                //call my table view, reload data/update table
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //moving cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let item = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(item, at: destinationIndexPath.row)
        UserDefaults.standard.set(list, forKey: "myList")
    }
    
    //Segue to second view on tap for editing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
 
}

