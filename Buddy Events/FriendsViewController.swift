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
	
	// initialize required variables
	var indexPath = Int()
	var rowIndex = Int()
	
	@IBOutlet weak var friendTableView: UITableView!
	
	override func viewWillAppear(_ animated: Bool) {
		//get data from database
		getFriends()
		//reload the data in table view
		friendTableView.reloadData()
		rowIndex = -1
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//Set delegate and source for tableview
		friendTableView.delegate = self
		friendTableView.dataSource = self
		
    }
	
	// enable left swipe deletion on table rows
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// delete the entry in table view and coredata
			deleteFriend(cellIndex: indexPath.row)
			//get and reload data in table view
			getFriends()
			self.friendTableView.reloadData()
		}
	}

	// set number of rows to display in table view
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return friends.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// set the required cell
		let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
		//get data from database
		getFriends()
		
		// perform actions only if the index range is less than or equal to the array feeding the values to the rows in table view
		if indexPath.row < friends.count {
			let friend  = friends[indexPath.row]
			let name = "\(friend.fname!) \(friend.lname!)"
			let address = friend.address
			//set all the values in custom table view cell
			cell.friendName.text = name
			cell.friendAddress.text = address
			cell.frindImage.image = UIImage(data: (friend.image! as Data))
		}
		return cell
	}
	
	// disable editing when new record is to be added
	@IBAction func addFriendAction(_ sender: Any) {
		let secondController = AddFriendViewController()
		secondController.cellIndex = -1
	}

	// performs segue to addedit friend controller
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		rowIndex = indexPath.row
		let indexPath = tableView.indexPathForSelectedRow!
		performSegue(withIdentifier: "addfriendsegue", sender: indexPath)
		
	}
	
	// change the index value in add/edit view controller for editing when row is selected
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "addfriendsegue") {
			let secondController = segue.destination as! AddFriendViewController
			secondController.cellIndex = rowIndex
		}
	}
	
	
}
