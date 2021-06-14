//
//  TabViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 08.06.21.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    var menuViewController: MenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu")

        if let menuVCInstance = menuVC as? MenuViewController {
            self.menuViewController = menuVCInstance
        }

        if let viewController = self.selectedViewController {
            viewController.view.addSubview(menuVC.view)
            menuVC.didMove(toParent: viewController)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard viewController.tabBarItem.title == "Mehr" else {
            return true
        }

        self.menuViewController?.toggle()

        return false
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.addMenu()
    }

    func addMenu() {
        self.menuViewController?.view.removeFromSuperview()
        self.menuViewController?.removeFromParent()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu")

        if let menuVCInstance = menuVC as? MenuViewController {
            self.menuViewController = menuVCInstance
        }

        if let viewController = self.selectedViewController {
            viewController.view.addSubview(menuVC.view)
            menuVC.didMove(toParent: viewController)
        }
    }
}
