//
//  AddEventViewController.swift
//  Buddy Events
//
//  Created by Kewal on 17/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
	
	var cellIndex = -1
	
	@IBOutlet weak var eventNameTextField: UITextField!
	@IBOutlet weak var eventLocationTextField: UITextField!
	@IBOutlet weak var eventDatePicker: UIDatePicker!

	@IBAction func eventSaveAction(_ sender: Any) {
		
		let ename = eventNameTextField.text!
		let elocation = eventLocationTextField.text!
		let edate = eventDatePicker.date
		
		if cellIndex == -1 {
			addEvent(ename: ename, edate: edate, elocation: elocation)
		} else {
			updateEvent(ename: ename, edate: edate, elocation: elocation, cellIndex: cellIndex)
		}
		navigationController?.popViewController(animated: true) // Pops back to previous view controller
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		if cellIndex > -1  {
			
			getEvents()
			
			eventNameTextField.text = events[cellIndex].ename
			eventLocationTextField.text = events[cellIndex].elocation
			eventDatePicker.setDate(events[cellIndex].edate! as Date, animated: true)
			
		}

	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let dateFormatter = DateFormatter()
		let date = eventDatePicker.date
		dateFormatter.timeZone = NSTimeZone.local
		print("date is \(dateFormatter.string(from: date))")
    }

	

}
