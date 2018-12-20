require 'bigdecimal'
require 'csv'

class Reporter
    def pluralize(count, singular, plural = nil)
        word = if (count == 1 || count =~ /^1(\.0+)?$/)
            singular
        else
            plural || singular.pluralize
        end

        "#{count || 0} #{word}"
    end

    def perform
        skip = 3
        n = 0
        total = {}
        CSV.foreach(ARGV[0]) do |row|
            n += 1
            next if n <= skip
            break if row.nil? || row.first.nil?
            currency = row[0].split(/\s+/).last.tr('()', '')
            units = row[1].to_s
            owed = row[7].to_s
            exchange_rate = row[8].to_s
            proceeds = row[9].to_s
            target_currency = row[10].to_s

            puts "#{owed} #{currency} @ #{exchange_rate} for #{pluralize(units, "unit", "units")} ⇒ #{proceeds} #{target_currency}"

            if total[target_currency] != nil
                total[target_currency] += BigDecimal.new(proceeds)
            else
                total[target_currency] = BigDecimal.new(proceeds)
            end
        end

        puts
        total.each_key do |key|
            puts "#{total[key].to_s("F")} #{key}"
        end
    end
end

Reporter.new.perform
