//
//  DailyTimesListViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class DailyTimesViewController: GeneralViewController {

    var router: DailyTimesRouterInput?
    var interactor: DailyTimesInteractorInput?
    
    private var numberOfPages = 2
    private var listCellId = "ListCellReuseId"
    private var settingsCellId = "SettingsCellReuseId"

    private lazy var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.backgroundColor = .clear

        collectionView.register(BaseCollectionContainerCell<DTListView>.self, forCellWithReuseIdentifier: listCellId)
        collectionView.register(BaseCollectionContainerCell<DTSettingsView>.self, forCellWithReuseIdentifier: settingsCellId)
        return collectionView
    }()

    private let pager: PageControl = {
        let pager  = PageControl()
        pager.currentPage = 0
        pager.numberOfPages = 2
        return pager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setuplayout()
    }


    private func addSubviews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pager)
    }

    private func setuplayout() {
        var layoutContraints = [NSLayoutConstraint]()

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]

        pager.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            pager.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pager.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ]

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func stylize() {
        
    }
}

extension DailyTimesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfPages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
}

extension DailyTimesViewController: UICollectionViewDelegate {

}

extension DailyTimesViewController: DailyTimesViewInput {
    
}
