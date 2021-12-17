//
//  ContentView.swift
//  testRoute
//
//  Created by ADSS on 17.12.2021.
//

import SwiftUI
import MapKit


struct ContentView: View {
    var body: some View {
        MapView()
    }
}

struct MapView: UIViewRepresentable{
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.5, longitude: 35.5), latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        map.delegate = context.coordinator
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.5, longitude: 35.5)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.8, longitude: 35.8)))
        request.transportType = .automobile
        let direction = MKDirections(request: request)
        direction.calculate { response, err in
            if let err = err{
                print(err.localizedDescription)
            }
            if let res = response?.routes[0]{
                let route = res
                map.addOverlay(route.polyline, level: .aboveLabels)
            }
        }
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    class Coordinator: NSObject, MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let overlay = MKPolylineRenderer(overlay: overlay)
            overlay.lineWidth  = 4
            
            overlay.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            return overlay
        }
    }
    typealias UIViewType = MKMapView
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
