//
//  SlideTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 19/09/2023.
//

import UIKit

final class SlideTableViewCell: UITableViewCell {

    @IBOutlet private weak var slideCollectionView: UICollectionView!

    private var slides: [Character] = []
    private var currentIndex = 0
    private var timer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        startTimer()

        if let layout = slideCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        slideCollectionView.decelerationRate = .fast
        slideCollectionView.register(
            UINib(nibName: String(describing: SlideCollectionViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: "slide")
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
    }

    public func configure(_ characters: [Character]) {
        self.slides = characters
        DispatchQueue.main.async { [weak self] in
            self?.slideCollectionView.reloadData()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0,
                                     target: self,
                                     selector: #selector(changeSlide), userInfo: nil, repeats: true)
    }

    @objc private func changeSlide() {
        let desiredScrollPosition = (currentIndex < slides.count - 1) ? currentIndex + 1 : 0
        currentIndex = desiredScrollPosition
        let rect = slideCollectionView.layoutAttributesForItem(
            at: IndexPath(row: desiredScrollPosition, section: 0))?.frame
        if let rect = rect {
            slideCollectionView.scrollRectToVisible(rect, animated: true)
        }
    }
}

extension SlideTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "slide", for: indexPath) as? SlideCollectionViewCell {
            if let thumbnail = slides[indexPath.row].thumbnail {
                guard let url = URL(string: thumbnail.path + "." + thumbnail.extension) else {
                    return UICollectionViewCell()
                }
                ImageProvider.shared.fetchData(url: url) { image in
                    DispatchQueue.main.async {
                        cell.configure(label: self.slides[indexPath.row].name, image: image)
                    }
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension SlideTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvRect = collectionView.frame
        return CGSize(width: cvRect.width, height: cvRect.height)
    }
}
