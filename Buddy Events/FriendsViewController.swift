//
//  FriendsViewController.swift
//  Buddy Events
//
//  Created by Kewal on 17/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit
import Foundation

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	
	var friends : [Friends] = []
	
	
	
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	var indexPath = Int()
	var rowIndex = Int()
	
	
	@IBOutlet weak var friendTableView: UITableView!
	
	
	override func viewWillAppear(_ animated: Bool) {
		
		getFriendData() //get data from database
		friendTableView.reloadData() //reload the table view
		rowIndex = -1
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
		
        friendTableView.delegate = self
		friendTableView.dataSource = self
		
    }
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let friend = friends[indexPath.row]
			context.delete(friend)
			(UIApplication.shared.delegate as! AppDelegate).saveContext()
			
			do {
				friends = try context.fetch(Friends.fetchRequest())
			} catch {
				print("Could not get friends!")
			}
		}
		friendTableView.reloadData()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return friends.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		let friend  = friends[indexPath.row]
		let name = "\(friend.fname!) \(friend.lname!)"
		cell.textLabel?.text = name
		
		return cell
	}
	
	
	func getFriendData() {
		do {
			friends = try context.fetch(Friends.fetchRequest())
		
		} catch {
			print("Could not get friends!")
		}
	}
	
	@IBAction func addFriendAction(_ sender: Any) {
		
		let secondController = AddFriendViewController()
		
		secondController.cellIndex = -1
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		rowIndex = indexPath.row
		
		// Get Cell Label
		let indexPath = tableView.indexPathForSelectedRow!
		
		//let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
		
		performSegue(withIdentifier: "addfriendsegue", sender: indexPath)
		
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if (segue.identifier == "addfriendsegue") {
			
			let secondController = segue.destination as! AddFriendViewController
			
			secondController.cellIndex = rowIndex
			
		}
		
	}
	
	
}
