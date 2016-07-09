//
//  GCDBlackBox.swift
//  OnTheMapJulia
//
//  Created by Julia Miller on 7/9/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation

func performUpdatesOnMain(updates: () -> Void){
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}