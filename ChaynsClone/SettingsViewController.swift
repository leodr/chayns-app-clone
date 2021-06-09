//
//  SettingsViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBAction func closeTap(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
}
