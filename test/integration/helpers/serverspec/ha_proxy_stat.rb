require 'csv'
require 'socket'

module Serverspec
  module Type
    class HAProxyStat < Base
      def initialize(backend)
        @backend = backend
        @info = stat_info
      end

      def check_status
        @info['check_status'] || ''
      end

      def check_code
        @info['check_code'].to_i
      end

      def status
        @info['status'] || ''
      end

      private

      def stat_info
        socket = UNIXSocket.new('/var/lib/haproxy/stats')
        socket.puts 'show stat'
        csv = CSV.new(socket.read.sub(/\s*^\#\s+/, ''), headers: true)
        data = {}

        csv.map do |row|
          h = row.to_hash
          data[h['svname']] = h
        end
        data[@backend] || {}
      end
    end

    def ha_proxy_stat(backend)
      HAProxyStat.new(backend)
    end
  end
end
include Serverspec::Type
