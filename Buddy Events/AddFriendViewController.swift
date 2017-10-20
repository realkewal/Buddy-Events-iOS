//
//  AddFriendViewController.swift
//  Buddy Events
//
//  Created by Kewal on 17/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddFriendViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	

	var cellIndex = -1

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
		image.allowsEditing = true
		self.present(image, animated: true)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		var selectedImage = UIImage()
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			 selectedImage = image
		}
		else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			 selectedImage = image
		} else{
			print("Something went wrong")
		}
		
		self.dismiss(animated: true, completion: {
			self.friendImageView.image = selectedImage
		})
	}
	
	// Following actions will be performed when Save button is pressed
	@IBAction func saveFriendButton(_ sender: Any) {
		var gender = String()
		let fname = firstNameTextField.text!
		let lname = lastNameTextField.text!
		
		let imgData = UIImageJPEGRepresentation(friendImageView.image!, 1)
		
		let image = imgData! as NSData

		if genderSegmentedControl.selectedSegmentIndex == 0 {
			 gender = "Male"
		} else if genderSegmentedControl.selectedSegmentIndex == 1 {
			 gender = "Female"
		} else if genderSegmentedControl.selectedSegmentIndex == 2 {
			 gender = "Other"
		}
		
		let age = Int16(ageTextField.text!)!
		let address = addressTextField.text!
		
		if cellIndex == -1 {
			addFriend(fname: fname, lname: lname, image: image, gender: gender, age: age, address: address)
		} else {
			updateFriend(fname: fname, lname: lname, image: image, gender: gender, age: age, address: address, cellIndex: cellIndex)
		}
		
		navigationController?.popToRootViewController(animated: true) // Pops back to root view controller
	}
	
	// Following actions will be performed when Delete (Trash) button is pressed
	@IBAction func deleteFriendButton(_ sender: Any) {
		if cellIndex > -1 {
			deleteFriend(cellIndex: cellIndex)
			navigationController?.popToRootViewController(animated: true)
		}
	}
	
	@IBAction func viewAddressButtonAction(_ sender: Any) {
		
		
		
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "viewMap" {
			let controller = segue.destination as! MapViewController
			controller.address = addressTextField.text!
			controller.name = "\(firstNameTextField.text!)'s Address"
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		if cellIndex > -1  {

			getFriends()
			
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
	
	
}
