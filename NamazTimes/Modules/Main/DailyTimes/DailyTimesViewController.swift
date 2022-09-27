//
//  DailyTimesListViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

protocol DailyTimesViewInput: GeneralViewControllerProtocol {
    func reload()
}

class DailyTimesViewController: GeneralViewController {
   
    var router: DailyTimesRouterInput?
    var interactor: DailyTimesInteractorInput?
    
    private let timesList = DTListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        guard let interactor = interactor else { return }
        timesList.set(data: interactor.getData())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timesList.reload()
    }
    
    private func configureSubviews() {
        view.addSubview(timesList)
        
        timesList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timesList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 32 + 64),
            timesList.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            timesList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            timesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

extension DailyTimesViewController: DailyTimesViewInput {
    
    func reload() {
        
    }
}


//
//class DailyTimesViewController: GeneralViewController {
//
//    private var currentVisibleIndex: IndexPath? {
//        collectionView.indexPathsForVisibleItems.first.flatMap({IndexPath(row: $0.row, section: $0.section)})
//    }
//
//    private var numberOfPages = 2
//    private var listCellId = "ListCellReuseId"
//    private var settingsCellId = "SettingsCellReuseId"
//
//    private lazy var layout: UICollectionViewFlowLayout = {
//        var layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
//        layout.collectionView?.clipsToBounds = false
//        layout.minimumInteritemSpacing = 0
//        return layout
//    }()
//
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
//        collectionView.isScrollEnabled = true
//        collectionView.clipsToBounds = false
//        collectionView.backgroundColor = .white
//
//        collectionView.register(BaseCollectionContainerCell<DTListView>.self, forCellWithReuseIdentifier: listCellId)
//        return collectionView
//    }()
//
//    private let pager = PagerView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        addSubviews()
//        setuplayout()
//
//        pager.currentPage = 0
//        pager.numberOfPages = numberOfPages
//        collectionView.reloadData()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        layout.itemSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
//    }
//
//
//    private func addSubviews() {
//        contentView.addSubview(collectionView)
//        contentView.addSubview(pager)
//    }
//
//    private func setuplayout() {
//        var layoutContraints = [NSLayoutConstraint]()
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        layoutContraints += [
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ]
//
//        pager.translatesAutoresizingMaskIntoConstraints = false
//        layoutContraints += [
//            pager.heightAnchor.constraint(equalToConstant: 10),
//            pager.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            pager.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
//            pager.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ]
//
//        NSLayoutConstraint.activate(layoutContraints)
//    }
//
//    private func stylize() {
//
//    }
//}
//
//extension DailyTimesViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        numberOfPages
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var collectionCell = UICollectionViewCell()
//        let data = interactor?.getData() ?? [DailyPrayerTime]()
//        switch indexPath.row {
//        case 0:
//            guard let cell: BaseCollectionContainerCell<DTListView> = collectionView.dequeueReusableCell(withReuseIdentifier: listCellId, for: indexPath) as? BaseCollectionContainerCell<DTListView> else { return collectionCell }
//
//            cell.innerView.set(data: data.filter({!$0.isHidden}))
//            collectionCell = cell
//
//        default:  return collectionCell
//        }
//
//        return collectionCell
//    }
//}
//
//extension DailyTimesViewController: UICollectionViewDelegate {
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        pager.currentPage = currentVisibleIndex?.row ?? 0
//        reload()
//    }
//}
//
//extension DailyTimesViewController: DailyTimesViewInput {
//    func reload() {
//        collectionView.reloadData()
//    }
//}
