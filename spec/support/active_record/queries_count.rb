# typed: true
# frozen_string_literal: true

class QueryCounter
  class Counter
    def initialize
      @count = 0
    end

    attr_reader :count

    def call(_name, _start, _finish, _message_id, values)
      query_type = values[:name]
      @count += 1 unless %w[CACHE SCHEMA].include? query_type
    end

    def to_proc
      ->(*args) { call(*args) }
    end
  end

  def self.call(&block)
    counter = Counter.new
    ActiveSupport::Notifications.subscribed(counter, "sql.active_record", &block)
    counter.count
  end
end
