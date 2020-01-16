class DemoEventController < ApplicationController
  def index
    
    @rank = Wallet.all
                  .map{|w| [w.user_id, (w.amount * get_rate(w.currency_id))]}
                  .sort{|x,y| x[0] <=> y[0]}
                  .reduce([[]]){|accu, w| (accu[-1][0] == w[0]) ? accu[0..-2].push([w[0],(accu[-1][1] + w[1])]) : accu.push(w)}[1..]
                  .sort{|x,y| x[1] <=> y[1]}
                  .last(10)
                  .reverse


  end
  def get_rate(currency_id)
    Currency.find_by(id: currency_id).last_rate
  end
end
