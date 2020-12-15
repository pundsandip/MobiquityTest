//
//  HomeViewController.swift
//  MobiquityTest
//
//  Created by Sandip Pund on 11/12/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var bookmarkedCities: [BookmarkCity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
        bookmarkCities()
        fetchCitiesOnMap(bookmarkedCities)
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied: // Show alert telling users how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted: // Show an alert letting them know what’s up
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }

    
    func bookmarkCities() {
        bookmarkedCities.append(BookmarkCity(name: "Delhi", lattitude: 28.704060, longtitude: 77.102493))
        bookmarkedCities.append(BookmarkCity(name: "Ahmedabad", lattitude: 23.0225, longtitude: 72.5714))
        bookmarkedCities.append(BookmarkCity(name: "Hyderabad", lattitude: 17.385044, longtitude: 78.486671))
        bookmarkedCities.append(BookmarkCity(name: "Mumbai", lattitude: 19.075983, longtitude: 72.877655))
        bookmarkedCities.append(BookmarkCity(name: "Pune", lattitude: 18.520430, longtitude: 73.856743))
        bookmarkedCities.append(BookmarkCity(name: "Bengaluru", lattitude: 12.971599, longtitude: 77.594566))
        bookmarkedCities.append(BookmarkCity(name: "Chennai", lattitude: 13.0827, longtitude: 80.2707))
        bookmarkedCities.append(BookmarkCity(name: "Kolkata", lattitude: 22.5726, longtitude: 88.3639))
        bookmarkedCities.append(BookmarkCity(name: "Lucknow", lattitude: 26.8467, longtitude: 80.9462))
    }
    
    func fetchCitiesOnMap(_ cities: [BookmarkCity]) {
        for city in cities {
            let annotations = MKPointAnnotation()
            annotations.title = city.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                city.lattitude, longitude: city.longtitude)
            mapView.addAnnotation(annotations)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let city = view.annotation?.title ?? "" else { return }
        ServiceManager.shared.fetchWeatherData(city: city) { response, error in
            if let model = response {
                let story = UIStoryboard(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "CityVC") as! CityViewController
                vc.model = model
                if let navController = self.navigationController {
                    navController.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

