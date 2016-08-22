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

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var collection: [StudentModel] {
        get {
           return StudentModel.collection
        }
    }
    
    override func viewDidLoad() {
        self.showPinsOnMap()
        map.delegate = self
    }
    
    @IBAction func reload(sender: AnyObject) {
        loadMapPage()
    }
    
    @IBAction func postPersLoc(sender: AnyObject) {
        let postVC = storyboard?.instantiateViewControllerWithIdentifier("PostVC") as! PostVC
        navigationController?.presentViewController(postVC, animated: true, completion: nil)
    }
    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showPinsOnMap(){
        
        var annotations = [MKPointAnnotation]()
        
        for student in collection {
            let annotation = MKPointAnnotation()
            let coord = CLLocationCoordinate2DMake(student.lat, student.long)
            annotation.coordinate = coord
            annotation.title = student.first + " " + student.last
            annotation.subtitle = student.url
            annotations.append(annotation)
        }
        
        map.addAnnotations(annotations)
        map.reloadInputViews()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let url = view.annotation!.subtitle!!
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func loadMapPage(){
        map.removeAnnotations(map.annotations)
        UdacityClient.sharedInstance.getStudentLocations({(success) -> Void in
            if (success){
                self.showPinsOnMap()
            }
            else {
                let alert = UIAlertController(title: nil, message: "Server error downloading student locations", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
}


