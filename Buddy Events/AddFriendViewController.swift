//
//  AddFriendViewController.swift
//  Buddy Events
//
//  Created by Kewal on 17/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit
import Foundation

class AddFriendViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	//Following line is used to interact with core data
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	var friends : [Friends] = []
	var cellIndex = -1
	var selectedImage = UIImage()
	
	// Outlets for all elements used in Add/Edit Friend View Controller

	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var friendImageView: UIImageView!
	@IBOutlet weak var browseImageButton: UIButton!
	@IBOutlet weak var genderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var ageTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	
	
	
	
	
	// Following actions will be performed when Age Stepper is pressed
	@IBAction func ageStepper(_ sender: Any) {
		
		
	}
	
	// Following action will be used when browse button is pressed
	@IBAction func browseImageButtonAction(_ sender: Any) {
		
		let image = UIImagePickerController()
		image.delegate = self
		
		image.sourceType = UIImagePickerControllerSourceType.photoLibrary
		
		image.allowsEditing = false
		
		self.present(image, animated: true)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			friendImageView.image = image
			selectedImage = image
			
		} else {
			//Display error message here
		}
		
		self.dismiss(animated: true, completion: nil)
	}
	
	// Following actions will be performed when Save button is pressed
	@IBAction func saveFriendButton(_ sender: Any) {

		
		let friend = Friends(context: context) // Object refers to entity in coredata
		
		
		
		//let objectID = friends[cellIndex].objectID
		
		friend.fname = firstNameTextField.text!
		friend.lname = lastNameTextField.text!
		let img = friendImageView.image
		let imgData = UIImageJPEGRepresentation(img!, 1)
		friend.image = imgData! as NSData
		if genderSegmentedControl.selectedSegmentIndex == 0 {
			friend.gender = "Male"
		} else if genderSegmentedControl.selectedSegmentIndex == 1 {
			friend.gender = "Female"
		} else if genderSegmentedControl.selectedSegmentIndex == 2 {
			friend.gender = "Other"
		}
		friend.age = Int16(ageTextField.text!)!
		friend.address = addressTextField.text!
		
		
		
		(UIApplication.shared.delegate as! AppDelegate).saveContext() // Saves all the data to database
		
		
	
		
		
		
		
		
		
	}
	
	// Following actions will be performed when Delete (Trash) button is pressed
	@IBAction func deleteFriendButton(_ sender: Any) {
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		if cellIndex > -1  {

			getFriendData()
			
			firstNameTextField.text = friends[cellIndex].fname
			lastNameTextField.text = friends[cellIndex].lname
			let thumbnail = UIImage(data: (friends[cellIndex].image!) as Data)
			friendImageView.image = thumbnail
			if friends[cellIndex].gender == "Male" {
				genderSegmentedControl.selectedSegmentIndex = 0
			} else if friends[cellIndex].gender == "Female" {
				genderSegmentedControl.selectedSegmentIndex = 1
			} else if friends[cellIndex].gender == "Other" {
				genderSegmentedControl.selectedSegmentIndex = 2
			}
			ageTextField.text = String(friends[cellIndex].age)
			addressTextField.text = friends[cellIndex].address
		}
	}
	
	func getFriendData() {
		
		do {
			friends = try context.fetch(Friends.fetchRequest())
		} catch {
			print("Could not get friends!")
		}
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		
		print(cellIndex)
		
    }
	
	
	
	
}
