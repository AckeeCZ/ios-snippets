//MARK: UITableView delegate
extension <#Class#>: UITableViewDelegate {

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
<#code#>
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
return <#height#>
}

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
return <#height#>
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
return <#height#>
}

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
<#code#>
}

func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
<#code#>
}
}