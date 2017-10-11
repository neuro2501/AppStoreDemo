//
//  CenterCellCollectionViewFlowLayout.swift
//  AppStoreDemo
//
//  Created by NEURO on 2017. 10. 2..
//  Copyright © 2017년 develobe. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/31355226/create-a-paging-uicollectionview-with-swift
//https://randexdev.com/2014/07/uicollectionview/
//http://blog.karmadust.com/centered-paging-with-preview-cells-on-uicollectionview/

class LeftSectionInsetCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        
        if let cv = self.collectionView {
        
            //마지막 cell에서 스크롤시 변경없이 끝자리 유지
            if proposedContentOffset.x == cv.contentSize.width - cv.bounds.size.width {
                return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
            }
            
            let cvBounds = cv.bounds
            let leftSectionInset = self.sectionInset.left

            let proposedContentOffsetLeftX = proposedContentOffset.x + leftSectionInset
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    if let candAttrs = candidateAttributes {

                        if attributesForVisibleCells.last == attributes {
                            
                        }
                        
                        let a = attributes.frame.origin.x - proposedContentOffsetLeftX
                        let b = candAttrs.frame.origin.x - proposedContentOffsetLeftX
                        
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes;
                        }
                        
                    }else {
                        candidateAttributes = attributes;
                        continue;
                    }
                    
                    
                }
                
                return CGPoint(x : candidateAttributes!.frame.origin.x - leftSectionInset, y : proposedContentOffset.y);
                
            }
            
        }
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
}
