//
//  ViewController.swift
//  MarvelApp
//
//  Created by Tobi on 11/09/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var slideCollectionView: UICollectionView!
    @IBOutlet private weak var homeTableView: UITableView!

    // TODO: fix later
    private let images = [
        UIImage(named: "test1"),
        UIImage(named: "test2"),
        UIImage(named: "test3")
    ]
    private var currentIndex = 0
    private var timer: Timer?
    private let sectionTitles = ["Heroes", "Creator", "Event", "Seri"]

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        slideCollectionView.register(
            UINib(nibName: String(describing: SlideCollectionViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: "slide")
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
        homeTableView.register(
            UINib(nibName: String(describing: ThumbnailTableViewCell.self),
                                     bundle: nil), forCellReuseIdentifier: "thumbnail")
        homeTableView.delegate = self
        homeTableView.dataSource = self

    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0,
                                     target: self,
                                     selector: #selector(changeSlide), userInfo: nil, repeats: true)
    }

    @objc private func changeSlide() {
        let desiredScrollPosition = (currentIndex < images.count - 1) ? currentIndex + 1 : 0
        currentIndex = desiredScrollPosition
        let rect = slideCollectionView.layoutAttributesForItem(
            at: IndexPath(row: desiredScrollPosition, section: 0))?.frame
        if let rect = rect {
            slideCollectionView.scrollRectToVisible(rect, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "slide", for: indexPath) as? SlideCollectionViewCell {
            cell.image = images[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = homeTableView.dequeueReusableCell(
            withIdentifier: "thumbnail", for: indexPath) as? ThumbnailTableViewCell {
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: Constant.titleSize, weight: .semibold)
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + Constant.paddingHorizontal,
            y: header.bounds.origin.y,
            width: Constant.sectionLabelWidth,
            height: header.bounds.height
        )
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.thumbnailHeight
    }
}
