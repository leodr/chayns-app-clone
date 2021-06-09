//
//  HomeViewController.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 07.06.21.
//

import SDWebImage
import UIKit

final class HomeViewController: UICollectionViewController {
    // MARK: - Properties

    private let reuseIdentifier = "LocationCell"

    private let sectionInsets = UIEdgeInsets(
        top: 35.0,
        left: 20.0,
        bottom: 35.0,
        right: 20.0
    )

    private let itemsPerRow: CGFloat = 4

    var locations: [Location] = []

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
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocationCollectionViewCell

        let location = locations[indexPath.row]

        cell.imageView.sd_setImage(with: URL(string: "https://sub60.tobit.com/l/\(location.id)"))
        cell.label.text = location.name

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
