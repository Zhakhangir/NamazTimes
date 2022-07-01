//
//  QFMapViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import UIKit
import MapKit
import CoreLocation

class QFMapViewController: UIViewController {

    var router: QFMapRouterInput?
    var interactor: QFMapInteractorInput?

    let KaabaCordinates = CLLocationCoordinate2D(latitude: 21.4216, longitude: 39.8248)

    private lazy var annotationKaaba: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "Kaaba"
        annotation.coordinate = KaabaCordinates
        return annotation
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.addAnnotation(annotationKaaba)
        mapView.showsUserLocation = true
        return mapView
    }()

    private lazy var aimImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "aim")

        return imageView
    }()

    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close-icon-rounded"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private var mapTypeSegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = GeneralColor.primary
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupLayout()
        stylize()
        addActions()

        mapView.delegate = self
    }

    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(aimImageView)
        view.addSubview(closeButton)
        view.addSubview(locationButton)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ]

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            locationButton.heightAnchor.constraint(equalToConstant: 30),
            locationButton.widthAnchor.constraint(equalToConstant: 30),
            locationButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            locationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ]

        mapView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        aimImageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            aimImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aimImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }

   @objc private func findUserLocation() {
       guard let location = interactor?.getUserLocation() else { return }

       let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
       mapView.setRegion(region, animated: true)
    }

    private func stylize() {

        findUserLocation()
        setPolyLine()
    }

    private func setPolyLine() {
        mapView.removeOverlays(mapView.overlays)
        let polyLineCoordinates = [mapView.centerCoordinate, KaabaCordinates]
        mapView.addOverlay(MKPolyline(coordinates: polyLineCoordinates, count: polyLineCoordinates.count))
    }

}

extension QFMapViewController: QFMapViewInput { }

extension QFMapViewController {

    private func addActions() {
        closeButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(findUserLocation), for: .touchUpInside)
    }

    @objc func goBack() {
        router?.goBack()
    }
}

extension QFMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let polyLineRender = MKPolylineRenderer(overlay: overlay)
        polyLineRender.strokeColor = GeneralColor.primary
        polyLineRender.lineWidth = 5

        return polyLineRender
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("Center", mapView.centerCoordinate)
        setPolyLine()
    }
}
