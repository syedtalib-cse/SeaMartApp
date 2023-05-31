//
//  SubCatNameCollectionViewCell.swift
//  ProtiensApp
//
//  Created by mehtab alam on 24/12/2020.
//

import UIKit

class SubCatNameCollectionViewCell: UICollectionViewCell {
    
    //function use to call in the cell
    @IBOutlet weak var subCatNameLbl: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
 
    }
    
    //function use to call in the cell
    func configCellForSubCategory(data: Subcat_names) {
        subCatNameLbl.text = data.name
    }    
}
