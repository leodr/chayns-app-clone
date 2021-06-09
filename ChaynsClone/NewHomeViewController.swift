//
//  NewHomeViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import UIKit

enum ScrollingStage {
    case transparent, blurry, logoShown
}

class NewHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var headerBar: UIView!

    @IBOutlet var nameLabel: UILabel!

    @IBOutlet var smallChaynsLogo: UIImageView!

    @IBOutlet var blurView: UIVisualEffectView!

    private let reuseIdentifier = "LocationCell"

    private let sectionInsets = UIEdgeInsets(
        top: 35.0,
        left: 20.0,
        bottom: 35.0,
        right: 20.0
    )

    private let itemsPerRow: CGFloat = 4

    var locations: [Location] = []

    var scrollingStage = ScrollingStage.transparent

    let logoScrollingThreshold = CGFloat(92)

    override func viewDidLoad() {
        super.viewDidLoad()

        LocationService.instance.getLocationData {
            response in

            switch response {
            case .success(let data):
                self.locations = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

        nameLabel.text = TokenService.instance.userName
        print("Username: ")
        print(TokenService.instance.userName)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollingDistance = scrollView.contentOffset.y

        if scrollingDistance.isLessThanOrEqualTo(CGFloat(0)) {
            apply(scrollingStage: .transparent)
        } else if scrollingDistance.isLessThanOrEqualTo(logoScrollingThreshold) {
            apply(scrollingStage: .blurry)
        } else {
            apply(scrollingStage: .logoShown)
        }
    }

    func apply(scrollingStage: ScrollingStage) {
        guard scrollingStage != self.scrollingStage else {
            return
        }

        self.scrollingStage = scrollingStage

        switch scrollingStage {
        case .transparent:
            headerBar.backgroundColor = nil

            UIView.animate(withDuration: 0.2) {
                self.blurView.alpha = 0
                self.smallChaynsLogo.alpha = 0
                self.nameLabel.alpha = 1
            }

        case .blurry:
            UIView.animate(withDuration: 0.2) {
                self.blurView.alpha = 1
                self.smallChaynsLogo.alpha = 0
                self.nameLabel.alpha = 1
            }
        case .logoShown:
            UIView.animate(withDuration: 0.2) {
                self.blurView.alpha = 1
                self.smallChaynsLogo.alpha = 1
                self.nameLabel.alpha = 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocationCollectionViewCell

        let location = locations[indexPath.row]

        cell.imageView.sd_setImage(with: URL(string: "https://sub60.tobit.com/l/\(location.id)"))
        cell.label.text = location.name

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Header",
            for: indexPath
        ) as! LocationGridHeaderCollectionReusableView

        header.searchBar.layer.cornerRadius = 3
        header.searchBar.clipsToBounds = true

        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

// MARK: - Collection View Flow Layout Delegate

extension NewHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem * 1.2)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}
