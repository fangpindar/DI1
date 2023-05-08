//
//  SelectionView.swift
//  DI Part 1
//
//  Created by 方品中 on 2023/5/7.
//
import UIKit
import UIKit

class SelectionView: UIView {
    weak var dataSource: SelectionViewDataSource? {
        didSet {
            self.initView()
        }
    }
    weak var delegate: SelectionViewDelegate? {
        didSet {
            self.initView()
        }
    }
    
    var indicatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        resetSelectionView()
        
        guard let numberOfCell = self.dataSource?.numberOfCell(self) else { return }
        
        let viewWidth = Int(self.frame.width)
        let viewHeight = Int(self.frame.height)
        let cellWidth = viewWidth / numberOfCell
        
        doSetCells(viewWidth: viewWidth, viewHeight: viewHeight, cellWidth: cellWidth, numberOfCell: numberOfCell)
        
        self.delegate?.selectionView?(self, didSelectCellAt: 0)
    }
    
    private func resetSelectionView() {
        self.backgroundColor = .black
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    private func doSetCells(viewWidth: Int, viewHeight: Int, cellWidth: Int, numberOfCell: Int) {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        for index in 0..<numberOfCell {
            guard let selectionViewCell = Bundle(for: SelectionViewCell.self).loadNibNamed("SelectionViewCell", owner: self, options: nil)?.first as? SelectionViewCell else { return }
            
            selectionViewCell.frame = CGRect(x: cellWidth * index, y: 0, width: cellWidth, height: viewHeight - 1)
            
            selectionViewCell.colorButton?.setTitle(self.dataSource?.selectionView(self, titleForCellAt: index), for: .normal)
            
            selectionViewCell.colorButton?.setTitleColor(self.dataSource?.selectionView(self, colorForTitleAt: index), for: .normal)
            
            selectionViewCell.colorButton?.titleLabel?.font = self.dataSource?.selectionView(self, fontForTitleAt: index)
            
            selectionViewCell.colorButton?.tag = index
            
            selectionViewCell.colorButton?.addTarget(self, action: #selector(doCellClick), for: .touchUpInside)
            
            stackView.addArrangedSubview(selectionViewCell)
            
            if index == 0 {
                self.indicatorView.backgroundColor = self.dataSource?.colorForIndicator(self)
                 let indicatorViewWidth = Double(viewWidth / numberOfCell) * 0.6
                 let indicatorViewX = Double(viewWidth / numberOfCell) * 0.2
                self.indicatorView.frame = CGRect(x: indicatorViewX, y: Double(viewHeight - 2), width: indicatorViewWidth, height: 2)
                
                self.addSubview(indicatorView)
            }
        }

        self.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    @objc private func doCellClick(_ sender : UIButton) {
        guard let shouldCellSelect = self.delegate?.selectionView?(self, shouldCellSelect: sender.tag) else { return  }
        
        if shouldCellSelect {
            self.delegate?.selectionView?(self, didSelectCellAt: sender.tag)
            self.moveIndicatorView(reference: sender)
        }
    }
    
    private func moveIndicatorView(reference: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            let referenceSuperView = reference.superview!.superview!
            self?.indicatorView.frame.origin.x = referenceSuperView.frame.minX + referenceSuperView.frame.width * 0.2
        })
    }
}
