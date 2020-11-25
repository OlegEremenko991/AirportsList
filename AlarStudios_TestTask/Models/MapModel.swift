//
//  MapMarkData.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 03.10.2020.
//

import MapKit

final class MapModel: NSObject, MKAnnotation {

    // MARK: Public properties

    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    var subtitle: String? { return locationName }

    // MARK: Lifecycle

    init(placeTitle: String?, country: String?, locationCoordinate: CLLocationCoordinate2D) {
        title = placeTitle
        locationName = country
        coordinate = locationCoordinate
        super.init()
    }

}
