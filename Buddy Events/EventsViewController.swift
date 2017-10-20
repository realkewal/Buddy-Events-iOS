//
//  EventsViewController.swift
//  Buddy Events
//
//  Created by Kewal on 17/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	
	var indexPath = Int()
	var rowIndex = -1
	var longpress = false
	
	let dateFormatter = DateFormatter()
	let timeFormatter = DateFormatter()
	
	@IBOutlet weak var eventTableView: UITableView!
	
	
	override func viewWillAppear(_ animated: Bool) {
		getEvents ()
		eventTableView.reloadData()
		rowIndex = -1
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		eventTableView.delegate = self
		eventTableView.dataSource = self
		
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			deleteEvent(cellIndex: indexPath.row)
			getEvents ()
			self.eventTableView.reloadData()
			
		}
		
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return events.count
	
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
		getEvents ()
		if indexPath.row < events.count {
			let event = events[indexPath.row]
			let eventName = event.ename
			let eventDate = event.edate
			
			dateFormatter.dateStyle = DateFormatter.Style.medium
			timeFormatter.timeStyle = DateFormatter.Style.short
			let edate = dateFormatter.string(from: event.edate! as Date)
			let etime = timeFormatter.string(from: event.edate! as Date)
			
			if (eventDate! as Date) < Date() {
				
				cell.imageView?.image = imageWithImage(image: UIImage(named: "sandtimerb.png")!, scaledToSize: CGSize(width: 15, height: 15))
			} else {
				cell.imageView?.image = imageWithImage(image: UIImage(named: "sandtimerf.png")!, scaledToSize: CGSize(width: 15, height: 15))
			}
			cell.textLabel?.text = eventName
			cell.detailTextLabel?.text = "\(edate) \(etime)"
		}
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		rowIndex = indexPath.row
		let indexPath = tableView.indexPathForSelectedRow!
		
		
		if eventTableView.isEditing == false {
				performSegue(withIdentifier: "addEventSegue", sender: indexPath)
		}

	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "addEventSegue") {
			let secondController = segue.destination as! AddEventViewController
			secondController.cellIndex = rowIndex
		}
	}
	
	

}
