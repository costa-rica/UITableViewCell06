//
//  ViewController.swift
//  UITableViewCell06
//
//  Created by Nick Rodriguez on 24/12/2023.
//

import UIKit

class DashboardVC: UIViewController {
    var tblDashboard = UITableView()
    var row01 : [String:String]!
    var row02 : [String:String]!
    var arryRows : [[String:String]]!
    var lblTitle=UILabel()
    override func viewDidLoad() {
        print("DashboardVC viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblDashboard.delegate = self
        self.tblDashboard.dataSource = self
        self.tblDashboard.register(DashboardTableCell.self, forCellReuseIdentifier: "DashboardTableCell")
        self.tblDashboard.rowHeight = UITableView.automaticDimension
        self.tblDashboard.estimatedRowHeight = 44
        
        self.row01 = createRow01()
        self.row02 = createRow02()
        self.arryRows = [self.row01, self.row02, self.row01, self.row02]
        
        self.lblTitle.translatesAutoresizingMaskIntoConstraints=false
        self.lblTitle.text = "Dashboard"
        self.lblTitle.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        view.addSubview(lblTitle)
        self.lblTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive=true
        self.lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive=true
        
        view.addSubview(tblDashboard)
        self.tblDashboard.translatesAutoresizingMaskIntoConstraints=false
        self.tblDashboard.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive=true
        self.tblDashboard.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        self.tblDashboard.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        self.tblDashboard.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        self.tblDashboard.backgroundColor = .systemGray
    }
}

extension DashboardVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DashboardTableCell else { return }
        cell.isLabelVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
extension DashboardVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arryRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableCell", for: indexPath) as? DashboardTableCell else {
            fatalError("Dequeued cell is not an instance of DashboardTableCell.")
        }
        cell.dictCellInfo = arryRows[indexPath.row]
        cell.setupCell()
        return cell
    }
}

class DashboardTableCell:UITableViewCell{
    var lblIndepName = UILabel()
    var lblDefinition = UILabel()
    var dictCellInfo : [String:String]!
    var lblDefinitionConstraints: [NSLayoutConstraint] = []
    var vwCircleConstraints: [NSLayoutConstraint] = []
    var isLabelVisible: Bool = false {
        didSet {
            print("lblDefinition is hidden")
            lblDefinition.isHidden = !isLabelVisible
            showLblDef()
            layoutIfNeeded()
            print("contentView height: \(contentView.frame.size)")
        }
    }
    // add circle
    var vwCircle = UIView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(){
        contentView.addSubview(lblIndepName)
        lblIndepName.text = dictCellInfo["independentVarName"]
        
        lblIndepName.translatesAutoresizingMaskIntoConstraints = false
        lblIndepName.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        
        lblDefinition.isHidden = true
        contentView.addSubview(lblDefinition)
        lblDefinition.translatesAutoresizingMaskIntoConstraints = false
        lblDefinition.text = dictCellInfo["definition"]
        lblDefinition.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblDefinition.numberOfLines = 0 // Enable multi-line

        contentView.addSubview(vwCircle)
        vwCircle.translatesAutoresizingMaskIntoConstraints=false
        vwCircle.accessibilityIdentifier = "vwCircle"
        vwCircle.backgroundColor = .systemBlue
        
        // Constraints for lblDefinition
        NSLayoutConstraint.activate([
            lblIndepName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightFromPct(percent: 2)),
            lblIndepName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblIndepName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -4)),
            lblIndepName.bottomAnchor.constraint(lessThanOrEqualTo:contentView.bottomAnchor, constant:heightFromPct(percent: -2)),
        ])

        lblIndepName.sizeToFit()// necessary for vwCircle frame
        let cellHeight = self.contentView.frame.height
        print("cellHeight: \(cellHeight)")
        let diameter = cellHeight - heightFromPct(percent: 1)
        vwCircle.layer.cornerRadius = diameter / 2
        vwCircle.frame = CGRect(x: widthFromPct(percent: 80), y: lblIndepName.frame.midY, width: diameter, height: diameter)
        vwCircle.layer.cornerRadius = diameter / 2
        
        print("vwCircle origin: \(vwCircle.frame.origin)")
        print("vwCircle size: \(vwCircle.frame.size)")
    }
    
    func showLblDef() {
        if lblDefinitionConstraints.isEmpty {
            // Create constraints only once and store them
            lblDefinitionConstraints = [
                lblDefinition.topAnchor.constraint(equalTo: lblIndepName.bottomAnchor, constant: heightFromPct(percent: 1)),
                lblDefinition.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: heightFromPct(percent: -1)),
                lblDefinition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
                lblDefinition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -4))
            ]
        }
        // Activate or deactivate constraints
        if isLabelVisible {
            NSLayoutConstraint.activate(lblDefinitionConstraints)
        } else {
            NSLayoutConstraint.deactivate(lblDefinitionConstraints)
        }
    }
}



