# Call this file 'foo.rb' (in logstash/filters, as above)
require "logstash/filters/base"
require "logstash/namespace"
require 'time'

class LogStash::Filters::Timer < LogStash::Filters::Base
  #mesture a success of ip mapping user process (print to /dev/shm/mapping_counter) 
  @@lasttime=0
  #$ipv6 = Hash.new
  # Setting the config_name here is required. This is how you
  # configure this filter from your logstash config.
  #
  # filter {
  #   foo { ... }
  # }
  config_name "timer"

  # New plugins should start life at milestone 1.
  milestone 1

  # Replace the message with this value.
  config :message, :validate => :string
  config :command, :validate => :string, :default => ""

  public
  def register
    @@lasttime = Time.now
    # nothing to do
  end # def register

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)
   #   system("echo \"enter timer plugin\"")
    if @command == "start" or @command == "restart" 
        @@lasttime = Time.now	
    end

    if @command == "gettime"
	t = Time.now
	diff=(t - @@lasttime) 
        system("echo \"#{diff}\"")
    end


#    if ! event["userID"] and event["userIPv4"] and event['userIPv4'] != "-" and $ipv4[event["userIPv4"]]
#	@@mapping_counter+=1	
   #    system("echo \"#{@@mapping_counter}\">/dev/shm/mapping_counter")
   #    system("echo \"evnet mapping ip complete #{event["userID"]}<=>#{event['userIPv4']}\"")
#    end
    #if @message
      # Replace the event message with our message as configured in the
      # config file.
    #  event["message"] = @message
    #end
    # filter_matched should go in the last line of our successful code 
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Foo
