//
//  LoadingLayer.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/1/22.
//

import UIKit
import Lottie

class LoadingLayer: NSObject {

    static let shared = LoadingLayer()

    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false

        return view
    }()

    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "loader4")
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        return animationView
    }()

    @objc func show() {

        guard let rootView =  UIApplication.shared.windows.first?.rootViewController?.view else {
            return
        }

        loadingView.addSubview(animationView)
        rootView.addSubview(loadingView)

        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300)
        ])

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: rootView.topAnchor),
            loadingView.rightAnchor.constraint(equalTo: rootView.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            loadingView.leftAnchor.constraint(equalTo: rootView.leftAnchor)
        ])
        
    }

    @objc func hide() {
        loadingView.removeFromSuperview()
    }
}
