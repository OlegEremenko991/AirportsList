//
//  MapViewController.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            nameLabel.setupLabel(text: "Airport name: " + placeName,
                                 textAlignment: .center,
                                 font: UIFont(name: "Verdana-Bold", size: 17))
        }
    }

    @IBOutlet private weak var countryLabel: UILabel! {
        didSet {
            countryLabel.setupLabel(text: "Country: " + placeCountry,
                                    textAlignment: .center,
                                    font: UIFont(name: "Verdana-Medium", size: 17))
        }
    }

    @IBOutlet private weak var latLabel: UILabel! {
        didSet {
            latLabel.setupLabel(text: "Latitude: " + String(placeLatitude),
                                textAlignment: .center)
        }
    }

    @IBOutlet private weak var lonLabel: UILabel! {
        didSet {
            lonLabel.setupLabel(text: "Longitude: " + String(placeLongitude),
                                textAlignment: .center)
        }
    }

    // MARK: - Public properties

    static let identifier = "MapViewControllerID"
    var placeName = ""
    var placeCountry = ""
    var placeLatitude: Double = 0.0
    var placeLongitude: Double = 0.0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showMark()
    }

    // MARK: - Private methods

    private func setupView() {
        title = "Airport location"
    }

    private func showMark() {
        DispatchQueue.main.async {
            let initialCenterLocation = CLLocation(latitude: self.placeLatitude, longitude: self.placeLongitude)
            let region = MKCoordinateRegion(center: initialCenterLocation.coordinate, latitudinalMeters: .zero, longitudinalMeters: .zero)
            self.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
            
            let cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 10000)
            self.mapView.setCameraZoomRange(cameraZoomRange, animated: true)
            
            let placeToShow = MapModel(placeTitle: self.placeName, country: self.placeCountry, locationCoordinate: CLLocationCoordinate2D(latitude: initialCenterLocation.coordinate.latitude, longitude: initialCenterLocation.coordinate.longitude))
            self.mapView.addAnnotation(placeToShow)
        }
    }

}
