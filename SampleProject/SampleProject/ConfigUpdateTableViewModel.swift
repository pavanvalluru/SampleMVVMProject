//
//  LiveUpdateTableViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 02.05.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

class ConfigUpdateTableViewModel: ConfigurableTableViewModel {
    
    var configIndex: Int {
        get {
            return UserDataManager.sharedInstance.userDefaults.integer(forKey: "currentIndex") 
        }
    }
    
    // array of tuples with title text and cell properties to configure, also used to calculate number of rows in section
    var section_0_rows: [(name: String, properties: (type: Int, category: Int))] {
        
        get {
            return [(name: "Configuration",
                     properties: (type: CellType.DetailCell.rawValue, category: ValueSelectionCellViewModel.ValueSelectionCategory.Airline.rawValue))
            ]
        }
    }
    
    var needsSecureToken: Bool {
        get {
            return (8 ... 10).contains(self.configIndex-1)
        }
    }
    
    var allowsTimePeriodSelection: Bool {
        
        get {
            switch self.configIndex-1 {
            case 1,3,5,7,8: // the indexes that allows timeperiod selection
                return true
            default:
                return false
            }
        }
    }
    
    var showsTimePicker = false
    
    // array of tuples with title text and cell properties to configure, also used to calculate number of rows in section
    var section_1_rows: [(name: String, properties: (type: Int, category: Int))] {
        
        get {
            
            switch self.configIndex-1 {
            case 0,2,11,12:
                return [(name: "Passwort speichern",
                         properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.ConfigPIN.rawValue))
                        ,(name: "Passwort",
                          properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue))
                        ,(name: "Benutzername",
                          properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue))
                       ]
            case 1,3,4,5,7:
                return [(name: "PIN speichern",
                         properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.ConfigPIN.rawValue))
                        ,(name: "PIN",
                          properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue))
                        ,(name: "My ID",
                          properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue))
                       ]
            case 6:
                return [(name: "My Nummer",
                         properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue))
                       ]
            case 8:
                return [(name: "Passcode speichern",
                         properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.ConfigPIN.rawValue))
                        ,(name: "Passcode",
                         properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue))
                        ,(name: "Benutzername",
                         properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue))
                       ]
            case 9,10:
                return [(name: "PIN speichern",
                         properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.ConfigPIN.rawValue))
                        ,(name: "PIN",
                          properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue))
                        ,(name: "My Nummer",
                          properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue))
                       ]
            default:
                return []
            }
            
        }
    }
    
    // array of tuples with title text and cell properties to configure, also used to calculate number of rows in section
    var section_2_rows: [(name: String, properties: (type: Int, category: Int))] {
        
        get {
            switch self.configIndex-1 {
            case 0,2:
                return []
            case 1,3,5,7,8:
                if UserDataManager.sharedInstance.userDefaults.integer(forKey: "duration_type") == 1 {
                    if self.showsTimePicker {
                        return [(name: "Zeitraum",
                                 properties: (type: CellType.ConfigUpdateStartEndTimeCell.rawValue, category: 0))
                                ,(name: "TimePicker",
                                 properties: (type: CellType.ConfigUpdateStartEndTimeCell.rawValue, category: 1))
                               ]
                    } else {
                        return [(name: "Zeitraum",
                                 properties: (type: CellType.ConfigUpdateStartEndTimeCell.rawValue, category: 0))
                               ]
                    }
                } else {
                    return [(name: "Vor Monat",
                             properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.PreviousMonth.rawValue))
                            ,(name: "Aktueller Monat",
                             properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.CurrentMonth.rawValue))
                            ,(name: "Nächstes Monat",
                             properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.NextMonth.rawValue))
                           ]
                }
            case 4:
                return [(name: "Vor Monat",
                         properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.PreviousMonth.rawValue))
                        ,(name: "Aktueller Monat",
                        properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.CurrentMonth.rawValue))
                        ,(name: "Nächstes Monat",
                        properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.NextMonth.rawValue))
                       ]
            case 6:
                return [(name: "Import Kalendar",
                         properties: (type: CellType.ButtonCell.rawValue, category: ConfigurableTableButtonCell.ButtonCellCategory.ImportCalendar.rawValue))
                        ,(name: "Import Monat",
                        properties: (type: CellType.ButtonCell.rawValue, category: ConfigurableTableButtonCell.ButtonCellCategory.ImportMonth.rawValue))
                       ]
            case 9,10:
                return [(name: "Vor Monat",
                         properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.PreviousMonth.rawValue))
                        ,(name: "Aktueller Monat",
                        properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.CurrentMonth.rawValue))
                        ,(name: "Nächstes Monat",
                        properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.NextMonth.rawValue))
                        ,(name: "Infos Typ1",
                        properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.InfosTyp1.rawValue))
                        ,(name: "Infos Typ2",
                        properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.InfosTyp2.rawValue))
                       ]
            case 11,12:
                return []
                
            default:
                return []
            }
        }
    }
    
    var section_3_rows: [(name: String, properties: (type: Int, category: Int))] {
        
        get {
            return [(name: "Update starten",
                     properties: (type: CellType.ButtonCell.rawValue, category: ConfigurableTableButtonCell.ButtonCellCategory.ConfigUpdate.rawValue))
            ]
        }
    }
    
    override init() {
        super.init()
        
        rows_in_section = [section_0_rows,section_1_rows,section_2_rows,section_3_rows]
        section_headers = ["","Sicherheit","Zu Aktualisierende Daten"]
    }
    
    func latest_rows_in_section() -> [[(name: String, properties: (type: Int, category: Int))]] {
        rows_in_section = [section_0_rows,section_1_rows,section_2_rows,section_3_rows]
        return rows_in_section
    }
    
}
