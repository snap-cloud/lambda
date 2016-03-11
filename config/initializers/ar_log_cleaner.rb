# LOG CLEANER
# Hides :code_submission and :test_case from SQL output
# Logging this much XML and JSON is a pain.
# Adapted From:
# http://stackoverflow.com/a/17869330
class ActiveRecord::ConnectionAdapters::AbstractAdapter
   protected

   # TODO: This doesn't seem to be redacting UPDATES
   def log_with_binary_truncate(sql, name="SQL", binds=[], stmt_key='', &block)
     binds = binds.map do |col, data|
       if col.name == 'code_submission' || col.name == 'test_results'
         data = "#{data[0,25]} [REDACTED #{data.size - 50} bytes]  #{data[-25,25]}"
       end
       [col, data]
     end
     log_without_binary_truncate(sql, name, binds, stmt_key, &block)
   end

   alias_method_chain :log, :binary_truncate
end