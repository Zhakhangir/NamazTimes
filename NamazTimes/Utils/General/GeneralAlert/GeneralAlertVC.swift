//
//  GeneralPopup.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/1/22.
//

import UIKit

protocol AlertPopupView: AnyObject {
    var dismissVcButtonTapped: (() -> Void)? { get set }
}

final class GeneralAlertPopupVc: UIViewController {

    typealias PopupView = (UIView & AlertPopupView)

    var contentView: PopupView?

    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = GeneralColor.blur.withAlphaComponent(0.5)

        return view
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
    }

    private func addSubviews() {
        view.addSubview(blurView)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blurView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    func setContentView(_ contentView: PopupView, radius: CGFloat = 24) {
        contentView.removeFromSuperview()

        self.contentView = contentView

        view.addSubview(contentView)
        contentView.layer.cornerRadius = radius
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        contentView.dismissVcButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
