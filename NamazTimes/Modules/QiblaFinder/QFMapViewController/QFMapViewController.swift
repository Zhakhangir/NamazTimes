//
//  QFMapViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol QFMapViewInput where Self: UIViewController {
}


class QFMapViewController: UIViewController {

    var router: QFMapRouterInput?
    var interactor: QFMapInteractorInput?
    let KaabaCordinates = CLLocationCoordinate2D(latitude: 21.422498, longitude: 39.826181)
    private let mapTypes = ["Standart", "Satellite"]

    private lazy var annotationKaaba: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "Kaaba"
        annotation.coordinate = KaabaCordinates
        return annotation
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .standard
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
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private var kaabaButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kaaba"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private lazy var mapTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: mapTypes)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        segmentedControl.tintColor = GeneralColor.primary
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        addSubviews()
        setupLayout()
        addActions()

        guard let userLocation = interactor?.getUserLocation() else { return }
        setRegion(coordinate: userLocation)
    }

    private func addSubviews() {
        view.addSubview(mapView)
        //        view.addSubview(aimImageView)
        view.addSubview(mapTypeSegmentedControl)
        view.addSubview(closeButton)
        view.addSubview(locationButton)
        view.addSubview(kaabaButton)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ]

        mapTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            mapTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapTypeSegmentedControl.bottomAnchor.constraint(equalTo: closeButton.bottomAnchor)
        ]

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            locationButton.heightAnchor.constraint(equalToConstant: 30),
            locationButton.widthAnchor.constraint(equalToConstant: 30),
            locationButton.leadingAnchor.constraint(equalTo: kaabaButton.trailingAnchor, constant: 16),
            locationButton.bottomAnchor.constraint(equalTo: closeButton.bottomAnchor)
        ]

        kaabaButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            kaabaButton.heightAnchor.constraint(equalToConstant: 30),
            kaabaButton.widthAnchor.constraint(equalToConstant: 30),
            kaabaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            kaabaButton.bottomAnchor.constraint(equalTo: closeButton.bottomAnchor)
        ]

        mapView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        if #available(iOS 11.0, *) {
            layoutConstraints += [
                closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            ]
        } else {
            layoutConstraints += [
                closeButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -32),
            ]
        }


        //        aimImageView.translatesAutoresizingMaskIntoConstraints = false
        //        layoutConstraints += [
        //            aimImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            aimImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        //        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() { }

    private func setPolyLine(from location: CLLocationCoordinate2D) {
        mapView.removeOverlays(mapView.overlays)
        let polyLineCoordinates = [location, KaabaCordinates]
        mapView.addOverlay(MKGeodesicPolyline(coordinates: polyLineCoordinates, count: polyLineCoordinates.count))
    }

    private func setRegion(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    @objc private func userLocation() {
        setRegion(coordinate: mapView.userLocation.coordinate)
    }

    @objc private func kaabaLocation() {
        setRegion(coordinate: KaabaCordinates)
    }

    @objc func mapTypeChanged() {
        switch mapTypeSegmentedControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .satellite
        default: return
        }
    }
}

extension QFMapViewController: QFMapViewInput { }

extension QFMapViewController {

    private func addActions() {
        closeButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(userLocation), for: .touchUpInside)
        kaabaButton.addTarget(self, action: #selector(kaabaLocation), for: .touchUpInside)
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
        setPolyLine(from: mapView.centerCoordinate)
    }
}
