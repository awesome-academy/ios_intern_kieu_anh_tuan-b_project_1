//
//  ViewController.swift
//  MarvelApp
//
//  Created by Tobi on 11/09/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet weak var slideCollectionView: UICollectionView!

    private let images = [
        UIImage(named: "test1"),
        UIImage(named: "test2"),
        UIImage(named: "test3")
    ]
    private var currentIndex = 0
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        slideCollectionView.register(
            UINib(nibName: "SlideCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "slide")
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0,
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
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
