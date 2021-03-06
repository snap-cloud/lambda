# LOG CLEANER
# Hides :code_submission and :test_case from SQL output
# Logging this much XML and JSON is a pain.
# Adapted From:
# http://stackoverflow.com/a/17869330
# class ActiveRecord::ConnectionAdapters::AbstractAdapter
#    protected
#
#    # TODO: This doesn't seem to be redacting UPDATES
#    def log_with_binary_truncate(sql, name="SQL", binds=[], stmt_key='', &block)
#      binds = binds.map do |col, data|
#        if col.name == 'code_submission' || col.name == 'test_results'
#          data = "#{data[0,25]} [REDACTED #{data.size - 50} bytes]  #{data[-25,25]}"
#        end
#        [col, data]
#      end
#      log_without_binary_truncate(sql, name, binds, stmt_key, &block)
#    end
#
#    alias_method_chain :log, :binary_truncate
# end

# http://stackoverflow.com/a/21731809
class ActiveRecord::ConnectionAdapters::AbstractAdapter
  protected

  def log_with_binary_truncate(sql, name="SQL", binds=[], statement_name = nil, &block)
    binds = binds.map do |col, data|
      if data.is_a?(String) && data.size > 100
        data = "#{data[0,10]} [REDACTED #{data.size - 20} bytes] #{data[-10,10]}"
      end
      [col, data]
    end

    sql = sql.gsub(/(?<='\\x[0-9a-f]{100})[0-9a-f]{100,}?(?=[0-9a-f]{100}')/) do |match|
      "[REDACTED #{match.size} chars]"
    end

    log_without_binary_truncate(sql, name, binds, statement_name, &block)
  end

  alias_method_chain :log, :binary_truncate
end