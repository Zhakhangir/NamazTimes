//
//  DailyTimesRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

protocol PrayerTimesListRouterInput {

}

class PrayerTimerListRouter: PrayerTimesListRouterInput {

    var view: PrayerTimesListViewInput?

    public func build() -> PrayerTimesListViewInput {
        let viewController = PrayerTimesListViewController()
        let interactor = PrayerTimesListInteractor(view: viewController)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
}
