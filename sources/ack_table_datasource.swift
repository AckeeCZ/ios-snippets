//MARK: UITableView data source
extension <#Class#>: UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
return <#code#>
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return <#code#>
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell = tableView.dequeueReusableCell(withIdentifier: <#identifier#>, for: indexPath)

configureCell(cell: cell, forRowAt: indexPath)

return cell
}

func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
<#code#>
}
}