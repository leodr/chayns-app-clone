//
//  NewHomeViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import SDWebImage
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
        top: 10.0,
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

        navigationController?.isNavigationBarHidden = true

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

        let borderWidth = CGFloat(0.5)

        headerBar.frame = headerBar.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        headerBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.0).cgColor
        headerBar.layer.borderWidth = borderWidth
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
                self.headerBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.0).cgColor
                self.blurView.alpha = 0
                self.smallChaynsLogo.alpha = 0
                self.nameLabel.alpha = 1
            }

        case .blurry:
            UIView.animate(withDuration: 0.2) {
                self.headerBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
                self.blurView.alpha = 1
                self.smallChaynsLogo.alpha = 0
                self.nameLabel.alpha = 1
            }
        case .logoShown:
            UIView.animate(withDuration: 0.2) {
                self.headerBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
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

        cell.imageView.sd_setImage(with: URL(string: "https://sub60.tobit.com/l/\(location.id)?size=120"))
        cell.label.text = location.name

        cell.label.preferredMaxLayoutWidth = cell.bounds.width

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.row]

        let siteViewController = SiteViewController()

        siteViewController.domain = "https://\(location.domain)"

        navigationController?.pushViewController(siteViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Header",
            for: indexPath
        ) as! LocationGridHeaderCollectionReusableView

        header.searchBar.layer.cornerRadius = 3
        header.searchBar.clipsToBounds = true
        header.searchBar.layer.borderWidth = 1
        header.searchBar.layer.borderColor = UIColor.systemGray5.cgColor

        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

// MARK: - Collection View Flow Layout Delegate

extension NewHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * 2 + 8 * itemsPerRow
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem * 1.48)
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
        return CGFloat(4)
    }
}
