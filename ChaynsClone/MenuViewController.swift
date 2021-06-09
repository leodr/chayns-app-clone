//
//  MenuViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!

    public var dismissHandler: (() -> Void)?

    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer) {
        dismissHandler?()
    }

    @IBAction func settingsTap(_ sender: UITapGestureRecognizer) {
        dismissHandler?()
    }
}
