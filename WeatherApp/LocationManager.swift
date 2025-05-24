//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Rokaya El Shahed on 12/02/2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    @Published var userLatitude: Double?
    @Published var userLongitude: Double?
    @Published var cityName: String?
    @Published var locationPermissionDenied = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLatitude = location.coordinate.latitude
                self.userLongitude = location.coordinate.longitude
                print(" Location Updated: \(self.userLatitude!), \(self.userLongitude!)")

                
                self.getCityFromCoordinates(latitude: self.userLatitude!, longitude: self.userLongitude!)
            }
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.locationPermissionDenied = true
        }
    }
    
    func getCityFromCoordinates(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Geocoding Error: \(error.localizedDescription)")
                return
            }

            if let city = placemarks?.first?.locality {
                DispatchQueue.main.async {
                    self.cityName = city
                    print(" City Detected: \(city)")
                }
            }
        }
    }
}
