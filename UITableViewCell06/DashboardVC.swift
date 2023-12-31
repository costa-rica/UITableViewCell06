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
        self.tblDashboard.estimatedRowHeight = 100
        
        self.row01 = createRow01()
        self.row02 = createRow02()
        self.arryRows = [self.row01, self.row02]
        
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
            lblCorrelation.isHidden = !isLabelVisible
            showLblDef()
            layoutIfNeeded()
            print("contentView height: \(contentView.frame.size)")
        }
    }
    // add circle
    var vwCircle = UIView()
    var lblCorrelation = UILabel()
    
    // additional paramters
    var fltCellHeight = CGFloat()
    var fltDiameter = CGFloat()
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("vwCircle origin: \(vwCircle.frame.origin)")
        print("vwCircle size: \(vwCircle.frame.size)")
        print("fltCellHeight: \(fltCellHeight)")
        print("lblCorrelation origin: \(lblCorrelation.frame.origin)")
        print("lblCorrelation size: \(lblCorrelation.frame.size)")
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
//        vwCircle.translatesAutoresizingMaskIntoConstraints=false
        vwCircle.accessibilityIdentifier = "vwCircle"
        vwCircle.backgroundColor = .systemBlue
        
        // Constraints for lblDefinition
        NSLayoutConstraint.activate([
            lblIndepName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightFromPct(percent: 2)),
            lblIndepName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblIndepName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: widthFromPct(percent: -4)),
            lblIndepName.bottomAnchor.constraint(lessThanOrEqualTo:contentView.bottomAnchor, constant:heightFromPct(percent: -5)),
        ])

        lblIndepName.sizeToFit()// necessary for vwCircle frame
        fltCellHeight = self.contentView.frame.height
        fltDiameter = fltCellHeight - heightFromPct(percent: 1)
        vwCircle.layer.cornerRadius = fltDiameter / 2
        vwCircle.frame = CGRect(x: widthFromPct(percent: 80), y: lblIndepName.frame.midY, width: fltDiameter, height: fltDiameter)
        vwCircle.layer.cornerRadius = fltDiameter / 2
        
        lblCorrelation.text = String(format: "%.2f", Double(dictCellInfo["correlationValue"]!) ?? 1.0)
        contentView.addSubview(lblCorrelation)
//        lblCorrelation.translatesAutoresizingMaskIntoConstraints=false
        lblCorrelation.isHidden = true
        lblCorrelation.frame = CGRect(x: vwCircle.frame.minX+3, y: vwCircle.frame.minY, width: fltDiameter+6, height: fltDiameter)
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



