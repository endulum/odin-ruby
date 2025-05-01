def stock_picker days
  best_days = []
  best_profit = 0

  days.each_with_index do |price_to_buy, day_to_buy|
    prices_to_sell = days[day_to_buy + 1..-1]
    if (prices_to_sell.length > 0)
      prices_to_sell.each_with_index do |price_to_sell, day_to_sell|
        profit = price_to_sell - price_to_buy
        if (profit > best_profit) 
          best_profit = profit 
          best_days[0] = day_to_buy
          best_days[1] = day_to_sell + day_to_buy + 1
        end
      end
    end
  end

  best_days
end