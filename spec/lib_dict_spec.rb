# -*- coding: utf-8 -*-
require_relative '../lib/dict'

describe Dict do
  
  it "shoud return Hash with translations of word 'samochód' for all available services" do
    get_all_dictionaries_translations("samochód") == {"wiktionary"=>samochód

{"samochód"=>["car", "automobile"]}
{"samochód"=>["She drove her car to the mall.", "The conductor linked the cars to the locomotive.", "The 11:10 to London was operated by a 4-car diesel multiple unit", "From the front-most car of the subway, he filmed the progress through the tunnel.", "We ordered five hundred cars of gypsum.", "Fix the car of the express elevator - the door is sticking.", "The most exciting part of riding a Ferris wheel is when your car goes over the top.", "Buy now! You can get more car for your money."]}
, "dictpl"=>samochód

{"samochód"=>["car", "autocar", "automobile"], "samochód ciężarowy"=>["lorry"], "samochód ciężarowy; samochód skrzyniowy"=>["truck"], "samochód cysterna (rodzaj pojazdu)"=>["gas tanker", "petrol tanker", "gasoline tanker"], "samochód do przewozu wojska [wojsk]"=>["troop-carrying vehicle"], "samochód dostawczy"=>["van", "cargo plane"], "samochód dwudrzwiowy"=>["two-door car"], "docierać samochód"=>["break in"], "kasować samochód"=>["write off"], "pojazd; samochód"=>["automobile"], "duży i tani samochód"=>["flivver"], "wypożyczony samochód"=>["u-drive"], "uruchomić samochód"=>["put the car in gear"], "krążownik szos; duży amerykański samochód"=>["yank-tank"], "zapalać samochód (zwłaszcza na pych)"=>["bump-start", "push-start"], "kabriolet; samochód bez dachu"=>["no-top"], "uruchomić samochód bez uzycia kluczyków (zwłaszcza, aby go ukraść)"=>["hot-wire"], "ciężarówka; samochód ciężarowy"=>["lorry"]}
{}
}

  end



end
