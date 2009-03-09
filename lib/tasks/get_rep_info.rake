namespace :db do 

  desc "Import House districts"
  
  desc "Import Senate districts"
  
  desc "Import representative info from www.scstatehouse.gov"
  task :import_reps => :environment do
    require 'hpricot'
    require 'open-uri'

    doc = Hpricot(open("http://www.scstatehouse.gov/html-pages/housemembersd.html"))
    
    # Listing of Representatives
    (doc/"div/div/pre/div/a").each do |rep|
      name = rep.inner_html.strip.split(/\ \[/).first
      party = rep.inner_html[/\[[A-Z]\]/].gsub(/[\[\]]/, "")
      link = rep["href"]

      case party
      when 'D'
        party = 'Democrat'
      when 'R'
        party = 'Republican'
      else
        party = 'Unknown'
      end

      Representative.create(:name => name, :party => party, :sc_url => link,
                            :district => District.find(district))
    end
  end
  
  desc "Import senator info from www.scstatehouse.gov"
  task :import_reps => :environment do
    require 'hpricot'
    require 'open-uri'

    doc = Hpricot(open("http://www.scstatehouse.gov/html-pages/housemembersd.html"))
    
    # Listing of Senators
    (doc/"div/div/pre/div/a").each do |rep|
      name = rep.inner_html.strip.split(/\ \[/).first
      party = rep.inner_html[/\[[A-Z]\]/].gsub(/[\[\]]/, "")
      link = rep["href"]

      case party
      when 'D'
        party = 'Democrat'
      when 'R'
        party = 'Republican'
      else
        party = 'Unknown'
      end

      Senator.create(:name => name, :party => party, :sc_url => link,
                     :district => District.find(district))
    end
end
