//
//  ViewController.swift
//  Drive Safe
//
//  Created by Nadine Saimua, 2022.
//

import UIKit
import MapboxMaps
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import CoreLocation
import MapKit

class ViewController: UIViewController {
    var mapView: NavigationMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = CLLocationCoordinate2D(latitude: 36.7783, longitude: -119.4179)
        
        //map setup
        mapView = NavigationMapView(frame: view.bounds) //fullscreen
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight] //autoresize
        self.view.addSubview(mapView)
//        let layerid = "mapbox://styles/nadinesaimua/cl88o6v7z00aj14p4gqwvtmd0"
//        mapStyleURL = URL(string: "mapbox://styles/nadinesaimua/cl88o6v7z00aj14p4gqwvtmd0")!


        //waypoints+navigation
        let origin = Waypoint(coordinate: LocationCoordinate2D(latitude: 32.6784, longitude: -117.0588), name: "Start")
        let destination = Waypoint(coordinate: LocationCoordinate2D(latitude: 32.9595, longitude: -117.2653), name: "Destination")
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
        Directions.shared.calculate(routeOptions) {session, result in
            switch result {
            case.failure(let error):
                print(error)
            case.success(let response):
                self.mapView.showcase(response.routes ?? [])
//insert ability to click between routes, and button for starting navigation.
                
                let navigationViewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
            self.present(navigationViewController, animated: true)
        }
        
            
        }
    }
    
    
}
//
//class CustomDayStyle: DayStyle {
//    required init() {
//            super.init()
//            mapStyleURL = URL(string: "mapbox://styles/mapbox/satellite-streets-v9")!
//            styleType = .dayStyle
//        }
//}
