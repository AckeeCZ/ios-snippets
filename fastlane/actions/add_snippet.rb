module Fastlane
  module Actions
    
    class AddSnippetAction < Action
      def self.run(params)
        dest_dir = File.expand_path(File.dirname(__FILE__))
        install_dir = File.expand_path(params[:install_dir])
        key = params[:key]
        
        code_snippets =  Dir.entries(install_dir).select{ |e| File.extname(e) == ".codesnippet"  }.map { |path| File.join(install_dir, path) }
        if !key
          UI.message "#{code_snippets.count} snippets found in #{install_dir}"
          snippet_keys = code_snippets.map { |snippet| snippet_prefix(snippet) }
          key = UI.select("Select snippet: ",  snippet_keys)
          snippet_path = code_snippets[snippet_keys.index(key)]
        else 
          matching_snippets = code_snippets.select { |snippet| snippet_prefix(snippet) == key }

          if matching_snippets.count == 0
            UI.user_error!("No snippet with the key #{key} found in #{install_dir}")
          elsif matching_snippets.count > 1 
            UI.message "Multiple snippets with the key #{key} found"
            snippet_path = UI.select("Select snippet: ", matching_snippets)
          elsif matching_snippets.count == 1
            if !UI.confirm("Found snippet #{matching_snippets[0]}, do you wish to add it?}") 
              return false
            else 
              snippet_path = matching_snippets[0]
            end
          end
        end

        destination_path =  File.join(params[:snippets_dir], "#{key}.codesnippet")
        
        
        if File.exists? destination_path
          if UI.confirm("Snippet #{key} already exists, do you wish to replace it?") == true 
            FileUtils.remove(destination_path)
          else 
            return false
          end
        end

        #Copy snippet
        FileUtils.cp snippet_path, destination_path

        #Copy source
        source = snippet_source(snippet_path)
        File.open(File.join(params[:sources_dir], "#{key}.swift"), 'w') { |file| file.write(source) }
        
        UI.message "Copying snippet #{key}"

        if UI.confirm("Successfully added #{key}, do you wish to commit?")
          sh "git commit -am \"added snippet #{key}\""
        end 

      end

      def self.snippet_prefix(path)
        FastlaneCore::CommandExecutor.execute(command: "/usr/libexec/PlistBuddy -c \"Print :IDECodeSnippetCompletionPrefix\" #{path}", print_all: false)
      end

      def self.snippet_source(path)
        FastlaneCore::CommandExecutor.execute(command: "/usr/libexec/PlistBuddy -c \"Print :IDECodeSnippetContents\" #{path}", print_all: false)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Adds existing snippet from Xcode to repository"
      end

      

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key,
                                       description: "Xcode abbreviation for the snippet",
                                       optional: true
                                       ),
          FastlaneCore::ConfigItem.new(key: :install_dir,
                                       env_name: "FL_SNIPPETS_INSTALL_DIR", 
                                       description: "Installation directory for the snippets", 
                                       default_value: "~/Library/Developer/Xcode/UserData/CodeSnippets"
                                       ),
          FastlaneCore::ConfigItem.new(key: :snippets_dir,
                                       env_name: "FL_SNIPPETS_SNIPPETS_DIR",
                                       description: "Relative path to folder with snippets in the repo", 
                                       default_value: "snippets"
                                       ),
          FastlaneCore::ConfigItem.new(key: :sources_dir,
                                       env_name: "FL_SNIPPETS_SOURCES_DIR",
                                       description: "Relative path to folder with sources in the repo", 
                                       default_value: "sources"
                                       ),
        ]
      end

      def self.authors
        ["dominoo"]
      end

    end
  end
end
