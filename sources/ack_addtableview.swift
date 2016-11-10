// ----- Table View -----
let tableView = UITableView()
tableView.delegate = self
tableView.dataSource = self
tableView.rowHeight =  UITableViewAutomaticDimension
view.addSubview(tableView)
tableView.snp_makeConstraints { make in
make.edges.equalTo(0)
}
self.tableView = tableView
