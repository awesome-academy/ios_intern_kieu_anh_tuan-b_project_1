//
//  TabBarController.swift
//  MarvelApp
//
//  Created by Tobi on 13/09/2023.
//

import UIKit

final class AppTabBarController: UITabBarController {
    private let homeViewController = UINavigationController(rootViewController: HomeViewController())
    private let searchViewController = UINavigationController(rootViewController: SearchViewController())
    private let comicViewController = UINavigationController(rootViewController: ComicViewController())
    private let favoriteViewController = UINavigationController(rootViewController: FavoriteViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        configTabBar()
    }

    private func configTabBar() {
        self.setViewControllers(
            [homeViewController, searchViewController, comicViewController, favoriteViewController],
            animated: true)
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .red

        homeViewController.title = "Home"
        searchViewController.title = "Search"
        comicViewController.title = "Comic"
        favoriteViewController.title = "Favorite"

        guard let items = self.tabBar.items else {
            return
        }

        let images = ["house", "magnifyingglass", "book", "heart"]

        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
        }
    }
}
