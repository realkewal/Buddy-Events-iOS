//
//  MapViewController.swift
//  Buddy Events
//
//  Created by Kewal on 20/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	
	@IBOutlet weak var myMapView: MKMapView!
	
	
	var address = String()
	var name = String()
	

    override func viewDidLoad() {
        super.viewDidLoad()

		let searchRequest = MKLocalSearchRequest()
		searchRequest.naturalLanguageQuery = address
		
		let activeSearch = MKLocalSearch(request: searchRequest)
		
		activeSearch.start { (response, error) in
		
			if response == nil {
				let alert = UIAlertController(title: "Sorry!", message:
					"Address not found!",
					preferredStyle: .alert)
				
				alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
					NSLog("The \"OK\" alert occured.")
				}))
				self.present(alert, animated: true, completion: nil)
			} else {
				//Remove any present annotations
				let annotations = self.myMapView.annotations
				self.myMapView.removeAnnotations(annotations)
				
				//Getting location data
				let latitude = response?.boundingRegion.center.latitude
				let longitude = response?.boundingRegion.center.longitude
				
				// Zoom in on location
				
				let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
				let span = MKCoordinateSpanMake(0.1, 0.1)
				let region = MKCoordinateRegionMake(coordinate, span)
				self.myMapView.setRegion(region, animated: true)
				
				//create annotation
				
				let annotation = MKPointAnnotation()
				annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
				annotation.title = self.name
				annotation.subtitle = self.address
				self.myMapView.addAnnotation(annotation)
				
				
			}
		}
		
	
	}

	
	
}
