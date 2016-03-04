# LOG CLEANER
# Hides :code_submission and :test_case from SQL output
# Adapted From:
# http://stackoverflow.com/a/17869330
class ActiveRecord::ConnectionAdapters::AbstractAdapter
   protected

   def log_with_binary_truncate(sql, name="SQL", binds=[], &block)
    binds = binds.map do |col, data|
      if col.type == :binary && data.is_a?(String) && data.size > 27
        data = "#{data[0,10]}[REDACTED #{data.size - 20} bytes]#{data[-10,10]}"
      end
      # if col.type == :code_submssion
      # TODO
      [col, data]
    end

    sql = sql.gsub(/(?<='\\x[0-9a-f]{20})[0-9a-f]{20,}?(?=[0-9a-f]{20}')/) do |match|
      "[REDACTED #{match.size} chars]"
    end

    log_without_binary_truncate(sql, name, binds, &block)
   end

   alias_method_chain :log, :binary_truncate
end