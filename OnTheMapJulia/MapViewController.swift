//
//  MapViewController.swift
//  OnTheMapJulia
//
//  Created by Julia Miller on 6/4/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        UdacityClient.sharedInstance.getStudentLocations()
    }
    
}
