
//
//  LocationManager.swift
//  CH3_Group13
//
//  Created by Andhika Satria on 25/05/26.
//

import SwiftUI
import Foundation
import CoreLocation
import Observation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate        = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter  = 10  // update every 10 meters of movement
        manager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("⚠️ Location permission denied by user")
        default:
            break
        }
    }
}

// Custom launcher to force GPS permission to appear in SwiftUI
@MainActor
@Observable
class LocationLauncher: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
}
