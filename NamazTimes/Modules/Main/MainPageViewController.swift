//
//  MainPageViewController.swift
//  Namaz Times
//
//  Created by &&TairoV on 26.09.2022.
//

import UIKit

protocol MainPageViewInput where Self: UIViewController {
    
}

class MainPageViewController: UIPageViewController {
    
    var router: MainPageRouterInput?
    var interactor: MainPageInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataSource = self
        delegate = self
        view.backgroundColor = .white
        
        configureSubviews()
        
        guard let interactor = interactor else { return }
        setViewControllers(interactor.getInitialVC(),
                           direction: .forward,
                           animated: true)
        
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = GeneralColor.el_subtitle
        appearance.currentPageIndicatorTintColor = GeneralColor.primary
        appearance.backgroundColor = .clear
    }
}

extension MainPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return interactor?.getAfterVC(current: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return interactor?.getBeforeVC(current: viewController)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return interactor?.getControllers().count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension MainPageViewController: MainPageViewInput {
    
    func scrollToNext() {
        
    }
    
    func scrollToPrevious() {
        
    }
}
