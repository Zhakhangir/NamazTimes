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

    private var currentVisibleIndex: IndexPath? {
        collectionView.indexPathsForVisibleItems.first.flatMap({IndexPath(row: $0.row, section: $0.section)})
    }
    
    private var numberOfPages = 2
    private var listCellId = "ListCellReuseId"
    private var settingsCellId = "SettingsCellReuseId"

    private lazy var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.collectionView?.clipsToBounds = false
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .blue

        collectionView.register(BaseCollectionContainerCell<DTListView>.self, forCellWithReuseIdentifier: listCellId)
        collectionView.register(BaseCollectionContainerCell<DTSettingsView>.self, forCellWithReuseIdentifier: settingsCellId)
        return collectionView
    }()

    private let pager = PagerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setuplayout()

        pager.currentPage = 0
        pager.numberOfPages = numberOfPages
        collectionView.reloadData()
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
            pager.heightAnchor.constraint(equalToConstant: 10),
            pager.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pager.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            pager.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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
        var collectionCell = UICollectionViewCell()
        switch indexPath.row {
        case 0:
            guard let cell: BaseCollectionContainerCell<DTListView> = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as? BaseCollectionContainerCell<DTListView> else { return collectionCell }
            collectionCell = cell
        case 1:
            guard let cell: BaseCollectionContainerCell<DTSettingsView> = collectionView.dequeueReusableCell(withReuseIdentifier: settingsCellId, for: indexPath) as? BaseCollectionContainerCell<DTSettingsView> else { return collectionCell }
            collectionCell = cell
        default:  return collectionCell
        }

        return collectionCell
    }
}

extension DailyTimesViewController: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pager.currentPage = currentVisibleIndex?.row ?? 0
    }
}

extension DailyTimesViewController: DailyTimesViewInput {
    
}
