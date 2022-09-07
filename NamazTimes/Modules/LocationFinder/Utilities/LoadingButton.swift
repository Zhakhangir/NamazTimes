//
//  LoadingButton.swift
//  Namaz Times
//
//  Created by &&TairoV on 11.08.2022.
//

import UIKit

class LoadingButton: UIButton {

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView?.contentMode = .scaleAspectFit
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func clearMode(isOn: Bool) {
        isOn ? setImage(UIImage(named: "close_icon"), for: .normal) : setImage(nil, for: .normal)
        isUserInteractionEnabled = isOn
    }

    func setSpinnerSize(width: CGFloat, height: CGFloat) {
        activityIndicator.heightAnchor.constraint(equalToConstant: height).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func setContentInsets(_ insets: UIEdgeInsets) {
        if #available(iOS 15.0, *) {
            configuration = .plain()
            configuration?.imagePadding = insets.left
        } else {
            contentEdgeInsets = insets
        }
    }

    func spinnerState(animate: Bool) {
        animate ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        imageView?.isHidden = animate
    }
}
