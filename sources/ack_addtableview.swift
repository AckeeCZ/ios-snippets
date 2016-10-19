// ----- Table View -----
let tableView = UITableView()
tableView.delegate = self
tableView.dataSource = self
tableView.rowHeight =  UITableViewAutomaticDimension
tableView.separatorColor = .clearColor()
tableView.tableFooterView = UIView(frame: .zero)
view.addSubview(tableView)
tableView.snp_makeConstraints { make in
make.edges.equalTo(0)
}
self.tableView = tableView