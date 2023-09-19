//
//  CollectionViewExtension.swift
//  MarvelApp
//
//  Created by Tobi on 19/09/2023.
//

import Foundation
import UIKit

final class SlideCollectionView: UICollectionViewFlowLayout {
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var point = super.targetContentOffset(
            forProposedContentOffset: proposedContentOffset,
            withScrollingVelocity: velocity)
        guard let collectionView = collectionView else {
            return point
        }
        let cells = collectionView.visibleCells
        let centerPoint = collectionView.center
        var cellFrame: CGRect = CGRect.zero
        for cell in cells {
            cellFrame = collectionView.convert(cell.frame, to: collectionView.superview)
            var newCenterPoint: CGPoint = centerPoint
            if velocity.x > 0 {
                newCenterPoint = CGPoint(x: centerPoint.x * 1.5, y: centerPoint.y)
            } else if velocity.x < 0 {
                newCenterPoint = CGPoint(x: centerPoint.x * 0.5, y: centerPoint.y)
            }
            guard cellFrame.contains(newCenterPoint) else {
                continue
            }
            let temp = collectionView.frame.width / 2 - cell.frame.width / 2
            point.x = cell.frame.origin.x - temp
            break
        }
        return point
    }
}
