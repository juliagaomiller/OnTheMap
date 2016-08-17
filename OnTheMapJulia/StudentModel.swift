//  StudentModel.swift
//  OnTheMapJulia
//
//  Created by Julia Miller on 7/24/16.
//  Copyright © 2016 Julia Miller. All rights reserved.


import Foundation

struct student {
    
    static let sharedInstance = student()
    
    var createdAt: String?
    var first: String?
    var last: String?
    var lat: Double?
    var long: Double?
    var url: String?

}