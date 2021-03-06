module Heaven
  module Notifier
    # A notifier for flowdock
    class Flowdock < Notifier::Default
      def deliver(message)
        filtered_message = message + " #{ascii_face}"
        Rails.logger.info "flowdock: #{filtered_message}"

        flow.push_to_chat(:content => filtered_message, :tags => ["Deploy"], :message_id => message_thread)
      end

      def flowdock_flow_api_token
        ENV["FLOWDOCK_FLOW_API_TOKEN"]
      end

      def flowdock_external_user_name
        ENV["FLOWDOCK_EXTERNAL_USER_NAME"]
      end

      def flow
        @flow ||= ::Flowdock::Flow.new(:api_token => flowdock_flow_api_token, :external_user_name => flowdock_external_user_name)
      end

      def message_thread
        deployment_payload["notify"]["message_thread"]
      end

      def repository_link(path = "")
        repo_url(path)
      end

      def user_link
        "@#{chat_user}"
      end

      def output_link
        target_url
      end
    end
  end
end
