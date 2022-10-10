//
//  MainIntreactor.swift
//  Namaz Times
//
//  Created by &&TairoV on 26.09.2022.
//

import UIKit

protocol MainPageInteractorInput {
    func getInitialVC() -> [UIViewController]
    func getControllers() -> [UIViewController]
    func getAfterVC(current: UIViewController) -> UIViewController?
    func getBeforeVC(current: UIViewController) -> UIViewController?
    func getCurrentIndex(current: UIViewController) -> Int?
}

class MainPageInteractor: MainPageInteractorInput {
   
    private var controllers: [UIViewController] = [IntervalTimeRouter().build(), PrayerTimerListRouter().build()]
    var view: MainPageViewInput
    
    init(view: MainPageViewInput) {
        self.view = view
    }
    
    func getControllers() -> [UIViewController] {
        return controllers
    }
    
    func getInitialVC() -> [UIViewController] {
        guard let initial = controllers.first else { return [UIViewController()] }
        
        return [initial]
    }
    
    func getBeforeVC(current: UIViewController) -> UIViewController? {
        
        guard let currentIndex = getCurrentIndex(current: current) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return controllers.last
        }
        
        guard controllers.count > previousIndex else {
            return nil
        }
        
        return controllers[previousIndex]
    }
    
    func getAfterVC(current: UIViewController) -> UIViewController? {
        
        guard let currentIndex = getCurrentIndex(current: current) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        let controllersCount = controllers.count
        
        guard controllersCount != nextIndex else {
            return controllers.first
        }
        
        guard controllersCount > nextIndex else {
            return nil
        }
        
        return controllers[nextIndex]
    }
    
    func getCurrentIndex(current: UIViewController) -> Int? {
        guard let currentIndex = controllers.firstIndex(where: { $0 == current }) else {
            return nil
        }
        
        return currentIndex
    }
}
