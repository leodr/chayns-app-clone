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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu")

        if let menuVCInstance = menuVC as? MenuViewController {
            self.menuViewController = menuVCInstance
        }

        self.selectedViewController!.view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self.selectedViewController!)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard viewController.tabBarItem.title == "Mehr" else {
            return true
        }

        self.menuViewController?.toggle()

        return false
    }

    func closeMenu() {
        if let viewController = menuViewController {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()

            self.menuViewController = nil
        }
    }
}
