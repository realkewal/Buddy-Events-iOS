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
	
	var indexPath = Int()
	var rowIndex = Int()
	
	@IBOutlet weak var friendTableView: UITableView!
	
	override func viewWillAppear(_ animated: Bool) {
		getFriends() //get data from database
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
			deleteFriend(cellIndex: indexPath.row)
			getFriends()
			self.friendTableView.reloadData()
		}
		
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return friends.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
		getFriends() //get data from database
		
		if indexPath.row < friends.count {
			let friend  = friends[indexPath.row]
			let name = "\(friend.fname!) \(friend.lname!)"
			let address = friend.address
			cell.textLabel?.text = name
			cell.detailTextLabel?.text = address
			
			
			cell.imageView?.image = imageWithImage(image: UIImage(data: (friend.image!) as Data)!, scaledToSize: CGSize(width: 20, height: 20))
			
			
		}
		return cell
	}
	
	@IBAction func addFriendAction(_ sender: Any) {
		let secondController = AddFriendViewController()
		secondController.cellIndex = -1
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		rowIndex = indexPath.row
		let indexPath = tableView.indexPathForSelectedRow!
		performSegue(withIdentifier: "addfriendsegue", sender: indexPath)
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "addfriendsegue") {
			let secondController = segue.destination as! AddFriendViewController
			secondController.cellIndex = rowIndex
		}
	}
	
	
}
