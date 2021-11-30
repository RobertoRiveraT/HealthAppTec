//
//  Maps.swift
//  HealthApp
//
//  Created by user194251 on 11/28/21.
//

import UIKit
import MapKit
import CoreLocation
import WatchConnectivity

class Maps: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var textFieldAddress: UITextField!
    @IBOutlet var getDirecctions: UIButton!
    @IBOutlet var map: MKMapView!
    
    var session: WCSession?
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWatchSession()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        map.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func setupWatchSession(){
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    @IBAction func getDirecctionsTapped(_ sender: Any) {
        
        print("test: Get Directions Tapped")
        
        if let validSession = self.session, validSession.isReachable {
            let dataToWatch: [String: Any] = ["Phone": "Hola desde Iphone" as Any]
            
            sendDictionary(dataToWatch)
            
            validSession.sendMessage(dataToWatch, replyHandler: nil, errorHandler: nil)
        }

        getAddress()
    }
    
    private func sendDictionary(_ dict: [String: Any]) {
            do {
                try self.session?.updateApplicationContext(dict)
            } catch {
                print("Error sending dictionary \(dict) to Apple Watch!")
            }
    }
    
    func getAddress(){
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textFieldAddress.text!) { (placemarks, erro) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else {
                print("No location found")
                return
                }
            print(location)
            self.mapThis(destinationCord: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCord: CLLocationCoordinate2D){
        
        let sourceCoordinate = (locationManager.location?.coordinate)!
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
            directions.calculate {(response, error) in
                guard let response = response else {
                    if let error = error {
                        print("Todo salio mal :(")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.map.addOverlay(route.polyline)
                self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
            }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer (overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}

extension Maps: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("test: Session did become INACTIVE")    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("test: Activation did complete")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //
    }
    
}
