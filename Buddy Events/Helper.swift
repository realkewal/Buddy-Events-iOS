//
//  Helper.swift
//  Buddy Events
//
//  Created by Kewal on 19/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var friends: [Friends] = []
var events: [Events] = []

func getContext() -> NSManagedObjectContext {
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	return appDelegate.persistentContainer.viewContext
}

let friendFetchRequest: NSFetchRequest<Friends> = Friends.fetchRequest() // Fetch request to refer to Friends Entity

let eventsFetchRequest: NSFetchRequest<Events> = Events.fetchRequest() // Fetch request to refer to Events Entity

let context = getContext() // Get the managed object context from coredata


func getFriends () {
	do {
		
		let sectionSortDescriptor = NSSortDescriptor(key: "fname", ascending: true)
		let sortDescriptors = [sectionSortDescriptor]
		friendFetchRequest.sortDescriptors = sortDescriptors
		friends = try getContext().fetch(friendFetchRequest)
	} catch {
		print("Error with request: \(error)")
	}
}

func addFriend (fname: String, lname: String, image: NSData, gender: String, age: Int16, address: String) {
	//retrieve the entity that we just created
	let entity =  NSEntityDescription.entity(forEntityName: "Friends", in: context)
	let friend = NSManagedObject(entity: entity!, insertInto: context)
	//set the entity values
	friend.setValue(fname, forKey: "fname")
	friend.setValue(lname, forKey: "lname")
	friend.setValue(image, forKey: "image")
	friend.setValue(gender, forKey: "gender")
	friend.setValue(age, forKey: "age")
	friend.setValue(address, forKey: "address")
	//save the object
	do {
		try context.save()
		print("saved!")
	} catch let error as NSError  {
		print("Could not save \(error)")
	} catch {
		
	}
}

func updateFriend (fname: String, lname: String, image: NSData, gender: String, age: Int16, address: String, cellIndex: Int) {
	
	do {
		let array_friends = try getContext().fetch(friendFetchRequest)
		let friend = array_friends[cellIndex]
		friend.setValue(fname, forKey: "fname")
		friend.setValue(lname, forKey: "lname")
		friend.setValue(image, forKey: "image")
		friend.setValue(gender, forKey: "gender")
		friend.setValue(age, forKey: "age")
		friend.setValue(address, forKey: "address")
		//save the context
		do {
			try context.save()
			print("saved!")
		} catch let error as NSError  {
			print("Could not save \(error)")
		} catch {
			
		}
	} catch {
		print("Error with request: \(error)")
	}
}

func deleteFriend(cellIndex: Int) {
	
	do {
		//go get the results
		let array_friends = try getContext().fetch(friendFetchRequest)
		let friend = array_friends[cellIndex]
		context.delete(friend)
		//save the context
		do {
			try context.save()
			print("Deleted!")
		} catch let error as NSError  {
			print("Could not save \(error)")
		} catch {
			
		}
	} catch {
		print("Error with request: \(error)")
	}
}

/* 
Following functions interact with Events entity in Core Data
*/

func getEvents () {
	do {
		events = try getContext().fetch(eventsFetchRequest)
		
	} catch {
		print("Error with events request: \(error)")
	}
}

func addEvent (ename: String, edate: Date, elocation: String) {
	//retrieve the entity that we just created
	let entity =  NSEntityDescription.entity(forEntityName: "Events", in: context)
	let event = NSManagedObject(entity: entity!, insertInto: context)
	//set the entity values
	event.setValue(ename, forKey: "ename")
	event.setValue(edate, forKey: "edate")
	event.setValue(elocation, forKey: "elocation")
		//save the object
	do {
		try context.save()
		print("saved!")
	} catch let error as NSError  {
		print("Could not save \(error)")
	} catch {
		
	}
}


func updateEvent (ename: String, edate: Date, elocation: String, cellIndex: Int) {
	
	do {
		let array_events = try getContext().fetch(eventsFetchRequest)
		let event = array_events[cellIndex]
		event.setValue(ename, forKey: "ename")
		event.setValue(edate, forKey: "edate")
		event.setValue(elocation, forKey: "elocation")
		//save the context
		do {
			try context.save()
			print("saved!")
		} catch let error as NSError  {
			print("Could not save \(error)")
		} catch {
			
		}
	} catch {
		print("Error with request: \(error)")
	}
}

func deleteEvent(cellIndex: Int) {
	
	do {
		//go get the results
		let array_events = try getContext().fetch(eventsFetchRequest)
		let event = array_events[cellIndex]
		context.delete(event)
		//save the context
		do {
			try context.save()
			print("Deleted!")
		} catch let error as NSError  {
			print("Could not save \(error)")
		} catch {
			
		}
	} catch {
		print("Error with request: \(error)")
	}
}

/*
Following functions do not interact with CoreData
*/

func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
	
	let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
	UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
	let context = UIGraphicsGetCurrentContext()
	
	// Set the quality level to use when rescaling
	context!.interpolationQuality = CGInterpolationQuality.default
	let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
	
	context!.concatenate(flipVertical)
	// Draw into the context; this scales the image
	context?.draw(image.cgImage!, in: CGRect(x: 0.0,y: 0.0, width: newRect.width, height: newRect.height))
	
	let newImageRef = context!.makeImage()! as CGImage
	let newImage = UIImage(cgImage: newImageRef)
	
	// Get the resized image from the context and a UIImage
	UIGraphicsEndImageContext()
	
	return newImage
}


func checkForNilValues(values: Array<String>) -> Bool {
	
	var flag = false
	
	for val in values {
		if val != ""{
			flag = true
		} else {
			flag = false
		}
	}
	
	return flag
}














