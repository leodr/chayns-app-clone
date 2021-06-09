//
//  TabViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 08.06.21.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    var menuViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard viewController.tabBarItem.title == "Mehr" else {
            return true
        }

        if self.menuViewController != nil {
            self.closeMenu()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu")

            if let menuVCInstance = menuVC as? MenuViewController {
                menuVCInstance.dismissHandler = {
                    self.closeMenu()
                }
            }

            self.selectedViewController!.view.addSubview(menuVC.view)
            menuVC.didMove(toParent: self.selectedViewController!)

            self.menuViewController = menuVC
        }

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
