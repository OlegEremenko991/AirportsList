//
//  MapViewController.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Public properties
    
    static let identifier = "MapViewControllerID"
    var placeName = ""
    var placeCountry = ""
    var placeLatitude: Double = 0.0
    var placeLongitude: Double = 0.0
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMark()
    }
    
    // MARK: Private methods
    
    private func showMark() {
    
        DispatchQueue.main.async {
            let initialCenterLocation = CLLocation(latitude: self.placeLatitude, longitude: self.placeLongitude)
            let region = MKCoordinateRegion(center: initialCenterLocation.coordinate, latitudinalMeters: .zero, longitudinalMeters: .zero)
            self.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
            
            let cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 10000)
            self.mapView.setCameraZoomRange(cameraZoomRange, animated: true)
            
            let placeToShow = MapMarkData(placeTitle: self.placeName, country: self.placeCountry, locationCoordinate: CLLocationCoordinate2D(latitude: initialCenterLocation.coordinate.latitude, longitude: initialCenterLocation.coordinate.longitude))
            self.mapView.addAnnotation(placeToShow)
        }

    }

}
