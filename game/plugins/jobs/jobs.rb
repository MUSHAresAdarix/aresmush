$:.unshift File.dirname(__FILE__)
load "jobs_api.rb"

# Must be loaded before other job commands
load "lib/single_job_cmd.rb"


load "lib/change_job_cmd.rb"
load "lib/close_job_cmd.rb"
load "lib/create_job_cmd.rb"
load "lib/create_request_cmd.rb"
load "lib/delete_job_cmd.rb"
load "lib/event_handlers.rb"
load "lib/handle_job_cmd.rb"
load "lib/helpers.rb"
load "lib/job_comment_cmd.rb"
load "lib/job_search_cmd.rb"
load "lib/job_status_cmd.rb"
load "lib/jobs_backup_cmd.rb"
load "lib/jobs_catchup.rb"
load "lib/jobs_model.rb"
load "lib/jobs_new_cmd.rb"
load "lib/list_jobs_cmd.rb"
load "lib/list_requests_cmd.rb"
load "lib/purge_jobs_cmd.rb"
load "lib/request_comment_cmd.rb"
load "lib/view_job_cmd.rb"
load "lib/view_request_cmd.rb"
load "templates/job_template.rb"
load "templates/jobs_list_template.rb"

module AresMUSH
  module Jobs
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("jobs", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.help_files
      [ "help/admin_jobs.md", "help/jobs_archive.md", "help/requests.md" ]
    end
 
    def self.config_files
      [ "config_jobs.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
       case cmd.root
       when "job"
         case cmd.switch
         when "all"
           return ListJobsCmd
         when "backup"
           return JobsBackupCmd
         when "cat"
           return ChangeCategoryCmd
         when "catchup"
           return JobsCatchupCmd
         when "discuss", "respond"
           return JobCommentCmd
         when "close"
           return CloseJobCmd
         when "confirmpurge"
           return PurgeJobsConfirmCmd
         when "create"
           return CreateJobCmd
         when "delete"
           return DeleteJobCmd
         when "handle", "assign"
           return HandleJobCmd
         when "new"
           return JobsNewCmd
         when "purge"
           return PurgeJobsCmd
         when "search"
           return JobSearchCmd
         when "status"
           return JobStatusCmd
         when "title"
           return ChangeTitleCmd
         when nil
           if (cmd.args)
             return ViewJobCmd
           else
             return ListJobsCmd
           end
         end
         
       when "request"
         case cmd.switch
         when "comment"
           return RequestCommentCmd
         when "all"
           return ListRequestsCmd
         when nil
           if (!cmd.args)
             return ListRequestsCmd
           elsif (cmd.args =~ /\=/)
             return CreateRequestCmd
           else
             return ViewRequestCmd
           end
         end
       end
       
       nil
    end

    def self.get_event_handler(event_name) 
      nil
    end
  end
end