//
//  ValueSelectionViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 08.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import RealmSwift

class ValueSelectionCellViewModel: ConfigurableTableViewCellViewModel {
    
    enum ValueSelectionCategory: Int {
        case Language = 0, Airline
        
        var description : String {
            switch self {
            case .Airline: return NSLocalizedString("Configuration", comment: "")
            case .Language: return NSLocalizedString("Sprache", comment: "")
            }
        }
    }
    
    init(category: Int) {
        super.init(title: "", category: category)
        self.title = ValueSelectionCategory(rawValue: category)?.description ?? ""
    }
    
    var category_items: [String] {
        
        get {
            switch category {
            case ValueSelectionCategory.Airline.rawValue:
                return ["—","Type 1","Type 2","Type 3","Type 4"
                    ,"Type 5","Type 6","Type 7","Type 8","Type 9","Type 10","Type 11","Type 12","Type 13"]
                case ValueSelectionCategory.Language.rawValue:
                    return ["Deutsch","Englisch"]
                default:
                    return []
            }
        }
    }

}


extension ValueSelectionCellViewModel: ValueSelectionCellDataSource {
    
}

extension ValueSelectionCellViewModel: ValueSelectionCellDelegate {
    
}
