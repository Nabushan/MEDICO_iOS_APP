//
//  CollectionViewLayoutProviderVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 24/09/22.
//

import UIKit

class CollectionViewLayoutProvider{
    
    func getCollectionViewCustomisedLayout() -> UICollectionViewCompositionalLayout {
        
        let compositionLayout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) in
            
            if(sectionIndex == 0){
                var itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                if(layoutEnvironment.container.effectiveContentSize.width > 700){
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10)
                }
                else{
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 5,
                        leading: 5,
                        bottom: 5,
                        trailing: 5)
                }
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/2))
                
                var firstHorizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 3)
                
                var secondHorizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 3)
                
                if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                    firstHorizontalGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 4)
                    
                    secondHorizontalGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 4)
                }
                
                var finalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/2))
                
                if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                    finalGroupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/2))
                }
                
                let finalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: finalGroupSize,
                    subitems: [firstHorizontalGroup, secondHorizontalGroup])
                
                let section = NSCollectionLayoutSection(group: finalGroup)
                
                section.boundarySupplementaryItems = [self.makeHeader()]
                
                return section
            }
            else if(sectionIndex == 1){
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/4),
                    heightDimension: .fractionalHeight(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
                if(layoutEnvironment.container.effectiveContentSize.width > 700){
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10)
                }
                else{
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 5,
                        leading: 5,
                        bottom: 5,
                        trailing: 5)
                }
            
                var finalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(3.5),
                    heightDimension: .fractionalHeight(1/4))
                
                if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                    finalGroupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(2.5),
                        heightDimension: .fractionalHeight(1/4))
                }
                else{
                    finalGroupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(3.5),
                        heightDimension: .fractionalHeight(1/4))
                }
                    
                let finalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: finalGroupSize,
                    subitem: item,
                    count: 10)
                    
                let section = NSCollectionLayoutSection(group: finalGroup)
                    
                section.boundarySupplementaryItems = [self.makeHeader()]
                    
                section.orthogonalScrollingBehavior = .continuous
                    
                return section
            }
            
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))))
        }
        
        return compositionLayout
    }

    func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: itemSize,
            elementKind: "header",
            alignment: .top)
        
        return header
    }
    
    func getArticleCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
            
        var groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(9),
            heightDimension: .fractionalHeight(1))
            
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(7),
                heightDimension: .fractionalHeight(1))
            
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(5),
                    heightDimension: .fractionalHeight(1))
            }
        }
        else{
            groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(9),
                heightDimension: .fractionalHeight(1))
        }
            
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 10)
            
        let section = NSCollectionLayoutSection(group: group)
            
        section.orthogonalScrollingBehavior = .continuous
            
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    func getPillLayout() -> UICollectionViewCompositionalLayout {
        if((UITraitCollection.current.userInterfaceIdiom == .phone)||((UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) && (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight))){
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/5),
                heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 5,
                leading: 5,
                bottom: 5,
                trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.8),
                heightDimension: .fractionalHeight(1))
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 6)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
            
            return UICollectionViewCompositionalLayout(section: section)
        }
        else{
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/5),
                heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 5,
                leading: 5,
                bottom: 5,
                trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2))
            
            let topGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 3)
            
            let bottomGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 3)
            
            let finalGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            
            let finalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: finalGroupSize,
                subitems: [topGroup, bottomGroup])
            
            let section = NSCollectionLayoutSection(group: finalGroup)
            
            return UICollectionViewCompositionalLayout(section: section)
        }
    }
    
    func getMedicineDetailsLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.45),
                heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 5,
                leading: 5,
                bottom: 5,
                trailing: 5)
            
            let subGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2))
            
            let upperGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: subGroupSize,
                subitem: item,
                count: 2)
            
            var groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(2/3))
            }
            else if(layoutEnvironment.container.effectiveContentSize.height > 550){
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/2.5))
            }
            else if(layoutEnvironment.container.effectiveContentSize.height > 300){
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(2/3))
            }
            
            let finalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: upperGroup,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: finalGroup)
            
            return section
        }
        
        return layout
    }
    
    func getDoctorDesignationLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex, layoutEnvironment) in
            
            if(sectionIndex == 0){
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.2),
                    heightDimension: .fractionalHeight(0.9))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(6),
                    heightDimension: .fractionalHeight(1))
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 10)
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            }
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))))
        }
        
        return layout
    }
    
    func getDoctorsLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex, layoutEnvironment) in
            
            if(sectionIndex == 0){
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/4))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 4)
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
            
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))))
        }
        
        return layout
    }
    
    func getEmergencyLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) in
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                if(sectionIndex == 0){
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/4),
                        heightDimension: .fractionalHeight(1))
                    
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 5,
                        leading: 5,
                        bottom: 5,
                        trailing: 5)
                    
                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/2))
                    
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 3)
                    
                    let finalGroup = NSCollectionLayoutGroup.vertical(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .fractionalHeight(1)),
                        subitem: group,
                        count: 2)
                    
                    let section = NSCollectionLayoutSection(group: finalGroup)
                    
                    return section
                }
            }
            else{
                if(sectionIndex == 0){
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1))
                    
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    item.contentInsets = NSDirectionalEdgeInsets(
                        top: 5,
                        leading: 5,
                        bottom: 5,
                        trailing: 5)
                    
                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(2.5),
                        heightDimension: .fractionalHeight(1))
                    
                    var group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 6)
                    
                    if(layoutEnvironment.container.effectiveContentSize.height > 300 && UIDevice.current.userInterfaceIdiom == .pad){
                        let tempgroupSize = NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .fractionalHeight(1/2))
                        
                        let tempGroup = NSCollectionLayoutGroup.horizontal(
                            layoutSize: tempgroupSize,
                            subitem: item,
                            count: 3)
                        
                        group = NSCollectionLayoutGroup.vertical(
                            layoutSize: NSCollectionLayoutSize(
                                widthDimension: .fractionalWidth(1.5),
                                heightDimension: .fractionalHeight(1)),
                            subitem: tempGroup,
                            count: 2)
                    }
                    
                    let section = NSCollectionLayoutSection(group: group)
                    
                    section.orthogonalScrollingBehavior = .continuous
                    
                    return section
                }
            }
            
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))))
        }
        
        return layout
    }
    
    func getPharmacyMedicineLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) in
            
            var itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension:  .fractionalHeight(1/4))
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1/4))
            }
            else{
                itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:  .fractionalHeight(1/3))
            }
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2.5,
                leading: 5,
                bottom: 2.5,
                trailing: 5)
            
            let verticalGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            
            var verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: verticalGroupSize,
                subitem: item,
                count: 4)
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: verticalGroupSize,
                    subitem: item,
                    count: 4)
            }
            else{
                verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: verticalGroupSize,
                    subitem: item,
                    count: 3)
            }
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        }
        
        return layout
    }
    
    func getPharmacyReviewLavout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, location) in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 5,
                bottom: 0,
                trailing: 5)
            
            var groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.93),
                heightDimension: .fractionalHeight(1))
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.6),
                    heightDimension: .fractionalHeight(1))
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            }
            else{
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.93),
                    heightDimension: .fractionalHeight(1))
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            }
        }
        
        return layout
    }
    
    func getSeeAllReviewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex, layoutEnvironment) in
            
            if(sectionIndex == 0){
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5)
                
                var groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/3))
                
                if(layoutEnvironment.container.effectiveContentSize.height > 950){
                    groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/4.5))
                }
                
                var group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 1)
                
                if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                    groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/3.5))
                    
                    group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 2)
                }
                
                
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.boundarySupplementaryItems = [self.makeHeaderForSeeAll()]
                
                return section
            }
            
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))))
        }
        
        return layout
    }
    
    func makeHeaderForSeeAll() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(180))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: itemSize,
            elementKind: "header",
            alignment: .top)
        
        return header
    }
    
    func getPharmacyProductInfoLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 5,
                trailing: 5)
            
            var groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2.5),
                heightDimension: .fractionalHeight(1))
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.8),
                    heightDimension: .fractionalHeight(1))
            }
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        
        return layout
    }
    
    func getHourLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex, layoutEnvironment) in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2.5,
                leading: 2.5,
                bottom: 2.5,
                trailing: 2.5)
            
            var groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/4))
            
            if(layoutEnvironment.container.effectiveContentSize.height > 410){
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/5))
            }
            
            var group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 3)
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 10,
                    bottom: 10,
                    trailing: 10)
                
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/4))
                
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/3))
                }
                
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: 4)
            }
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        return layout
    }
}
