//
//  MenuViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import UIKit

enum OpenState {
    case open, closed
}

class MenuViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!

    @IBOutlet var backgroundDim: UIView!

    @IBOutlet var sheet: UIView!

    var openState = OpenState.closed

    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer) {
        leave()
    }

    @IBAction func settingsTap(_ sender: UITapGestureRecognizer) {
        leave()
    }

    override func viewDidLoad() {
        backgroundDim.alpha = 0
        sheet.transform = CGAffineTransform(translationX: 0, y: sheet.frame.height)
    }

    public func toggle() {
        switch openState {
        case .open:
            leave()
        case .closed:
            enter()
        }
    }

    public func enter() {
        view.isUserInteractionEnabled = true
        openState = .open

        UIView.animate(withDuration: 0.2) {
            self.backgroundDim.alpha = 0.75
            self.sheet.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }

    public func leave() {
        view.isUserInteractionEnabled = false
        openState = .closed

        UIView.animate(withDuration: 0.2) {
            self.backgroundDim.alpha = 0
            self.sheet.transform = CGAffineTransform(translationX: 0, y: self.sheet.frame.height)
        }
    }
}
