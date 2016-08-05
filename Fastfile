

desc "Upload snippet"


lane :upload_snippet do |options| 

	dest_dir = File.expand_path(File.dirname(__FILE__))
	install_dir = File.expand_path("~/Library/Developer/Xcode/UserData/CodeSnippets")
	code_snippets =  Dir.entries(install_dir).select{ |e| File.extname(e) == ".codesnippet"  }

	key = options[:key]

	code_snippets.select.each do |snippet|
	  src_snippet_path = "#{install_dir}/#{snippet}"
	  val = get_info_plist_value(path: src_snippet_path, key: "IDECodeSnippetCompletionPrefix")
	  if val == key
	  	dest_path = "#{dest_dir}/snippets/#{key}.codesnippet"
	  	source = get_info_plist_value(path: src_snippet_path, key: "IDECodeSnippetContents")
	  	FileUtils.cp src_snippet_path, dest_path
	  	File.open("#{dest_dir}/#{val}.swift", 'w') { |file| file.write(source) }
	  	UI.message "Copying snippet #{key}"
	  	sh "git commit -am \"added #{key}\""
	  	break
	  end
	end
end

lane :upload_all_snippets do |options| 

	dest_dir = File.expand_path(File.dirname(__FILE__))
	install_dir = File.expand_path("~/Library/Developer/Xcode/UserData/CodeSnippets")
	code_snippets =  Dir.entries(install_dir).select{ |e| File.extname(e) == ".codesnippet"  }

	code_snippets.select.each do |snippet|
	  	src_snippet_path = "#{install_dir}/#{snippet}"
	  	val = get_info_plist_value(path: src_snippet_path, key: "IDECodeSnippetCompletionPrefix")
	  	source = get_info_plist_value(path: src_snippet_path, key: "IDECodeSnippetContents")
	  	dest_path = "#{dest_dir}/snippets/#{val}.codesnippet"
		FileUtils.cp src_snippet_path, dest_path
	  	File.open("#{dest_dir}/#{val}.swift", 'w') { |file| file.write(source) }
	  	UI.message "Copying snippet #{val}"
	end
 	#sh "git add ."
 	#sh "git commit -am \"added all snippets\""

end
