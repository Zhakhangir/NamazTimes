//
//  LocationViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/23/22.
//

import UIKit
import MapKit
import CoreLocation

class LocationSettingsViewController: UIViewController {

    let locationManager = LocationMen()
    let fieldImageView = UIImageView(frame: CGRect(x: 10, y: -10, width: 20, height: 20))

    lazy var fieldLeftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: locationTextField.frame.height))
        view.addSubview(fieldImageView)

        return  view
    }()

    private var status: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.locmen.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, fieldStackView])
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationTextField, locationButton])
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.text = NSLocalizedString("choose_location", comment: "choose location")
        label.numberOfLines = 0
        return label
    }()

    private var locationTextField = UITextField()

    private var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        addActions()
        stylize()
    }

    private func addSubviews() {
        view.addSubview(mainStackView)
    }

    private func setupLayout() {

        var layoutContraints = [NSLayoutConstraint]()

        locationTextField.delegate = self
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            locationTextField.heightAnchor.constraint(equalToConstant: 42)
        ]

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            locationButton.heightAnchor.constraint(equalToConstant: 24),
            locationButton.widthAnchor.constraint(equalToConstant: 24)
        ]

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func addActions() {
        locationButton.addTarget(self, action: #selector(autoFindLocation), for: .touchUpInside)
    }

    private func stylize() {
        fieldImageView.contentMode = .scaleAspectFit
        fieldImageView.image = UIImage(named: "search")

        locationTextField.leftView = fieldLeftView
        locationTextField.leftViewMode = .always

        locationTextField.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        locationTextField.rightViewMode = .always

        locationTextField.keyboardType = .webSearch
        locationTextField.font = UIFont.systemFont(ofSize: 16)
        locationTextField.layer.cornerRadius = 18

        locationTextField.layer.borderWidth = 1
        locationTextField.layer.borderColor = GeneralColor.primary.cgColor
        locationTextField.placeholder = NSLocalizedString("city_name", comment: "city name")

        locationTextField.returnKeyType = .go
        locationTextField.autocorrectionType = .no
    }
}

extension LocationSettingsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        autoFindLocation()
        return true
    }
}

extension LocationSettingsViewController {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }

    @objc func autoFindLocation() {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            present(UINavigationController(rootViewController: GeneralTabBarViewController()), animated: true, completion: nil)
            //Find location service
        case .restricted:
            print("Error Alert")
        case .denied:
            let alertVc = GeneralAlertPopupVc()
            let model = GeneralAlertModel(titleLabel: "Error Location", buttonTitle: "Open", actionButtonTapped: {
                if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
                    UIApplication.shared.open(url)
                }
            })
            let alertView = GeneralAlertPopupView()
            alertView.configure(with: model)
            alertVc.setContentView(alertView)

            present(alertVc, animated: true, completion: nil)
        case .notDetermined:
            locationManager.locmen.requestAlwaysAuthorization()
            locationManager.locmen.requestWhenInUseAuthorization()
        @unknown default:
            print("Location error")
        }
    }
}

extension LocationSettingsViewController: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        autoFindLocation()
    }
}

