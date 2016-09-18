module Fastlane
  module Actions
    module SharedValues
    end

    class InstallSnippetsAction < Action
      def self.run(params)
        require 'tmpdir'
        git_repo = params[:git_repo]
        snippets_dir = params[:snippets_dir]
        install_dir = File.expand_path(params[:install_dir])
        
        if ! File.exists? snippets_dir and git_repo.to_s.empty?
          git_repo = UI.input("Please enter the URL to the git repository with snippets:")
        end


        if git_repo 
          tmp_dir = Dir.mktmpdir("fl_snippets")
          branch = params[:branch]

          branch_option = ""
          branch_option = "--branch #{branch}" if branch != 'HEAD'

          UI.message "Cloning remote git repo..."

          sh "GIT_TERMINAL_PROMPT=0 git clone '#{git_repo}' '#{tmp_dir}' --depth 1 -n #{branch_option}"
          sh "cd '#{tmp_dir}' && git checkout #{branch} '#{snippets_dir}'"

          src_dir = File.join(tmp_dir, params[:snippets_dir])
        else
          #Install from local dir 
          src_dir = File.expand_path(params[:snippets_dir])
        end

        if ! File.exists? install_dir
            UI.message "Creating Code Snippets Xcode directory #{install_dir}"
            FileUtils.mkdir_p install_dir
        end

        code_snippets =  Dir.entries(src_dir).select{ |e| File.extname(e) == ".codesnippet"  }
        
        code_snippets.select.each do |snippet|
          src_snippet_path = File.join(src_dir, snippet)

          UI.message "Installing code snippet #{snippet}"
          FileUtils.cp_r src_snippet_path, install_dir
        end
        
        UI.success "Successfully installed #{code_snippets.count} snippets into Xcode"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Installs snippets from repository to Xcode"
      end


      def self.available_options
        [

          FastlaneCore::ConfigItem.new(key: :install_dir,
                                       env_name: "FL_SNIPPETS_INSTALL_DIR", 
                                       description: "Installation directory for the snippets", 
                                       default_value: "~/Library/Developer/Xcode/UserData/CodeSnippets"
                                       ),
          FastlaneCore::ConfigItem.new(key: :snippets_dir,
                                       env_name: "FL_SNIPPETS_SNIPPETS_DIR",
                                       description: "Relative path to the folder with snippets in the repo", 
                                       default_value: "snippets"
                                       ),
          FastlaneCore::ConfigItem.new(key: :git_repo,
                                       env_name: "FL_SNIPPETS_GIT_REPO",
                                       description: "URL to git repository with snippets",
                                       optional: true,
                                       is_string: true
                                       ),
          FastlaneCore::ConfigItem.new(key: :branch,
                                       env_name: "FL_SNIPPETS_BRANCH",
                                       description: "Branch in the git repository",
                                       default_value: "HEAD"
                                       )
        ]
      end

      def self.output
        [
          
        ]
      end

      def self.authors
        ["dominoo"]
      end

    end
  end
end
