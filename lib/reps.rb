require 'config/environment'
require 'scrubyt'

class Representative
  attr_accessor :full_name, :district, :home_address, :columbia_address, :email

  def initialize(representative)
    @full_name = (representative/:full_name).inner_html
    @district = (representative/:district).inner_html
    @home_address = (representative/:home_address).inner_html
    @columbia_address = (representative/:columbia_address).inner_html
    @email = (representative/:email).inner_html
  end
end

def reps
    Scrubyt.logger = Scrubyt::Logger.new

    rep_data = Scrubyt::Extractor.define do
      #fetch "http://www.scstatehouse.gov/html-pages/housemembers.html"
      fetch "http://localhost/~chris/scgov/public/housemembers.html"

      # Grab each <div class="sansSerifNormal"> ?? surrounding each rep
      representatives "//div[@class='sansSerifNormal'][5]/a[@class='contentlink']" do
      #representatives "//div[@class='sansSerifNormal']/a[@href='http://www.scstatehouse.gov/members/bios/0006818181.html']" do
        
        # follows the URL since it ends in _detail?????
        rep_detail do
          representative '//td[3]/div' do
            full_name '/span[1]'
            district '/span[2]'
            home_address "/table/tbody/tr[1]/td[2]"
            columbia_address "/table/tbody/tr[4]/td[2]"
            email "/a"
          end

          rep_info "//div[@class='menuboxcontent']/div[@class='serifNormal']" do
            committees "/pre/a"
            #bio "/text()"
          end
        end
      end
    end


  representative_hash = {}

  rp = Hpricot.XML(rep_data.to_xml)
  (rp/:representative).each do |representative|
    representative_hash[(representative/:full_name).inner_html] = Representative.new(representative)
  end

  puts representative_hash.to_yaml
end

reps
