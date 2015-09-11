require 'contracts'
require 'rakuna/integration/github'

module Rakuna
  module Authentication
    module GitHub
      module Organization
        include Contracts
        include Rakuna::Integration::GitHub

        Contract Maybe[String] => Any
        def is_authorized?(authorization_header = nil)
          organizations.any? { |org| whitelist.include? org.login }
        end

        private

        Contract None => ArrayOf[String]
        def whitelist
          []
        end

        Contract None => Sawyer::Resource
        def user
          @user ||= github.user
        end

        Contract None => String
        def username
          @username ||= user.login
        end

        Contract None => Array
        def organizations
          @organizations ||= github.organizations
        end
      end
    end
  end
end
