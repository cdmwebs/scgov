namespace :db do 
  require 'hpricot'
  require 'scrubyt'
   
  desc "Import representative info from www.scstatehouse.gov"
  task :import_reps => :environment do
    doc = Hpricot(open("http://www.scstatehouse.gov/html-pages/housemembers.html"))
    
    # /html/body/table/tbody/tr[2]/td/div/table/tbody/tr/td[2]/div/div/pre/div
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

      Representative.create(:name => name, :party => party, :sc_url => link)
                            #:district => District.find(district))
    end
  end
  
  desc "Import senator info from www.scstatehouse.gov"
  task :import_senators => :environment do
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


  desc "With Scrubyt"
  task :get_reps => :environment do
    Scrubyt.logger = Scrubyt::Logger.new

    rep_data = Scrubyt::Extractor.define do
      #fetch "http://www.scstatehouse.gov/html-pages/housemembers.html"
      fetch "http://localhost/~chris/scgov/public/housemembers.html"

      # Grab each <div class="sansSerifNormal"> ?? surrounding each rep
      representatives "//div[@class='sansSerifNormal']/a[@class='contentlink']" do
        # dumps the href of the a
        link_url
        
        # follows the URL since it ends in _detail?????
        rep_detail do
          representative '//td[3]/div' do
            full_name '/span[1]'
            district '/span[2]'
            link_url
            debugger
          end
        end

=begin
        rep_link "/a" do
          rep_details "//td[3]/div" do
            full_name "/span[1]"
            district  "/span[2]"
            home_address "/table/tbody/tr[1]/td[2]"
            columbia_address "/table/tbody/tr[4]/td[2]"
            email "/a"
          end

          rep_info "//div[@class='menuboxcontent']/div[@class='serifNormal']" do
            committees "/pre/a"
            #bio "/text()"
          end
        end
=end
      end
    end

    puts rep_data.to_xml
  end


  desc "Process a single representative"
  task :get_rep => :environment do
    Scrubyt.logger = Scrubyt::Logger.new

    rep_data = Scrubyt::Extractor.define(:log_level => :verbose) do

      fetch "http://localhost/~chris/scgov/public/0006818181.html"

      representatives '//div[@id="tablecontent"]' do
        representative '//td[3]/div' do
          full_name '/span[1]'
          district '/span[2]'
        end
      end
    end

    puts rep_data.to_xml
  end
end
