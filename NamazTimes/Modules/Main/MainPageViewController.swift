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
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .clear
        pageControl.pageIndicatorTintColor = GeneralColor.el_subtitle
        pageControl.currentPageIndicatorTintColor = GeneralColor.primary
        pageControl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        pageControl.layer.position.x = UIScreen.main.bounds.width
        return pageControl
    }()
    
    var router: MainPageRouterInput?
    var interactor: MainPageInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        view.backgroundColor = .white
        
        configureSubviews()
        
        guard let interactor = interactor else { return }
        pageControl.numberOfPages = interactor.getControllers().count
        pageControl.currentPage = 0
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
     
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        if DeviceType.heightType == .big {
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat(UIScreen.main.bounds.width/4)).isActive = true
        }
    }
}

extension MainPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return interactor?.getAfterVC(current: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return interactor?.getBeforeVC(current: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
       
        guard let current = interactor?.getCurrentIndex(current: viewControllers?.first ?? UIViewController()), completed else {
            return
        }
        pageControl.currentPage = current
    }
}

extension MainPageViewController: MainPageViewInput {
    
    func scrollToNext() {
        
    }
    
    func scrollToPrevious() {
        
    }
}
