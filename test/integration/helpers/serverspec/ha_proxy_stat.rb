require 'csv'
require 'socket'

module Serverspec
  module Type
    class HAProxyStat < Base
      def initialize(backend_id, socket = '/var/lib/haproxy/stats')
        @backend_id = backend_id
        @socket = socket
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
        socket = UNIXSocket.new(@socket)
        socket.puts 'show stat'
        csv = CSV.new(socket.read.sub(/\s*^\#\s+/, ''), headers: true)
        data = {}

        csv.map do |row|
          h = row.to_hash
          data[h['svname']] = h
        end
        data[@backend_id] || {}
      end
    end

    def ha_proxy_stat(backend_id)
      HAProxyStat.new(backend_id)
    end
  end
end
include Serverspec::Type
