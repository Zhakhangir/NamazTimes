//
//  LocationFinderViewOnctroller+Extension.swift
//  Namaz Times
//
//  Created by &&TairoV on 04.09.2022.
//

import UIKit

extension  LocationFinderViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.getNumberOfSection() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  interactor?.getNumberOfRows(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        interactor?.getTitle(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<LoadingLabelView> = tableView.dequeueReusableCell(withIdentifier: resultCellId, for: indexPath) as? BaseContainerCell<LoadingLabelView> else {
            return UITableViewCell()
        }

        guard let item = interactor?.getItem(at: indexPath) else { return UITableViewCell() }
        cell.innerView.titleLabel.text = item.text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        interactor?.didSelectItem(at: indexPath)
    }
}

