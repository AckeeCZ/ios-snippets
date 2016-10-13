module Fastlane
  module Actions

    class AddAllSnippetsAction < Action
      def self.run(params)
        dest_dir = File.expand_path(File.dirname(__FILE__))
        install_dir = File.expand_path(params[:install_dir])
        replace_all = params[:replace_all]

        code_snippets =  Dir.entries(install_dir).select{ |e| File.extname(e) == ".codesnippet"  }.map { |path| File.join(install_dir, path) }


        snippets_added = []

        code_snippets.each do |snippet_path|

          key = snippet_prefix(snippet_path)
          destination_path =  File.join(params[:snippets_dir], "#{key}.codesnippet")

          if File.exists? destination_path and not replace_all
            choice = UI.select("Snippet #{key} already exists, do you wish to replace it?", ["Replace", "Replace All", "Cancel"])
            if choice == "Cancel"
              break
            end

            if choice == "Replace All"
                replace_all = true
            end
          end

          #Copy snippet
          FileUtils.cp snippet_path, destination_path

          #Copy source
          source = snippet_source(snippet_path)

          unless File.directory?(params[:sources_dir])
            FileUtils.mkdir_p(params[:sources_dir])
          end

          File.open(File.join(params[:sources_dir], "#{key}.swift"), 'w') { |file| file.write(source) }

          UI.message "Copying snippet #{key}"

          snippets_added << key

        end

        if snippets_added.count > 0
          if UI.confirm("Successfully added #{snippets_added.count} snippets, do you wish to commit?")
            sh "git commit -am \"Added #{snippets_added.count} snippets \n\n #{snippets_added.join(", ")}\""
          end
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
          FastlaneCore::ConfigItem.new(key: :install_dir,
                                       env_name: "FL_SNIPPETS_INSTALL_DIR",
                                       description: "Installation directory for the snippets",
                                       default_value: "~/Library/Developer/Xcode/UserData/CodeSnippets"
                                       ),
          FastlaneCore::ConfigItem.new(key: :replace_all,
                                       description: "Replace all snippets with the same name",
                                       default_value: false
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
