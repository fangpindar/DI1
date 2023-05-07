//
//  SelectionViewDelegate.swift
//  DI Part 1
//
//  Created by 方品中 on 2023/5/7.
//
import UIKit

@objc protocol SelectionViewDelegate: AnyObject {
    @objc optional func selectionView(_ selectionView: SelectionView, didSelectCellAt: Int)
    @objc optional func selectionView(_ selectionView: SelectionView, shouldCellSelect: Int) -> Bool
}
