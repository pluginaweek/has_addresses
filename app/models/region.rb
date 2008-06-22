# Defined by the ISO 3166-2 standard.  This is a standard that gives short codes
# for provinces, etc. within a country.
# 
# Data is based on http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166_2/iso_3166_2.xml?op=file
class Region < ActiveRecord::Base
  acts_as_enumeration :code
  
  column :country_id, :integer
  column :group, :string # Currently only used by GB (United Kingdom)
  column :name, :string
  column :abbreviation, :string
  
  belongs_to  :country
  has_many    :addresses
  
  validates_presence_of   :name,
                          :country_id,
                          :abbreviation
  validates_length_of     :abbreviation,
                            :within => 1..5
  
  def initialize(attributes = nil) #:nodoc:
    super
    self.abbreviation ||= default_abbreviation unless attributes && attributes.include?(:abbreviation)
    self.code = default_code
  end
  
  private
    # The abbreviation for this region unique within the country
    def default_abbreviation
      "%03d" % (id % 1000) if id
    end
    
    # The unique code assigned to this region by the standard
    def default_code
      "#{country}-#{abbreviation}"
    end
  
  # Andorra
  with_options(:country => Country['AD']) do |country|
    country.create :id => 20002, :name => "Canillo"
    country.create :id => 20003, :name => "Encamp"
    country.create :id => 20004, :name => "La Massana"
    country.create :id => 20005, :name => "Ordino"
    country.create :id => 20006, :name => "Sant Julià de Lòria"
    country.create :id => 20007, :name => "Andorra la Vella"
    country.create :id => 20008, :name => "Escaldes-Engordany"
  end
  
  # United Arab Emirates
  with_options(:country => Country['AE']) do |country|
    country.create :id => 784001, :name => "Abū Ȥaby", :abbreviation => 'AZ' # Abu Dhabi
    country.create :id => 784002, :name => "AjmānAjmān", :abbreviation => 'AJ'
    country.create :id => 784003, :name => "Al Fujayrah", :abbreviation => 'FU'
    country.create :id => 784004, :name => "Ash Shāriqah", :abbreviation => 'SH'
    country.create :id => 784005, :name => "Dubayy", :abbreviation => 'DU'
    country.create :id => 784006, :name => "Ra's al Khaymah", :abbreviation => 'RK'
    country.create :id => 784007, :name => "Umm al Qaywayn", :abbreviation => 'UQ'
  end
  
  # Afghanistan
  with_options(:country => Country['AF']) do |country|
    country.create :id => 4001, :name => "Badakhshān", :abbreviation => 'BDS'
    country.create :id => 4002, :name => "Bādghīs", :abbreviation => 'BDG'
    country.create :id => 4003, :name => "Baghlān", :abbreviation => 'BGL'
    country.create :id => 4004, :name => "Balkh", :abbreviation => 'BAL'
    country.create :id => 4005, :name => "Bāmīān", :abbreviation => 'BAM'
    country.create :id => 4006, :name => "Dāykondī", :abbreviation => 'DAY'
    country.create :id => 4007, :name => "Farāh", :abbreviation => 'FRA'
    country.create :id => 4008, :name => "Fāryāb", :abbreviation => 'FYB'
    country.create :id => 4009, :name => "Ghaznī", :abbreviation => 'GHA'
    country.create :id => 4010, :name => "Ghowr", :abbreviation => 'GHO'
    country.create :id => 4011, :name => "Helmand", :abbreviation => 'HEL'
    country.create :id => 4012, :name => "Herāt", :abbreviation => 'HER'
    country.create :id => 4013, :name => "Jowzjān", :abbreviation => 'JOW'
    country.create :id => 4014, :name => "Kābul", :abbreviation => 'KAB' # Kābul [Kābol]
    country.create :id => 4015, :name => "Kandahār", :abbreviation => 'KAN'
    country.create :id => 4016, :name => "Kāpīsā", :abbreviation => 'KAP'
    country.create :id => 4017, :name => "Khowst", :abbreviation => 'KHO'
    country.create :id => 4018, :name => "Konar", :abbreviation => 'KNR' # Konar [Kunar]
    country.create :id => 4019, :name => "Kondoz", :abbreviation => 'KDZ' # Kondoz [Kunduz]
    country.create :id => 4020, :name => "Laghmān", :abbreviation => 'LAG'
    country.create :id => 4021, :name => "Lowgar", :abbreviation => 'LOW'
    country.create :id => 4022, :name => "Nangrahār", :abbreviation => 'NAN' # Nangrahār [Nangarhār]
    country.create :id => 4023, :name => "Nīmrūz", :abbreviation => 'NIM'
    country.create :id => 4024, :name => "Nūrestān", :abbreviation => 'NUR'
    country.create :id => 4025, :name => "Orūzgān", :abbreviation => 'ORU' # Orūzgān [Urūzgān]
    country.create :id => 4026, :name => "Panjshīr", :abbreviation => 'PAN'
    country.create :id => 4027, :name => "Paktīā", :abbreviation => 'PIA'
    country.create :id => 4028, :name => "Paktīkā", :abbreviation => 'PKA'
    country.create :id => 4029, :name => "Parwān", :abbreviation => 'PAR'
    country.create :id => 4030, :name => "Samangān", :abbreviation => 'SAM'
    country.create :id => 4031, :name => "Sar-e Pol", :abbreviation => 'SAR'
    country.create :id => 4032, :name => "Takhār", :abbreviation => 'TAK'
    country.create :id => 4033, :name => "Wardak", :abbreviation => 'WAR' # Wardak [Wardag]
    country.create :id => 4034, :name => "Zābol", :abbreviation => 'ZAB' # Zābol [Zābul]
  end
  
  # Antigua and Barbuda
  with_options(:country => Country['AG']) do |country|
    country.create :id => 28003, :name => "Saint George"
    country.create :id => 28004, :name => "Saint John"
    country.create :id => 28005, :name => "Saint Mary"
    country.create :id => 28006, :name => "Saint Paul"
    country.create :id => 28007, :name => "Saint Peter"
    country.create :id => 28008, :name => "Saint Philip"
    country.create :id => 28010, :name => "Barbuda"
  end
  
  # Albania
  with_options(:country => Country['AL']) do |country|
    country.create :id => 8001, :name => "Berat", :abbreviation => 'BR'
    country.create :id => 8002, :name => "Bulqizë", :abbreviation => 'BU'
    country.create :id => 8003, :name => "Delvinë", :abbreviation => 'DL'
    country.create :id => 8004, :name => "Devoll", :abbreviation => 'DV'
    country.create :id => 8005, :name => "Dibër", :abbreviation => 'DI'
    country.create :id => 8006, :name => "Durrës", :abbreviation => 'DR'
    country.create :id => 8007, :name => "Elbasan", :abbreviation => 'EL'
    country.create :id => 8008, :name => "Fier", :abbreviation => 'FR'
    country.create :id => 8009, :name => "Gramsh", :abbreviation => 'GR'
    country.create :id => 8010, :name => "Gjirokastër", :abbreviation => 'GJ'
    country.create :id => 8011, :name => "Has", :abbreviation => 'HA'
    country.create :id => 8012, :name => "Kavajë", :abbreviation => 'KA'
    country.create :id => 8013, :name => "Kolonjë", :abbreviation => 'ER'
    country.create :id => 8014, :name => "Korçë", :abbreviation => 'KO'
    country.create :id => 8015, :name => "Krujë", :abbreviation => 'KR'
    country.create :id => 8016, :name => "Kuçovë", :abbreviation => 'KC'
    country.create :id => 8017, :name => "Kukës", :abbreviation => 'KU'
    country.create :id => 8018, :name => "Kurbin", :abbreviation => 'KB'
    country.create :id => 8019, :name => "Lezhë", :abbreviation => 'LE'
    country.create :id => 8020, :name => "Librazhd", :abbreviation => 'LB'
    country.create :id => 8021, :name => "Lushnjë", :abbreviation => 'LU'
    country.create :id => 8022, :name => "Malësi e Madhe", :abbreviation => 'MM'
    country.create :id => 8023, :name => "Mallakastër", :abbreviation => 'MK'
    country.create :id => 8024, :name => "Mat", :abbreviation => 'MT'
    country.create :id => 8025, :name => "Mirditë", :abbreviation => 'MR'
    country.create :id => 8026, :name => "Peqin", :abbreviation => 'PQ'
    country.create :id => 8027, :name => "Përmet", :abbreviation => 'PR'
    country.create :id => 8028, :name => "Pogradec", :abbreviation => 'PG'
    country.create :id => 8029, :name => "Pukë", :abbreviation => 'PU'
    country.create :id => 8030, :name => "Sarandë", :abbreviation => 'SR'
    country.create :id => 8031, :name => "Skrapar", :abbreviation => 'SK'
    country.create :id => 8032, :name => "Shkodër", :abbreviation => 'SH'
    country.create :id => 8033, :name => "Tepelenë", :abbreviation => 'TE'
    country.create :id => 8034, :name => "Tiranë", :abbreviation => 'TR'
    country.create :id => 8035, :name => "Tropojë", :abbreviation => 'TP'
    country.create :id => 8036, :name => "Vlorë", :abbreviation => 'VL'
  end
  
  # Armenia
  with_options(:country => Country['AM']) do |country|
    country.create :id => 51001, :name => "Erevan", :abbreviation => 'ER'
    country.create :id => 51002, :name => "Aragacotn", :abbreviation => 'AG'
    country.create :id => 51003, :name => "Ararat", :abbreviation => 'AR'
    country.create :id => 51004, :name => "Armavir", :abbreviation => 'AV'
    country.create :id => 51005, :name => "Gegarkunik", :abbreviation => 'GR'
    country.create :id => 51006, :name => "Kotayk", :abbreviation => 'KT'
    country.create :id => 51007, :name => "Lory", :abbreviation => 'LO'
    country.create :id => 51008, :name => "Sirak", :abbreviation => 'SH'
    country.create :id => 51009, :name => "Syunik", :abbreviation => 'SU'
    country.create :id => 51010, :name => "Tavus", :abbreviation => 'TV'
    country.create :id => 51011, :name => "Vayoc Jor", :abbreviation => 'VD'
  end
  
  # Angola
  with_options(:country => Country['AO']) do |country|
    country.create :id => 24001, :name => "Bengo", :abbreviation => 'BGO'
    country.create :id => 24002, :name => "Benguela", :abbreviation => 'BGU'
    country.create :id => 24003, :name => "Bié", :abbreviation => 'BIE'
    country.create :id => 24004, :name => "Cabinda", :abbreviation => 'CAB'
    country.create :id => 24005, :name => "Cuando-Cubango", :abbreviation => 'CCU'
    country.create :id => 24006, :name => "Cuanza Norte", :abbreviation => 'CNO'
    country.create :id => 24007, :name => "Cuanza Sul", :abbreviation => 'CUS'
    country.create :id => 24008, :name => "Cunene", :abbreviation => 'CNN'
    country.create :id => 24009, :name => "Huambo", :abbreviation => 'HUA'
    country.create :id => 24010, :name => "Huíla", :abbreviation => 'HUI'
    country.create :id => 24011, :name => "Luanda", :abbreviation => 'LUA'
    country.create :id => 24012, :name => "Lunda Norte", :abbreviation => 'LNO'
    country.create :id => 24013, :name => "Lunda Sul", :abbreviation => 'LSU'
    country.create :id => 24014, :name => "Malange", :abbreviation => 'MAL'
    country.create :id => 24015, :name => "Moxico", :abbreviation => 'MOX'
    country.create :id => 24016, :name => "Namibe", :abbreviation => 'NAM'
    country.create :id => 24017, :name => "Uíge", :abbreviation => 'UIG'
    country.create :id => 24018, :name => "Zaire", :abbreviation => 'ZAI'
  end
  
  # Argentina
  with_options(:country => Country['AR']) do |country|
    country.create :id => 32001, :name => "Capital federal", :abbreviation => 'C'
    country.create :id => 32002, :name => "Buenos Aires", :abbreviation => 'B'
    country.create :id => 32003, :name => "Catamarca", :abbreviation => 'K'
    country.create :id => 32004, :name => "Cordoba", :abbreviation => 'X'
    country.create :id => 32005, :name => "Corrientes", :abbreviation => 'W'
    country.create :id => 32006, :name => "Chaco", :abbreviation => 'H'
    country.create :id => 32007, :name => "Chubut", :abbreviation => 'U'
    country.create :id => 32008, :name => "Entre Rios", :abbreviation => 'E'
    country.create :id => 32009, :name => "Formosa", :abbreviation => 'P'
    country.create :id => 32010, :name => "Jujuy", :abbreviation => 'Y'
    country.create :id => 32011, :name => "La Pampa", :abbreviation => 'L'
    country.create :id => 32012, :name => "Mendoza", :abbreviation => 'M'
    country.create :id => 32013, :name => "Misiones", :abbreviation => 'N'
    country.create :id => 32014, :name => "Neuquen", :abbreviation => 'Q'
    country.create :id => 32015, :name => "Rio Negro", :abbreviation => 'R'
    country.create :id => 32016, :name => "Salta", :abbreviation => 'A'
    country.create :id => 32017, :name => "San Juan", :abbreviation => 'J'
    country.create :id => 32018, :name => "San Luis", :abbreviation => 'D'
    country.create :id => 32019, :name => "Santa Cruz", :abbreviation => 'Z'
    country.create :id => 32020, :name => "Santa Fe", :abbreviation => 'S'
    country.create :id => 32021, :name => "Santiago del Estero", :abbreviation => 'G'
    country.create :id => 32022, :name => "Tierra del Fuego", :abbreviation => 'V'
    country.create :id => 32023, :name => "Tucuman", :abbreviation => 'T'
  end
  
  # Austria
  with_options(:country => Country['AT']) do |country|
    country.create :id => 40001, :name => "Burgenland", :abbreviation => '1'
    country.create :id => 40002, :name => "Kärnten", :abbreviation => '2'
    country.create :id => 40003, :name => "Niederösterreich", :abbreviation => '3'
    country.create :id => 40004, :name => "Oberösterreich", :abbreviation => '4'
    country.create :id => 40005, :name => "Salzburg", :abbreviation => '5'
    country.create :id => 40006, :name => "Steiermark", :abbreviation => '6'
    country.create :id => 40007, :name => "Tirol", :abbreviation => '7'
    country.create :id => 40008, :name => "Vorarlberg", :abbreviation => '8'
    country.create :id => 40009, :name => "Wien", :abbreviation => '9'
  end
  
  # Australia
  with_options(:country => Country['AU']) do |country|
    country.create :id => 36001, :name => "New South Wales", :abbreviation => 'NSW'
    country.create :id => 36002, :name => "Queensland", :abbreviation => 'QLD'
    country.create :id => 36003, :name => "South Australia", :abbreviation => 'SA'
    country.create :id => 36004, :name => "Tasmania", :abbreviation => 'TAS'
    country.create :id => 36005, :name => "Victoria", :abbreviation => 'VIC'
    country.create :id => 36006, :name => "Western Australia", :abbreviation => 'WA'
    country.create :id => 36007, :name => "Australian Capital Territory", :abbreviation => 'ACT'
    country.create :id => 36008, :name => "Northern Territory", :abbreviation => 'NT'
  end
  
  # Azerbaijan
  with_options(:country => Country['AZ']) do |country|
    country.create :id => 310001, :name => "Əli Bayramlı", :abbreviation => 'AB'
    country.create :id => 310002, :name => "Bakı", :abbreviation => 'BA'
    country.create :id => 310003, :name => "Gəncə", :abbreviation => 'GA'
    country.create :id => 310004, :name => "Lənkəran", :abbreviation => 'LA'
    country.create :id => 310005, :name => "Mingəçevir", :abbreviation => 'MI'
    country.create :id => 310006, :name => "Naftalan", :abbreviation => 'NA'
    country.create :id => 310007, :name => "Şəki", :abbreviation => 'SA'
    country.create :id => 310008, :name => "Sumqayıt", :abbreviation => 'SM'
    country.create :id => 310009, :name => "Şuşa", :abbreviation => 'SS'
    country.create :id => 310010, :name => "Xankəndi", :abbreviation => 'XA'
    country.create :id => 310011, :name => "Yevlax", :abbreviation => 'YE'
    country.create :id => 310012, :name => "Abşeron", :abbreviation => 'ABS'
    country.create :id => 310013, :name => "Ağcabədi", :abbreviation => 'AGC'
    country.create :id => 310014, :name => "Ağdam", :abbreviation => 'AGM'
    country.create :id => 310015, :name => "Ağdaş", :abbreviation => 'AGS'
    country.create :id => 310016, :name => "Ağstafa", :abbreviation => 'AGA'
    country.create :id => 310017, :name => "Ağsu", :abbreviation => 'AGU'
    country.create :id => 310018, :name => "Astara", :abbreviation => 'AST'
    country.create :id => 310019, :name => "Babək", :abbreviation => 'BAB'
    country.create :id => 310020, :name => "Balakən", :abbreviation => 'BAL'
    country.create :id => 310021, :name => "Bərdə", :abbreviation => 'BAR'
    country.create :id => 310022, :name => "Beyləqan", :abbreviation => 'BEY'
    country.create :id => 310023, :name => "Biləsuvar", :abbreviation => 'BIL'
    country.create :id => 310024, :name => "Cəbrayıl", :abbreviation => 'CAB'
    country.create :id => 310025, :name => "Cəlilabab", :abbreviation => 'CAL'
    country.create :id => 310026, :name => "Culfa", :abbreviation => 'CUL'
    country.create :id => 310027, :name => "Daşkəsən", :abbreviation => 'DAS'
    country.create :id => 310028, :name => "Dəvəçi", :abbreviation => 'DAV'
    country.create :id => 310029, :name => "Füzuli", :abbreviation => 'FUZ'
    country.create :id => 310030, :name => "Gədəbəy", :abbreviation => 'GAD'
    country.create :id => 310031, :name => "Goranboy", :abbreviation => 'GOR'
    country.create :id => 310032, :name => "Göyçay", :abbreviation => 'GOY'
    country.create :id => 310033, :name => "Hacıqabul", :abbreviation => 'HAC'
    country.create :id => 310034, :name => "İmişli", :abbreviation => 'IMI'
    country.create :id => 310035, :name => "İsmayıllı", :abbreviation => 'ISM'
    country.create :id => 310036, :name => "Kəlbəcər", :abbreviation => 'KAL'
    country.create :id => 310037, :name => "Kürdəmir", :abbreviation => 'KUR'
    country.create :id => 310038, :name => "Laçın", :abbreviation => 'LAC'
    country.create :id => 310039, :name => "Lənkəran", :abbreviation => 'LAN'
    country.create :id => 310040, :name => "Lerik", :abbreviation => 'LER'
    country.create :id => 310041, :name => "Masallı", :abbreviation => 'MAS'
    country.create :id => 310042, :name => "Neftçala", :abbreviation => 'NEF'
    country.create :id => 310043, :name => "Oğuz", :abbreviation => 'OGU'
    country.create :id => 310044, :name => "Ordubad", :abbreviation => 'ORD'
    country.create :id => 310045, :name => "Qəbələ", :abbreviation => 'QAB'
    country.create :id => 310046, :name => "Qax", :abbreviation => 'QAX'
    country.create :id => 310047, :name => "Qazax", :abbreviation => 'QAZ'
    country.create :id => 310048, :name => "Qobustan", :abbreviation => 'QOB'
    country.create :id => 310049, :name => "Quba", :abbreviation => 'QBA'
    country.create :id => 310050, :name => "Qubadlı", :abbreviation => 'QBI'
    country.create :id => 310051, :name => "Qusar", :abbreviation => 'QUS'
    country.create :id => 310052, :name => "Saatlı", :abbreviation => 'SAT'
    country.create :id => 310053, :name => "Sabirabad", :abbreviation => 'SAB'
    country.create :id => 310054, :name => "Sədərək", :abbreviation => 'SAD'
    country.create :id => 310055, :name => "Şahbuz", :abbreviation => 'SAH'
    country.create :id => 310056, :name => "Şəki", :abbreviation => 'SAK'
    country.create :id => 310057, :name => "Salyan", :abbreviation => 'SAL'
    country.create :id => 310058, :name => "Şamaxı", :abbreviation => 'SMI'
    country.create :id => 310059, :name => "Şəmkir", :abbreviation => 'SKR'
    country.create :id => 310060, :name => "Samux", :abbreviation => 'SMX'
    country.create :id => 310061, :name => "Şərur", :abbreviation => 'SAR'
    country.create :id => 310062, :name => "Siyəzən", :abbreviation => 'SIY'
    country.create :id => 310063, :name => "Şuşa", :abbreviation => 'SUS'
    country.create :id => 310064, :name => "Tərtər", :abbreviation => 'TAR'
    country.create :id => 310065, :name => "Tovuz", :abbreviation => 'TOV'
    country.create :id => 310066, :name => "Ucar", :abbreviation => 'UCA'
    country.create :id => 310067, :name => "Xaçmaz", :abbreviation => 'XAC'
    country.create :id => 310068, :name => "Xanlar", :abbreviation => 'XAN'
    country.create :id => 310069, :name => "Xızı", :abbreviation => 'XIZ'
    country.create :id => 310070, :name => "Xocalı", :abbreviation => 'XCI'
    country.create :id => 310071, :name => "Xocavənd", :abbreviation => 'XVD'
    country.create :id => 310072, :name => "Yardımlı", :abbreviation => 'YAR'
    country.create :id => 310073, :name => "Yevlax", :abbreviation => 'YEV'
    country.create :id => 310074, :name => "Zəngilan", :abbreviation => 'ZAN'
    country.create :id => 310075, :name => "Zaqatala", :abbreviation => 'ZAQ'
    country.create :id => 310076, :name => "Zərdab", :abbreviation => 'ZAR'
  end
  
  # Bosnia and Herzegovina
  with_options(:country => Country['BA']) do |country|
    country.create :id => 70001, :name => "Federacija Bosna i Hercegovina", :abbreviation => 'BIH'
    country.create :id => 70002, :name => "Republika Srpska", :abbreviation => 'SRP'
  end
  
  # Barbados
  with_options(:country => Country['BB']) do |country|
    country.create :id => 52001, :name => "Christ Church"
    country.create :id => 52002, :name => "Saint Andrew"
    country.create :id => 52003, :name => "Saint George"
    country.create :id => 52004, :name => "Saint James"
    country.create :id => 52005, :name => "Saint John"
    country.create :id => 52006, :name => "Saint Joseph"
    country.create :id => 52007, :name => "Saint Lucy"
    country.create :id => 52008, :name => "Saint Michael"
    country.create :id => 52009, :name => "Saint Peter"
    country.create :id => 52010, :name => "Saint Philip"
    country.create :id => 52011, :name => "Saint Thomas"
  end
  
  # Bangladesh
  with_options(:country => Country['BD']) do |country|
    country.create :id => 50001, :name => "Bandarban"
    country.create :id => 50002, :name => "Barguna"
    country.create :id => 50003, :name => "Bogra"
    country.create :id => 50004, :name => "Brahmanbaria"
    country.create :id => 50005, :name => "Bagerhat"
    country.create :id => 50006, :name => "Barisal"
    country.create :id => 50007, :name => "Bhola"
    country.create :id => 50008, :name => "Comilla"
    country.create :id => 50009, :name => "Chandpur"
    country.create :id => 50010, :name => "Chittagong"
    country.create :id => 50011, :name => "Cox's Bazar"
    country.create :id => 50012, :name => "Chuadanga"
    country.create :id => 50013, :name => "Dhaka"
    country.create :id => 50014, :name => "Dinajpur"
    country.create :id => 50015, :name => "Faridpur"
    country.create :id => 50016, :name => "Feni"
    country.create :id => 50017, :name => "Gopalganj"
    country.create :id => 50018, :name => "Gazipur"
    country.create :id => 50019, :name => "Gaibandha"
    country.create :id => 50020, :name => "Habiganj"
    country.create :id => 50021, :name => "Jamalpur"
    country.create :id => 50022, :name => "Jessore"
    country.create :id => 50023, :name => "Jhenaidah"
    country.create :id => 50024, :name => "Jaipurhat"
    country.create :id => 50025, :name => "Jhalakati"
    country.create :id => 50026, :name => "Kishorganj"
    country.create :id => 50027, :name => "Khulna"
    country.create :id => 50028, :name => "Kurigram"
    country.create :id => 50029, :name => "Khagrachari"
    country.create :id => 50030, :name => "Kushtia"
    country.create :id => 50031, :name => "Lakshmipur"
    country.create :id => 50032, :name => "Lalmonirhat"
    country.create :id => 50033, :name => "Manikganj"
    country.create :id => 50034, :name => "Mymensingh"
    country.create :id => 50035, :name => "Munshiganj"
    country.create :id => 50036, :name => "Madaripur"
    country.create :id => 50037, :name => "Magura"
    country.create :id => 50038, :name => "Moulvibazar"
    country.create :id => 50039, :name => "Meherpur"
    country.create :id => 50040, :name => "Narayanganj"
    country.create :id => 50041, :name => "Netrakona"
    country.create :id => 50042, :name => "Narsingdi"
    country.create :id => 50043, :name => "Narail"
    country.create :id => 50044, :name => "Natore"
    country.create :id => 50045, :name => "Nawabganj"
    country.create :id => 50046, :name => "Nilphamari"
    country.create :id => 50047, :name => "Noakhali"
    country.create :id => 50048, :name => "Naogaon"
    country.create :id => 50049, :name => "Pabna"
    country.create :id => 50050, :name => "Pirojpur"
    country.create :id => 50051, :name => "Patuakhali"
    country.create :id => 50052, :name => "Panchagarh"
    country.create :id => 50053, :name => "Rajbari"
    country.create :id => 50054, :name => "Rajshahi"
    country.create :id => 50055, :name => "Rangpur"
    country.create :id => 50056, :name => "Rangamati"
    country.create :id => 50057, :name => "Sherpur"
    country.create :id => 50058, :name => "Satkhira"
    country.create :id => 50059, :name => "Sirajganj"
    country.create :id => 50060, :name => "Sylhet"
    country.create :id => 50061, :name => "Sunamganj"
    country.create :id => 50062, :name => "Shariatpur"
    country.create :id => 50063, :name => "Tangail"
    country.create :id => 50064, :name => "Thakurgaon"
  end
  
  # Belgium
  with_options(:country => Country['BE']) do |country|
    country.create :id => 56001, :name => "Antwerpen", :abbreviation => 'VAN'
    country.create :id => 56002, :name => "Brabant Wallon", :abbreviation => 'WBR'
    country.create :id => 56003, :name => "Brussels-Capital Region", :abbreviation => 'BRU'
    country.create :id => 56004, :name => "Hainaut", :abbreviation => 'WHT'
    country.create :id => 56005, :name => "Liège", :abbreviation => 'WLG'
    country.create :id => 56006, :name => "Limburg", :abbreviation => 'VLI'
    country.create :id => 56007, :name => "Luxembourg", :abbreviation => 'WLX'
    country.create :id => 56008, :name => "Namur", :abbreviation => 'WNA'
    country.create :id => 56009, :name => "Oost-Vlaanderen", :abbreviation => 'VOV'
    country.create :id => 56010, :name => "Vlaams-Brabant", :abbreviation => 'VBR'
    country.create :id => 56011, :name => "West-Vlaanderen", :abbreviation => 'VWV'
  end
  
  # Burkina Faso
  with_options(:country => Country['BF']) do |country|
    country.create :id => 854001, :name => "Balé", :abbreviation => 'BAL'
    country.create :id => 854002, :name => "Bam", :abbreviation => 'BAM'
    country.create :id => 854003, :name => "Banwa", :abbreviation => 'BAN'
    country.create :id => 854004, :name => "Bazèga", :abbreviation => 'BAZ'
    country.create :id => 854005, :name => "Bougouriba", :abbreviation => 'BGR'
    country.create :id => 854006, :name => "Boulgou", :abbreviation => 'BLG'
    country.create :id => 854007, :name => "Boulkiemdé", :abbreviation => 'BLK'
    country.create :id => 854008, :name => "Comoé", :abbreviation => 'COM'
    country.create :id => 854009, :name => "Ganzourgou", :abbreviation => 'GAN'
    country.create :id => 854010, :name => "Gnagna", :abbreviation => 'GNA'
    country.create :id => 854011, :name => "Gourma", :abbreviation => 'GOU'
    country.create :id => 854012, :name => "Houet", :abbreviation => 'HOU'
    country.create :id => 854013, :name => "Ioba", :abbreviation => 'IOB'
    country.create :id => 854014, :name => "Kadiogo", :abbreviation => 'KAD'
    country.create :id => 854015, :name => "Kénédougou", :abbreviation => 'KEN'
    country.create :id => 854016, :name => "Komondjari", :abbreviation => 'KMD'
    country.create :id => 854017, :name => "Kompienga", :abbreviation => 'KMP'
    country.create :id => 854018, :name => "Kossi", :abbreviation => 'KOS'
    country.create :id => 854019, :name => "Koulpélogo", :abbreviation => 'KOP'
    country.create :id => 854020, :name => "Kouritenga", :abbreviation => 'KOT'
    country.create :id => 854021, :name => "Kourwéogo", :abbreviation => 'KOW'
    country.create :id => 854022, :name => "Léraba", :abbreviation => 'LER'
    country.create :id => 854023, :name => "Loroum", :abbreviation => 'LOR'
    country.create :id => 854024, :name => "Mouhoun", :abbreviation => 'MOU'
    country.create :id => 854025, :name => "Naouri", :abbreviation => 'NAO'
    country.create :id => 854026, :name => "Namentenga", :abbreviation => 'NAM'
    country.create :id => 854027, :name => "Nayala", :abbreviation => 'NAY'
    country.create :id => 854028, :name => "Noumbiel", :abbreviation => 'NOU'
    country.create :id => 854029, :name => "Oubritenga", :abbreviation => 'OUB'
    country.create :id => 854030, :name => "Oudalan", :abbreviation => 'OUD'
    country.create :id => 854031, :name => "Passoré", :abbreviation => 'PAS'
    country.create :id => 854032, :name => "Poni", :abbreviation => 'PON'
    country.create :id => 854033, :name => "Sanguié", :abbreviation => 'SNG'
    country.create :id => 854034, :name => "Sanmatenga", :abbreviation => 'SMT'
    country.create :id => 854035, :name => "Séno", :abbreviation => 'SEN'
    country.create :id => 854036, :name => "Sissili", :abbreviation => 'SIS'
    country.create :id => 854037, :name => "Soum", :abbreviation => 'SOM'
    country.create :id => 854038, :name => "Sourou", :abbreviation => 'SOR'
    country.create :id => 854039, :name => "Tapoa", :abbreviation => 'TAP'
    country.create :id => 854040, :name => "Tui", :abbreviation => 'TUI'
    country.create :id => 854041, :name => "Yagha", :abbreviation => 'YAG'
    country.create :id => 854042, :name => "Yatenga", :abbreviation => 'YAT'
    country.create :id => 854043, :name => "Ziro", :abbreviation => 'ZIR'
    country.create :id => 854044, :name => "Zondoma", :abbreviation => 'ZON'
    country.create :id => 854045, :name => "Zoundwéogo", :abbreviation => 'ZOU'
  end
  
  # Bulgaria
  with_options(:country => Country['BG']) do |country|
    country.create :id => 100001, :name => "Blagoevgrad"
    country.create :id => 100002, :name => "Burgas"
    country.create :id => 100003, :name => "Varna"
    country.create :id => 100004, :name => "Veliko Tarnovo"
    country.create :id => 100005, :name => "Vidin"
    country.create :id => 100006, :name => "Vratsa"
    country.create :id => 100007, :name => "Gabrovo"
    country.create :id => 100008, :name => "Dobrich"
    country.create :id => 100009, :name => "Kardzhali"
    country.create :id => 100010, :name => "Kyustendil"
    country.create :id => 100011, :name => "Lovech"
    country.create :id => 100012, :name => "Montana"
    country.create :id => 100013, :name => "Pazardzhik"
    country.create :id => 100014, :name => "Pernik"
    country.create :id => 100015, :name => "Pleven"
    country.create :id => 100016, :name => "Plovdiv"
    country.create :id => 100017, :name => "Razgrad"
    country.create :id => 100018, :name => "Ruse"
    country.create :id => 100019, :name => "Silistra"
    country.create :id => 100020, :name => "Sliven"
    country.create :id => 100021, :name => "Smolyan"
    country.create :id => 100022, :name => "Sofia-Grad"
    country.create :id => 100023, :name => "Sofia"
    country.create :id => 100024, :name => "Stara Zagora"
    country.create :id => 100025, :name => "Targovishte"
    country.create :id => 100026, :name => "Haskovo"
    country.create :id => 100027, :name => "Shumen"
    country.create :id => 100028, :name => "Yambol"
  end
  
  # Bahrain
  with_options(:country => Country['BH']) do |country|
    country.create :id => 48013, :name => "Al Manāmah" # Al ‘Āşimah
    country.create :id => 48014, :name => "Al Janūbīyah"
    country.create :id => 48015, :name => "Al Muḩarraq"
    country.create :id => 48016, :name => "Al Wusţá"
    country.create :id => 48017, :name => "Ash Shamālīyah"
  end
  
  # Burundi
  with_options(:country => Country['BI']) do |country|
    country.create :id => 108001, :name => "Bubanza", :abbreviation => 'BB'
    country.create :id => 108002, :name => "Bujumbura", :abbreviation => 'BJ'
    country.create :id => 108003, :name => "Bururi", :abbreviation => 'BR'
    country.create :id => 108004, :name => "Cankuzo", :abbreviation => 'CA'
    country.create :id => 108005, :name => "Cibitoke", :abbreviation => 'CI'
    country.create :id => 108006, :name => "Gitega", :abbreviation => 'GI'
    country.create :id => 108007, :name => "Karuzi", :abbreviation => 'KR'
    country.create :id => 108008, :name => "Kayanza", :abbreviation => 'KY'
    country.create :id => 108009, :name => "Kirundo", :abbreviation => 'KI'
    country.create :id => 108010, :name => "Makamba", :abbreviation => 'MA'
    country.create :id => 108011, :name => "Muramvya", :abbreviation => 'MU'
    country.create :id => 108012, :name => "Mwaro", :abbreviation => 'MW'
    country.create :id => 108013, :name => "Ngozi", :abbreviation => 'NG'
    country.create :id => 108014, :name => "Rutana", :abbreviation => 'RT'
    country.create :id => 108015, :name => "Ruyigi", :abbreviation => 'RY'
  end
  
  # Benin
  with_options(:country => Country['BJ']) do |country|
    country.create :id => 204001, :name => "Alibori", :abbreviation => 'AL'
    country.create :id => 204002, :name => "Atakora", :abbreviation => 'AK'
    country.create :id => 204003, :name => "Atlantique", :abbreviation => 'AQ'
    country.create :id => 204004, :name => "Borgou", :abbreviation => 'BO'
    country.create :id => 204005, :name => "Collines", :abbreviation => 'CO'
    country.create :id => 204006, :name => "Donga", :abbreviation => 'DO'
    country.create :id => 204007, :name => "Kouffo", :abbreviation => 'KO'
    country.create :id => 204008, :name => "Littoral", :abbreviation => 'LI'
    country.create :id => 204009, :name => "Mono", :abbreviation => 'MO'
    country.create :id => 204010, :name => "Ouémé", :abbreviation => 'OU'
    country.create :id => 204011, :name => "Plateau", :abbreviation => 'PL'
    country.create :id => 204012, :name => "Zou", :abbreviation => 'ZO'
  end
  
  # Brunei Darussalam
  with_options(:country => Country['BN']) do |country|
    country.create :id => 96001, :name => "Belait", :abbreviation => 'BE'
    country.create :id => 96002, :name => "Brunei-Muara", :abbreviation => 'BM'
    country.create :id => 96003, :name => "Temburong", :abbreviation => 'TE'
    country.create :id => 96004, :name => "Tutong", :abbreviation => 'TU'
  end
  
  # Bolivia
  with_options(:country => Country['BO']) do |country|
    country.create :id => 68001, :name => "Cochabamba", :abbreviation => 'C'
    country.create :id => 68002, :name => "Chuquisaca", :abbreviation => 'H'
    country.create :id => 68003, :name => "El Beni", :abbreviation => 'B'
    country.create :id => 68004, :name => "La Paz", :abbreviation => 'L'
    country.create :id => 68005, :name => "Oruro", :abbreviation => 'O'
    country.create :id => 68006, :name => "Pando", :abbreviation => 'N'
    country.create :id => 68007, :name => "Potosí", :abbreviation => 'P'
    country.create :id => 68008, :name => "Santa Cruz", :abbreviation => 'S'
    country.create :id => 68009, :name => "Tarija", :abbreviation => 'T'
  end
  
  # Brazil
  with_options(:country => Country['BR']) do |country|
    country.create :id => 76001, :name => "Acre", :abbreviation => 'AC'
    country.create :id => 76002, :name => "Alagoas", :abbreviation => 'AL'
    country.create :id => 76003, :name => "Amazonas", :abbreviation => 'AM'
    country.create :id => 76004, :name => "Amapá", :abbreviation => 'AP'
    country.create :id => 76005, :name => "Bahia", :abbreviation => 'BA'
    country.create :id => 76006, :name => "Ceará", :abbreviation => 'CE'
    country.create :id => 76007, :name => "Espírito Santo", :abbreviation => 'ES'
    country.create :id => 76008, :name => "Fernando de Noronha", :abbreviation => 'FN'
    country.create :id => 76009, :name => "Goiás", :abbreviation => 'GO'
    country.create :id => 76010, :name => "Maranhão", :abbreviation => 'MA'
    country.create :id => 76011, :name => "Minas Gerais", :abbreviation => 'MG'
    country.create :id => 76012, :name => "Mato Grosso do Sul", :abbreviation => 'MS'
    country.create :id => 76013, :name => "Mato Grosso", :abbreviation => 'MT'
    country.create :id => 76014, :name => "Pará", :abbreviation => 'PA'
    country.create :id => 76015, :name => "Paraíba", :abbreviation => 'PB'
    country.create :id => 76016, :name => "Pernambuco", :abbreviation => 'PE'
    country.create :id => 76017, :name => "Piauí", :abbreviation => 'PI'
    country.create :id => 76018, :name => "Paraná", :abbreviation => 'PR'
    country.create :id => 76019, :name => "Rio de Janeiro", :abbreviation => 'RJ'
    country.create :id => 76020, :name => "Rio Grande do Norte", :abbreviation => 'RN'
    country.create :id => 76021, :name => "Rondônia", :abbreviation => 'RO'
    country.create :id => 76022, :name => "Roraima", :abbreviation => 'RR'
    country.create :id => 76023, :name => "Rio Grande do Sul", :abbreviation => 'RS'
    country.create :id => 76024, :name => "Santa Catarina", :abbreviation => 'SC'
    country.create :id => 76025, :name => "Sergipe", :abbreviation => 'SE'
    country.create :id => 76026, :name => "Sâo Paulo", :abbreviation => 'SP'
    country.create :id => 76027, :name => "Tocantins", :abbreviation => 'TO'
    country.create :id => 76028, :name => "Distrito Federal", :abbreviation => 'DF'
  end
  
  # Bahamas
  with_options(:country => Country['BS']) do |country|
    country.create :id => 44001, :name => "Acklins and Crooked Islands", :abbreviation => 'AC'
    country.create :id => 44002, :name => "Bimini", :abbreviation => 'BI'
    country.create :id => 44003, :name => "Cat Island", :abbreviation => 'CI'
    country.create :id => 44004, :name => "Exuma", :abbreviation => 'EX'
    country.create :id => 44005, :name => "Freeport", :abbreviation => 'FP'
    country.create :id => 44006, :name => "Fresh Creek", :abbreviation => 'FC'
    country.create :id => 44007, :name => "Governors Harbours Harbour", :abbreviation => 'GH'
    country.create :id => 44008, :name => "Green Turtle Cay", :abbreviation => 'GT'
    country.create :id => 44009, :name => "Harbour Island", :abbreviation => 'HI'
    country.create :id => 44010, :name => "High Rock", :abbreviation => 'HR'
    country.create :id => 44011, :name => "Inagua", :abbreviation => 'IN'
    country.create :id => 44012, :name => "Kemps Bay", :abbreviation => 'KB'
    country.create :id => 44013, :name => "Long Island", :abbreviation => 'LI'
    country.create :id => 44014, :name => "Marsh Harbour", :abbreviation => 'MH'
    country.create :id => 44015, :name => "Mayaguana", :abbreviation => 'MG'
    country.create :id => 44016, :name => "New Providence", :abbreviation => 'NP'
    country.create :id => 44017, :name => "Nicholls Town and Berry Islands", :abbreviation => 'NB'
    country.create :id => 44018, :name => "Ragged Island", :abbreviation => 'RI'
    country.create :id => 44019, :name => "Rock Sound", :abbreviation => 'RS'
    country.create :id => 44020, :name => "Sandy Point", :abbreviation => 'SP'
    country.create :id => 44021, :name => "San Salvador and Rum Cay", :abbreviation => 'SR'
  end
  
  # Bhutan
  with_options(:country => Country['BT']) do |country|
    country.create :id => 64011, :name => "Paro"
    country.create :id => 64012, :name => "Chhukha"
    country.create :id => 64013, :name => "Ha"
    country.create :id => 64014, :name => "Samtee"
    country.create :id => 64015, :name => "Thimphu"
    country.create :id => 64021, :name => "Tsirang"
    country.create :id => 64022, :name => "Dagana"
    country.create :id => 64023, :name => "Punakha"
    country.create :id => 64024, :name => "Wangdue Phodrang"
    country.create :id => 64031, :name => "Sarpang"
    country.create :id => 64032, :name => "Trongsa"
    country.create :id => 64033, :name => "Bumthang"
    country.create :id => 64034, :name => "Zhemgang"
    country.create :id => 64041, :name => "Trashigang"
    country.create :id => 64042, :name => "Monggar"
    country.create :id => 64043, :name => "Pemagatshel"
    country.create :id => 64044, :name => "Lhuentse"
    country.create :id => 64045, :name => "Samdrup Jongkha"
    country.create :id => 64100, :name => "Gasa", :abbreviation => 'GA'
    country.create :id => 64101, :name => "Trashi Yangtse", :abbreviation => 'TY'
  end
  
  # Botswana
  with_options(:country => Country['BW']) do |country|
    country.create :id => 72001, :name => "Central", :abbreviation => 'CE'
    country.create :id => 72002, :name => "Ghanzi", :abbreviation => 'GH'
    country.create :id => 72003, :name => "Kgalagadi", :abbreviation => 'KG'
    country.create :id => 72004, :name => "Kgatleng", :abbreviation => 'KL'
    country.create :id => 72005, :name => "Kweneng", :abbreviation => 'KW'
    country.create :id => 72006, :name => "Ngamiland", :abbreviation => 'NG'
    country.create :id => 72007, :name => "North-East", :abbreviation => 'NE'
    country.create :id => 72008, :name => "North-West", :abbreviation => 'NW' # North-West (Botswana)
    country.create :id => 72009, :name => "South-East", :abbreviation => 'SE'
    country.create :id => 72010, :name => "Southern", :abbreviation => 'SO' # Southern (Botswana)
  end
  
  # Belarus
  with_options(:country => Country['BY']) do |country|
    country.create :id => 112001, :name => "Brèsckaja", :abbreviation => 'BR'
    country.create :id => 112002, :name => "Homel'skaja", :abbreviation => 'HO'
    country.create :id => 112003, :name => "Hrodzenskaja", :abbreviation => 'HR'
    country.create :id => 112004, :name => "Mahilëuskaja", :abbreviation => 'MA'
    country.create :id => 112005, :name => "Minskaja", :abbreviation => 'MI'
    country.create :id => 112006, :name => "Vicebskaja", :abbreviation => 'VI'
  end
  
  # Belize
  with_options(:country => Country['BZ']) do |country|
    country.create :id => 84001, :name => "Belize", :abbreviation => 'BZ'
    country.create :id => 84002, :name => "Cayo", :abbreviation => 'CY'
    country.create :id => 84003, :name => "Corozal", :abbreviation => 'CZL'
    country.create :id => 84004, :name => "Orange Walk", :abbreviation => 'OW'
    country.create :id => 84005, :name => "Stann Creek", :abbreviation => 'SC'
    country.create :id => 84006, :name => "Toledo", :abbreviation => 'TOL'
  end
  
  # Canada
  with_options(:country => Country['CA']) do |country|
    # Province
    country.create :id => 124001, :name => "Alberta", :abbreviation => 'AB'
    country.create :id => 124002, :name => "British Columbia", :abbreviation => 'BC'
    country.create :id => 124003, :name => "Manitoba", :abbreviation => 'MB'
    country.create :id => 124004, :name => "New Brunswick", :abbreviation => 'NB'
    country.create :id => 124005, :name => "Newfoundland and Labrador", :abbreviation => 'NL'
    country.create :id => 124006, :name => "Nova Scotia", :abbreviation => 'NS'
    country.create :id => 124007, :name => "Ontario", :abbreviation => 'ON'
    country.create :id => 124008, :name => "Prince Edward Island", :abbreviation => 'PE'
    country.create :id => 124009, :name => "Quebec", :abbreviation => 'QC'
    country.create :id => 124010, :name => "Saskatchewan", :abbreviation => 'SK'
    
    # Territory
    country.create :id => 124011, :name => "Northwest Territories", :abbreviation => 'NT'
    country.create :id => 124012, :name => "Nunavut", :abbreviation => 'NU'
    country.create :id => 124013, :name => "Yukon Territory", :abbreviation => 'YT'
  end
  
  # Congo, The Democratic Republic of the
  # Congo, Democratic Republic of
  with_options(:country => Country['CD']) do |country|
    # City
    country.create :id => 180001, :name => "Kinshasa", :abbreviation => 'KN'
    
    # Province
    country.create :id => 180002, :name => "Bandundu", :abbreviation => 'BN'
    country.create :id => 180003, :name => "Bas-Congo", :abbreviation => 'BC'
    country.create :id => 180004, :name => "Équateur", :abbreviation => 'EQ'
    country.create :id => 180005, :name => "Haut-Congo", :abbreviation => 'HC'
    country.create :id => 180006, :name => "Kasai-Occidental", :abbreviation => 'KW'
    country.create :id => 180007, :name => "Kasai-Oriental", :abbreviation => 'KE'
    country.create :id => 180008, :name => "Katanga", :abbreviation => 'KA'
    country.create :id => 180009, :name => "Maniema", :abbreviation => 'MA'
    country.create :id => 180010, :name => "Nord-Kivu", :abbreviation => 'NK'
    country.create :id => 180011, :name => "Orientale", :abbreviation => 'OR'
    country.create :id => 180012, :name => "Sud-Kivu", :abbreviation => 'SK'
  end
  
  with_options(:country => Country['CF']) do |country|
    # Prefecture
    country.create :id => 140001, :name => "Bamingui-Bangoran", :abbreviation => 'BB'
    country.create :id => 140002, :name => "Basse-Kotto", :abbreviation => 'BK'
    country.create :id => 140003, :name => "Haute-Kotto", :abbreviation => 'HK'
    country.create :id => 140004, :name => "Haut-Mbomou", :abbreviation => 'HM'
    country.create :id => 140005, :name => "Kémo", :abbreviation => 'KG'
    country.create :id => 140006, :name => "Lobaye", :abbreviation => 'LB'
    country.create :id => 140007, :name => "Mambéré-Kadéï", :abbreviation => 'HS'
    country.create :id => 140008, :name => "Mbomou", :abbreviation => 'MB'
    country.create :id => 140009, :name => "Nana-Mambéré", :abbreviation => 'NM'
    country.create :id => 140010, :name => "Ombella-Mpokopoko", :abbreviation => 'MP'
    country.create :id => 140011, :name => "Ouaka", :abbreviation => 'UK'
    country.create :id => 140012, :name => "Ouham", :abbreviation => 'AC'
    country.create :id => 140013, :name => "Ouham-Pendé", :abbreviation => 'OP'
    country.create :id => 140014, :name => "Vakaga", :abbreviation => 'VR'
    
    # Economic Prefecture
    country.create :id => 140015, :name => "Nana-Grébizi", :abbreviation => 'KB'
    country.create :id => 140016, :name => "Sangha-Mbaéré", :abbreviation => 'SE'
    
    # Autonomous Commune
    country.create :id => 140017, :name => "Bangui", :abbreviation => 'BGF'
  end
  
  # Congo
  with_options(:country => Country['CG']) do |country|
    # Region
    country.create :id => 178002, :name => "Lékoumou"
    country.create :id => 178005, :name => "Kouilou"
    country.create :id => 178007, :name => "Likouala"
    country.create :id => 178008, :name => "Cuvette"
    country.create :id => 178009, :name => "Niari"
    country.create :id => 178011, :name => "Bouenza"
    country.create :id => 178012, :name => "Pool"
    country.create :id => 178013, :name => "Sangha"
    country.create :id => 178014, :name => "Plateaux"
    country.create :id => 178015, :name => "Cuvette-Ouest"
    
    # Capital District
    country.create :id => 178016, :name => "Brazzaville", :abbreviation => 'BZV'
  end
  
  # Switzerland
  with_options(:country => Country['CH']) do |country|
    country.create :id => 756001, :name => "Aargau", :abbreviation => 'AG'
    country.create :id => 756002, :name => "Appenzell Innerrhoden", :abbreviation => 'AI'
    country.create :id => 756003, :name => "Appenzell Ausserrhoden", :abbreviation => 'AR'
    country.create :id => 756004, :name => "Bern", :abbreviation => 'BE'
    country.create :id => 756005, :name => "Basel-Landschaft", :abbreviation => 'BL'
    country.create :id => 756006, :name => "Basel-Stadt", :abbreviation => 'BS'
    country.create :id => 756007, :name => "Fribourg", :abbreviation => 'FR'
    country.create :id => 756008, :name => "Genève", :abbreviation => 'GE'
    country.create :id => 756009, :name => "Glarus", :abbreviation => 'GL'
    country.create :id => 756010, :name => "Graubünden", :abbreviation => 'GR'
    country.create :id => 756011, :name => "Jura", :abbreviation => 'JU'
    country.create :id => 756012, :name => "Luzern", :abbreviation => 'LU'
    country.create :id => 756013, :name => "Neuchâtel", :abbreviation => 'NE'
    country.create :id => 756014, :name => "Nidwalden", :abbreviation => 'NW'
    country.create :id => 756015, :name => "Obwalden", :abbreviation => 'OW'
    country.create :id => 756016, :name => "Sankt Gallen", :abbreviation => 'SG'
    country.create :id => 756017, :name => "Schaffhausen", :abbreviation => 'SH'
    country.create :id => 756018, :name => "Solothurn", :abbreviation => 'SO'
    country.create :id => 756019, :name => "Schwyz", :abbreviation => 'SZ'
    country.create :id => 756020, :name => "Thurgau", :abbreviation => 'TG'
    country.create :id => 756021, :name => "Ticino", :abbreviation => 'TI'
    country.create :id => 756022, :name => "Uri", :abbreviation => 'UR'
    country.create :id => 756023, :name => "Vaud", :abbreviation => 'VD'
    country.create :id => 756024, :name => "Valais", :abbreviation => 'VS'
    country.create :id => 756025, :name => "Zug", :abbreviation => 'ZG'
    country.create :id => 756026, :name => "Zürich", :abbreviation => 'ZH'
  end
  
  # Côte d'Ivoire
  with_options(:country => Country['CI']) do |country|
    country.create :id => 384001, :name => "Lagunes"
    country.create :id => 384002, :name => "Haut-Sassandra"
    country.create :id => 384003, :name => "Savanes"
    country.create :id => 384004, :name => "Vallée du Bandama"
    country.create :id => 384005, :name => "Moyen-Comoé"
    country.create :id => 384006, :name => "18 Montagnes"
    country.create :id => 384007, :name => "Lacs"
    country.create :id => 384008, :name => "Zanzan"
    country.create :id => 384009, :name => "Bas-Sassandra"
    country.create :id => 384010, :name => "Denguélé"
    country.create :id => 384011, :name => "Nzi-Comoé"
    country.create :id => 384012, :name => "Marahoué"
    country.create :id => 384013, :name => "Sud-Comoé"
    country.create :id => 384014, :name => "Worodouqou"
    country.create :id => 384015, :name => "Sud-Bandama"
    country.create :id => 384016, :name => "Agnébi"
    country.create :id => 384017, :name => "Bafing"
    country.create :id => 384018, :name => "Fromager"
    country.create :id => 384019, :name => "Moyen-Cavally"
  end
  
  # Chile
  with_options(:country => Country['CL']) do |country|
    country.create :id => 152001, :name => "Aisén del General Carlos Ibáñez del Campo", :abbreviation => 'AI'
    country.create :id => 152002, :name => "Antofagasta", :abbreviation => 'AN'
    country.create :id => 152003, :name => "Araucanía", :abbreviation => 'AR'
    country.create :id => 152004, :name => "Atacama", :abbreviation => 'AT'
    country.create :id => 152005, :name => "Bío-Bío", :abbreviation => 'BI'
    country.create :id => 152006, :name => "Coquimbo", :abbreviation => 'CO'
    country.create :id => 152007, :name => "Libertador General Bernardo O'Higgins", :abbreviation => 'LI'
    country.create :id => 152008, :name => "Los Lagos", :abbreviation => 'LL'
    country.create :id => 152009, :name => "Magallanes y Antártica Chilena", :abbreviation => 'MA'
    country.create :id => 152010, :name => "Maule", :abbreviation => 'ML'
    country.create :id => 152011, :name => "Región Metropolitana de Santiago", :abbreviation => 'RM'
    country.create :id => 152012, :name => "Tarapacá", :abbreviation => 'TA'
    country.create :id => 152013, :name => "Valparaíso", :abbreviation => 'VS'
  end
  
  # Cameroon
  with_options(:country => Country['CM']) do |country|
    country.create :id => 120001, :name => "Adamaoua", :abbreviation => 'AD'
    country.create :id => 120002, :name => "Centre", :abbreviation => 'CE'
    country.create :id => 120003, :name => "East", :abbreviation => 'ES'
    country.create :id => 120004, :name => "Far North", :abbreviation => 'EN'
    country.create :id => 120005, :name => "Littoral", :abbreviation => 'LT'
    country.create :id => 120006, :name => "North", :abbreviation => 'NO'
    country.create :id => 120007, :name => "North-West", :abbreviation => 'NW'
    country.create :id => 120008, :name => "South", :abbreviation => 'SU'
    country.create :id => 120009, :name => "South-West", :abbreviation => 'SW'
    country.create :id => 120010, :name => "West", :abbreviation => 'OU'
  end
  
  # China
  with_options(:country => Country['CN']) do |country|
    country.create :id => 156011, :name => "Beijing"
    country.create :id => 156012, :name => "Tianjin"
    country.create :id => 156013, :name => "Hebei"
    country.create :id => 156014, :name => "Shanxi"
    country.create :id => 156015, :name => "Nei Mongol"
    country.create :id => 156021, :name => "Liaoning"
    country.create :id => 156022, :name => "Jilin"
    country.create :id => 156023, :name => "Heilongjiang"
    country.create :id => 156031, :name => "Shanghai"
    country.create :id => 156032, :name => "Jiangsu"
    country.create :id => 156033, :name => "Zhejiang"
    country.create :id => 156034, :name => "Anhui"
    country.create :id => 156035, :name => "Fujian"
    country.create :id => 156036, :name => "Jiangxi"
    country.create :id => 156037, :name => "Shandong"
    country.create :id => 156041, :name => "Henan"
    country.create :id => 156042, :name => "Hubei"
    country.create :id => 156043, :name => "Hunan"
    country.create :id => 156044, :name => "Guangdong"
    country.create :id => 156045, :name => "Guangxi"
    country.create :id => 156046, :name => "Hainan"
    country.create :id => 156050, :name => "Chongqing"
    country.create :id => 156051, :name => "Sichuan"
    country.create :id => 156052, :name => "Guizhou"
    country.create :id => 156053, :name => "Yunnan"
    country.create :id => 156054, :name => "Xizang"
    country.create :id => 156061, :name => "Shaanxi"
    country.create :id => 156062, :name => "Gansu"
    country.create :id => 156063, :name => "Qinghai"
    country.create :id => 156064, :name => "Ningxia"
    country.create :id => 156065, :name => "Xinjiang"
    country.create :id => 156071, :name => "Taiwan"
    country.create :id => 156091, :name => "Xianggang"
    country.create :id => 156092, :name => "Aomen"
  end
  
  # Colombia
  with_options(:country => Country['CO']) do |country|
    # Capital District
    country.create :id => 170001, :name => "Distrito Capital de Bogotá", :abbreviation => 'DC'
    
    # Department
    country.create :id => 170002, :name => "Amazonas", :abbreviation => 'AMA'
    country.create :id => 170003, :name => "Antioquia", :abbreviation => 'ANT'
    country.create :id => 170004, :name => "Arauca", :abbreviation => 'ARA'
    country.create :id => 170005, :name => "Atlántico", :abbreviation => 'ATL'
    country.create :id => 170006, :name => "Bolívar", :abbreviation => 'BOL'
    country.create :id => 170007, :name => "Boyacá", :abbreviation => 'BOY'
    country.create :id => 170008, :name => "Caldas", :abbreviation => 'CAL'
    country.create :id => 170009, :name => "Caquetá", :abbreviation => 'CAQ'
    country.create :id => 170010, :name => "Casanare", :abbreviation => 'CAS'
    country.create :id => 170011, :name => "Cauca", :abbreviation => 'CAU'
    country.create :id => 170012, :name => "Cesar", :abbreviation => 'CES'
    country.create :id => 170013, :name => "Chocó", :abbreviation => 'CHO'
    country.create :id => 170014, :name => "Córdoba", :abbreviation => 'COR'
    country.create :id => 170015, :name => "Cundinamarca", :abbreviation => 'CUN'
    country.create :id => 170016, :name => "Guainía", :abbreviation => 'GUA'
    country.create :id => 170017, :name => "Guaviare", :abbreviation => 'GUV'
    country.create :id => 170018, :name => "Huila", :abbreviation => 'HUI'
    country.create :id => 170019, :name => "La Guajira", :abbreviation => 'LAG'
    country.create :id => 170020, :name => "Magdalena", :abbreviation => 'MAG'
    country.create :id => 170021, :name => "Meta", :abbreviation => 'MET'
    country.create :id => 170022, :name => "Nariño", :abbreviation => 'NAR'
    country.create :id => 170023, :name => "Norte de Santander", :abbreviation => 'NSA'
    country.create :id => 170024, :name => "Putumayo", :abbreviation => 'PUT'
    country.create :id => 170025, :name => "Quindío", :abbreviation => 'QUI'
    country.create :id => 170026, :name => "Risaralda", :abbreviation => 'RIS'
    country.create :id => 170027, :name => "San Andrés, Providencia y Santa Catalina", :abbreviation => 'SAP'
    country.create :id => 170028, :name => "Santander", :abbreviation => 'SAN'
    country.create :id => 170029, :name => "Sucre", :abbreviation => 'SUC'
    country.create :id => 170030, :name => "Tolima", :abbreviation => 'TOL'
    country.create :id => 170031, :name => "Valle del Cauca", :abbreviation => 'VAC'
    country.create :id => 170032, :name => "Vaupés", :abbreviation => 'VAU'
    country.create :id => 170033, :name => "Vichada", :abbreviation => 'VID'
  end
  
  # Costa Rica
  with_options(:country => Country['CR']) do |country|
    country.create :id => 188001, :name => "Alajuela", :abbreviation => 'A'
    country.create :id => 188002, :name => "Cartago", :abbreviation => 'C'
    country.create :id => 188003, :name => "Guanacaste", :abbreviation => 'G'
    country.create :id => 188004, :name => "Heredia", :abbreviation => 'H'
    country.create :id => 188005, :name => "Limón", :abbreviation => 'L'
    country.create :id => 188006, :name => "Puntarenas", :abbreviation => 'P'
    country.create :id => 188007, :name => "San José", :abbreviation => 'SJ'
  end
  
  # Cuba
  with_options(:country => Country['CU']) do |country|
    country.create :id => 192001, :name => "Pinar del Rio"
    country.create :id => 192002, :name => "La Habana"
    country.create :id => 192003, :name => "Ciudad de La Habana"
    country.create :id => 192004, :name => "Matanzas"
    country.create :id => 192005, :name => "Villa Clara"
    country.create :id => 192006, :name => "Cienfuegos"
    country.create :id => 192007, :name => "Sancti Spíritus"
    country.create :id => 192008, :name => "Ciego de Ávila"
    country.create :id => 192009, :name => "Camagüey"
    country.create :id => 192010, :name => "Las Tunas"
    country.create :id => 192011, :name => "Holguín"
    country.create :id => 192012, :name => "Granma"
    country.create :id => 192013, :name => "Santiago de Cuba"
    country.create :id => 192014, :name => "Guantánamo"
    country.create :id => 192099, :name => "Isla de la Juventud"
  end
  
  # Cape Verde
  with_options(:country => Country['CV']) do |country|
    country.create :id => 132001, :name => "Boa Vista", :abbreviation => 'BV'
    country.create :id => 132002, :name => "Brava", :abbreviation => 'BR'
    country.create :id => 132003, :name => "Calheta de São Miguel", :abbreviation => 'CS'
    country.create :id => 132004, :name => "Maio", :abbreviation => 'MA'
    country.create :id => 132005, :name => "Mosteiros", :abbreviation => 'MO'
    country.create :id => 132006, :name => "Paúl", :abbreviation => 'PA'
    country.create :id => 132007, :name => "Porto Novo", :abbreviation => 'PN'
    country.create :id => 132008, :name => "Praia", :abbreviation => 'PR'
    country.create :id => 132009, :name => "Ribeira Grande", :abbreviation => 'RG'
    country.create :id => 132010, :name => "Sal", :abbreviation => 'SL'
    country.create :id => 132011, :name => "Santa Catarina", :abbreviation => 'CA'
    country.create :id => 132012, :name => "Santa Cruz", :abbreviation => 'CR'
    country.create :id => 132013, :name => "São Domingos", :abbreviation => 'SD'
    country.create :id => 132014, :name => "São Filipe", :abbreviation => 'SF'
    country.create :id => 132015, :name => "São Nicolau", :abbreviation => 'SN'
    country.create :id => 132016, :name => "São Vicente", :abbreviation => 'SV'
    country.create :id => 132017, :name => "Tarrafal", :abbreviation => 'TA'
  end
  
  # Cyprus
  with_options(:country => Country['CY']) do |country|
    country.create :id => 196001, :name => "Lefkosía"
    country.create :id => 196002, :name => "Lemesós"
    country.create :id => 196003, :name => "Lárnaka"
    country.create :id => 196004, :name => "Ammóchostos"
    country.create :id => 196005, :name => "Páfos"
    country.create :id => 196006, :name => "Kerýneia"
  end
  
  # Czech Republic
  with_options(:country => Country['CZ']) do |country|
    country.create :id => 203101, :name => "Praha 1"
    country.create :id => 203102, :name => "Praha 2"
    country.create :id => 203103, :name => "Praha 3"
    country.create :id => 203104, :name => "Praha 4"
    country.create :id => 203105, :name => "Praha 5"
    country.create :id => 203106, :name => "Praha 6"
    country.create :id => 203107, :name => "Praha 7"
    country.create :id => 203108, :name => "Praha 8"
    country.create :id => 203109, :name => "Praha 9"
    country.create :id => 203110, :name => "Praha 10", :abbreviation => '10A'
    country.create :id => 203111, :name => "Praha 11", :abbreviation => '10B'
    country.create :id => 203112, :name => "Praha 12", :abbreviation => '10C'
    country.create :id => 203113, :name => "Praha 13", :abbreviation => '10D'
    country.create :id => 203114, :name => "Praha 14", :abbreviation => '10E'
    country.create :id => 203115, :name => "Praha 15", :abbreviation => '10F'
    country.create :id => 203201, :name => "Benešov"
    country.create :id => 203202, :name => "Beroun"
    country.create :id => 203203, :name => "Kladno"
    country.create :id => 203204, :name => "Kolín"
    country.create :id => 203205, :name => "Kutná Hora"
    country.create :id => 203206, :name => "Mělník"
    country.create :id => 203207, :name => "Mladá Boleslav"
    country.create :id => 203208, :name => "Nymburk"
    country.create :id => 203209, :name => "Praha-východ"
    country.create :id => 203210, :name => "Praha-západ", :abbreviation => '20A'
    country.create :id => 203211, :name => "Příbram", :abbreviation => '20B'
    country.create :id => 203212, :name => "Rakovník", :abbreviation => '20C'
    country.create :id => 203311, :name => "České Budějovice"
    country.create :id => 203312, :name => "Český Krumlov"
    country.create :id => 203313, :name => "Jindřichův Hradec"
    country.create :id => 203314, :name => "Písek"
    country.create :id => 203315, :name => "Prachatice"
    country.create :id => 203316, :name => "Strakonice"
    country.create :id => 203317, :name => "Tábor"
    country.create :id => 203321, :name => "Domažlice"
    country.create :id => 203322, :name => "Klatovy"
    country.create :id => 203323, :name => "Plzeň-město"
    country.create :id => 203324, :name => "Plzeň-jih"
    country.create :id => 203325, :name => "Plzeň-sever"
    country.create :id => 203326, :name => "Rokycany"
    country.create :id => 203327, :name => "Tachov"
    country.create :id => 203411, :name => "Cheb"
    country.create :id => 203412, :name => "Karlovy Vary"
    country.create :id => 203413, :name => "Sokolov"
    country.create :id => 203421, :name => "Děčín"
    country.create :id => 203422, :name => "Chomutov"
    country.create :id => 203423, :name => "Litoměřice"
    country.create :id => 203424, :name => "Louny"
    country.create :id => 203425, :name => "Most"
    country.create :id => 203426, :name => "Teplice"
    country.create :id => 203427, :name => "Ústí nad Labem"
    country.create :id => 203511, :name => "Česká Lípa"
    country.create :id => 203512, :name => "Jablonec nad Nisou"
    country.create :id => 203513, :name => "Liberec"
    country.create :id => 203514, :name => "Semily"
    country.create :id => 203521, :name => "Hradec Králové"
    country.create :id => 203522, :name => "Jičín"
    country.create :id => 203523, :name => "Náchod"
    country.create :id => 203524, :name => "Rychnov nad Kněžnou"
    country.create :id => 203525, :name => "Trutnov"
    country.create :id => 203531, :name => "Chrudim"
    country.create :id => 203532, :name => "Pardubice"
    country.create :id => 203533, :name => "Svitavy"
    country.create :id => 203534, :name => "Ústí nad Orlicí"
    country.create :id => 203611, :name => "Havlíčkův Brod"
    country.create :id => 203612, :name => "Jihlava"
    country.create :id => 203613, :name => "Pelhřimov"
    country.create :id => 203614, :name => "Třebíč"
    country.create :id => 203615, :name => "Žd’ár nad Sázavou"
    country.create :id => 203621, :name => "Blansko"
    country.create :id => 203622, :name => "Brno-město"
    country.create :id => 203623, :name => "Brno-venkov"
    country.create :id => 203624, :name => "Břeclav"
    country.create :id => 203625, :name => "Hodonín"
    country.create :id => 203626, :name => "Vyškov"
    country.create :id => 203627, :name => "Znojmo"
    country.create :id => 203711, :name => "Jeseník"
    country.create :id => 203712, :name => "Olomouc"
    country.create :id => 203713, :name => "Prostĕjov"
    country.create :id => 203714, :name => "Přerov"
    country.create :id => 203715, :name => "Šumperk"
    country.create :id => 203721, :name => "Kromĕříž"
    country.create :id => 203722, :name => "Uherské Hradištĕ"
    country.create :id => 203723, :name => "Vsetín"
    country.create :id => 203724, :name => "Zlín"
    country.create :id => 203801, :name => "Bruntál"
    country.create :id => 203802, :name => "Frýdek - Místek"
    country.create :id => 203803, :name => "Karviná"
    country.create :id => 203804, :name => "Nový Jičín"
    country.create :id => 203805, :name => "Opava"
    country.create :id => 203806, :name => "Ostrava - město"
  end
  
  # Germany
  with_options(:country => Country['DE']) do |country|
    country.create :id => 276001, :name => "Baden-Württemberg", :abbreviation => 'BW'
    country.create :id => 276002, :name => "Bayern", :abbreviation => 'BY'
    country.create :id => 276003, :name => "Bremen", :abbreviation => 'HB'
    country.create :id => 276004, :name => "Hamburg", :abbreviation => 'HH'
    country.create :id => 276005, :name => "Hessen", :abbreviation => 'HE'
    country.create :id => 276006, :name => "Niedersachsen", :abbreviation => 'NI'
    country.create :id => 276007, :name => "Nordrhein-Westfalen", :abbreviation => 'NW'
    country.create :id => 276008, :name => "Rheinland-Pfalz", :abbreviation => 'RP'
    country.create :id => 276009, :name => "Saarland", :abbreviation => 'SL'
    country.create :id => 276010, :name => "Schleswig-Holstein", :abbreviation => 'SH'
    country.create :id => 276011, :name => "Berlin", :abbreviation => 'BE'
    country.create :id => 276012, :name => "Brandenburg", :abbreviation => 'BB'
    country.create :id => 276013, :name => "Mecklenburg-Vorpommern", :abbreviation => 'MV'
    country.create :id => 276014, :name => "Sachsen", :abbreviation => 'SN'
    country.create :id => 276015, :name => "Sachsen-Anhalt", :abbreviation => 'ST'
    country.create :id => 276016, :name => "Thüringen", :abbreviation => 'TH'
  end
  
  # Djibouti
  with_options(:country => Country['DJ']) do |country|
    # Region
    country.create :id => 262001, :name => "Ali Sabieh", :abbreviation => 'AS'
    country.create :id => 262002, :name => "Arta", :abbreviation => 'AR'
    country.create :id => 262003, :name => "Dikhil", :abbreviation => 'DI'
    country.create :id => 262004, :name => "Obock", :abbreviation => 'OB'
    country.create :id => 262005, :name => "Tadjourah", :abbreviation => 'TA'
    
    # City
    country.create :id => 262006, :name => "Djibouti", :abbreviation => 'DJ'
  end
  
  # Denmark
  with_options(:country => Country['DK']) do |country|
    country.create :id => 208015, :name => "Copenhagen"
    country.create :id => 208020, :name => "Frederiksborg"
    country.create :id => 208025, :name => "Roskilde"
    country.create :id => 208030, :name => "Western Zealand"
    country.create :id => 208035, :name => "Storstrøm"
    country.create :id => 208040, :name => "Bornholm"
    country.create :id => 208042, :name => "Funen"
    country.create :id => 208050, :name => "Southern Jutland"
    country.create :id => 208055, :name => "Ribe"
    country.create :id => 208060, :name => "Vejle"
    country.create :id => 208065, :name => "Ringkøbing"
    country.create :id => 208070, :name => "Aarhus"
    country.create :id => 208076, :name => "Viborg"
    country.create :id => 208080, :name => "Northern Jutland"
  end
  
  # Dominica
  with_options(:country => Country['DM']) do |country|
    country.create :id => 212001, :name => "Saint Peter"
    country.create :id => 212002, :name => "Saint Andrew"
    country.create :id => 212003, :name => "Saint David"
    country.create :id => 212004, :name => "Saint George"
    country.create :id => 212005, :name => "Saint John"
    country.create :id => 212006, :name => "Saint Joseph"
    country.create :id => 212007, :name => "Saint Luke"
    country.create :id => 212008, :name => "Saint Mark"
    country.create :id => 212009, :name => "Saint Patrick"
    country.create :id => 212010, :name => "Saint Paul"
  end
  
  # Dominican Republic
  with_options(:country => Country['DO']) do |country|
    country.create :id => 214001, :name => "Distrito Nacional (Santo Domingo)"
    country.create :id => 214002, :name => "Azua"
    country.create :id => 214003, :name => "Bahoruco"
    country.create :id => 214004, :name => "Barahona"
    country.create :id => 214005, :name => "Dajabón"
    country.create :id => 214006, :name => "Duarte"
    country.create :id => 214007, :name => "La Estrelleta" # Elías Piña
    country.create :id => 214008, :name => "El Seybo" # El Seibo
    country.create :id => 214009, :name => "Espaillat"
    country.create :id => 214010, :name => "Independencia"
    country.create :id => 214011, :name => "La Altagracia"
    country.create :id => 214012, :name => "La Romana"
    country.create :id => 214013, :name => "La Vega"
    country.create :id => 214014, :name => "María Trinidad Sánchez"
    country.create :id => 214015, :name => "Monte Cristi"
    country.create :id => 214016, :name => "Pedernales"
    country.create :id => 214017, :name => "Peravia"
    country.create :id => 214018, :name => "Puerto Plata"
    country.create :id => 214019, :name => "Salcedo"
    country.create :id => 214020, :name => "Samaná"
    country.create :id => 214021, :name => "San Cristóbal"
    country.create :id => 214022, :name => "San Juan"
    country.create :id => 214023, :name => "San Pedro de Macorís"
    country.create :id => 214024, :name => "Sánchez Ramírez"
    country.create :id => 214025, :name => "Santiago"
    country.create :id => 214026, :name => "Santiago Rodríguez"
    country.create :id => 214027, :name => "Valverde"
    country.create :id => 214028, :name => "Monseñor Nouel"
    country.create :id => 214029, :name => "Monte Plata"
    country.create :id => 214030, :name => "Hato Mayor"
  end
  
  # Algeria
  with_options(:country => Country['DZ']) do |country|
    country.create :id => 12001, :name => "Adrar"
    country.create :id => 12002, :name => "Chlef"
    country.create :id => 12003, :name => "Laghouat"
    country.create :id => 12004, :name => "Oum el Bouaghi"
    country.create :id => 12005, :name => "Batna"
    country.create :id => 12006, :name => "Béjaïa"
    country.create :id => 12007, :name => "Biskra"
    country.create :id => 12008, :name => "Béchar"
    country.create :id => 12009, :name => "Blida"
    country.create :id => 12010, :name => "Bouira"
    country.create :id => 12011, :name => "Tamanghasset"
    country.create :id => 12012, :name => "Tébessa"
    country.create :id => 12013, :name => "Tlemcen"
    country.create :id => 12014, :name => "Tiaret"
    country.create :id => 12015, :name => "Tizi Ouzou"
    country.create :id => 12016, :name => "Alger"
    country.create :id => 12017, :name => "Djelfa"
    country.create :id => 12018, :name => "Jijel"
    country.create :id => 12019, :name => "Sétif"
    country.create :id => 12020, :name => "Saïda"
    country.create :id => 12021, :name => "Skikda"
    country.create :id => 12022, :name => "Sidi Bel Abbès"
    country.create :id => 12023, :name => "Annaba"
    country.create :id => 12024, :name => "Guelma"
    country.create :id => 12025, :name => "Constantine"
    country.create :id => 12026, :name => "Médéa"
    country.create :id => 12027, :name => "Mostaganem"
    country.create :id => 12028, :name => "Msila"
    country.create :id => 12029, :name => "Mascara"
    country.create :id => 12030, :name => "Ouargla"
    country.create :id => 12031, :name => "Oran"
    country.create :id => 12032, :name => "El Bayadh"
    country.create :id => 12033, :name => "Illizi"
    country.create :id => 12034, :name => "Bordj Bou Arréridj"
    country.create :id => 12036, :name => "El Tarf"
    country.create :id => 12037, :name => "Tindouf"
    country.create :id => 12038, :name => "Tissemsilt"
    country.create :id => 12039, :name => "El Oued"
    country.create :id => 12040, :name => "Khenchela"
    country.create :id => 12041, :name => "Souk Ahras"
    country.create :id => 12042, :name => "Tipaza"
    country.create :id => 12043, :name => "Mila"
    country.create :id => 12044, :name => "Aïn Defla"
    country.create :id => 12045, :name => "Naama"
    country.create :id => 12046, :name => "Aïn Témouchent"
    country.create :id => 12047, :name => "Ghardaïa"
    country.create :id => 12048, :name => "Relizane"
  end
  
  # Ecuador
  with_options(:country => Country['EC']) do |country|
    country.create :id => 218001, :name => "Azuay", :abbreviation => 'A'
    country.create :id => 218002, :name => "Bolívar", :abbreviation => 'B'
    country.create :id => 218003, :name => "Cañar", :abbreviation => 'F'
    country.create :id => 218004, :name => "Carchi", :abbreviation => 'C'
    country.create :id => 218005, :name => "Cotopaxi", :abbreviation => 'X'
    country.create :id => 218006, :name => "Chimborazo", :abbreviation => 'H'
    country.create :id => 218007, :name => "El Oro", :abbreviation => 'O'
    country.create :id => 218008, :name => "Esmeraldas", :abbreviation => 'E'
    country.create :id => 218009, :name => "Galápagos", :abbreviation => 'W'
    country.create :id => 218010, :name => "Guayas", :abbreviation => 'G'
    country.create :id => 218011, :name => "Imbabura", :abbreviation => 'I'
    country.create :id => 218012, :name => "Loja", :abbreviation => 'L'
    country.create :id => 218013, :name => "Los Ríos", :abbreviation => 'R'
    country.create :id => 218014, :name => "Manabí", :abbreviation => 'M'
    country.create :id => 218015, :name => "Morona-Santiago", :abbreviation => 'S'
    country.create :id => 218016, :name => "Napo", :abbreviation => 'N'
    country.create :id => 218017, :name => "Orellana", :abbreviation => 'D'
    country.create :id => 218018, :name => "Pastaza", :abbreviation => 'Y'
    country.create :id => 218019, :name => "Pichincha", :abbreviation => 'P'
    country.create :id => 218020, :name => "Sucumbíos", :abbreviation => 'U'
    country.create :id => 218021, :name => "Tungurahua", :abbreviation => 'T'
    country.create :id => 218022, :name => "Zamora-Chinchipe", :abbreviation => 'Z'
  end
  
  # Estonia
  with_options(:country => Country['EE']) do |country|
    country.create :id => 233037, :name => "Harjumaa"
    country.create :id => 233039, :name => "Hiiumaa"
    country.create :id => 233044, :name => "Ida-Virumaa"
    country.create :id => 233049, :name => "Jõgevamaa"
    country.create :id => 233051, :name => "Järvamaa"
    country.create :id => 233057, :name => "Läänemaa"
    country.create :id => 233059, :name => "Lääne-Virumaa"
    country.create :id => 233065, :name => "Põlvamaa"
    country.create :id => 233067, :name => "Pärnumaa"
    country.create :id => 233070, :name => "Raplamaa"
    country.create :id => 233074, :name => "Saaremaa"
    country.create :id => 233078, :name => "Tartumaa"
    country.create :id => 233082, :name => "Valgamaa"
    country.create :id => 233084, :name => "Viljandimaa"
    country.create :id => 233086, :name => "Võrumaa"
  end
  
  # Egypt
  with_options(:country => Country['EG']) do |country|
    country.create :id => 818001, :name => "Ad Daqahlīyah", :abbreviation => 'DK'
    country.create :id => 818002, :name => "Al Bahr al Ahmar", :abbreviation => 'BA'
    country.create :id => 818003, :name => "Al Buhayrah", :abbreviation => 'BH'
    country.create :id => 818004, :name => "Al Fayyūm", :abbreviation => 'FYM'
    country.create :id => 818005, :name => "Al Gharbīyah", :abbreviation => 'GH'
    country.create :id => 818006, :name => "Al Iskandarīyah", :abbreviation => 'ALX'
    country.create :id => 818007, :name => "Al Ismā`īlīyah", :abbreviation => 'IS'
    country.create :id => 818008, :name => "Al Jīzah", :abbreviation => 'GZ'
    country.create :id => 818009, :name => "Al Minūfīyah", :abbreviation => 'MNF'
    country.create :id => 818010, :name => "Al Minyā", :abbreviation => 'MN'
    country.create :id => 818011, :name => "Al Qāhirah", :abbreviation => 'C'
    country.create :id => 818012, :name => "Al Qalyūbīyah", :abbreviation => 'KB'
    country.create :id => 818013, :name => "Al Wādī al Jadīd", :abbreviation => 'WAD'
    country.create :id => 818014, :name => "Ash Sharqīyah", :abbreviation => 'SHR'
    country.create :id => 818015, :name => "As Suways", :abbreviation => 'SUZ'
    country.create :id => 818016, :name => "Aswān", :abbreviation => 'ASN'
    country.create :id => 818017, :name => "Asyūt", :abbreviation => 'AST'
    country.create :id => 818018, :name => "Banī Suwayf", :abbreviation => 'BNS'
    country.create :id => 818019, :name => "Būr Sa`īd", :abbreviation => 'PTS'
    country.create :id => 818020, :name => "Dumyāt", :abbreviation => 'DT'
    country.create :id => 818021, :name => "Janūb Sīnā", :abbreviation => 'JS'
    country.create :id => 818022, :name => "Kafr ash Shaykh", :abbreviation => 'KFS'
    country.create :id => 818023, :name => "Matrūh", :abbreviation => 'MT'
    country.create :id => 818024, :name => "Qinā", :abbreviation => 'KN'
    country.create :id => 818025, :name => "Shamal Sīnā", :abbreviation => 'SIN'
    country.create :id => 818026, :name => "Sūhāj", :abbreviation => 'SHG'
  end
  
  # Eritrea
  with_options(:country => Country['ER']) do |country|
    country.create :id => 232001, :name => "Anseba", :abbreviation => 'AN'
    country.create :id => 232002, :name => "Debub", :abbreviation => 'DU'
    country.create :id => 232003, :name => "Debubawi Keyih Bahri", :abbreviation => 'DK' # Debub-Keih-Bahri
    country.create :id => 232004, :name => "Gash-Barka", :abbreviation => 'GB'
    country.create :id => 232005, :name => "Maakel", :abbreviation => 'MA' # Maekel
    country.create :id => 232006, :name => "Semenawi Keyih Bahri", :abbreviation => 'SK' # Semien-Keih-Bahri
  end
  
  # Spain
  with_options(:country => Country['ES']) do |country|
    # Province
    country.create :id => 724001, :name => "Álava", :abbreviation => 'VI'
    country.create :id => 724002, :name => "Albacete", :abbreviation => 'AB'
    country.create :id => 724003, :name => "Alicante", :abbreviation => 'A'
    country.create :id => 724004, :name => "Almería", :abbreviation => 'AL'
    country.create :id => 724005, :name => "Asturias", :abbreviation => 'O'
    country.create :id => 724006, :name => "Ávila", :abbreviation => 'AV'
    country.create :id => 724007, :name => "Badajoz", :abbreviation => 'BA'
    country.create :id => 724008, :name => "Baleares", :abbreviation => 'IB'
    country.create :id => 724009, :name => "Barcelona", :abbreviation => 'B'
    country.create :id => 724010, :name => "Burgos", :abbreviation => 'BU'
    country.create :id => 724011, :name => "Cáceres", :abbreviation => 'CC'
    country.create :id => 724012, :name => "Cádiz", :abbreviation => 'CA'
    country.create :id => 724013, :name => "Cantabria", :abbreviation => 'S'
    country.create :id => 724014, :name => "Castellón", :abbreviation => 'CS'
    country.create :id => 724015, :name => "Ciudad Real", :abbreviation => 'CR'
    country.create :id => 724016, :name => "Córdoba", :abbreviation => 'CO'
    country.create :id => 724017, :name => "Cuenca", :abbreviation => 'CU'
    country.create :id => 724018, :name => "Girona", :abbreviation => 'GI'
    country.create :id => 724019, :name => "Granada", :abbreviation => 'GR'
    country.create :id => 724020, :name => "Guadalajara", :abbreviation => 'GU'
    country.create :id => 724021, :name => "Guipúzcoa", :abbreviation => 'SS'
    country.create :id => 724022, :name => "Huelva", :abbreviation => 'H'
    country.create :id => 724023, :name => "Huesca", :abbreviation => 'HU'
    country.create :id => 724024, :name => "Jaén", :abbreviation => 'J'
    country.create :id => 724025, :name => "A Coruña", :abbreviation => 'C'
    country.create :id => 724026, :name => "La Rioja", :abbreviation => 'LO'
    country.create :id => 724027, :name => "Las Palmas", :abbreviation => 'GC'
    country.create :id => 724028, :name => "León", :abbreviation => 'LE'
    country.create :id => 724029, :name => "Lleida", :abbreviation => 'L'
    country.create :id => 724030, :name => "Lugo", :abbreviation => 'LU'
    country.create :id => 724031, :name => "Madrid", :abbreviation => 'M'
    country.create :id => 724032, :name => "Málaga", :abbreviation => 'MA'
    country.create :id => 724033, :name => "Murcia", :abbreviation => 'MU'
    country.create :id => 724034, :name => "Navarra", :abbreviation => 'NA'
    country.create :id => 724035, :name => "Ourense", :abbreviation => 'OR'
    country.create :id => 724036, :name => "Palencia", :abbreviation => 'P'
    country.create :id => 724037, :name => "Pontevedra", :abbreviation => 'PO'
    country.create :id => 724038, :name => "Salamanca", :abbreviation => 'SA'
    country.create :id => 724039, :name => "Santa Cruz de Tenerife", :abbreviation => 'TF'
    country.create :id => 724040, :name => "Segovia", :abbreviation => 'SG'
    country.create :id => 724041, :name => "Sevilla", :abbreviation => 'SE'
    country.create :id => 724042, :name => "Soria", :abbreviation => 'SO'
    country.create :id => 724043, :name => "Tarragona", :abbreviation => 'T'
    country.create :id => 724044, :name => "Teruel", :abbreviation => 'TE'
    country.create :id => 724045, :name => "Toledo", :abbreviation => 'TO'
    country.create :id => 724046, :name => "Valencia", :abbreviation => 'V'
    country.create :id => 724047, :name => "Valladolid", :abbreviation => 'VA'
    country.create :id => 724048, :name => "Vizcaya", :abbreviation => 'BI'
    country.create :id => 724049, :name => "Zamora", :abbreviation => 'ZA'
    country.create :id => 724050, :name => "Zaragoza", :abbreviation => 'Z'

    # Autonomous City
    country.create :id => 724051, :name => "Ceuta", :abbreviation => 'CE'
    country.create :id => 724052, :name => "Melilla", :abbreviation => 'ML'
  end
  
  # Ethiopia
  with_options(:country => Country['ET']) do |country|
    # Administration
    country.create :id => 231001, :name => "Ādīs Ābeba", :abbreviation => 'AA'
    country.create :id => 231002, :name => "Dirē Dawa", :abbreviation => 'DD'
    
    # State
    country.create :id => 231003, :name => "Āfar", :abbreviation => 'AF'
    country.create :id => 231004, :name => "Āmara", :abbreviation => 'AM'
    country.create :id => 231005, :name => "Bīnshangul Gumuz", :abbreviation => 'BE'
    country.create :id => 231006, :name => "Gambēla Hizboch", :abbreviation => 'GA'
    country.create :id => 231007, :name => "Hārerī Hizb", :abbreviation => 'HA'
    country.create :id => 231008, :name => "Oromīya", :abbreviation => 'OR'
    country.create :id => 231009, :name => "Sumalē", :abbreviation => 'SO'
    country.create :id => 231010, :name => "Tigray", :abbreviation => 'TI'
    country.create :id => 231011, :name => "YeDebub Bihēroch Bihēreseboch na Hizboch", :abbreviation => 'SN'
  end
  
  # Finland
  with_options(:country => Country['FI']) do |country|
    country.create :id => 246001, :name => "Ahvenanmaan lääni", :abbreviation => 'AL'
    country.create :id => 246002, :name => "Etelä-Suomen lääni", :abbreviation => 'ES'
    country.create :id => 246003, :name => "Itä-Suomen lääni", :abbreviation => 'IS'
    country.create :id => 246004, :name => "Lapin lääni", :abbreviation => 'LL'
    country.create :id => 246005, :name => "Länsi-Suomen lääni", :abbreviation => 'LS'
    country.create :id => 246006, :name => "Oulun lääni", :abbreviation => 'OL'
  end
  
  # Fiji
  with_options(:country => Country['FJ']) do |country|
    # Division
    country.create :id => 242001, :name => "Central", :abbreviation => 'C'
    country.create :id => 242002, :name => "Eastern", :abbreviation => 'E'
    country.create :id => 242003, :name => "Northern", :abbreviation => 'N'
    country.create :id => 242004, :name => "Western", :abbreviation => 'W'
    
    # Dependency
    country.create :id => 242005, :name => "Rotum", :abbreviation => 'R'
  end
  
  # Micronesia
  with_options(:country => Country['FM']) do |country|
    country.create :id => 58301, :name => "Chuuk", :abbreviation => 'TRK'
    country.create :id => 58302, :name => "Kosrae", :abbreviation => 'KSA'
    country.create :id => 58303, :name => "Pohnpei", :abbreviation => 'PNI'
    country.create :id => 58304, :name => "Yap", :abbreviation => 'YAP'
  end
  
  # France
  with_options(:country => Country['FR']) do |country|
    # Metropolitan Department
    country.create :id => 250001, :name => "Ain"
    country.create :id => 250002, :name => "Aisne"
    country.create :id => 250003, :name => "Allier"
    country.create :id => 250004, :name => "Alpes-de-Haute-Provence"
    country.create :id => 250005, :name => "Hautes-Alpes"
    country.create :id => 250006, :name => "Alpes-Maritimes"
    country.create :id => 250007, :name => "Ardèche"
    country.create :id => 250008, :name => "Ardennes"
    country.create :id => 250009, :name => "Ariège"
    country.create :id => 250010, :name => "Aube"
    country.create :id => 250011, :name => "Aude"
    country.create :id => 250012, :name => "Aveyron"
    country.create :id => 250013, :name => "Bouches-du-Rhône"
    country.create :id => 250014, :name => "Calvados"
    country.create :id => 250015, :name => "Cantal"
    country.create :id => 250016, :name => "Charente"
    country.create :id => 250017, :name => "Charente-Maritime"
    country.create :id => 250018, :name => "Cher"
    country.create :id => 250019, :name => "Corrèze"
    country.create :id => 250020, :name => "Corse-du-Sud", :abbreviation => '02A'
    country.create :id => 250021, :name => "Côte-d'Or"
    country.create :id => 250022, :name => "Côtes-d'Armor"
    country.create :id => 250023, :name => "Creuse"
    country.create :id => 250024, :name => "Dordogne"
    country.create :id => 250025, :name => "Doubs"
    country.create :id => 250026, :name => "Drôme"
    country.create :id => 250027, :name => "Eure"
    country.create :id => 250028, :name => "Eure-et-Loir"
    country.create :id => 250029, :name => "Finistère"
    country.create :id => 250030, :name => "Gard"
    country.create :id => 250031, :name => "Haute-Garonne"
    country.create :id => 250032, :name => "Gers"
    country.create :id => 250033, :name => "Gironde"
    country.create :id => 250034, :name => "Hérault"
    country.create :id => 250035, :name => "Ille-et-Vilaine"
    country.create :id => 250036, :name => "Indre"
    country.create :id => 250037, :name => "Indre-et-Loire"
    country.create :id => 250038, :name => "Isère"
    country.create :id => 250039, :name => "Jura"
    country.create :id => 250040, :name => "Landes"
    country.create :id => 250041, :name => "Loir-et-Cher"
    country.create :id => 250042, :name => "Loire"
    country.create :id => 250043, :name => "Haute-Loire"
    country.create :id => 250044, :name => "Loire-Atlantique"
    country.create :id => 250045, :name => "Loiret"
    country.create :id => 250046, :name => "Lot"
    country.create :id => 250047, :name => "Lot-et-Garonne"
    country.create :id => 250048, :name => "Lozère"
    country.create :id => 250049, :name => "Maine-et-Loire"
    country.create :id => 250050, :name => "Manche"
    country.create :id => 250051, :name => "Marne"
    country.create :id => 250052, :name => "Haute-Marne"
    country.create :id => 250053, :name => "Mayenne"
    country.create :id => 250054, :name => "Meurthe-et-Moselle"
    country.create :id => 250055, :name => "Meuse"
    country.create :id => 250056, :name => "Morbihan"
    country.create :id => 250057, :name => "Moselle"
    country.create :id => 250058, :name => "Nièvre"
    country.create :id => 250059, :name => "Nord"
    country.create :id => 250060, :name => "Oise"
    country.create :id => 250061, :name => "Orne"
    country.create :id => 250062, :name => "Pas-de-Calais"
    country.create :id => 250063, :name => "Puy-de-Dôme"
    country.create :id => 250064, :name => "Pyrénées-Atlantiques"
    country.create :id => 250065, :name => "Hautes-Pyrénées"
    country.create :id => 250066, :name => "Pyrénées-Orientales"
    country.create :id => 250067, :name => "Bas-Rhin"
    country.create :id => 250068, :name => "Haut-Rhin"
    country.create :id => 250069, :name => "Rhône"
    country.create :id => 250070, :name => "Haute-Saône"
    country.create :id => 250071, :name => "Saône-et-Loire"
    country.create :id => 250072, :name => "Sarthe"
    country.create :id => 250073, :name => "Savoie"
    country.create :id => 250074, :name => "Haute-Savoie"
    country.create :id => 250075, :name => "Paris"
    country.create :id => 250076, :name => "Seine-Maritime"
    country.create :id => 250077, :name => "Seine-et-Marne"
    country.create :id => 250078, :name => "Yvelines"
    country.create :id => 250079, :name => "Deux-Sèvres"
    country.create :id => 250080, :name => "Somme"
    country.create :id => 250081, :name => "Tarn"
    country.create :id => 250082, :name => "Tarn-et-Garonne"
    country.create :id => 250083, :name => "Var"
    country.create :id => 250084, :name => "Vaucluse"
    country.create :id => 250085, :name => "Vendée"
    country.create :id => 250086, :name => "Vienne"
    country.create :id => 250087, :name => "Haute-Vienne"
    country.create :id => 250088, :name => "Vosges"
    country.create :id => 250089, :name => "Yonne"
    country.create :id => 250090, :name => "Territoire de Belfort"
    country.create :id => 250091, :name => "Essonne"
    country.create :id => 250092, :name => "Hauts-de-Seine"
    country.create :id => 250093, :name => "Seine-Saint-Denis"
    country.create :id => 250094, :name => "Val-de-Marne"
    country.create :id => 250095, :name => "Val d'Oise"
    
    # Numeric non-matching
    country.create :id => 250101, :name => "Haute-Corse", :abbreviation => '02B'
    
    # Dependency
    country.create :id => 250201, :name => "Clipperton", :abbreviation => 'CP'
    country.create :id => 250202, :name => "Saint-Barthélemy", :abbreviation => 'BL'
    country.create :id => 250203, :name => "Saint-Martin", :abbreviation => 'MF'
    country.create :id => 250204, :name => "Nouvelle-Calédonie", :abbreviation => 'NC'
    country.create :id => 250205, :name => "Polynésie française", :abbreviation => 'PF'
    country.create :id => 250206, :name => "Saint-Pierre-et-Miquelon", :abbreviation => 'PM'
    country.create :id => 250207, :name => "Terres australes françaises", :abbreviation => 'TF'
    country.create :id => 250208, :name => "Wallis et Futuna", :abbreviation => 'WF'
    country.create :id => 250209, :name => "Mayotte", :abbreviation => 'YT'
  end
  
  # United Kingdom
  with_options(:country => Country['GB']) do |country|
    country.with_options(:group => "England") do |country|
      # Two-tier county
      country.create :id => 826001, :name => "Bedfordshire", :abbreviation => 'BDF'
      country.create :id => 826002, :name => "Buckinghamshire", :abbreviation => 'BKM'
      country.create :id => 826003, :name => "Cambridgeshire", :abbreviation => 'CAM'
      country.create :id => 826004, :name => "Cheshire", :abbreviation => 'CHS'
      country.create :id => 826005, :name => "Cornwall", :abbreviation => 'CON'
      country.create :id => 826006, :name => "Cumbria", :abbreviation => 'CMA'
      country.create :id => 826007, :name => "Derbyshire", :abbreviation => 'DBY'
      country.create :id => 826008, :name => "Devon", :abbreviation => 'DEV'
      country.create :id => 826009, :name => "Dorset", :abbreviation => 'DOR'
      country.create :id => 826010, :name => "Durham", :abbreviation => 'DUR'
      country.create :id => 826011, :name => "East Sussex", :abbreviation => 'ESX'
      country.create :id => 826012, :name => "Essex", :abbreviation => 'ESS'
      country.create :id => 826013, :name => "Gloucestershire", :abbreviation => 'GLS'
      country.create :id => 826014, :name => "Hampshire", :abbreviation => 'HAM'
      country.create :id => 826015, :name => "Hertfordshire", :abbreviation => 'HRT'
      country.create :id => 826016, :name => "Kent", :abbreviation => 'KEN'
      country.create :id => 826017, :name => "Lancashire", :abbreviation => 'LAN'
      country.create :id => 826018, :name => "Leicestershire", :abbreviation => 'LEC'
      country.create :id => 826019, :name => "Lincolnshire", :abbreviation => 'LIN'
      country.create :id => 826020, :name => "Norfolk", :abbreviation => 'NFK'
      country.create :id => 826021, :name => "North Yorkshire", :abbreviation => 'NYK'
      country.create :id => 826022, :name => "Northamptonshire", :abbreviation => 'NTH'
      country.create :id => 826023, :name => "Northumbarland", :abbreviation => 'NBL'
      country.create :id => 826024, :name => "Nottinghamshire", :abbreviation => 'NTT'
      country.create :id => 826025, :name => "Oxfordshire", :abbreviation => 'OXF'
      country.create :id => 826026, :name => "Somerse", :abbreviation => 'SOM'
      country.create :id => 826027, :name => "Staffordshire", :abbreviation => 'STS'
      country.create :id => 826028, :name => "Suffolk", :abbreviation => 'SFK'
      country.create :id => 826029, :name => "Surrey", :abbreviation => 'SRY'
      country.create :id => 826030, :name => "West Sussex", :abbreviation => 'WSX'
      country.create :id => 826031, :name => "Wiltshire", :abbreviation => 'WIL'
      country.create :id => 826032, :name => "Worcestershire", :abbreviation => 'WOR'

      # London borough
      country.create :id => 826033, :name => "Barking and Dagenham", :abbreviation => 'BDG'
      country.create :id => 826034, :name => "Barnet", :abbreviation => 'BNE'
      country.create :id => 826035, :name => "Bexley", :abbreviation => 'BEX'
      country.create :id => 826036, :name => "Brent", :abbreviation => 'BEN'
      country.create :id => 826037, :name => "Bromley", :abbreviation => 'BRY'
      country.create :id => 826038, :name => "Camden", :abbreviation => 'CMD'
      country.create :id => 826039, :name => "Croydon", :abbreviation => 'CRY'
      country.create :id => 826040, :name => "Ealing", :abbreviation => 'EAL'
      country.create :id => 826041, :name => "Enfield", :abbreviation => 'ENF'
      country.create :id => 826042, :name => "Greenwich", :abbreviation => 'GRE'
      country.create :id => 826043, :name => "Hackney", :abbreviation => 'HCK'
      country.create :id => 826044, :name => "Hammersmith and Fulham", :abbreviation => 'HMF'
      country.create :id => 826045, :name => "Haringey", :abbreviation => 'HRY'
      country.create :id => 826046, :name => "Harrow", :abbreviation => 'HRW'
      country.create :id => 826047, :name => "Havering", :abbreviation => 'HAV'
      country.create :id => 826048, :name => "Hillingdon", :abbreviation => 'HIL'
      country.create :id => 826049, :name => "Hounslow", :abbreviation => 'HNS'
      country.create :id => 826050, :name => "Islington", :abbreviation => 'ISL'
      country.create :id => 826051, :name => "Kensington and Chelsea", :abbreviation => 'KEC'
      country.create :id => 826052, :name => "Kingston upon Thames", :abbreviation => 'KTT'
      country.create :id => 826053, :name => "Lambeth", :abbreviation => 'LBH'
      country.create :id => 826054, :name => "Lewisham", :abbreviation => 'LEW'
      country.create :id => 826055, :name => "Merton", :abbreviation => 'MRT'
      country.create :id => 826056, :name => "Newham", :abbreviation => 'NWM'
      country.create :id => 826057, :name => "Redbridge", :abbreviation => 'RDB'
      country.create :id => 826058, :name => "Richmond upon Thames", :abbreviation => 'RIC'
      country.create :id => 826059, :name => "Southwark", :abbreviation => 'SWK'
      country.create :id => 826060, :name => "Sutton", :abbreviation => 'STN'
      country.create :id => 826061, :name => "Tower Hamlets", :abbreviation => 'TWH'
      country.create :id => 826062, :name => "Waltham Forest", :abbreviation => 'WFT'
      country.create :id => 826063, :name => "Wandsworth", :abbreviation => 'WND'
      country.create :id => 826064, :name => "Westminster", :abbreviation => 'WSM'

      # Metropolitan district
      country.create :id => 826065, :name => "Barnsley", :abbreviation => 'BNS'
      country.create :id => 826066, :name => "Birmingham", :abbreviation => 'BIR'
      country.create :id => 826067, :name => "Bolton", :abbreviation => 'BOL'
      country.create :id => 826068, :name => "Bradford", :abbreviation => 'BRD'
      country.create :id => 826069, :name => "Bury", :abbreviation => 'BUR'
      country.create :id => 826070, :name => "Calderdale", :abbreviation => 'CLD'
      country.create :id => 826071, :name => "Coventry", :abbreviation => 'COV'
      country.create :id => 826072, :name => "Doncaster", :abbreviation => 'DNC'
      country.create :id => 826073, :name => "Dudley", :abbreviation => 'DUD'
      country.create :id => 826074, :name => "Gateshead", :abbreviation => 'GAT'
      country.create :id => 826075, :name => "Kirklees", :abbreviation => 'KIR'
      country.create :id => 826076, :name => "Knowsley", :abbreviation => 'KWL'
      country.create :id => 826077, :name => "Leeds", :abbreviation => 'LDS'
      country.create :id => 826078, :name => "Liverpool", :abbreviation => 'LIV'
      country.create :id => 826079, :name => "Manchester", :abbreviation => 'MAN'
      country.create :id => 826080, :name => "Newcastle upon Tyne", :abbreviation => 'NET'
      country.create :id => 826081, :name => "North Tyneside", :abbreviation => 'NTY'
      country.create :id => 826082, :name => "Oldham", :abbreviation => 'OLD'
      country.create :id => 826083, :name => "Rochdale", :abbreviation => 'RCH'
      country.create :id => 826084, :name => "Rotherham", :abbreviation => 'ROT'
      country.create :id => 826085, :name => "Salford", :abbreviation => 'SLF'
      country.create :id => 826086, :name => "Sandwell", :abbreviation => 'SAW'
      country.create :id => 826087, :name => "Sefton", :abbreviation => 'SFT'
      country.create :id => 826088, :name => "Sheffield", :abbreviation => 'SHF'
      country.create :id => 826089, :name => "Solihull", :abbreviation => 'SOL'
      country.create :id => 826090, :name => "South Tyneside", :abbreviation => 'STY'
      country.create :id => 826091, :name => "St. Helens", :abbreviation => 'SHN'
      country.create :id => 826092, :name => "Stockport", :abbreviation => 'SKP'
      country.create :id => 826093, :name => "Sunderland", :abbreviation => 'SND'
      country.create :id => 826094, :name => "Tameside", :abbreviation => 'TAM'
      country.create :id => 826095, :name => "Trafford", :abbreviation => 'TRF'
      country.create :id => 826096, :name => "Wakefield", :abbreviation => 'WKF'
      country.create :id => 826097, :name => "Walsall", :abbreviation => 'WLL'
      country.create :id => 826098, :name => "Wigan", :abbreviation => 'WGN'
      country.create :id => 826099, :name => "Wirral", :abbreviation => 'WRL'
      country.create :id => 826100, :name => "Wolverhampton", :abbreviation => 'WLV'

      # City corporation
      country.create :id => 826101, :name => "London, City of", :abbreviation => 'LND'

      # Division
      country.create :id => 826102, :name => "Bath and North East Somerset", :abbreviation => 'BAS'
      country.create :id => 826103, :name => "Blackburn with Darwen", :abbreviation => 'BBD'
      country.create :id => 826104, :name => "Blackpool", :abbreviation => 'BPL'
      country.create :id => 826105, :name => "Bournemouth", :abbreviation => 'BMH'
      country.create :id => 826106, :name => "Bracknell Forest", :abbreviation => 'BRC'
      country.create :id => 826107, :name => "Brighton and Hove", :abbreviation => 'BNH'
      country.create :id => 826108, :name => "Bristol, City of", :abbreviation => 'BST'
      country.create :id => 826109, :name => "Darlington", :abbreviation => 'DAL'
      country.create :id => 826110, :name => "Derby", :abbreviation => 'DER'
      country.create :id => 826111, :name => "East Riding of Yorkshire", :abbreviation => 'ERY'
      country.create :id => 826112, :name => "Halton", :abbreviation => 'HAL'
      country.create :id => 826113, :name => "Hartlepool", :abbreviation => 'HPL'
      country.create :id => 826114, :name => "Herefordshire, County of", :abbreviation => 'HEF'
      country.create :id => 826115, :name => "Isle of Wight", :abbreviation => 'IOW'
      country.create :id => 826116, :name => "Isles of Scilly", :abbreviation => 'IOS'
      country.create :id => 826117, :name => "Kingston upon Hull, City of", :abbreviation => 'KHL'
      country.create :id => 826118, :name => "Leicester", :abbreviation => 'LCE'
      country.create :id => 826119, :name => "Luton", :abbreviation => 'LUT'
      country.create :id => 826120, :name => "Medway", :abbreviation => 'MDW'
      country.create :id => 826121, :name => "Middlesbrough", :abbreviation => 'MDB'
      country.create :id => 826122, :name => "Milton Keynes", :abbreviation => 'MIK'
      country.create :id => 826123, :name => "North East Lincolnshire", :abbreviation => 'NEL'
      country.create :id => 826124, :name => "North Lincolnshire", :abbreviation => 'NLN'
      country.create :id => 826125, :name => "North Somerset", :abbreviation => 'NSM'
      country.create :id => 826126, :name => "Nottingham", :abbreviation => 'NGM'
      country.create :id => 826127, :name => "Peterborough", :abbreviation => 'PTE'
      country.create :id => 826128, :name => "Plymouth", :abbreviation => 'PLY'
      country.create :id => 826129, :name => "Poole", :abbreviation => 'POL'
      country.create :id => 826130, :name => "Portsmouth", :abbreviation => 'POR'
      country.create :id => 826131, :name => "Reading", :abbreviation => 'RDG'
      country.create :id => 826132, :name => "Redcar and Cleveland", :abbreviation => 'RCC'
      country.create :id => 826133, :name => "Rutland", :abbreviation => 'RUT'
      country.create :id => 826134, :name => "Shropshire", :abbreviation => 'SHR'
      country.create :id => 826135, :name => "Slough", :abbreviation => 'SLG'
      country.create :id => 826136, :name => "South Gloucestershire", :abbreviation => 'SGC'
      country.create :id => 826137, :name => "Southampton", :abbreviation => 'STH'
      country.create :id => 826138, :name => "Southend-on-Sea", :abbreviation => 'SOS'
      country.create :id => 826139, :name => "Stockton-on-Tees", :abbreviation => 'STT'
      country.create :id => 826140, :name => "Stoke-on-Trent", :abbreviation => 'STE'
      country.create :id => 826141, :name => "Swindon", :abbreviation => 'SWD'
      country.create :id => 826142, :name => "Telford and Wrekin", :abbreviation => 'TFW'
      country.create :id => 826143, :name => "Thurrock", :abbreviation => 'THR'
      country.create :id => 826144, :name => "Torbay", :abbreviation => 'TOB'
      country.create :id => 826145, :name => "Warrington", :abbreviation => 'WRT'
      country.create :id => 826146, :name => "Warwickshire", :abbreviation => 'WAR'
      country.create :id => 826147, :name => "West Berkshire", :abbreviation => 'WBX'
      country.create :id => 826148, :name => "Windsor and Maidenhead", :abbreviation => 'WNM'
      country.create :id => 826149, :name => "Wokingham", :abbreviation => 'WOK'
      country.create :id => 826150, :name => "York", :abbreviation => 'YOR'
    end

    country.with_options(:group => "Scotland") do |country|
      country.create :id => 826201, :name => "Aberdeen City", :abbreviation => 'ABE'
      country.create :id => 826202, :name => "Aberdeenshire", :abbreviation => 'ABD'
      country.create :id => 826203, :name => "Angus", :abbreviation => 'ANS'
      country.create :id => 826204, :name => "Argyll and Bute", :abbreviation => 'AGB'
      country.create :id => 826205, :name => "Clackmannanshire", :abbreviation => 'CLK'
      country.create :id => 826206, :name => "Dumfries and Galloway", :abbreviation => 'DGY'
      country.create :id => 826207, :name => "Dundee City", :abbreviation => 'DND'
      country.create :id => 826208, :name => "East Ayrshire", :abbreviation => 'EAY'
      country.create :id => 826209, :name => "East Dunbartonshire", :abbreviation => 'EDU'
      country.create :id => 826210, :name => "East Lothian", :abbreviation => 'ELN'
      country.create :id => 826211, :name => "East Renfrewshire", :abbreviation => 'ERW'
      country.create :id => 826212, :name => "Edinburgh, City of", :abbreviation => 'EDH'
      country.create :id => 826213, :name => "Eilean Siar", :abbreviation => 'ELS'
      country.create :id => 826214, :name => "Falkirk", :abbreviation => 'FAL'
      country.create :id => 826215, :name => "Fife", :abbreviation => 'FIF'
      country.create :id => 826216, :name => "Glasgow City", :abbreviation => 'GLG'
      country.create :id => 826217, :name => "Highland", :abbreviation => 'HED'
      country.create :id => 826218, :name => "Inverclyde", :abbreviation => 'IVC'
      country.create :id => 826219, :name => "Midlothian", :abbreviation => 'MLN'
      country.create :id => 826220, :name => "Moray", :abbreviation => 'MRY'
      country.create :id => 826221, :name => "North Ayrshire", :abbreviation => 'NAY'
      country.create :id => 826222, :name => "North Lanarkshire", :abbreviation => 'NLK'
      country.create :id => 826223, :name => "Orkney Islands", :abbreviation => 'ORR'
      country.create :id => 826224, :name => "Perth and Kinross", :abbreviation => 'PKN'
      country.create :id => 826225, :name => "Renfrewshire", :abbreviation => 'RFW'
      country.create :id => 826226, :name => "Scottish Borders, The", :abbreviation => 'SCB'
      country.create :id => 826227, :name => "Shetland Islands", :abbreviation => 'ZET'
      country.create :id => 826228, :name => "South Ayrshire", :abbreviation => 'SAY'
      country.create :id => 826229, :name => "South Lanarkshire", :abbreviation => 'SLK'
      country.create :id => 826230, :name => "Stirling", :abbreviation => 'STG'
      country.create :id => 826231, :name => "West Dunbartonshire", :abbreviation => 'WDU'
      country.create :id => 826232, :name => "West Lothian", :abbreviation => 'WLN'
    end

    country.with_options(:group => "Northern Ireland") do |country|
      country.create :id => 826301, :name => "Antrim", :abbreviation => 'ANT'
      country.create :id => 826302, :name => "Ards", :abbreviation => 'ARD'
      country.create :id => 826303, :name => "Armagh", :abbreviation => 'ARM'
      country.create :id => 826304, :name => "Ballymena", :abbreviation => 'BLA'
      country.create :id => 826305, :name => "Ballymoney", :abbreviation => 'BLY'
      country.create :id => 826306, :name => "Banbridge", :abbreviation => 'BNB'
      country.create :id => 826307, :name => "Belfast", :abbreviation => 'BFS'
      country.create :id => 826308, :name => "Carrickfergus", :abbreviation => 'CKF'
      country.create :id => 826309, :name => "Castlereagh", :abbreviation => 'CSR'
      country.create :id => 826310, :name => "Coleraine", :abbreviation => 'CLR'
      country.create :id => 826311, :name => "Cookstown", :abbreviation => 'CKT'
      country.create :id => 826312, :name => "Craigavon", :abbreviation => 'CGV'
      country.create :id => 826313, :name => "Derry", :abbreviation => 'DRY'
      country.create :id => 826314, :name => "Down", :abbreviation => 'DOW'
      country.create :id => 826315, :name => "Dungannon", :abbreviation => 'DGN'
      country.create :id => 826316, :name => "Fermanagh", :abbreviation => 'FER'
      country.create :id => 826317, :name => "Larne", :abbreviation => 'LRN'
      country.create :id => 826318, :name => "Limavady", :abbreviation => 'LMV'
      country.create :id => 826319, :name => "Lisburn", :abbreviation => 'LSB'
      country.create :id => 826320, :name => "Magherafelt", :abbreviation => 'MFT'
      country.create :id => 826321, :name => "Moyle", :abbreviation => 'MYL'
      country.create :id => 826322, :name => "Newry and Mourne", :abbreviation => 'NYM'
      country.create :id => 826323, :name => "Newtownabbey", :abbreviation => 'NTA'
      country.create :id => 826324, :name => "North Down", :abbreviation => 'NDN'
      country.create :id => 826325, :name => "Omagh", :abbreviation => 'OMG'
      country.create :id => 826326, :name => "Strabane", :abbreviation => 'STB'
    end

    country.with_options(:group => "Wales") do |country|
      country.create :id => 826401, :name => "Blaenau Gwent", :abbreviation => 'BGW'
      country.create :id => 826402, :name => "Bridgend", :abbreviation => 'BGE'
      country.create :id => 826403, :name => "Caerphilly", :abbreviation => 'CAY'
      country.create :id => 826404, :name => "Cardiff", :abbreviation => 'CRF'
      country.create :id => 826405, :name => "Carmarthenshire", :abbreviation => 'CMN'
      country.create :id => 826406, :name => "Ceredigion", :abbreviation => 'CGN'
      country.create :id => 826407, :name => "Conwy", :abbreviation => 'CWY'
      country.create :id => 826408, :name => "Denbighshire", :abbreviation => 'DEN'
      country.create :id => 826409, :name => "Flintshire", :abbreviation => 'FLN'
      country.create :id => 826410, :name => "Gwynedd", :abbreviation => 'GWN'
      country.create :id => 826411, :name => "Isle of Anglesey", :abbreviation => 'AGY'
      country.create :id => 826412, :name => "Merthyr Tydfil", :abbreviation => 'MTY'
      country.create :id => 826413, :name => "Monmouthshire", :abbreviation => 'MON'
      country.create :id => 826414, :name => "Neath Port Talbot", :abbreviation => 'NTL'
      country.create :id => 826415, :name => "Newport", :abbreviation => 'NWP'
      country.create :id => 826416, :name => "Pembrokeshire", :abbreviation => 'PEM'
      country.create :id => 826417, :name => "Powys", :abbreviation => 'POW'
      country.create :id => 826418, :name => "Rhondda, Cynon, Taff", :abbreviation => 'RCT'
      country.create :id => 826419, :name => "Swansea", :abbreviation => 'SWA'
      country.create :id => 826420, :name => "Torfaen", :abbreviation => 'TOF'
      country.create :id => 826421, :name => "Vale of Glamorgan, The", :abbreviation => 'VGL'
      country.create :id => 826422, :name => "Wrexham", :abbreviation => 'WRX'
    end
  end
  
  # Grenada
  with_options(:country => Country['GD']) do |country|
    # Parish
    country.create :id => 308001, :name => "Saint Andrew", :abbreviation => '01'
    country.create :id => 308002, :name => "Saint David", :abbreviation => '02'
    country.create :id => 308003, :name => "Saint George", :abbreviation => '03'
    country.create :id => 308004, :name => "Saint John", :abbreviation => '04'
    country.create :id => 308005, :name => "Saint Mark", :abbreviation => '05'
    country.create :id => 308006, :name => "Saint Patrick", :abbreviation => '06'
    
    # Dependency
    country.create :id => 308010, :name => "Southern Grenadine Island", :abbreviation => '10'
  end
  
  # Georgia
  with_options(:country => Country['GE']) do |country|
    # Autonomous republic
    country.create :id => 268001, :name => "Abkhazia", :abbreviation => 'AB'
    country.create :id => 268002, :name => "Ajaria", :abbreviation => 'AJ'
    
    # City
    country.create :id => 268003, :name => "T’bilisi", :abbreviation => 'TB'
    
    # Region
    country.create :id => 268004, :name => "Guria", :abbreviation => 'GU'
    country.create :id => 268005, :name => "Imeret’i", :abbreviation => 'IM'
    country.create :id => 268006, :name => "Kakhet’i", :abbreviation => 'KA'
    country.create :id => 268007, :name => "K’vemo K’art’li", :abbreviation => 'KK'
    country.create :id => 268008, :name => "Mts’khet’a-Mt’ianet’i", :abbreviation => 'MM'
    country.create :id => 268009, :name => "Racha-Lech’khumi-K’vemo Svanet’i", :abbreviation => 'RL'
    country.create :id => 268010, :name => "Samegrelo-Zemo Svanet’i", :abbreviation => 'SZ'
    country.create :id => 268011, :name => "Samts’khe-Javakhet’i", :abbreviation => 'SJ'
    country.create :id => 268012, :name => "Shida K’art’li", :abbreviation => 'SK'
  end
  
  # Ghana
  with_options(:country => Country['GH']) do |country|
    country.create :id => 288001, :name => "Ashanti", :abbreviation => 'AH'
    country.create :id => 288002, :name => "Brong-Ahafo", :abbreviation => 'BA'
    country.create :id => 288003, :name => "Central", :abbreviation => 'CP'
    country.create :id => 288004, :name => "Eastern", :abbreviation => 'EP'
    country.create :id => 288005, :name => "Greater Accra", :abbreviation => 'AA'
    country.create :id => 288006, :name => "Northern", :abbreviation => 'NP'
    country.create :id => 288007, :name => "Upper East", :abbreviation => 'UE'
    country.create :id => 288008, :name => "Upper West", :abbreviation => 'UW'
    country.create :id => 288009, :name => "Volta", :abbreviation => 'TV'
    country.create :id => 288010, :name => "Western", :abbreviation => 'WP'
  end
  
  # Gambia
  with_options(:country => Country['GM']) do |country|
    country.create :id => 270001, :name => "Lower River", :abbreviation => 'L'
    country.create :id => 270002, :name => "Central River", :abbreviation => 'M'
    country.create :id => 270003, :name => "North Bank", :abbreviation => 'N'
    country.create :id => 270004, :name => "Upper River", :abbreviation => 'U'
    country.create :id => 270005, :name => "Western", :abbreviation => 'W'
    country.create :id => 270006, :name => "Banjul", :abbreviation => 'B'
  end
  
  # Guinea
  with_options(:country => Country['GN']) do |country|
    country.create :id => 321001, :name => "Beyla", :abbreviation => 'BE'
    country.create :id => 321002, :name => "Boffa", :abbreviation => 'BF'
    country.create :id => 321003, :name => "Boké", :abbreviation => 'BK'
    country.create :id => 321004, :name => "Coyah", :abbreviation => 'CO'
    country.create :id => 321005, :name => "Dabola", :abbreviation => 'DB'
    country.create :id => 321006, :name => "Dalaba", :abbreviation => 'DL'
    country.create :id => 321007, :name => "Dinguiraye", :abbreviation => 'DI'
    country.create :id => 321008, :name => "Dubréka", :abbreviation => 'DU'
    country.create :id => 321009, :name => "Faranah", :abbreviation => 'FA'
    country.create :id => 321010, :name => "Forécariah", :abbreviation => 'FO'
    country.create :id => 321011, :name => "Fria", :abbreviation => 'FR'
    country.create :id => 321012, :name => "Gaoual", :abbreviation => 'GA'
    country.create :id => 321013, :name => "Guékédou", :abbreviation => 'GU'
    country.create :id => 321014, :name => "Kankan", :abbreviation => 'KA'
    country.create :id => 321015, :name => "Kérouané", :abbreviation => 'KE'
    country.create :id => 321016, :name => "Kindia", :abbreviation => 'KD'
    country.create :id => 321017, :name => "Kissidougou", :abbreviation => 'KS'
    country.create :id => 321018, :name => "Koubia", :abbreviation => 'KB'
    country.create :id => 321019, :name => "Koundara", :abbreviation => 'KN'
    country.create :id => 321020, :name => "Kouroussa", :abbreviation => 'KO'
    country.create :id => 321021, :name => "Labé", :abbreviation => 'LA'
    country.create :id => 321022, :name => "Lélouma", :abbreviation => 'LE'
    country.create :id => 321023, :name => "Lola", :abbreviation => 'LO'
    country.create :id => 321024, :name => "Macenta", :abbreviation => 'MC'
    country.create :id => 321025, :name => "Mali", :abbreviation => 'ML'
    country.create :id => 321026, :name => "Mamou", :abbreviation => 'MM'
    country.create :id => 321027, :name => "Mandiana", :abbreviation => 'MD'
    country.create :id => 321028, :name => "Nzérékoré", :abbreviation => 'NZ'
    country.create :id => 321029, :name => "Pita", :abbreviation => 'PI'
    country.create :id => 321030, :name => "Siguiri", :abbreviation => 'SI'
    country.create :id => 321031, :name => "Télimélé", :abbreviation => 'TE'
    country.create :id => 321032, :name => "Tougué", :abbreviation => 'TO'
    country.create :id => 321033, :name => "Yomou", :abbreviation => 'YO'
  end
  
  # Equatorial Guinea
  with_options(:country => Country['GQ']) do |country|
    country.create :id => 226001, :name => "Región Continental", :abbreviation => 'C'
    country.create :id => 226002, :name => "Región Insular", :abbreviation => 'I'
    country.create :id => 226003, :name => "Annobón", :abbreviation => 'AN'
    country.create :id => 226004, :name => "Bioko Norte", :abbreviation => 'BN'
    country.create :id => 226005, :name => "Bioko Sur", :abbreviation => 'BS'
    country.create :id => 226006, :name => "Centro Sur", :abbreviation => 'CS'
    country.create :id => 226007, :name => "Kié-Ntem", :abbreviation => 'KN'
    country.create :id => 226008, :name => "Litoral", :abbreviation => 'LI'
    country.create :id => 226009, :name => "Wele-Nzás", :abbreviation => 'WN'
  end
  
  # Greece
  with_options(:country => Country['GR']) do |country|
    country.create :id => 300001, :name => "Aitoloakarnanías"
    country.create :id => 300003, :name => "Voiotías"
    country.create :id => 300004, :name => "Évvoias"
    country.create :id => 300005, :name => "Evrytanías"
    country.create :id => 300006, :name => "Fthiótidas"
    country.create :id => 300007, :name => "Fokídas"
    country.create :id => 300011, :name => "Argolídas"
    country.create :id => 300012, :name => "Arkadías"
    country.create :id => 300013, :name => "Achaḯas"
    country.create :id => 300014, :name => "Ileías"
    country.create :id => 300015, :name => "Korinthías"
    country.create :id => 300016, :name => "Lakonías"
    country.create :id => 300017, :name => "Messinías"
    country.create :id => 300021, :name => "Zakýnthoy"
    country.create :id => 300022, :name => "Kérkyras"
    country.create :id => 300023, :name => "Kefaloniás kai Ithákis"
    country.create :id => 300024, :name => "Lefkádas"
    country.create :id => 300031, :name => "Ártas"
    country.create :id => 300032, :name => "Thesprotías"
    country.create :id => 300033, :name => "Ioannínon"
    country.create :id => 300034, :name => "Prévezas"
    country.create :id => 300041, :name => "Kardítsas"
    country.create :id => 300042, :name => "Lárissas"
    country.create :id => 300043, :name => "Magnisías"
    country.create :id => 300044, :name => "Trikálon"
    country.create :id => 300051, :name => "Grevenón"
    country.create :id => 300052, :name => "Drámas"
    country.create :id => 300053, :name => "Imathías"
    country.create :id => 300054, :name => "Thessaloníkis"
    country.create :id => 300055, :name => "Kaválas"
    country.create :id => 300056, :name => "Kastoriás"
    country.create :id => 300057, :name => "Kilkís"
    country.create :id => 300058, :name => "Kozánis"
    country.create :id => 300059, :name => "Péllas"
    country.create :id => 300061, :name => "Pierías"
    country.create :id => 300062, :name => "Serrón"
    country.create :id => 300063, :name => "Flórinas"
    country.create :id => 300064, :name => "Chalkidikís"
    country.create :id => 300069, :name => "Ágion Óros"
    country.create :id => 300071, :name => "Évroy"
    country.create :id => 300072, :name => "Xánthis"
    country.create :id => 300073, :name => "Rodópis"
    country.create :id => 300081, :name => "Dodekanísoy"
    country.create :id => 300082, :name => "Kykládon"
    country.create :id => 300083, :name => "Lésboy"
    country.create :id => 300084, :name => "Sámoy"
    country.create :id => 300085, :name => "Chíoy"
    country.create :id => 300091, :name => "Irakleíoy"
    country.create :id => 300092, :name => "Lasithíoy"
    country.create :id => 300093, :name => "Rethýmnoy"
    country.create :id => 300094, :name => "Chaníon"
    
    # Non-numeric
    country.create :id => 300101, :name => "Athinón", :abbreviation => 'A1'
    country.create :id => 300102, :name => "Anatolikís Attikís", :abbreviation => 'A2'
    country.create :id => 300103, :name => "Peiraiós", :abbreviation => 'A3'
    country.create :id => 300104, :name => "Dytikís Attikís", :abbreviation => 'A4'
  end
  
  # Guatemala
  with_options(:country => Country['GT']) do |country|
    country.create :id => 320001, :name => "Alta Verapaz", :abbreviation => 'AV'
    country.create :id => 320002, :name => "Baja Verapaz", :abbreviation => 'BV'
    country.create :id => 320003, :name => "Chimaltenango", :abbreviation => 'CM'
    country.create :id => 320004, :name => "Chiquimula", :abbreviation => 'CQ'
    country.create :id => 320005, :name => "El Progreso", :abbreviation => 'PR'
    country.create :id => 320006, :name => "Escuintla", :abbreviation => 'ES'
    country.create :id => 320007, :name => "Guatemala", :abbreviation => 'GU'
    country.create :id => 320008, :name => "Huehuetenango", :abbreviation => 'HU'
    country.create :id => 320009, :name => "Izabal", :abbreviation => 'IZ'
    country.create :id => 320010, :name => "Jalapa", :abbreviation => 'JA'
    country.create :id => 320011, :name => "Jutiapa", :abbreviation => 'JU'
    country.create :id => 320012, :name => "Petén", :abbreviation => 'PE'
    country.create :id => 320013, :name => "Quetzaltenango", :abbreviation => 'QZ'
    country.create :id => 320014, :name => "Quiché", :abbreviation => 'QC'
    country.create :id => 320015, :name => "Retalhuleu", :abbreviation => 'RE'
    country.create :id => 320016, :name => "Sacatepéquez", :abbreviation => 'SA'
    country.create :id => 320017, :name => "San Marcos", :abbreviation => 'SM'
    country.create :id => 320018, :name => "Santa Rosa", :abbreviation => 'SR'
    country.create :id => 320019, :name => "Sololá", :abbreviation => 'SO'
    country.create :id => 320020, :name => "Suchitepéquez", :abbreviation => 'SU'
    country.create :id => 320021, :name => "Totonicapán", :abbreviation => 'TO'
    country.create :id => 320022, :name => "Zacapa", :abbreviation => 'ZA'
  end
  
  # Guinea-Bissau
  with_options(:country => Country['GW']) do |country|
    country.create :id => 624001, :name => "Bafatá", :abbreviation => 'BA'
    country.create :id => 624002, :name => "Biombo", :abbreviation => 'BM'
    country.create :id => 624003, :name => "Bolama", :abbreviation => 'BL'
    country.create :id => 624004, :name => "Cacheu", :abbreviation => 'CA'
    country.create :id => 624005, :name => "Gabú", :abbreviation => 'GA'
    country.create :id => 624006, :name => "Oio", :abbreviation => 'OI'
    country.create :id => 624007, :name => "Quinara", :abbreviation => 'QU'
    country.create :id => 624008, :name => "Tombali", :abbreviation => 'TO'
    country.create :id => 624009, :name => "Bissau", :abbreviation => 'BS'
  end
  
  # Guyana
  with_options(:country => Country['GY']) do |country|
    country.create :id => 328001, :name => "Barima-Waini", :abbreviation => 'BA'
    country.create :id => 328002, :name => "Cuyuni-Mazaruni", :abbreviation => 'CU'
    country.create :id => 328003, :name => "Demerara-Mahaica", :abbreviation => 'DE'
    country.create :id => 328004, :name => "East Berbice-Corentyne", :abbreviation => 'EB'
    country.create :id => 328005, :name => "Essequibo Islands-West Demerara", :abbreviation => 'ES'
    country.create :id => 328006, :name => "Mahaica-Berbice", :abbreviation => 'MA'
    country.create :id => 328007, :name => "Pomeroon-Supenaam", :abbreviation => 'PM'
    country.create :id => 328008, :name => "Potaro-Siparuni", :abbreviation => 'PT'
    country.create :id => 328009, :name => "Upper Demerara-Berbice", :abbreviation => 'UD'
    country.create :id => 328010, :name => "Upper Takutu-Upper Essequibo", :abbreviation => 'UT'
  end
  
  # Honduras
  with_options(:country => Country['HN']) do |country|
    country.create :id => 340001, :name => "Atlántida", :abbreviation => 'AT'
    country.create :id => 340002, :name => "Colón", :abbreviation => 'CL'
    country.create :id => 340003, :name => "Comayagua", :abbreviation => 'CM'
    country.create :id => 340004, :name => "Copán", :abbreviation => 'CP'
    country.create :id => 340005, :name => "Cortés", :abbreviation => 'CR'
    country.create :id => 340006, :name => "Choluteca", :abbreviation => 'CH'
    country.create :id => 340007, :name => "El Paraíso", :abbreviation => 'EP'
    country.create :id => 340008, :name => "Francisco Morazán", :abbreviation => 'FM'
    country.create :id => 340009, :name => "Gracias a Dios", :abbreviation => 'GD'
    country.create :id => 340010, :name => "Intibucá", :abbreviation => 'IN'
    country.create :id => 340011, :name => "Islas de la Bahía", :abbreviation => 'IB'
    country.create :id => 340012, :name => "La Paz", :abbreviation => 'LP'
    country.create :id => 340013, :name => "Lempira", :abbreviation => 'LE'
    country.create :id => 340014, :name => "Ocotepeque", :abbreviation => 'OC'
    country.create :id => 340015, :name => "Olancho", :abbreviation => 'OL'
    country.create :id => 340016, :name => "Santa Bárbara", :abbreviation => 'SB'
    country.create :id => 340017, :name => "Valle", :abbreviation => 'VA'
    country.create :id => 340018, :name => "Yoro", :abbreviation => 'YO'
  end
  
  # Croatia
  with_options(:country => Country['HR']) do |country|
    country.create :id => 191001, :name => "Zagrebačka županija"
    country.create :id => 191002, :name => "Krapinsko-zagorska županija"
    country.create :id => 191003, :name => "Sisačko-moslavačka županija"
    country.create :id => 191004, :name => "Karlovačka županija"
    country.create :id => 191005, :name => "Varaždinska županija"
    country.create :id => 191006, :name => "Koprivničko-križevačka županija"
    country.create :id => 191007, :name => "Bjelovarsko-bilogorska županija"
    country.create :id => 191008, :name => "Primorsko-goranska županija"
    country.create :id => 191009, :name => "Ličko-senjska županija"
    country.create :id => 191010, :name => "Virovitičko-podravska županija"
    country.create :id => 191011, :name => "Požeško-slavonska županija"
    country.create :id => 191012, :name => "Brodsko-posavska županija"
    country.create :id => 191013, :name => "Zadarska županija"
    country.create :id => 191014, :name => "Osječko-baranjska županija"
    country.create :id => 191015, :name => "Šibensko-kninska županija"
    country.create :id => 191016, :name => "Vukovarsko-srijemska županija"
    country.create :id => 191017, :name => "Splitsko-dalmatinska županija"
    country.create :id => 191018, :name => "Istarska županija"
    country.create :id => 191019, :name => "Dubrovačko-neretvanska županija"
    country.create :id => 191020, :name => "Međimurska županija"
    country.create :id => 191021, :name => "Grad Zagreb"
  end
  
  # Haiti
  with_options(:country => Country['HT']) do |country|
    country.create :id => 332001, :name => "Artibonite", :abbreviation => 'AR'
    country.create :id => 332002, :name => "Centre", :abbreviation => 'CE'
    country.create :id => 332003, :name => "Grande-Anse", :abbreviation => 'GA'
    country.create :id => 332004, :name => "Nord", :abbreviation => 'ND'
    country.create :id => 332005, :name => "Nord-Est", :abbreviation => 'NE'
    country.create :id => 332006, :name => "Nord-Ouest", :abbreviation => 'NO'
    country.create :id => 332007, :name => "Ouest", :abbreviation => 'OU'
    country.create :id => 332008, :name => "Sud", :abbreviation => 'SD'
    country.create :id => 332009, :name => "Sud-Est", :abbreviation => 'SE'
  end
  
  # Hungary
  with_options(:country => Country['HU']) do |country|
    country.create :id => 348001, :name => "Bács-Kiskun", :abbreviation => 'BK'
    country.create :id => 348002, :name => "Baranya", :abbreviation => 'BA'
    country.create :id => 348003, :name => "Békés", :abbreviation => 'BE'
    country.create :id => 348004, :name => "Borsod-Abaúj-Zemplén", :abbreviation => 'BZ'
    country.create :id => 348005, :name => "Csongrád", :abbreviation => 'CS'
    country.create :id => 348006, :name => "Fejér", :abbreviation => 'FE'
    country.create :id => 348007, :name => "Győr-Moson-Sopron", :abbreviation => 'GS'
    country.create :id => 348008, :name => "Hajdú-Bihar", :abbreviation => 'HB'
    country.create :id => 348009, :name => "Heves", :abbreviation => 'HE'
    country.create :id => 348010, :name => "Jász-Nagykun-Szolnok", :abbreviation => 'JN'
    country.create :id => 348011, :name => "Komárom-Esztergom", :abbreviation => 'KE'
    country.create :id => 348012, :name => "Nógrád", :abbreviation => 'NO'
    country.create :id => 348013, :name => "Pest", :abbreviation => 'PE'
    country.create :id => 348014, :name => "Somogy", :abbreviation => 'SO'
    country.create :id => 348015, :name => "Szabolcs-Szatmár-Bereg", :abbreviation => 'SZ'
    country.create :id => 348016, :name => "Tolna", :abbreviation => 'TO'
    country.create :id => 348017, :name => "Vas", :abbreviation => 'VA'
    country.create :id => 348018, :name => "Veszprém (county)", :abbreviation => 'VE'
    country.create :id => 348019, :name => "Zala", :abbreviation => 'ZA'
    country.create :id => 348020, :name => "Békéscsaba", :abbreviation => 'BC'
    country.create :id => 348021, :name => "Debrecen", :abbreviation => 'DE'
    country.create :id => 348022, :name => "Dunaújváros", :abbreviation => 'DU'
    country.create :id => 348023, :name => "Eger", :abbreviation => 'EG'
    country.create :id => 348024, :name => "Győr", :abbreviation => 'GY'
    country.create :id => 348025, :name => "Hódmezővásárhely", :abbreviation => 'HV'
    country.create :id => 348026, :name => "Kaposvár", :abbreviation => 'KV'
    country.create :id => 348027, :name => "Kecskemét", :abbreviation => 'KM'
    country.create :id => 348028, :name => "Miskolc", :abbreviation => 'MI'
    country.create :id => 348029, :name => "Nagykanizsa", :abbreviation => 'NK'
    country.create :id => 348030, :name => "Nyíregyháza", :abbreviation => 'NY'
    country.create :id => 348031, :name => "Pécs", :abbreviation => 'PS'
    country.create :id => 348032, :name => "Salgótarján", :abbreviation => 'ST'
    country.create :id => 348033, :name => "Sopron", :abbreviation => 'SN'
    country.create :id => 348034, :name => "Szeged", :abbreviation => 'SD'
    country.create :id => 348035, :name => "Székesfehérvár", :abbreviation => 'SF'
    country.create :id => 348036, :name => "Szekszárd", :abbreviation => 'SS'
    country.create :id => 348037, :name => "Szolnok", :abbreviation => 'SK'
    country.create :id => 348038, :name => "Szombathely", :abbreviation => 'SH'
    country.create :id => 348039, :name => "Tatabánya", :abbreviation => 'TB'
    country.create :id => 348040, :name => "Veszprém", :abbreviation => 'VM'
    country.create :id => 348041, :name => "Zalaegerszeg", :abbreviation => 'ZE'
    country.create :id => 348042, :name => "Budapest", :abbreviation => 'BU'
  end
  
  # Indonesia
  with_options(:country => Country['ID']) do |country|
    country.create :id => 360001, :name => "Aceh", :abbreviation => 'AC'
    country.create :id => 360002, :name => "Bali", :abbreviation => 'BA'
    country.create :id => 360003, :name => "Bangka Belitung", :abbreviation => 'BB'
    country.create :id => 360004, :name => "Banten", :abbreviation => 'BT'
    country.create :id => 360005, :name => "Bengkulu", :abbreviation => 'BE'
    country.create :id => 360006, :name => "Gorontalo", :abbreviation => 'GO'
    country.create :id => 360007, :name => "Jambi", :abbreviation => 'JA'
    country.create :id => 360008, :name => "Jawa Barat", :abbreviation => 'JB'
    country.create :id => 360009, :name => "Jawa Tengah", :abbreviation => 'JT'
    country.create :id => 360010, :name => "Jawa Timur", :abbreviation => 'JI'
    country.create :id => 360011, :name => "Kalimantan Barat", :abbreviation => 'KB'
    country.create :id => 360012, :name => "Kalimantan Tengah", :abbreviation => 'KT'
    country.create :id => 360013, :name => "Kalimantan Selatan", :abbreviation => 'KS'
    country.create :id => 360014, :name => "Kalimantan Timur", :abbreviation => 'KI'
    country.create :id => 360015, :name => "Kepulauan Riau", :abbreviation => 'KR'
    country.create :id => 360016, :name => "Lampung", :abbreviation => 'LA'
    country.create :id => 360017, :name => "Maluku", :abbreviation => 'MA'
    country.create :id => 360018, :name => "Maluku Utara", :abbreviation => 'MU'
    country.create :id => 360019, :name => "Nusa Tenggara Barat", :abbreviation => 'NB'
    country.create :id => 360020, :name => "Nusa Tenggara Timur", :abbreviation => 'NT'
    country.create :id => 360021, :name => "Papua", :abbreviation => 'PA'
    country.create :id => 360022, :name => "Riau", :abbreviation => 'RI'
    country.create :id => 360023, :name => "Sulawesi Barat", :abbreviation => 'SR'
    country.create :id => 360024, :name => "Sulawesi Selatan", :abbreviation => 'SN'
    country.create :id => 360025, :name => "Sulawesi Tengah", :abbreviation => 'ST'
    country.create :id => 360026, :name => "Sulawesi Tenggara", :abbreviation => 'SG'
    country.create :id => 360027, :name => "Sulawesi Utara", :abbreviation => 'SA'
    country.create :id => 360028, :name => "Sumatra Barat", :abbreviation => 'SB'
    country.create :id => 360029, :name => "Sumatra Selatan", :abbreviation => 'SS'
    country.create :id => 360030, :name => "Sumatera Utara", :abbreviation => 'SU'
    country.create :id => 360031, :name => "Jakarta Raya", :abbreviation => 'JK'
    country.create :id => 360032, :name => "Yogyakarta", :abbreviation => 'YO'
  end
  
  # Ireland
  with_options(:country => Country['IE']) do |country|
    country.create :id => 372001, :name => "Cork", :abbreviation => 'C'
    country.create :id => 372002, :name => "Clare", :abbreviation => 'CE'
    country.create :id => 372003, :name => "Cavan", :abbreviation => 'CN'
    country.create :id => 372004, :name => "Carlow", :abbreviation => 'CW'
    country.create :id => 372005, :name => "Dublin", :abbreviation => 'D'
    country.create :id => 372006, :name => "Donegal", :abbreviation => 'DL'
    country.create :id => 372007, :name => "Galway", :abbreviation => 'G'
    country.create :id => 372008, :name => "Kildare", :abbreviation => 'KE'
    country.create :id => 372009, :name => "Kilkenny", :abbreviation => 'KK'
    country.create :id => 372010, :name => "Kerry", :abbreviation => 'KY'
    country.create :id => 372011, :name => "Longford", :abbreviation => 'LD'
    country.create :id => 372012, :name => "Louth", :abbreviation => 'LH'
    country.create :id => 372013, :name => "Limerick", :abbreviation => 'LK'
    country.create :id => 372014, :name => "Leitrim", :abbreviation => 'LM'
    country.create :id => 372015, :name => "Laois", :abbreviation => 'LS'
    country.create :id => 372016, :name => "Meath", :abbreviation => 'MH'
    country.create :id => 372017, :name => "Monaghan", :abbreviation => 'MN'
    country.create :id => 372018, :name => "Mayo", :abbreviation => 'MO'
    country.create :id => 372019, :name => "Offaly", :abbreviation => 'OY'
    country.create :id => 372020, :name => "Roscommon", :abbreviation => 'RN'
    country.create :id => 372021, :name => "Sligo", :abbreviation => 'SO'
    country.create :id => 372022, :name => "Tipperary", :abbreviation => 'TA'
    country.create :id => 372023, :name => "Waterford", :abbreviation => 'WD'
    country.create :id => 372024, :name => "Westmeath", :abbreviation => 'WH'
    country.create :id => 372025, :name => "Wicklow", :abbreviation => 'WW'
    country.create :id => 372026, :name => "Wexford", :abbreviation => 'WX'
  end
  
  # Israel
  with_options(:country => Country['IL']) do |country|
    country.create :id => 376001, :name => "HaDarom", :abbreviation => 'D'
    country.create :id => 376002, :name => "HaMerkaz", :abbreviation => 'M'
    country.create :id => 376003, :name => "HaZafon", :abbreviation => 'Z'
    country.create :id => 376004, :name => "Hefa", :abbreviation => 'HA'
    country.create :id => 376005, :name => "Tel-Aviv", :abbreviation => 'TA'
    country.create :id => 376006, :name => "Yerushalayim Al Quds", :abbreviation => 'JM'
  end
  
  # India
  with_options(:country => Country['IN']) do |country|
    country.create :id => 356001, :name => "Andhra Pradesh", :abbreviation => 'AP'
    country.create :id => 356002, :name => "Arunāchal Pradesh", :abbreviation => 'AR'
    country.create :id => 356003, :name => "Assam", :abbreviation => 'AS'
    country.create :id => 356004, :name => "Bihār", :abbreviation => 'BR'
    country.create :id => 356005, :name => "Chhattīsgarh", :abbreviation => 'CT'
    country.create :id => 356006, :name => "Goa", :abbreviation => 'GA'
    country.create :id => 356007, :name => "Gujarāt", :abbreviation => 'GJ'
    country.create :id => 356008, :name => "Haryāna", :abbreviation => 'HR'
    country.create :id => 356009, :name => "Himāchal Pradesh", :abbreviation => 'HP'
    country.create :id => 356010, :name => "Jammu and Kashmīr", :abbreviation => 'JK'
    country.create :id => 356011, :name => "Jharkhand", :abbreviation => 'JH'
    country.create :id => 356012, :name => "Karnātaka", :abbreviation => 'KA'
    country.create :id => 356013, :name => "Kerala", :abbreviation => 'KL'
    country.create :id => 356014, :name => "Madhya Pradesh", :abbreviation => 'MP'
    country.create :id => 356015, :name => "Mahārāshtra", :abbreviation => 'MH'
    country.create :id => 356016, :name => "Manipur", :abbreviation => 'MN'
    country.create :id => 356017, :name => "Meghālaya", :abbreviation => 'ML'
    country.create :id => 356018, :name => "Mizoram", :abbreviation => 'MZ'
    country.create :id => 356019, :name => "Nāgāland", :abbreviation => 'NL'
    country.create :id => 356020, :name => "Orissa", :abbreviation => 'OR'
    country.create :id => 356021, :name => "Punjab", :abbreviation => 'PB'
    country.create :id => 356022, :name => "Rājasthān", :abbreviation => 'RJ'
    country.create :id => 356023, :name => "Sikkim", :abbreviation => 'SK'
    country.create :id => 356024, :name => "Tamil Nādu", :abbreviation => 'TN'
    country.create :id => 356025, :name => "Tripura", :abbreviation => 'TR'
    country.create :id => 356026, :name => "Uttaranchal", :abbreviation => 'UL'
    country.create :id => 356027, :name => "Uttar Pradesh", :abbreviation => 'UP'
    country.create :id => 356028, :name => "West Bengal", :abbreviation => 'WB'
    country.create :id => 356029, :name => "Andaman and Nicobar Islands", :abbreviation => 'AN'
    country.create :id => 356030, :name => "Chandīgarh", :abbreviation => 'CH'
    country.create :id => 356031, :name => "Dādra and Nagar Haveli", :abbreviation => 'DN'
    country.create :id => 356032, :name => "Damān and Diu", :abbreviation => 'DD'
    country.create :id => 356033, :name => "Delhi", :abbreviation => 'DL'
    country.create :id => 356034, :name => "Lakshadweep", :abbreviation => 'LD'
    country.create :id => 356035, :name => "Pondicherry", :abbreviation => 'PY'
  end
  
  # Iraq
  with_options(:country => Country['IQ']) do |country|
    country.create :id => 368001, :name => "Al Anbar", :abbreviation => 'AN'
    country.create :id => 368002, :name => "Al Basrah", :abbreviation => 'BA'
    country.create :id => 368003, :name => "Al Muthanna", :abbreviation => 'MU'
    country.create :id => 368004, :name => "Al Qadisiyah", :abbreviation => 'QA'
    country.create :id => 368005, :name => "An Najef", :abbreviation => 'NA'
    country.create :id => 368006, :name => "Arbil", :abbreviation => 'AR'
    country.create :id => 368007, :name => "As Sulaymaniyah", :abbreviation => 'SW'
    country.create :id => 368008, :name => "At Ta'mim", :abbreviation => 'TS'
    country.create :id => 368009, :name => "Babil", :abbreviation => 'BB'
    country.create :id => 368010, :name => "Baghdad", :abbreviation => 'BG'
    country.create :id => 368011, :name => "Dahuk", :abbreviation => 'DA'
    country.create :id => 368012, :name => "Dhi Qar", :abbreviation => 'DQ'
    country.create :id => 368013, :name => "Diyala", :abbreviation => 'DI'
    country.create :id => 368014, :name => "Karbala'", :abbreviation => 'KA'
    country.create :id => 368015, :name => "Maysan", :abbreviation => 'MA'
    country.create :id => 368016, :name => "Ninawa", :abbreviation => 'NI'
    country.create :id => 368017, :name => "Salah ad Din", :abbreviation => 'SD'
    country.create :id => 368018, :name => "Wasit", :abbreviation => 'WA'
  end
  
  # Iran
  with_options(:country => Country['IR']) do |country|
    country.create :id => 364001, :name => "Āzarbāyjān-e Sharqī"
    country.create :id => 364002, :name => "Āzarbāyjān-e Gharbī"
    country.create :id => 364003, :name => "Ardabīl"
    country.create :id => 364004, :name => "Eşfahān"
    country.create :id => 364005, :name => "Īlām"
    country.create :id => 364006, :name => "Būshehr"
    country.create :id => 364007, :name => "Tehrān"
    country.create :id => 364008, :name => "Chahār Mahāll va Bakhtīārī"
    country.create :id => 364010, :name => "Khūzestān"
    country.create :id => 364011, :name => "Zanjān"
    country.create :id => 364012, :name => "Semnān"
    country.create :id => 364013, :name => "Sīstān va Balūchestān"
    country.create :id => 364014, :name => "Fārs"
    country.create :id => 364015, :name => "Kermān"
    country.create :id => 364016, :name => "Kordestān"
    country.create :id => 364017, :name => "Kermānshāh"
    country.create :id => 364018, :name => "Kohgīlūyeh va Būyer Ahmad"
    country.create :id => 364019, :name => "Gīlān"
    country.create :id => 364020, :name => "Lorestān"
    country.create :id => 364021, :name => "Māzandarān"
    country.create :id => 364022, :name => "Markazī"
    country.create :id => 364023, :name => "Hormozgān"
    country.create :id => 364024, :name => "Hamadān"
    country.create :id => 364025, :name => "Yazd"
    country.create :id => 364026, :name => "Qom"
    country.create :id => 364027, :name => "Golestān"
    country.create :id => 364028, :name => "Qazvīn"
    country.create :id => 364029, :name => "Khorāsān-e Janūbī"
    country.create :id => 364030, :name => "Khorāsān-e Razavī"
    country.create :id => 364031, :name => "Khorāsān-e Shemālī"
  end
  
  # Iceland
  with_options(:country => Country['IS']) do |country|
    country.create :id => 352000, :name => "Reykjavík"
    country.create :id => 352001, :name => "Höfuðborgarsvæðið"
    country.create :id => 352002, :name => "Suðurnes"
    country.create :id => 352003, :name => "Vesturland"
    country.create :id => 352004, :name => "Vestfirðir"
    country.create :id => 352005, :name => "Norðurland vestra"
    country.create :id => 352006, :name => "Norðurland eystra"
    country.create :id => 352007, :name => "Austurland"
    country.create :id => 352008, :name => "Suðurland"
  end
  
  # Italy
  with_options(:country => Country['IT']) do |country|
    country.create :id => 380001, :name => "Agrigento", :abbreviation => 'AG'
    country.create :id => 380002, :name => "Alessandria", :abbreviation => 'AL'
    country.create :id => 380003, :name => "Ancona", :abbreviation => 'AN'
    country.create :id => 380004, :name => "Aosta", :abbreviation => 'AO'
    country.create :id => 380005, :name => "Arezzo", :abbreviation => 'AR'
    country.create :id => 380006, :name => "Ascoli Piceno", :abbreviation => 'AP'
    country.create :id => 380007, :name => "Asti", :abbreviation => 'AT'
    country.create :id => 380008, :name => "Avellino", :abbreviation => 'AV'
    country.create :id => 380009, :name => "Bari", :abbreviation => 'BA'
    country.create :id => 380010, :name => "Belluno", :abbreviation => 'BL'
    country.create :id => 380011, :name => "Benevento", :abbreviation => 'BN'
    country.create :id => 380012, :name => "Bergamo", :abbreviation => 'BG'
    country.create :id => 380013, :name => "Biella", :abbreviation => 'BI'
    country.create :id => 380014, :name => "Bologna", :abbreviation => 'BO'
    country.create :id => 380015, :name => "Bolzano", :abbreviation => 'BZ'
    country.create :id => 380016, :name => "Brescia", :abbreviation => 'BS'
    country.create :id => 380017, :name => "Brindisi", :abbreviation => 'BR'
    country.create :id => 380018, :name => "Cagliari", :abbreviation => 'CA'
    country.create :id => 380019, :name => "Caltanissetta", :abbreviation => 'CL'
    country.create :id => 380020, :name => "Campobasso", :abbreviation => 'CB'
    country.create :id => 380021, :name => "Carbonia-Iglesias", :abbreviation => 'CI'
    country.create :id => 380022, :name => "Caserta", :abbreviation => 'CE'
    country.create :id => 380023, :name => "Catania", :abbreviation => 'CT'
    country.create :id => 380024, :name => "Catanzaro", :abbreviation => 'CZ'
    country.create :id => 380025, :name => "Chieti", :abbreviation => 'CH'
    country.create :id => 380026, :name => "Como", :abbreviation => 'CO'
    country.create :id => 380027, :name => "Cosenza", :abbreviation => 'CS'
    country.create :id => 380028, :name => "Cremona", :abbreviation => 'CR'
    country.create :id => 380029, :name => "Crotone", :abbreviation => 'KR'
    country.create :id => 380030, :name => "Cuneo", :abbreviation => 'CN'
    country.create :id => 380031, :name => "Enna", :abbreviation => 'EN'
    country.create :id => 380032, :name => "Ferrara", :abbreviation => 'FE'
    country.create :id => 380033, :name => "Firenze", :abbreviation => 'FI'
    country.create :id => 380034, :name => "Foggia", :abbreviation => 'FG'
    country.create :id => 380035, :name => "Forlì", :abbreviation => 'FO'
    country.create :id => 380036, :name => "Frosinone", :abbreviation => 'FR'
    country.create :id => 380037, :name => "Genova", :abbreviation => 'GE'
    country.create :id => 380038, :name => "Gorizia", :abbreviation => 'GO'
    country.create :id => 380039, :name => "Grosseto", :abbreviation => 'GR'
    country.create :id => 380040, :name => "Imperia", :abbreviation => 'IM'
    country.create :id => 380041, :name => "Isernia", :abbreviation => 'IS'
    country.create :id => 380042, :name => "La Spezia", :abbreviation => 'SP'
    country.create :id => 380043, :name => "L'Aquila", :abbreviation => 'AQ'
    country.create :id => 380044, :name => "Latina", :abbreviation => 'LT'
    country.create :id => 380045, :name => "Lecce", :abbreviation => 'LE'
    country.create :id => 380046, :name => "Lecco", :abbreviation => 'LC'
    country.create :id => 380047, :name => "Livorno", :abbreviation => 'LI'
    country.create :id => 380048, :name => "Lodi", :abbreviation => 'LO'
    country.create :id => 380049, :name => "Lucca", :abbreviation => 'LU'
    country.create :id => 380050, :name => "Macerata", :abbreviation => 'SC'
    country.create :id => 380051, :name => "Mantova", :abbreviation => 'MN'
    country.create :id => 380052, :name => "Massa-Carrara", :abbreviation => 'MS'
    country.create :id => 380053, :name => "Matera", :abbreviation => 'MT'
    country.create :id => 380054, :name => "Medio Campidano", :abbreviation => 'VS'
    country.create :id => 380055, :name => "Messina", :abbreviation => 'ME'
    country.create :id => 380056, :name => "Milano", :abbreviation => 'MI'
    country.create :id => 380057, :name => "Modena", :abbreviation => 'MO'
    country.create :id => 380058, :name => "Napoli", :abbreviation => 'NA'
    country.create :id => 380059, :name => "Novara", :abbreviation => 'NO'
    country.create :id => 380060, :name => "Nuoro", :abbreviation => 'NU'
    country.create :id => 380061, :name => "Ogliastra", :abbreviation => 'OG'
    country.create :id => 380062, :name => "Olbia-Tempio", :abbreviation => 'OT'
    country.create :id => 380063, :name => "Oristano", :abbreviation => 'OR'
    country.create :id => 380064, :name => "Padova", :abbreviation => 'PD'
    country.create :id => 380065, :name => "Palermo", :abbreviation => 'PA'
    country.create :id => 380066, :name => "Parma", :abbreviation => 'PR'
    country.create :id => 380067, :name => "Pavia", :abbreviation => 'PV'
    country.create :id => 380068, :name => "Perugia", :abbreviation => 'PG'
    country.create :id => 380069, :name => "Pesaro e Urbino", :abbreviation => 'PS'
    country.create :id => 380070, :name => "Pescara", :abbreviation => 'PE'
    country.create :id => 380071, :name => "Piacenza", :abbreviation => 'PC'
    country.create :id => 380072, :name => "Pisa", :abbreviation => 'PI'
    country.create :id => 380073, :name => "Pistoia", :abbreviation => 'PT'
    country.create :id => 380074, :name => "Pordenone", :abbreviation => 'PN'
    country.create :id => 380075, :name => "Potenza", :abbreviation => 'PZ'
    country.create :id => 380076, :name => "Prato", :abbreviation => 'PO'
    country.create :id => 380077, :name => "Ragusa", :abbreviation => 'RG'
    country.create :id => 380078, :name => "Ravenna", :abbreviation => 'RA'
    country.create :id => 380079, :name => "Reggio Calabria", :abbreviation => 'RC'
    country.create :id => 380080, :name => "Reggio Emilia", :abbreviation => 'RE'
    country.create :id => 380081, :name => "Rieti", :abbreviation => 'RI'
    country.create :id => 380082, :name => "Rimini", :abbreviation => 'RN'
    country.create :id => 380083, :name => "Roma", :abbreviation => 'RM'
    country.create :id => 380084, :name => "Rovigo", :abbreviation => 'RO'
    country.create :id => 380085, :name => "Salerno", :abbreviation => 'SA'
    country.create :id => 380086, :name => "Sassari", :abbreviation => 'SS'
    country.create :id => 380087, :name => "Savona", :abbreviation => 'SV'
    country.create :id => 380088, :name => "Siena", :abbreviation => 'SI'
    country.create :id => 380089, :name => "Siracusa", :abbreviation => 'SR'
    country.create :id => 380090, :name => "Sondrio", :abbreviation => 'SO'
    country.create :id => 380091, :name => "Taranto", :abbreviation => 'TA'
    country.create :id => 380092, :name => "Teramo", :abbreviation => 'TE'
    country.create :id => 380093, :name => "Terni", :abbreviation => 'TR'
    country.create :id => 380094, :name => "Torino", :abbreviation => 'TO'
    country.create :id => 380095, :name => "Trapani", :abbreviation => 'TP'
    country.create :id => 380096, :name => "Trento", :abbreviation => 'TN'
    country.create :id => 380097, :name => "Treviso", :abbreviation => 'TV'
    country.create :id => 380098, :name => "Trieste", :abbreviation => 'TS'
    country.create :id => 380099, :name => "Udine", :abbreviation => 'UD'
    country.create :id => 380100, :name => "Varese", :abbreviation => 'VA'
    country.create :id => 380101, :name => "Venezia", :abbreviation => 'VE'
    country.create :id => 380102, :name => "Verbano-Cusio-Ossola", :abbreviation => 'VB'
    country.create :id => 380103, :name => "Vercelli", :abbreviation => 'VC'
    country.create :id => 380104, :name => "Verona", :abbreviation => 'VR'
    country.create :id => 380105, :name => "Vibo Valentia", :abbreviation => 'VV'
    country.create :id => 380106, :name => "Vicenza", :abbreviation => 'VI'
    country.create :id => 380107, :name => "Viterbo", :abbreviation => 'VT'
  end
  
  # Jamaica
  with_options(:country => Country['JM']) do |country|
    country.create :id => 388001, :name => "Kingston"
    country.create :id => 388002, :name => "Saint Andrew"
    country.create :id => 388003, :name => "Saint Thomas"
    country.create :id => 388004, :name => "Portland"
    country.create :id => 388005, :name => "Saint Mary"
    country.create :id => 388006, :name => "Saint Ann"
    country.create :id => 388007, :name => "Trelawny"
    country.create :id => 388008, :name => "Saint James"
    country.create :id => 388009, :name => "Hanover"
    country.create :id => 388010, :name => "Westmoreland"
    country.create :id => 388011, :name => "Saint Elizabeth"
    country.create :id => 388012, :name => "Manchester"
    country.create :id => 388013, :name => "Clarendon"
    country.create :id => 388014, :name => "Saint Catherine"
  end
  
  # Jordan
  with_options(:country => Country['JO']) do |country|
    country.create :id => 400001, :name => "`Ajlun", :abbreviation => 'AJ'
    country.create :id => 400002, :name => "Al `Aqabah", :abbreviation => 'AQ'
    country.create :id => 400003, :name => "Al Balqā'", :abbreviation => 'BA'
    country.create :id => 400004, :name => "Al Karak", :abbreviation => 'KA'
    country.create :id => 400005, :name => "Al Mafraq", :abbreviation => 'MA'
    country.create :id => 400006, :name => "Amman", :abbreviation => 'AM'
    country.create :id => 400007, :name => "Aţ Ţafīlah", :abbreviation => 'AT'
    country.create :id => 400008, :name => "Az Zarqā'", :abbreviation => 'AZ'
    country.create :id => 400009, :name => "Irbid", :abbreviation => 'JR'
    country.create :id => 400010, :name => "Jarash", :abbreviation => 'JA'
    country.create :id => 400011, :name => "Ma`ān", :abbreviation => 'MN'
    country.create :id => 400012, :name => "Mādabā", :abbreviation => 'MD'
  end
  
  # Japan
  with_options(:country => Country['JP']) do |country|
    country.create :id => 392001, :name => "Hokkaido"
    country.create :id => 392002, :name => "Aomori"
    country.create :id => 392003, :name => "Iwate"
    country.create :id => 392004, :name => "Miyagi"
    country.create :id => 392005, :name => "Akita"
    country.create :id => 392006, :name => "Yamagata"
    country.create :id => 392007, :name => "Fukushima"
    country.create :id => 392008, :name => "Ibaraki"
    country.create :id => 392009, :name => "Tochigi"
    country.create :id => 392010, :name => "Gunma"
    country.create :id => 392011, :name => "Saitama"
    country.create :id => 392012, :name => "Chiba"
    country.create :id => 392013, :name => "Tokyo"
    country.create :id => 392014, :name => "Kanagawa"
    country.create :id => 392015, :name => "Niigata"
    country.create :id => 392016, :name => "Toyama"
    country.create :id => 392017, :name => "Ishikawa"
    country.create :id => 392018, :name => "Fukui"
    country.create :id => 392019, :name => "Yamanashi"
    country.create :id => 392020, :name => "Nagano"
    country.create :id => 392021, :name => "Gifu"
    country.create :id => 392022, :name => "Shizuoka"
    country.create :id => 392023, :name => "Aichi"
    country.create :id => 392024, :name => "Mie"
    country.create :id => 392025, :name => "Shiga"
    country.create :id => 392026, :name => "Kyoto"
    country.create :id => 392027, :name => "Osaka"
    country.create :id => 392028, :name => "Hyogo"
    country.create :id => 392029, :name => "Nara"
    country.create :id => 392030, :name => "Wakayama"
    country.create :id => 392031, :name => "Tottori"
    country.create :id => 392032, :name => "Shimane"
    country.create :id => 392033, :name => "Okayama"
    country.create :id => 392034, :name => "Hiroshima"
    country.create :id => 392035, :name => "Yamaguchi"
    country.create :id => 392036, :name => "Tokushima"
    country.create :id => 392037, :name => "Kagawa"
    country.create :id => 392038, :name => "Ehime"
    country.create :id => 392039, :name => "Kochi"
    country.create :id => 392040, :name => "Fukuoka"
    country.create :id => 392041, :name => "Saga"
    country.create :id => 392042, :name => "Nagasaki"
    country.create :id => 392043, :name => "Kumamoto"
    country.create :id => 392044, :name => "Oita"
    country.create :id => 392045, :name => "Miyazaki"
    country.create :id => 392046, :name => "Kagoshima"
    country.create :id => 392047, :name => "Okinawa"
  end
  
  # Kenya
  with_options(:country => Country['KE']) do |country|
    country.create :id => 404110, :name => "Nairobi Municipality"
    country.create :id => 404200, :name => "Central"
    country.create :id => 404300, :name => "Coast"
    country.create :id => 404400, :name => "Eastern"
    country.create :id => 404500, :name => "North-Eastern Kaskazini Mashariki"
    country.create :id => 404700, :name => "Rift Valley"
    country.create :id => 404900, :name => "Western Magharibi"
  end
  
  # Kyrgyzstan
  with_options(:country => Country['KG']) do |country|
    country.create :id => 417001, :name => "Bishkek", :abbreviation => 'GB'
    country.create :id => 417002, :name => "Batken", :abbreviation => 'B'
    country.create :id => 417003, :name => "Chü", :abbreviation => 'C'
    country.create :id => 417004, :name => "Jalal-Abad", :abbreviation => 'J'
    country.create :id => 417005, :name => "Naryn", :abbreviation => 'N'
    country.create :id => 417006, :name => "Osh", :abbreviation => 'O'
    country.create :id => 417007, :name => "Talas", :abbreviation => 'T'
    country.create :id => 417008, :name => "Ysyk-Köl", :abbreviation => 'Y'
  end
  
  # Cambodia
  with_options(:country => Country['KH']) do |country|
    country.create :id => 116001, :name => "Banteay Mean Chey"
    country.create :id => 116002, :name => "Battambang"
    country.create :id => 116003, :name => "Kampong Cham"
    country.create :id => 116004, :name => "Kampong Chhnang"
    country.create :id => 116005, :name => "Kampong Speu"
    country.create :id => 116006, :name => "Kampong Thom"
    country.create :id => 116007, :name => "Kampot"
    country.create :id => 116008, :name => "Kandal"
    country.create :id => 116009, :name => "Kach Kong"
    country.create :id => 116010, :name => "Krachoh"
    country.create :id => 116011, :name => "Mondol Kiri"
    country.create :id => 116012, :name => "Phnom Penh"
    country.create :id => 116013, :name => "Preah Vihear"
    country.create :id => 116014, :name => "Prey Veaeng"
    country.create :id => 116015, :name => "Pousaat"
    country.create :id => 116016, :name => "Rotanak Kiri"
    country.create :id => 116017, :name => "Siem Reab"
    country.create :id => 116018, :name => "Krong Preah Sihanouk"
    country.create :id => 116019, :name => "Stueng Traeng"
    country.create :id => 116020, :name => "Svaay Rieng"
    country.create :id => 116021, :name => "Taakaev"
    country.create :id => 116022, :name => "Otdar Mean Chey"
    country.create :id => 116023, :name => "Krong Kaeb"
    country.create :id => 116024, :name => "Krong Pailin"
  end
  
  # Kiribati
  with_options(:country => Country['KI']) do |country|
    country.create :id => 296001, :name => "Gilbert Islands", :abbreviation => 'G'
    country.create :id => 296002, :name => "Line Islands", :abbreviation => 'L'
    country.create :id => 296003, :name => "Phoenix Islands", :abbreviation => 'P'
  end
  
  # St. Kitts and Nevis
  with_options(:country => Country['KN']) do |country|
    country.create :id => 659001, :name => "Christ Church Nichola Town"
    country.create :id => 659002, :name => "Saint Anne Sandy Point"
    country.create :id => 659003, :name => "Saint George Basseterre"
    country.create :id => 659004, :name => "Saint George Gingerland"
    country.create :id => 659005, :name => "Saint James Windward"
    country.create :id => 659006, :name => "Saint John Capisterre"
    country.create :id => 659007, :name => "Saint John Figtree"
    country.create :id => 659008, :name => "Saint Mary Cayon"
    country.create :id => 659009, :name => "Saint Paul Capisterre"
    country.create :id => 659010, :name => "Saint Paul Charlestown"
    country.create :id => 659011, :name => "Saint Peter Basseterre"
    country.create :id => 659012, :name => "Saint Thomas Lowland"
    country.create :id => 659013, :name => "Saint Thomas Middle Island"
    country.create :id => 659015, :name => "Trinity Palmetto Point"
  end
  
  # Comoros
  with_options(:country => Country['KM']) do |country|
    country.create :id => 174001, :name => "Anjouan Ndzouani", :abbreviation => 'A'
    country.create :id => 174002, :name => "Grande Comore Ngazidja", :abbreviation => 'G'
    country.create :id => 174003, :name => "Mohéli Moili", :abbreviation => 'M'
  end
  
  # North Korea
  with_options(:country => Country['KP']) do |country|
    # Province
    country.create :id => 408001, :name => "Chagang", :abbreviation => 'CHA'
    country.create :id => 408002, :name => "Hamgyongbuk", :abbreviation => 'HAB'
    country.create :id => 408003, :name => "Hamgyongnam", :abbreviation => 'HAN'
    country.create :id => 408004, :name => "Hwanghaebuk", :abbreviation => 'HWB'
    country.create :id => 408005, :name => "Hwanghaenam", :abbreviation => 'HWN'
    country.create :id => 408006, :name => "Kangwon", :abbreviation => 'KAN'
    country.create :id => 408007, :name => "Pyonganbuk", :abbreviation => 'PYB'
    country.create :id => 408008, :name => "Pyongannam", :abbreviation => 'PYN'
    country.create :id => 408009, :name => "Yanggang", :abbreviation => 'YAN'
    country.create :id => 408010, :name => "Kaesong", :abbreviation => 'KAE'
    
    # Special city
    country.create :id => 408011, :name => "Najin Sonbong", :abbreviation => 'NAJ'
    country.create :id => 408012, :name => "Nampo", :abbreviation => 'NAM'
    country.create :id => 408013, :name => "Pyongyang", :abbreviation => 'PYO'
  end
  
  # South Korea
  with_options(:country => Country['KR']) do |country|
    # Capital Metropolitan City
    country.create :id => 410011, :name => "Seoul Teugbyeolsi"
    
    # Metropolitan Cities
    country.create :id => 410026, :name => "Busan Gwang'yeogsi"
    country.create :id => 410027, :name => "Daegu Gwang'yeogsi"
    country.create :id => 410028, :name => "Incheon Gwang'yeogsi"
    country.create :id => 410029, :name => "Gwangju Gwang'yeogsi"
    country.create :id => 410030, :name => "Daejeon Gwang'yeogsi"
    country.create :id => 410031, :name => "Ulsan Gwang'yeogsi"
    country.create :id => 410041, :name => "Gyeonggido"
    country.create :id => 410042, :name => "Gang'weondo"
    
    # Province
    country.create :id => 410043, :name => "Chungcheongbukdo"
    country.create :id => 410044, :name => "Chungcheongnamdo"
    country.create :id => 410045, :name => "Jeonrabukdo"
    country.create :id => 410046, :name => "Jeonranamdo"
    country.create :id => 410047, :name => "Gyeongsangbukdo"
    country.create :id => 410048, :name => "Gyeongsangnamdo"
    country.create :id => 410049, :name => "Jejudo"
  end
  
  # Kuwait
  with_options(:country => Country['KW']) do |country|
    country.create :id => 414001, :name => "Al Ahmadi", :abbreviation => 'AH'
    country.create :id => 414002, :name => "Al Farwānīyah", :abbreviation => 'FA'
    country.create :id => 414003, :name => "Al Jahrah", :abbreviation => 'JA'
    country.create :id => 414004, :name => "Al Kuwayt", :abbreviation => 'KU'
    country.create :id => 414005, :name => "Hawallī", :abbreviation => 'HA'
  end
  
  # Kazakhstan
  with_options(:country => Country['KZ']) do |country|
    country.create :id => 398001, :name => "Almaty", :abbreviation => 'ALA'
    country.create :id => 398002, :name => "Astana", :abbreviation => 'AST'
    country.create :id => 398003, :name => "Almaty", :abbreviation => 'ALM'
    country.create :id => 398004, :name => "Aqmola", :abbreviation => 'AKM'
    country.create :id => 398005, :name => "Aqtöbe", :abbreviation => 'AKT'
    country.create :id => 398006, :name => "Atyraū", :abbreviation => 'ATY'
    country.create :id => 398007, :name => "Batys Quzaqstan", :abbreviation => 'ZAP'
    country.create :id => 398008, :name => "Mangghystaū", :abbreviation => 'MAN'
    country.create :id => 398009, :name => "Ongtüstik Qazaqstan", :abbreviation => 'YUZ'
    country.create :id => 398010, :name => "Pavlodar", :abbreviation => 'PAV'
    country.create :id => 398011, :name => "Qaraghandy", :abbreviation => 'KAR'
    country.create :id => 398012, :name => "Qostanay", :abbreviation => 'KUS'
    country.create :id => 398013, :name => "Qyzylorda", :abbreviation => 'KZY'
    country.create :id => 398014, :name => "Shyghys Qazaqstan", :abbreviation => 'VOS'
    country.create :id => 398015, :name => "Soltüstik Quzaqstan", :abbreviation => 'SEV'
    country.create :id => 398016, :name => "Zhambyl", :abbreviation => 'ZHA'
  end
  
  # Laos
  with_options(:country => Country['LA']) do |country|
    # Prefecture
    country.create :id => 418001, :name => "Vientiane", :abbreviation => 'VT'
    
    # Province
    country.create :id => 418002, :name => "Attapu", :abbreviation => 'AT'
    country.create :id => 418003, :name => "Bokèo", :abbreviation => 'BK'
    country.create :id => 418004, :name => "Bolikhamxai", :abbreviation => 'BL'
    country.create :id => 418005, :name => "Champasak", :abbreviation => 'CH'
    country.create :id => 418006, :name => "Houaphan", :abbreviation => 'HO'
    country.create :id => 418007, :name => "Khammouan", :abbreviation => 'KH'
    country.create :id => 418008, :name => "Louang Namtha", :abbreviation => 'LM'
    country.create :id => 418009, :name => "Louangphabang", :abbreviation => 'LP'
    country.create :id => 418010, :name => "Oudômxai", :abbreviation => 'OU'
    country.create :id => 418011, :name => "Phôngsali", :abbreviation => 'PH'
    country.create :id => 418012, :name => "Salavan", :abbreviation => 'SL'
    country.create :id => 418013, :name => "Savannakhét", :abbreviation => 'SV'
    country.create :id => 418014, :name => "Vientiane", :abbreviation => 'VI'
    country.create :id => 418015, :name => "Xaignabouli", :abbreviation => 'XA'
    country.create :id => 418016, :name => "Xékong", :abbreviation => 'XE'
    country.create :id => 418017, :name => "Xiangkhoang", :abbreviation => 'XI'
    
    # Special zone
    country.create :id => 418018, :name => "Xiasômboun", :abbreviation => 'XN'
  end
  
  # Liechtenstein
  with_options(:country => Country['LI']) do |country|
    country.create :id => 438001, :name => "Balzers"
    country.create :id => 438002, :name => "Eschen"
    country.create :id => 438003, :name => "Gamprin"
    country.create :id => 438004, :name => "Mauren"
    country.create :id => 438005, :name => "Planken"
    country.create :id => 438006, :name => "Ruggell"
    country.create :id => 438007, :name => "Schaan"
    country.create :id => 438008, :name => "Schellenberg"
    country.create :id => 438009, :name => "Triesen"
    country.create :id => 438010, :name => "Triesenberg"
    country.create :id => 438011, :name => "Vaduz"
  end
  
  # Lebanon
  with_options(:country => Country['LB']) do |country|
    country.create :id => 422001, :name => "Aakkâr", :abbreviation => 'AK'
    country.create :id => 422002, :name => "Baalbek-Hermel", :abbreviation => 'BH'
    country.create :id => 422003, :name => "Béqaa", :abbreviation => 'BI'
    country.create :id => 422004, :name => "Beyrouth", :abbreviation => 'BA'
    country.create :id => 422005, :name => "Liban-Nord", :abbreviation => 'AS'
    country.create :id => 422006, :name => "Liban-Sud", :abbreviation => 'JA'
    country.create :id => 422007, :name => "Mont-Liban", :abbreviation => 'JL'
    country.create :id => 422008, :name => "Nabatîyé", :abbreviation => 'NA'
  end
  
  # Sri Lanka
  with_options(:country => Country['LK']) do |country|
    country.create :id => 144011, :name => "Colombo"
    country.create :id => 144012, :name => "Gampaha"
    country.create :id => 144013, :name => "Kalutara"
    country.create :id => 144021, :name => "Kandy"
    country.create :id => 144022, :name => "Matale"
    country.create :id => 144023, :name => "Nuwara Eliya"
    country.create :id => 144031, :name => "Galle"
    country.create :id => 144032, :name => "Matara"
    country.create :id => 144033, :name => "Hambantota"
    country.create :id => 144041, :name => "Jaffna"
    country.create :id => 144042, :name => "Kilinochchi"
    country.create :id => 144043, :name => "Mannar"
    country.create :id => 144044, :name => "Vavuniya"
    country.create :id => 144045, :name => "Mullaittivu"
    country.create :id => 144051, :name => "Batticaloa"
    country.create :id => 144052, :name => "Ampara"
    country.create :id => 144053, :name => "Trincomalee"
    country.create :id => 144061, :name => "Kurunegala"
    country.create :id => 144062, :name => "Puttalum"
    country.create :id => 144071, :name => "Anuradhapura"
    country.create :id => 144072, :name => "Polonnaruwa"
    country.create :id => 144081, :name => "Badulla"
    country.create :id => 144082, :name => "Monaragala"
    country.create :id => 144091, :name => "Ratnapura"
    country.create :id => 144092, :name => "Kegalla"
  end
  
  # Liberia
  with_options(:country => Country['LR']) do |country|
    country.create :id => 430001, :name => "Bomi", :abbreviation => 'BM'
    country.create :id => 430002, :name => "Bong", :abbreviation => 'BG'
    country.create :id => 430003, :name => "Grand Bassa", :abbreviation => 'GB'
    country.create :id => 430004, :name => "Grand Cape Mount", :abbreviation => 'CM'
    country.create :id => 430005, :name => "Grand Gedeh", :abbreviation => 'GG'
    country.create :id => 430006, :name => "Grand Kru", :abbreviation => 'GK'
    country.create :id => 430007, :name => "Lofa", :abbreviation => 'LO'
    country.create :id => 430008, :name => "Margibi", :abbreviation => 'MG'
    country.create :id => 430009, :name => "Maryland", :abbreviation => 'MY'
    country.create :id => 430010, :name => "Montserrado", :abbreviation => 'MO'
    country.create :id => 430011, :name => "Nimba", :abbreviation => 'NI'
    country.create :id => 430012, :name => "Rivercess", :abbreviation => 'RI'
    country.create :id => 430013, :name => "Sinoe", :abbreviation => 'SI'
  end
  
  # Lesotho
  with_options(:country => Country['LS']) do |country|
    country.create :id => 426001, :name => "Berea", :abbreviation => 'D'
    country.create :id => 426002, :name => "Butha-Buthe", :abbreviation => 'B'
    country.create :id => 426003, :name => "Leribe", :abbreviation => 'C'
    country.create :id => 426004, :name => "Mafeteng", :abbreviation => 'E'
    country.create :id => 426005, :name => "Maseru", :abbreviation => 'A'
    country.create :id => 426006, :name => "Mohale's Hoek", :abbreviation => 'F'
    country.create :id => 426007, :name => "Mokhotlong", :abbreviation => 'J'
    country.create :id => 426008, :name => "Qacha's Nek", :abbreviation => 'H'
    country.create :id => 426009, :name => "Quthing", :abbreviation => 'G'
    country.create :id => 426010, :name => "Thaba-Tseka", :abbreviation => 'K'
  end
  
  # Lithuania
  with_options(:country => Country['LT']) do |country|
    country.create :id => 440001, :name => "Alytaus", :abbreviation => 'AL'
    country.create :id => 440002, :name => "Kauno", :abbreviation => 'KU'
    country.create :id => 440003, :name => "Klaipėdos", :abbreviation => 'KL'
    country.create :id => 440004, :name => "Marijampolės", :abbreviation => 'MR'
    country.create :id => 440005, :name => "Panevėžio", :abbreviation => 'PN'
    country.create :id => 440006, :name => "Šiaulių", :abbreviation => 'SA'
    country.create :id => 440007, :name => "Tauragés", :abbreviation => 'TA'
    country.create :id => 440008, :name => "Telšių", :abbreviation => 'TE'
    country.create :id => 440009, :name => "Utenos", :abbreviation => 'UT'
    country.create :id => 440010, :name => "Vilniaus", :abbreviation => 'VL'
  end
  
  # Luxembourg
  with_options(:country => Country['LU']) do |country|
    country.create :id => 442001, :name => "Diekirch", :abbreviation => 'D'
    country.create :id => 442002, :name => "Grevenmacher", :abbreviation => 'G'
    country.create :id => 442003, :name => "Luxembourg", :abbreviation => 'L'
  end
  
  # Latvia
  with_options(:country => Country['LV']) do |country|
    # District
    country.create :id => 428001, :name => "Aizkraukle", :abbreviation => 'AI'
    country.create :id => 428002, :name => "Alūksne", :abbreviation => 'AL'
    country.create :id => 428003, :name => "Balvi", :abbreviation => 'BL'
    country.create :id => 428004, :name => "Bauska", :abbreviation => 'BU'
    country.create :id => 428005, :name => "Cēsis", :abbreviation => 'CE'
    country.create :id => 428006, :name => "Daugavpils", :abbreviation => 'DA'
    country.create :id => 428007, :name => "Dobele", :abbreviation => 'DO'
    country.create :id => 428008, :name => "Gulbene", :abbreviation => 'GU'
    country.create :id => 428009, :name => "Jēkabpils", :abbreviation => 'JK'
    country.create :id => 428010, :name => "Jelgava", :abbreviation => 'JL'
    country.create :id => 428011, :name => "Krāslava", :abbreviation => 'KR'
    country.create :id => 428012, :name => "Kuldīga", :abbreviation => 'KU'
    country.create :id => 428013, :name => "Liepāja", :abbreviation => 'LE'
    country.create :id => 428014, :name => "Limbaži", :abbreviation => 'LM'
    country.create :id => 428015, :name => "Ludza", :abbreviation => 'LU'
    country.create :id => 428016, :name => "Madona", :abbreviation => 'MA'
    country.create :id => 428017, :name => "Ogre", :abbreviation => 'OG'
    country.create :id => 428018, :name => "Preiļi", :abbreviation => 'PR'
    country.create :id => 428019, :name => "Rēzekne", :abbreviation => 'RE'
    country.create :id => 428020, :name => "Rīga", :abbreviation => 'RI'
    country.create :id => 428021, :name => "Saldus", :abbreviation => 'SA'
    country.create :id => 428022, :name => "Talsi", :abbreviation => 'TA'
    country.create :id => 428023, :name => "Tukums", :abbreviation => 'TU'
    country.create :id => 428024, :name => "Valka", :abbreviation => 'VK'
    country.create :id => 428025, :name => "Valmiera", :abbreviation => 'VM'
    country.create :id => 428026, :name => "Ventspils", :abbreviation => 'VE'
    
    # City
    country.create :id => 428027, :name => "Daugavpils", :abbreviation => 'DGV'
    country.create :id => 428028, :name => "Jelgava", :abbreviation => 'JEL'
    country.create :id => 428029, :name => "Jūrmala", :abbreviation => 'JUR'
    country.create :id => 428030, :name => "Liepāja", :abbreviation => 'LPX'
    country.create :id => 428031, :name => "Rēzekne", :abbreviation => 'REZ'
    country.create :id => 428032, :name => "Rīga", :abbreviation => 'RIX'
    country.create :id => 428033, :name => "Ventspils", :abbreviation => 'VEN'
  end
  
  # Libya
  with_options(:country => Country['LY']) do |country|
    country.create :id => 434001, :name => "Ajdābiyā", :abbreviation => 'AJ'
    country.create :id => 434002, :name => "Al Buţnān", :abbreviation => 'BU'
    country.create :id => 434003, :name => "Al Ḩizām al Akhḑar", :abbreviation => 'HZ'
    country.create :id => 434004, :name => "Al Jabal al Akhḑar", :abbreviation => 'JA'
    country.create :id => 434005, :name => "Al Jifārah", :abbreviation => 'JI'
    country.create :id => 434006, :name => "Al Jufrah", :abbreviation => 'JU'
    country.create :id => 434007, :name => "Al Kufrah", :abbreviation => 'KF'
    country.create :id => 434008, :name => "Al Marj", :abbreviation => 'MJ'
    country.create :id => 434009, :name => "Al Marqab", :abbreviation => 'MB'
    country.create :id => 434010, :name => "Al Qaţrūn", :abbreviation => 'QT'
    country.create :id => 434011, :name => "Al Qubbah", :abbreviation => 'QB'
    country.create :id => 434012, :name => "Al Wāḩah", :abbreviation => 'WA'
    country.create :id => 434013, :name => "An Nuqaţ al Khams", :abbreviation => 'NQ'
    country.create :id => 434014, :name => "Ash Shāţi'", :abbreviation => 'SH'
    country.create :id => 434015, :name => "Az Zāwiyah", :abbreviation => 'ZA'
    country.create :id => 434016, :name => "Banghāzī", :abbreviation => 'BA'
    country.create :id => 434017, :name => "Banī Walīd", :abbreviation => 'BW'
    country.create :id => 434018, :name => "Darnah", :abbreviation => 'DR'
    country.create :id => 434019, :name => "Ghadāmis", :abbreviation => 'GD'
    country.create :id => 434020, :name => "Gharyān", :abbreviation => 'GR'
    country.create :id => 434021, :name => "Ghāt", :abbreviation => 'GT'
    country.create :id => 434022, :name => "Jaghbūb", :abbreviation => 'JB'
    country.create :id => 434023, :name => "Mişrātah", :abbreviation => 'MI'
    country.create :id => 434024, :name => "Mizdah", :abbreviation => 'MZ'
    country.create :id => 434025, :name => "Murzuq", :abbreviation => 'MQ'
    country.create :id => 434026, :name => "Nālūt", :abbreviation => 'NL'
    country.create :id => 434027, :name => "Sabhā", :abbreviation => 'SB'
    country.create :id => 434028, :name => "Şabrātah Şurmān", :abbreviation => 'SS'
    country.create :id => 434029, :name => "Surt", :abbreviation => 'SR'
    country.create :id => 434030, :name => "Tājūrā' wa an Nawāḩī al Arbāʻ", :abbreviation => 'TN'
    country.create :id => 434031, :name => "Ţarābulus", :abbreviation => 'TB'
    country.create :id => 434032, :name => "Tarhūnah-Masallātah", :abbreviation => 'TM'
    country.create :id => 434033, :name => "Wādī al Ḩayāt", :abbreviation => 'WD'
    country.create :id => 434034, :name => "Yafran-Jādū", :abbreviation => 'YJ'
  end
  
  # Morocco
  with_options(:country => Country['MA']) do |country|
    country.create :id => 504001, :name => "Agadir", :abbreviation => 'AGD'
    country.create :id => 504002, :name => "Aït Baha", :abbreviation => 'BAH'
    country.create :id => 504003, :name => "Aït Melloul", :abbreviation => 'MEL'
    country.create :id => 504004, :name => "Al Haouz", :abbreviation => 'HAO'
    country.create :id => 504005, :name => "Al Hoceïma", :abbreviation => 'HOC'
    country.create :id => 504006, :name => "Assa-Zag", :abbreviation => 'ASZ'
    country.create :id => 504007, :name => "Azilal", :abbreviation => 'AZI'
    country.create :id => 504008, :name => "Beni Mellal", :abbreviation => 'BEM'
    country.create :id => 504009, :name => "Ben Sllmane", :abbreviation => 'BES'
    country.create :id => 504010, :name => "Berkane", :abbreviation => 'BER'
    country.create :id => 504011, :name => "Boujdour", :abbreviation => 'BOD'
    country.create :id => 504012, :name => "Boulemane", :abbreviation => 'BOM'
    country.create :id => 504013, :name => "Casablanca", :abbreviation => 'CAS' # Dar el Beïda
    country.create :id => 504014, :name => "Chefchaouene", :abbreviation => 'CHE'
    country.create :id => 504015, :name => "Chichaoua", :abbreviation => 'CHI'
    country.create :id => 504016, :name => "El Hajeb", :abbreviation => 'HAJ'
    country.create :id => 504017, :name => "El Jadida", :abbreviation => 'JDI'
    country.create :id => 504018, :name => "Errachidia", :abbreviation => 'ERR'
    country.create :id => 504019, :name => "Essaouira", :abbreviation => 'ESI'
    country.create :id => 504020, :name => "Es Smara", :abbreviation => 'ESM'
    country.create :id => 504021, :name => "Fès", :abbreviation => 'FES'
    country.create :id => 504022, :name => "Figuig", :abbreviation => 'FIG'
    country.create :id => 504023, :name => "Guelmim", :abbreviation => 'GUE'
    country.create :id => 504024, :name => "Ifrane", :abbreviation => 'IFR'
    country.create :id => 504025, :name => "Jerada", :abbreviation => 'JRA'
    country.create :id => 504026, :name => "Kelaat Sraghna", :abbreviation => 'KES'
    country.create :id => 504027, :name => "Kénitra", :abbreviation => 'KEN'
    country.create :id => 504028, :name => "Khemisaet", :abbreviation => 'KHE'
    country.create :id => 504029, :name => "Khenifra", :abbreviation => 'KHN'
    country.create :id => 504030, :name => "Khouribga", :abbreviation => 'KHO'
    country.create :id => 504031, :name => "Laâyoune", :abbreviation => 'LAA'
    country.create :id => 504032, :name => "Larache", :abbreviation => 'LAP'
    country.create :id => 504033, :name => "Marrakech", :abbreviation => 'MAR'
    country.create :id => 504034, :name => "Meknsès", :abbreviation => 'MEK'
    country.create :id => 504035, :name => "Nador", :abbreviation => 'NAD'
    country.create :id => 504036, :name => "Ouarzazate", :abbreviation => 'OUA'
    country.create :id => 504037, :name => "Oued ed Dahab", :abbreviation => 'OUD'
    country.create :id => 504038, :name => "Oujda", :abbreviation => 'OUJ'
    country.create :id => 504039, :name => "Rabat-Salé", :abbreviation => 'RBA'
    country.create :id => 504040, :name => "Safi", :abbreviation => 'SAF'
    country.create :id => 504041, :name => "Sefrou", :abbreviation => 'SEF'
    country.create :id => 504042, :name => "Settat", :abbreviation => 'SET'
    country.create :id => 504043, :name => "Sidl Kacem", :abbreviation => 'SIK'
    country.create :id => 504044, :name => "Tanger", :abbreviation => 'TNG'
    country.create :id => 504045, :name => "Tan-Tan", :abbreviation => 'TNT'
    country.create :id => 504046, :name => "Taounate", :abbreviation => 'TAO'
    country.create :id => 504047, :name => "Taroudannt", :abbreviation => 'TAR'
    country.create :id => 504048, :name => "Tata", :abbreviation => 'TAT'
    country.create :id => 504049, :name => "Taza", :abbreviation => 'TAZ'
    country.create :id => 504050, :name => "Tétouan", :abbreviation => 'TET'
    country.create :id => 504051, :name => "Tiznit", :abbreviation => 'TIZ'
  end
  
  # Moldova
  with_options(:country => Country['MD']) do |country|
    # Autonomous Territory
    country.create :id => 498001, :name => "Găgăuzia", :abbreviation => 'GA'
    
    # City
    country.create :id => 498002, :name => "Chişinău", :abbreviation => 'CU'
    
    # District
    country.create :id => 498003, :name => "Bălţi", :abbreviation => 'BA'
    country.create :id => 498004, :name => "Cahul", :abbreviation => 'CA'
    country.create :id => 498005, :name => "Chişinău", :abbreviation => 'CH'
    country.create :id => 498006, :name => "Edineţ", :abbreviation => 'ED'
    country.create :id => 498007, :name => "Lăpuşna", :abbreviation => 'LA'
    country.create :id => 498008, :name => "Orhei", :abbreviation => 'OR'
    country.create :id => 498009, :name => "Soroca", :abbreviation => 'SO'
    country.create :id => 498010, :name => "Taraclia", :abbreviation => 'TA'
    country.create :id => 498011, :name => "Tighina", :abbreviation => 'TI'
    country.create :id => 498012, :name => "Ungheni", :abbreviation => 'UN'
    
    # Territorial unit
    country.create :id => 498013, :name => "Stînga Nistrului", :abbreviation => 'SN'
  end
  
  # Montenegro
  with_options(:country => Country['ME']) do |country|
    country.create :id => 499001, :name => "Andrijevica"
    country.create :id => 499002, :name => "Bar"
    country.create :id => 499003, :name => "Berane"
    country.create :id => 499004, :name => "Bijelo Polje"
    country.create :id => 499005, :name => "Budva"
    country.create :id => 499006, :name => "Cetinje"
    country.create :id => 499007, :name => "Danilovgrad"
    country.create :id => 499008, :name => "Herceg-Novi"
    country.create :id => 499009, :name => "Kolašin"
    country.create :id => 499010, :name => "Kotor"
    country.create :id => 499011, :name => "Mojkovac"
    country.create :id => 499012, :name => "Nikšić"
    country.create :id => 499013, :name => "Plav"
    country.create :id => 499014, :name => "Pljevlja"
    country.create :id => 499015, :name => "Plužine"
    country.create :id => 499016, :name => "Podgorica"
    country.create :id => 499017, :name => "Rožaje"
    country.create :id => 499018, :name => "Šavnik"
    country.create :id => 499019, :name => "Tivat"
    country.create :id => 499020, :name => "Ulcinj"
    country.create :id => 499021, :name => "Žabljak"
  end
  
  # Madagascar
  with_options(:country => Country['MG']) do |country|
    country.create :id => 450001, :name => "Antananarivo", :abbreviation => 'T'
    country.create :id => 450002, :name => "Antsiranana", :abbreviation => 'D'
    country.create :id => 450003, :name => "Fianarantsoa", :abbreviation => 'F'
    country.create :id => 450004, :name => "Mahajanga", :abbreviation => 'M'
    country.create :id => 450005, :name => "Toamasina", :abbreviation => 'A'
    country.create :id => 450006, :name => "Toliara", :abbreviation => 'U'
  end
  
  # Marshall Islands
  with_options(:country => Country['MH']) do |country|
    country.create :id => 584001, :name => "Ailinglapalap", :abbreviation => 'ALL'
    country.create :id => 584002, :name => "Ailuk", :abbreviation => 'ALK'
    country.create :id => 584003, :name => "Arno", :abbreviation => 'ARN'
    country.create :id => 584004, :name => "Aur", :abbreviation => 'AUR'
    country.create :id => 584005, :name => "Ebon", :abbreviation => 'EBO'
    country.create :id => 584006, :name => "Eniwetok", :abbreviation => 'ENI'
    country.create :id => 584007, :name => "Jaluit", :abbreviation => 'JAL'
    country.create :id => 584008, :name => "Kili", :abbreviation => 'KIL'
    country.create :id => 584009, :name => "Kwajalein", :abbreviation => 'KWA'
    country.create :id => 584010, :name => "Lae", :abbreviation => 'LAE'
    country.create :id => 584011, :name => "Lib", :abbreviation => 'LIB'
    country.create :id => 584012, :name => "Likiep", :abbreviation => 'LIK'
    country.create :id => 584013, :name => "Majuro", :abbreviation => 'MAJ'
    country.create :id => 584014, :name => "Maloelap", :abbreviation => 'MAL'
    country.create :id => 584015, :name => "Mejit", :abbreviation => 'MEJ'
    country.create :id => 584016, :name => "Mili", :abbreviation => 'MIL'
    country.create :id => 584017, :name => "Namorik", :abbreviation => 'NMK'
    country.create :id => 584018, :name => "Namu", :abbreviation => 'NMU'
    country.create :id => 584019, :name => "Rongelap", :abbreviation => 'RON'
    country.create :id => 584020, :name => "Ujae", :abbreviation => 'UJA'
    country.create :id => 584021, :name => "Ujelang", :abbreviation => 'UJL'
    country.create :id => 584022, :name => "Utirik", :abbreviation => 'UTI'
    country.create :id => 584023, :name => "Wotho", :abbreviation => 'WTN'
    country.create :id => 584024, :name => "Wotje", :abbreviation => 'WTJ'
  end
  
  # Macedonia
  with_options(:country => Country['MK']) do |country|
    country.create :id => 807001, :name => "Aerodrom"
    country.create :id => 807002, :name => "Aračinovo"
    country.create :id => 807003, :name => "Berovo"
    country.create :id => 807004, :name => "Bitola"
    country.create :id => 807005, :name => "Bogdanci"
    country.create :id => 807006, :name => "Bogovinje"
    country.create :id => 807007, :name => "Bosilovo"
    country.create :id => 807008, :name => "Brvenica"
    country.create :id => 807009, :name => "Butel"
    country.create :id => 807010, :name => "Valandovo"
    country.create :id => 807011, :name => "Vasilevo"
    country.create :id => 807012, :name => "Vevčani"
    country.create :id => 807013, :name => "Veles"
    country.create :id => 807014, :name => "Vinica"
    country.create :id => 807015, :name => "Vraneštica"
    country.create :id => 807016, :name => "Vrapčište"
    country.create :id => 807017, :name => "Gazi Baba"
    country.create :id => 807018, :name => "Gevgelija"
    country.create :id => 807019, :name => "Gostivar"
    country.create :id => 807020, :name => "Gradsko"
    country.create :id => 807021, :name => "Debar"
    country.create :id => 807022, :name => "Debarca"
    country.create :id => 807023, :name => "Delčevo"
    country.create :id => 807024, :name => "Demir Kapija"
    country.create :id => 807025, :name => "Demir Hisar"
    country.create :id => 807026, :name => "Dojran"
    country.create :id => 807027, :name => "Dolneni"
    country.create :id => 807028, :name => "Drugovo"
    country.create :id => 807029, :name => "Gjorče Petrov"
    country.create :id => 807030, :name => "Želino"
    country.create :id => 807031, :name => "Zajas"
    country.create :id => 807032, :name => "Zelenikovo"
    country.create :id => 807033, :name => "Zrnovci"
    country.create :id => 807034, :name => "Ilinden"
    country.create :id => 807035, :name => "Jegunovce"
    country.create :id => 807036, :name => "Kavadarci"
    country.create :id => 807037, :name => "Karbinci"
    country.create :id => 807038, :name => "Karpoš"
    country.create :id => 807039, :name => "Kisela Voda"
    country.create :id => 807040, :name => "Kičevo"
    country.create :id => 807041, :name => "Konče"
    country.create :id => 807042, :name => "Kočani"
    country.create :id => 807043, :name => "Kratovo"
    country.create :id => 807044, :name => "Kriva Palanka"
    country.create :id => 807045, :name => "Krivogaštani"
    country.create :id => 807046, :name => "Kruševo"
    country.create :id => 807047, :name => "Kumanovo"
    country.create :id => 807048, :name => "Lipkovo"
    country.create :id => 807049, :name => "Lozovo"
    country.create :id => 807050, :name => "Mavrovo-i-Rostuša"
    country.create :id => 807051, :name => "Makedonska Kamenica"
    country.create :id => 807052, :name => "Makedonski Brod"
    country.create :id => 807053, :name => "Mogila"
    country.create :id => 807054, :name => "Negotino"
    country.create :id => 807055, :name => "Novaci"
    country.create :id => 807056, :name => "Novo Selo"
    country.create :id => 807057, :name => "Oslomej"
    country.create :id => 807058, :name => "Ohrid"
    country.create :id => 807059, :name => "Petrovec"
    country.create :id => 807060, :name => "Pehčevo"
    country.create :id => 807061, :name => "Plasnica"
    country.create :id => 807062, :name => "Prilep"
    country.create :id => 807063, :name => "Probištip"
    country.create :id => 807064, :name => "Radoviš"
    country.create :id => 807065, :name => "Rankovce"
    country.create :id => 807066, :name => "Resen"
    country.create :id => 807067, :name => "Rosoman"
    country.create :id => 807068, :name => "Saraj"
    country.create :id => 807069, :name => "Sveti Nikole"
    country.create :id => 807070, :name => "Sopište"
    country.create :id => 807071, :name => "Staro Nagoričane"
    country.create :id => 807072, :name => "Struga"
    country.create :id => 807073, :name => "Strumica"
    country.create :id => 807074, :name => "Studeničani"
    country.create :id => 807075, :name => "Tearce"
    country.create :id => 807076, :name => "Tetovo"
    country.create :id => 807077, :name => "Centar"
    country.create :id => 807078, :name => "Centar Župa"
    country.create :id => 807079, :name => "Čair"
    country.create :id => 807080, :name => "Čaška"
    country.create :id => 807081, :name => "Češinovo-Obleševo"
    country.create :id => 807082, :name => "Čučer Sandevo"
    country.create :id => 807083, :name => "Štip"
    country.create :id => 807084, :name => "Šuto Orizari"
  end
  
  # Mali
  with_options(:country => Country['ML']) do |country|
    # Region
    country.create :id => 466001, :name => "Kayes"
    country.create :id => 466002, :name => "Koulikoro"
    country.create :id => 466003, :name => "Sikasso"
    country.create :id => 466004, :name => "Ségou"
    country.create :id => 466005, :name => "Mopti"
    country.create :id => 466006, :name => "Tombouctou"
    country.create :id => 466007, :name => "Gao"
    country.create :id => 466008, :name => "Kidal"
    
    # Non-numeric districts
    country.create :id => 466100, :name => "Bamako", :abbreviation => 'BK0'
  end
  
  # Myanmar
  with_options(:country => Country['MM']) do |country|
    # Division
    country.create :id => 104001, :name => "Sagaing"
    country.create :id => 104002, :name => "Bago"
    country.create :id => 104003, :name => "Magway"
    country.create :id => 104004, :name => "Mandalay"
    country.create :id => 104005, :name => "Tanintharyi"
    country.create :id => 104006, :name => "Yangon"
    country.create :id => 104007, :name => "Ayeyarwady"
    
    # State
    country.create :id => 104011, :name => "Kachin"
    country.create :id => 104012, :name => "Kayah"
    country.create :id => 104013, :name => "Kayin"
    country.create :id => 104014, :name => "Chin"
    country.create :id => 104015, :name => "Mon"
    country.create :id => 104016, :name => "Rakhine"
    country.create :id => 104017, :name => "Shan"
  end
  
  # Mongolia
  with_options(:country => Country['MN']) do |country|
    country.create :id => 496001, :name => "Ulanbaatar"
    country.create :id => 496035, :name => "Orhon"
    country.create :id => 496037, :name => "Darhan uul"
    country.create :id => 496039, :name => "Hentiy"
    country.create :id => 496041, :name => "Hövsgöl"
    country.create :id => 496043, :name => "Hovd"
    country.create :id => 496046, :name => "Uvs"
    country.create :id => 496047, :name => "Töv"
    country.create :id => 496049, :name => "Selenge"
    country.create :id => 496051, :name => "Sühbaatar"
    country.create :id => 496053, :name => "Ömnögovi"
    country.create :id => 496055, :name => "Övörhangay"
    country.create :id => 496057, :name => "Dzavhan"
    country.create :id => 496059, :name => "Dundgovi"
    country.create :id => 496061, :name => "Dornod"
    country.create :id => 496063, :name => "Dornogovi"
    country.create :id => 496064, :name => "Govi-Sumber"
    country.create :id => 496065, :name => "Govi-Altay"
    country.create :id => 496067, :name => "Bulgan"
    country.create :id => 496069, :name => "Bayanhongor"
    country.create :id => 496071, :name => "Bayan-Ölgiy"
    country.create :id => 496073, :name => "Arhangay"
  end
  
  # Mauritania
  with_options(:country => Country['MR']) do |country|
    # Region
    country.create :id => 478001, :name => "Hodh ech Chargui"
    country.create :id => 478002, :name => "Hodh el Charbi"
    country.create :id => 478003, :name => "Assaba"
    country.create :id => 478004, :name => "Gorgol"
    country.create :id => 478005, :name => "Brakna"
    country.create :id => 478006, :name => "Trarza"
    country.create :id => 478007, :name => "Adrar"
    country.create :id => 478008, :name => "Dakhlet Nouadhibou"
    country.create :id => 478009, :name => "Tagant"
    country.create :id => 478010, :name => "Guidimaka"
    country.create :id => 478011, :name => "Tiris Zemmour"
    country.create :id => 478012, :name => "Inchiri"
    
    # District
    country.create :id => 478100, :name => "Nouakchott", :abbreviation => 'NKC'
  end
  
  # Malta
  with_options(:country => Country['MT']) do |country|
    country.create :id => 470001, :name => "Attard"
    country.create :id => 470002, :name => "Balzan"
    country.create :id => 470003, :name => "Birgu"
    country.create :id => 470004, :name => "Birkirkara"
    country.create :id => 470005, :name => "Birżebbuġa"
    country.create :id => 470006, :name => "Bormla"
    country.create :id => 470007, :name => "Dingli"
    country.create :id => 470008, :name => "Fgura"
    country.create :id => 470009, :name => "Floriana"
    country.create :id => 470010, :name => "Fontana"
    country.create :id => 470011, :name => "Gudja"
    country.create :id => 470012, :name => "Gżira"
    country.create :id => 470013, :name => "Għajnsielem"
    country.create :id => 470014, :name => "Għarb"
    country.create :id => 470015, :name => "Għargħur"
    country.create :id => 470016, :name => "Għasri"
    country.create :id => 470017, :name => "Għaxaq"
    country.create :id => 470018, :name => "Ħamrun"
    country.create :id => 470019, :name => "Iklin"
    country.create :id => 470020, :name => "Isla"
    country.create :id => 470021, :name => "Kalkara"
    country.create :id => 470022, :name => "Kerċem"
    country.create :id => 470023, :name => "Kirkop"
    country.create :id => 470024, :name => "Lija"
    country.create :id => 470025, :name => "Luqa"
    country.create :id => 470026, :name => "Marsa"
    country.create :id => 470027, :name => "Marsaskala"
    country.create :id => 470028, :name => "Marsaxlokk"
    country.create :id => 470029, :name => "Mdina"
    country.create :id => 470030, :name => "Mellieħa"
    country.create :id => 470031, :name => "Mġarr"
    country.create :id => 470032, :name => "Mosta"
    country.create :id => 470033, :name => "Mqabba"
    country.create :id => 470034, :name => "Msida"
    country.create :id => 470035, :name => "Mtarfa"
    country.create :id => 470036, :name => "Munxar"
    country.create :id => 470037, :name => "Nadur"
    country.create :id => 470038, :name => "Naxxar"
    country.create :id => 470039, :name => "Paola"
    country.create :id => 470040, :name => "Pembroke"
    country.create :id => 470041, :name => "Pietà"
    country.create :id => 470042, :name => "Qala"
    country.create :id => 470043, :name => "Qormi"
    country.create :id => 470044, :name => "Qrendi"
    country.create :id => 470045, :name => "Rabat Għawdex"
    country.create :id => 470046, :name => "Rabat Malta"
    country.create :id => 470047, :name => "Safi"
    country.create :id => 470048, :name => "San Ġiljan"
    country.create :id => 470049, :name => "San Ġwann"
    country.create :id => 470050, :name => "San Lawrenz"
    country.create :id => 470051, :name => "San Pawl il-Baħar"
    country.create :id => 470052, :name => "Sannat"
    country.create :id => 470053, :name => "Santa Luċija"
    country.create :id => 470054, :name => "Santa Venera"
    country.create :id => 470055, :name => "Siġġiewi"
    country.create :id => 470056, :name => "Sliema"
    country.create :id => 470057, :name => "Swieqi"
    country.create :id => 470058, :name => "Ta’ Xbiex"
    country.create :id => 470059, :name => "Tarxien"
    country.create :id => 470060, :name => "Valletta"
    country.create :id => 470061, :name => "Xagħra"
    country.create :id => 470062, :name => "Xewkija"
    country.create :id => 470063, :name => "Xgħajra"
    country.create :id => 470064, :name => "Żabbar"
    country.create :id => 470065, :name => "Żebbuġ Għawdex"
    country.create :id => 470066, :name => "Żebbuġ Malta"
    country.create :id => 470067, :name => "Żejtun"
    country.create :id => 470068, :name => "Żurrieq"
  end
  
  # Mauritius
  with_options(:country => Country['MU']) do |country|
    # City
    country.create :id => 480001, :name => "Beau Bassin-Rose Hill", :abbreviation => 'BR'
    country.create :id => 480002, :name => "Curepipe", :abbreviation => 'CU'
    country.create :id => 480003, :name => "Port Louis", :abbreviation => 'PU'
    country.create :id => 480004, :name => "Quatre Bornes", :abbreviation => 'QB'
    country.create :id => 480005, :name => "Vacoas-Phoenix", :abbreviation => 'VP'
    
    # Dependency
    country.create :id => 480006, :name => "Agalega Islands", :abbreviation => 'AG'
    country.create :id => 480007, :name => "Cargados Carajos Shoals", :abbreviation => 'CC'
    country.create :id => 480008, :name => "Rodrigues Island", :abbreviation => 'RO'
    
    # District
    country.create :id => 480009, :name => "Black River", :abbreviation => 'BL'
    country.create :id => 480010, :name => "Flacq", :abbreviation => 'FL'
    country.create :id => 480011, :name => "Grand Port", :abbreviation => 'GP'
    country.create :id => 480012, :name => "Moka", :abbreviation => 'MO'
    country.create :id => 480013, :name => "Pamplemousses", :abbreviation => 'PA'
    country.create :id => 480014, :name => "Plaines Wilhems", :abbreviation => 'PW'
    country.create :id => 480015, :name => "Port Louis", :abbreviation => 'PL'
    country.create :id => 480016, :name => "Rivière du Rempart", :abbreviation => 'RP'
    country.create :id => 480017, :name => "Savanne", :abbreviation => 'SA'
  end
  
  # Maldives
  with_options(:country => Country['MV']) do |country|
    # Atoll
    country.create :id => 462001, :name => "Seenu"
    country.create :id => 462002, :name => "Alif"
    country.create :id => 462003, :name => "Lhaviyani"
    country.create :id => 462004, :name => "Vaavu"
    country.create :id => 462005, :name => "Laamu"
    country.create :id => 462007, :name => "Haa Alif"
    country.create :id => 462008, :name => "Thaa"
    country.create :id => 462012, :name => "Meemu"
    country.create :id => 462013, :name => "Raa"
    country.create :id => 462014, :name => "Faafu"
    country.create :id => 462017, :name => "Dhaalu"
    country.create :id => 462020, :name => "Baa"
    country.create :id => 462023, :name => "Haa Dhaalu"
    country.create :id => 462024, :name => "Shaviyani"
    country.create :id => 462025, :name => "Noonu"
    country.create :id => 462026, :name => "Kaafu"
    country.create :id => 462027, :name => "Gaafu Aliff"
    country.create :id => 462028, :name => "Gaafu Daalu"
    country.create :id => 462029, :name => "Gnaviyani"
    
    # City
    country.create :id => 462100, :name => "Male", :abbreviation => 'MLE'
  end
  
  # Malawi
  with_options(:country => Country['MW']) do |country|
    country.create :id => 454001, :name => "Balaka", :abbreviation => 'BA'
    country.create :id => 454002, :name => "Blantyre", :abbreviation => 'BL'
    country.create :id => 454003, :name => "Chikwawa", :abbreviation => 'CK'
    country.create :id => 454004, :name => "Chiradzulu", :abbreviation => 'CR'
    country.create :id => 454005, :name => "Chitipa", :abbreviation => 'CT'
    country.create :id => 454006, :name => "Dedza", :abbreviation => 'DE'
    country.create :id => 454007, :name => "Dowa", :abbreviation => 'DO'
    country.create :id => 454008, :name => "Karonga", :abbreviation => 'KR'
    country.create :id => 454009, :name => "Kasungu", :abbreviation => 'KS'
    country.create :id => 454010, :name => "Likoma Island", :abbreviation => 'LK'
    country.create :id => 454011, :name => "Lilongwe", :abbreviation => 'LI'
    country.create :id => 454012, :name => "Machinga", :abbreviation => 'MH'
    country.create :id => 454013, :name => "Mangochi", :abbreviation => 'MG'
    country.create :id => 454014, :name => "Mchinji", :abbreviation => 'MC'
    country.create :id => 454015, :name => "Mulanje", :abbreviation => 'MU'
    country.create :id => 454016, :name => "Mwanza", :abbreviation => 'MW'
    country.create :id => 454017, :name => "Mzimba", :abbreviation => 'MZ'
    country.create :id => 454018, :name => "Nkhata Bay", :abbreviation => 'NB'
    country.create :id => 454019, :name => "Nkhotakota", :abbreviation => 'NK'
    country.create :id => 454020, :name => "Nsanje", :abbreviation => 'NS'
    country.create :id => 454021, :name => "Ntcheu", :abbreviation => 'NU'
    country.create :id => 454022, :name => "Ntchisi", :abbreviation => 'NI'
    country.create :id => 454023, :name => "Phalombe", :abbreviation => 'PH'
    country.create :id => 454024, :name => "Rumphi", :abbreviation => 'RU'
    country.create :id => 454025, :name => "Salima", :abbreviation => 'SA'
    country.create :id => 454026, :name => "Thyolo", :abbreviation => 'TH'
    country.create :id => 454027, :name => "Zomba", :abbreviation => 'ZO'
  end
  
  # Mexico
  with_options(:country => Country['MX']) do |country|
    # Federal district
    country.create :id => 484001, :name => "Distrito Federal", :abbreviation => 'DIF'
    
    # State
    country.create :id => 484002, :name => "Aguascalientes", :abbreviation => 'AGU'
    country.create :id => 484003, :name => "Baja California", :abbreviation => 'BCN'
    country.create :id => 484004, :name => "Baja California Sur", :abbreviation => 'BCS'
    country.create :id => 484005, :name => "Campeche", :abbreviation => 'CAM'
    country.create :id => 484006, :name => "Coahuila", :abbreviation => 'COA'
    country.create :id => 484007, :name => "Colima", :abbreviation => 'COL'
    country.create :id => 484008, :name => "Chiapas", :abbreviation => 'CHP'
    country.create :id => 484009, :name => "Chihuahua", :abbreviation => 'CHH'
    country.create :id => 484010, :name => "Durango", :abbreviation => 'DUR'
    country.create :id => 484011, :name => "Guanajuato", :abbreviation => 'GUA'
    country.create :id => 484012, :name => "Guerrero", :abbreviation => 'GRO'
    country.create :id => 484013, :name => "Hidalgo", :abbreviation => 'HID'
    country.create :id => 484014, :name => "Jalisco", :abbreviation => 'JAL'
    country.create :id => 484015, :name => "México", :abbreviation => 'MEX'
    country.create :id => 484016, :name => "Michoacán", :abbreviation => 'MIC'
    country.create :id => 484017, :name => "Morelos", :abbreviation => 'MOR'
    country.create :id => 484018, :name => "Nayarit", :abbreviation => 'NAY'
    country.create :id => 484019, :name => "Nuevo León", :abbreviation => 'NLE'
    country.create :id => 484020, :name => "Oaxaca", :abbreviation => 'OAX'
    country.create :id => 484021, :name => "Puebla", :abbreviation => 'PUE'
    country.create :id => 484022, :name => "Querétaro", :abbreviation => 'QUE'
    country.create :id => 484023, :name => "Quintana Roo", :abbreviation => 'ROO'
    country.create :id => 484024, :name => "San Luis Potosí", :abbreviation => 'SLP'
    country.create :id => 484025, :name => "Sinaloa", :abbreviation => 'SIN'
    country.create :id => 484026, :name => "Sonora", :abbreviation => 'SON'
    country.create :id => 484027, :name => "Tabasco", :abbreviation => 'TAB'
    country.create :id => 484028, :name => "Tamaulipas", :abbreviation => 'TAM'
    country.create :id => 484029, :name => "Tlaxcala", :abbreviation => 'TLA'
    country.create :id => 484030, :name => "Veracruz", :abbreviation => 'VER'
    country.create :id => 484031, :name => "Yucatán", :abbreviation => 'YUC'
    country.create :id => 484032, :name => "Zacatecas", :abbreviation => 'ZAC'
  end
  
  # Malaysia
  with_options(:country => Country['MY']) do |country|
    # State
    country.create :id => 458001, :name => "Johor"
    country.create :id => 458002, :name => "Kedah"
    country.create :id => 458003, :name => "Kelantan"
    country.create :id => 458004, :name => "Melaka"
    country.create :id => 458005, :name => "Negeri Sembilan"
    country.create :id => 458006, :name => "Pahang"
    country.create :id => 458007, :name => "Pulau Pinang"
    country.create :id => 458008, :name => "Perak"
    country.create :id => 458009, :name => "Perlis"
    country.create :id => 458010, :name => "Selangor"
    country.create :id => 458011, :name => "Terengganu"
    country.create :id => 458012, :name => "Sabah"
    country.create :id => 458013, :name => "Sarawak"
    
    # Federal territories
    country.create :id => 458014, :name => "Kuala Lumpur"
    country.create :id => 458015, :name => "Labuan"
    country.create :id => 458016, :name => "Putrajaya"
  end
  
  # Mozambique
  with_options(:country => Country['MZ']) do |country|
    # City
    country.create :id => 508001, :name => "Maputo (city)", :abbreviation => 'MPM'
    
    # Province
    country.create :id => 508002, :name => "Cabo Delgado", :abbreviation => 'P'
    country.create :id => 508003, :name => "Gaza", :abbreviation => 'G'
    country.create :id => 508004, :name => "Inhambane", :abbreviation => 'I'
    country.create :id => 508005, :name => "Manica", :abbreviation => 'B'
    country.create :id => 508006, :name => "Maputo", :abbreviation => 'L'
    country.create :id => 508007, :name => "Numpula", :abbreviation => 'N'
    country.create :id => 508008, :name => "Niassa", :abbreviation => 'A'
    country.create :id => 508009, :name => "Sofala", :abbreviation => 'S'
    country.create :id => 508010, :name => "Tete", :abbreviation => 'T'
    country.create :id => 508011, :name => "Zambezia", :abbreviation => 'Q'
  end
  
  # Namibia
  with_options(:country => Country['NA']) do |country|
    country.create :id => 516001, :name => "Caprivi", :abbreviation => 'CA'
    country.create :id => 516002, :name => "Erongo", :abbreviation => 'ER'
    country.create :id => 516003, :name => "Hardap", :abbreviation => 'HA'
    country.create :id => 516004, :name => "Karas", :abbreviation => 'KA'
    country.create :id => 516005, :name => "Khomas", :abbreviation => 'KH'
    country.create :id => 516006, :name => "Kunene", :abbreviation => 'KU'
    country.create :id => 516007, :name => "Ohangwena", :abbreviation => 'OW'
    country.create :id => 516008, :name => "Okavango", :abbreviation => 'OK'
    country.create :id => 516009, :name => "Omaheke", :abbreviation => 'OH'
    country.create :id => 516010, :name => "Omusati", :abbreviation => 'OS'
    country.create :id => 516011, :name => "Oshana", :abbreviation => 'ON'
    country.create :id => 516012, :name => "Oshikoto", :abbreviation => 'OT'
    country.create :id => 516013, :name => "Otjozondjupa", :abbreviation => 'OD'
  end
  
  # Niger
  with_options(:country => Country['NE']) do |country|
    # Department
    country.create :id => 562001, :name => "Agadez"
    country.create :id => 562002, :name => "Diffa"
    country.create :id => 562003, :name => "Dosso"
    country.create :id => 562004, :name => "Maradi"
    country.create :id => 562005, :name => "Tahoua"
    country.create :id => 562006, :name => "Tillabéri"
    country.create :id => 562007, :name => "Zinder"
    
    # Capital district
    country.create :id => 562008, :name => "Niamey"
  end
  
  # Nigeria
  with_options(:country => Country['NG']) do |country|
    # Capital territory
    country.create :id => 566001, :name => "Abuja", :abbreviation => 'FC'
    
    # State
    country.create :id => 566002, :name => "Abia", :abbreviation => 'AB'
    country.create :id => 566003, :name => "Adamawa", :abbreviation => 'AD'
    country.create :id => 566004, :name => "Akwa Ibom", :abbreviation => 'AK'
    country.create :id => 566005, :name => "Anambra", :abbreviation => 'AN'
    country.create :id => 566006, :name => "Bauchi", :abbreviation => 'BA'
    country.create :id => 566007, :name => "Bayelsa", :abbreviation => 'BY'
    country.create :id => 566008, :name => "Benue", :abbreviation => 'BE'
    country.create :id => 566009, :name => "Borno", :abbreviation => 'BO'
    country.create :id => 566010, :name => "Cross River", :abbreviation => 'CR'
    country.create :id => 566011, :name => "Delta", :abbreviation => 'DE'
    country.create :id => 566012, :name => "Ebonyi", :abbreviation => 'EB'
    country.create :id => 566013, :name => "Edo", :abbreviation => 'ED'
    country.create :id => 566014, :name => "Ekiti", :abbreviation => 'EK'
    country.create :id => 566015, :name => "Enugu", :abbreviation => 'EN'
    country.create :id => 566016, :name => "Gombe", :abbreviation => 'GO'
    country.create :id => 566017, :name => "Imo", :abbreviation => 'IM'
    country.create :id => 566018, :name => "Jigawa", :abbreviation => 'JI'
    country.create :id => 566019, :name => "Kaduna", :abbreviation => 'KD'
    country.create :id => 566020, :name => "Kano", :abbreviation => 'KN'
    country.create :id => 566021, :name => "Katsina", :abbreviation => 'KT'
    country.create :id => 566022, :name => "Kebbi", :abbreviation => 'KE'
    country.create :id => 566023, :name => "Kogi", :abbreviation => 'KO'
    country.create :id => 566024, :name => "Kwara", :abbreviation => 'KW'
    country.create :id => 566025, :name => "Lagos", :abbreviation => 'LA'
    country.create :id => 566026, :name => "Nassarawa", :abbreviation => 'NA'
    country.create :id => 566027, :name => "Niger", :abbreviation => 'NI'
    country.create :id => 566028, :name => "Ogun", :abbreviation => 'OG'
    country.create :id => 566029, :name => "Ondo", :abbreviation => 'ON'
    country.create :id => 566030, :name => "Osun", :abbreviation => 'OS'
    country.create :id => 566031, :name => "Oyo", :abbreviation => 'OY'
    country.create :id => 566032, :name => "Plateau", :abbreviation => 'PL'
    country.create :id => 566033, :name => "Rivers", :abbreviation => 'RI'
    country.create :id => 566034, :name => "Sokoto", :abbreviation => 'SO'
    country.create :id => 566035, :name => "Taraba", :abbreviation => 'TA'
    country.create :id => 566036, :name => "Yobe", :abbreviation => 'YO'
    country.create :id => 566037, :name => "Zamfara", :abbreviation => 'ZA'
  end
  
  # Nicaragua
  with_options(:country => Country['NI']) do |country|
    # Department
    country.create :id => 558001, :name => "Boaco", :abbreviation => 'BO'
    country.create :id => 558002, :name => "Carazo", :abbreviation => 'CA'
    country.create :id => 558003, :name => "Chinandega", :abbreviation => 'CI'
    country.create :id => 558004, :name => "Chontales", :abbreviation => 'CO'
    country.create :id => 558005, :name => "Estelí", :abbreviation => 'ES'
    country.create :id => 558006, :name => "Granada", :abbreviation => 'GR'
    country.create :id => 558007, :name => "Jinotega", :abbreviation => 'JI'
    country.create :id => 558008, :name => "León", :abbreviation => 'LE'
    country.create :id => 558009, :name => "Madriz", :abbreviation => 'MD'
    country.create :id => 558010, :name => "Managua", :abbreviation => 'MN'
    country.create :id => 558011, :name => "Masaya", :abbreviation => 'MS'
    country.create :id => 558012, :name => "Matagalpa", :abbreviation => 'MT'
    country.create :id => 558013, :name => "Nueva Segovia", :abbreviation => 'NS'
    country.create :id => 558014, :name => "Río San Juan", :abbreviation => 'SJ'
    country.create :id => 558015, :name => "Rivas", :abbreviation => 'RI'
    
    # Autonomous Region
    country.create :id => 558016, :name => "Atlántico Norte", :abbreviation => 'AN'
    country.create :id => 558017, :name => "Atlántico Sur", :abbreviation => 'AS'
  end
  
  # Netherlands
  with_options(:country => Country['NL']) do |country|
    country.create :id => 528001, :name => "Drenthe", :abbreviation => 'DR'
    country.create :id => 528002, :name => "Flevoland", :abbreviation => 'FL'
    country.create :id => 528003, :name => "Friesland", :abbreviation => 'FR'
    country.create :id => 528004, :name => "Gelderland", :abbreviation => 'GE'
    country.create :id => 528005, :name => "Groningen", :abbreviation => 'GR'
    country.create :id => 528006, :name => "Limburg", :abbreviation => 'LI'
    country.create :id => 528007, :name => "Noord-Brabant", :abbreviation => 'NB'
    country.create :id => 528008, :name => "Noord-Holland", :abbreviation => 'NH'
    country.create :id => 528009, :name => "Overijssel", :abbreviation => 'OV'
    country.create :id => 528010, :name => "Utrecht", :abbreviation => 'UT'
    country.create :id => 528011, :name => "Zeeland", :abbreviation => 'ZE'
    country.create :id => 528012, :name => "Zu360Holland", :abbreviation => 'ZH'
  end
  
  # Norway
  with_options(:country => Country['NO']) do |country|
    country.create :id => 578001, :name => "Østfold"
    country.create :id => 578002, :name => "Akershus"
    country.create :id => 578003, :name => "Oslo"
    country.create :id => 578004, :name => "Hedmark"
    country.create :id => 578005, :name => "Oppland"
    country.create :id => 578006, :name => "Buskerud"
    country.create :id => 578007, :name => "Vestfold"
    country.create :id => 578008, :name => "Telemark"
    country.create :id => 578009, :name => "Aust-Agder"
    country.create :id => 578010, :name => "Vest-Agder"
    country.create :id => 578011, :name => "Rogaland"
    country.create :id => 578012, :name => "Hordaland"
    country.create :id => 578014, :name => "Sogn og Fjordane"
    country.create :id => 578015, :name => "Møre og Romsdal"
    country.create :id => 578016, :name => "Sør-Trøndelag"
    country.create :id => 578017, :name => "Nord-Trøndelag"
    country.create :id => 578018, :name => "Nordland"
    country.create :id => 578019, :name => "Troms"
    country.create :id => 578020, :name => "Finnmark"
    country.create :id => 578021, :name => "Svalbard"
    country.create :id => 578022, :name => "Jan Mayen"
  end
  
  # Nauru
  with_options(:country => Country['NR']) do |country|
    country.create :id => 520001, :name => "Aiwo"
    country.create :id => 520002, :name => "Anabar"
    country.create :id => 520003, :name => "Anetan"
    country.create :id => 520004, :name => "Anibare"
    country.create :id => 520005, :name => "Baiti"
    country.create :id => 520006, :name => "Boe"
    country.create :id => 520007, :name => "Buada"
    country.create :id => 520008, :name => "Denigomodu"
    country.create :id => 520009, :name => "Ewa"
    country.create :id => 520010, :name => "Ijuw"
    country.create :id => 520011, :name => "Meneng"
    country.create :id => 520012, :name => "Nibok"
    country.create :id => 520013, :name => "Uaboe"
    country.create :id => 520014, :name => "Yaren"
  end
  
  # New Zealand
  with_options(:country => Country['NZ']) do |country|
    # Regional council
    country.create :id => 554001, :name => "Auckland", :abbreviation => 'AUK'
    country.create :id => 554002, :name => "Bay of Plenty", :abbreviation => 'BOP'
    country.create :id => 554003, :name => "Canterbury", :abbreviation => 'CAN'
    country.create :id => 554004, :name => "Hawkes Bay", :abbreviation => 'HKB'
    country.create :id => 554005, :name => "Manawatu-Wanganui", :abbreviation => 'MWT'
    country.create :id => 554006, :name => "Northland", :abbreviation => 'NTL'
    country.create :id => 554007, :name => "Otago", :abbreviation => 'OTA'
    country.create :id => 554008, :name => "Southland", :abbreviation => 'STL'
    country.create :id => 554009, :name => "Taranaki", :abbreviation => 'TKI'
    country.create :id => 554010, :name => "Waikato", :abbreviation => 'WKO'
    country.create :id => 554011, :name => "Wellington", :abbreviation => 'WGN'
    country.create :id => 554012, :name => "West Coast", :abbreviation => 'WTC'
    
    # Unitary authority
    country.create :id => 554013, :name => "Gisborne", :abbreviation => 'GIS'
    country.create :id => 554014, :name => "Marlborough", :abbreviation => 'MBH'
    country.create :id => 554015, :name => "Nelson", :abbreviation => 'NSN'
    country.create :id => 554016, :name => "Tasman", :abbreviation => 'TAS'
  end
  
  # Oman
  with_options(:country => Country['OM']) do |country|
    # Region
    country.create :id => 512001, :name => "Ad Dakhillyah", :abbreviation => 'DA'
    country.create :id => 512002, :name => "Al Batinah", :abbreviation => 'BA'
    country.create :id => 512003, :name => "Al Wusta", :abbreviation => 'WU'
    country.create :id => 512004, :name => "Ash Sharqlyah", :abbreviation => 'SH'
    country.create :id => 512005, :name => "Az Zahirah", :abbreviation => 'ZA'
    country.create :id => 512006, :name => "Al Janblyah", :abbreviation => 'JA'
    
    # Governorate
    country.create :id => 512007, :name => "Masqat", :abbreviation => 'MA'
    country.create :id => 512008, :name => "Musandam", :abbreviation => 'MU'
  end
  
  # Panama
  with_options(:country => Country['PA']) do |country|
    country.create :id => 591000, :name => "Kuna Yala"
    country.create :id => 591001, :name => "Bocas del Toro"
    country.create :id => 591002, :name => "Coclé"
    country.create :id => 591003, :name => "Colón"
    country.create :id => 591004, :name => "Chiriquí"
    country.create :id => 591005, :name => "Darién"
    country.create :id => 591006, :name => "Herrera"
    country.create :id => 591007, :name => "Los Santos"
    country.create :id => 591008, :name => "Panamá"
    country.create :id => 591009, :name => "Veraguas"
  end
  
  # Peru
  with_options(:country => Country['PE']) do |country|
    country.create :id => 604001, :name => "El Callao", :abbreviation => 'CAL'
    country.create :id => 604002, :name => "Amazonas", :abbreviation => 'AMA'
    country.create :id => 604003, :name => "Ancash", :abbreviation => 'ANC'
    country.create :id => 604004, :name => "Apurímac", :abbreviation => 'APU'
    country.create :id => 604005, :name => "Arequipa", :abbreviation => 'ARE'
    country.create :id => 604006, :name => "Ayacucho", :abbreviation => 'AYA'
    country.create :id => 604007, :name => "Cajamarca", :abbreviation => 'CAJ'
    country.create :id => 604008, :name => "Cusco", :abbreviation => 'CUS'
    country.create :id => 604009, :name => "Huancavelica", :abbreviation => 'HUV'
    country.create :id => 604010, :name => "Huánuco", :abbreviation => 'HUC'
    country.create :id => 604011, :name => "Ica", :abbreviation => 'ICA'
    country.create :id => 604012, :name => "Junín", :abbreviation => 'JUN'
    country.create :id => 604013, :name => "La Libertad", :abbreviation => 'LAL'
    country.create :id => 604014, :name => "Lambayeque", :abbreviation => 'LAM'
    country.create :id => 604015, :name => "Lima", :abbreviation => 'LIM'
    country.create :id => 604016, :name => "Loreto", :abbreviation => 'LOR'
    country.create :id => 604017, :name => "Madre de Dios", :abbreviation => 'MDD'
    country.create :id => 604018, :name => "Moquegua", :abbreviation => 'MOQ'
    country.create :id => 604019, :name => "Pasco", :abbreviation => 'PAS'
    country.create :id => 604020, :name => "Piura", :abbreviation => 'PIU'
    country.create :id => 604021, :name => "Puno", :abbreviation => 'PUN'
    country.create :id => 604022, :name => "San Martín", :abbreviation => 'SAM'
    country.create :id => 604023, :name => "Tacna", :abbreviation => 'TAC'
    country.create :id => 604024, :name => "Tumbes", :abbreviation => 'TUM'
    country.create :id => 604025, :name => "Ucayali", :abbreviation => 'UCA'
  end
  
  # Papua New Guinea
  with_options(:country => Country['PG']) do |country|
    # District
    country.create :id => 598001, :name => "Port Moresby", :abbreviation => 'NCD'
    
    # Province
    country.create :id => 598002, :name => "Central", :abbreviation => 'CPM'
    country.create :id => 598003, :name => "Chimbu", :abbreviation => 'CPK'
    country.create :id => 598004, :name => "Eastern Highlands", :abbreviation => 'EHG'
    country.create :id => 598005, :name => "East New Britain", :abbreviation => 'EBR'
    country.create :id => 598006, :name => "East Sepik", :abbreviation => 'ESW'
    country.create :id => 598007, :name => "Enga", :abbreviation => 'EPW'
    country.create :id => 598008, :name => "Gulf", :abbreviation => 'GPK'
    country.create :id => 598009, :name => "Madang", :abbreviation => 'MPM'
    country.create :id => 598010, :name => "Manus", :abbreviation => 'MRL'
    country.create :id => 598011, :name => "Milne Bay", :abbreviation => 'MBA'
    country.create :id => 598012, :name => "Morobe", :abbreviation => 'MPL'
    country.create :id => 598013, :name => "New Ireland", :abbreviation => 'NIK'
    country.create :id => 598014, :name => "Northern", :abbreviation => 'NPP'
    country.create :id => 598015, :name => "North Solomons", :abbreviation => 'NSA'
    country.create :id => 598016, :name => "Sandaun", :abbreviation => 'SAN'
    country.create :id => 598017, :name => "Southern Highlands", :abbreviation => 'SHM'
    country.create :id => 598018, :name => "Western", :abbreviation => 'WPD'
    country.create :id => 598019, :name => "Western Highlands", :abbreviation => 'WHM'
    country.create :id => 598020, :name => "West New Britain", :abbreviation => 'WBK'
  end
  
  # Philippines
  with_options(:country => Country['PH']) do |country|
    country.create :id => 608001, :name => "Abra", :abbreviation => 'ABR'
    country.create :id => 608002, :name => "Agusan del Norte", :abbreviation => 'AGN'
    country.create :id => 608003, :name => "Agusan del Sur", :abbreviation => 'AGS'
    country.create :id => 608004, :name => "Aklan", :abbreviation => 'AKL'
    country.create :id => 608005, :name => "Albay", :abbreviation => 'ALB'
    country.create :id => 608006, :name => "Antique", :abbreviation => 'ANT'
    country.create :id => 608007, :name => "Apayao", :abbreviation => 'APA'
    country.create :id => 608008, :name => "Aurora", :abbreviation => 'AUR'
    country.create :id => 608009, :name => "Basilan", :abbreviation => 'BAS'
    country.create :id => 608010, :name => "Batasn", :abbreviation => 'BAN'
    country.create :id => 608011, :name => "Batanes", :abbreviation => 'BTN'
    country.create :id => 608012, :name => "Batangas", :abbreviation => 'BTG'
    country.create :id => 608013, :name => "Benguet", :abbreviation => 'BEN'
    country.create :id => 608014, :name => "Biliran", :abbreviation => 'BIL'
    country.create :id => 608015, :name => "Bohol", :abbreviation => 'BOH'
    country.create :id => 608016, :name => "Bukidnon", :abbreviation => 'BUK'
    country.create :id => 608017, :name => "Bulacan", :abbreviation => 'BUL'
    country.create :id => 608018, :name => "Cagayan", :abbreviation => 'CAG'
    country.create :id => 608019, :name => "Camarines Norte", :abbreviation => 'CAN'
    country.create :id => 608020, :name => "Camarines Sur", :abbreviation => 'CAS'
    country.create :id => 608021, :name => "Camiguin", :abbreviation => 'CAM'
    country.create :id => 608022, :name => "Capiz", :abbreviation => 'CAP'
    country.create :id => 608023, :name => "Catanduanes", :abbreviation => 'CAT'
    country.create :id => 608024, :name => "Cavite", :abbreviation => 'CAV'
    country.create :id => 608025, :name => "Cebu", :abbreviation => 'CEB'
    country.create :id => 608026, :name => "Compostela Valley", :abbreviation => 'COM'
    country.create :id => 608027, :name => "Davao del Norte", :abbreviation => 'DAV'
    country.create :id => 608028, :name => "Davao del Sur", :abbreviation => 'DAS'
    country.create :id => 608029, :name => "Davao Oriental", :abbreviation => 'DAO'
    country.create :id => 608030, :name => "Eastern Samar", :abbreviation => 'EAS'
    country.create :id => 608031, :name => "Guimaras", :abbreviation => 'GUI'
    country.create :id => 608032, :name => "Ifugao", :abbreviation => 'IFU'
    country.create :id => 608033, :name => "Ilocos Norte", :abbreviation => 'ILN'
    country.create :id => 608034, :name => "Ilocos Sur", :abbreviation => 'ILS'
    country.create :id => 608035, :name => "Iloilo", :abbreviation => 'ILI'
    country.create :id => 608036, :name => "Isabela", :abbreviation => 'ISA'
    country.create :id => 608037, :name => "Kalinga-Apayso", :abbreviation => 'KAL'
    country.create :id => 608038, :name => "Laguna", :abbreviation => 'LAG'
    country.create :id => 608039, :name => "Lanao del Norte", :abbreviation => 'LAN'
    country.create :id => 608040, :name => "Lanao del Sur", :abbreviation => 'LAS'
    country.create :id => 608041, :name => "La Union", :abbreviation => 'LUN'
    country.create :id => 608042, :name => "Leyte", :abbreviation => 'LEY'
    country.create :id => 608043, :name => "Maguindanao", :abbreviation => 'MAG'
    country.create :id => 608044, :name => "Marinduque", :abbreviation => 'MAD'
    country.create :id => 608045, :name => "Masbate", :abbreviation => 'MAS'
    country.create :id => 608046, :name => "Mindoro Occidental", :abbreviation => 'MDC'
    country.create :id => 608047, :name => "Mindoro Oriental", :abbreviation => 'MDR'
    country.create :id => 608048, :name => "Misamis Occidental", :abbreviation => 'MSC'
    country.create :id => 608049, :name => "Misamis Oriental", :abbreviation => 'MSR'
    country.create :id => 608050, :name => "Mountain Province", :abbreviation => 'MOU'
    country.create :id => 608051, :name => "Negroe Occidental", :abbreviation => 'NEC'
    country.create :id => 608052, :name => "Negros Oriental", :abbreviation => 'NER'
    country.create :id => 608053, :name => "North Cotabato", :abbreviation => 'NCO'
    country.create :id => 608054, :name => "Northern Samar", :abbreviation => 'NSA'
    country.create :id => 608055, :name => "Nueva Ecija", :abbreviation => 'NUE'
    country.create :id => 608056, :name => "Nueva Vizcaya", :abbreviation => 'NUV'
    country.create :id => 608057, :name => "Palawan", :abbreviation => 'PLW'
    country.create :id => 608058, :name => "Pampanga", :abbreviation => 'PAM'
    country.create :id => 608059, :name => "Pangasinan", :abbreviation => 'PAN'
    country.create :id => 608060, :name => "Quezon", :abbreviation => 'QUE'
    country.create :id => 608061, :name => "Quirino", :abbreviation => 'QUI'
    country.create :id => 608062, :name => "Rizal", :abbreviation => 'RIZ'
    country.create :id => 608063, :name => "Romblon", :abbreviation => 'ROM'
    country.create :id => 608064, :name => "Sarangani", :abbreviation => 'SAR'
    country.create :id => 608065, :name => "Siquijor", :abbreviation => 'SIG'
    country.create :id => 608066, :name => "Sorsogon", :abbreviation => 'SOR'
    country.create :id => 608067, :name => "South Cotabato", :abbreviation => 'SCO'
    country.create :id => 608068, :name => "Southern Leyte", :abbreviation => 'SLE'
    country.create :id => 608069, :name => "Sultan Kudarat", :abbreviation => 'SUK'
    country.create :id => 608070, :name => "Sulu", :abbreviation => 'SLU'
    country.create :id => 608071, :name => "Surigao del Norte", :abbreviation => 'SUN'
    country.create :id => 608072, :name => "Surigao del Sur", :abbreviation => 'SUR'
    country.create :id => 608073, :name => "Tarlac", :abbreviation => 'TAR'
    country.create :id => 608074, :name => "Tawi-Tawi", :abbreviation => 'TAW'
    country.create :id => 608075, :name => "Western Samar", :abbreviation => 'WSA'
    country.create :id => 608076, :name => "Zambales", :abbreviation => 'ZMB'
    country.create :id => 608077, :name => "Zamboanga del Norte", :abbreviation => 'ZAN'
    country.create :id => 608078, :name => "Zamboanga del Sur", :abbreviation => 'ZAS'
    country.create :id => 608079, :name => "Zamboanga Sibiguey", :abbreviation => 'ZSI'
  end
  
  # Pakistan
  with_options(:country => Country['PK']) do |country|
    # Capital territory
    country.create :id => 586001, :name => "Islamabad", :abbreviation => 'IS'
    
    # Province
    country.create :id => 586002, :name => "Balochistan", :abbreviation => 'BA'
    country.create :id => 586003, :name => "North-West Frontier", :abbreviation => 'NW'
    country.create :id => 586004, :name => "Punjab", :abbreviation => 'PB'
    country.create :id => 586005, :name => "Sindh", :abbreviation => 'SD'
    country.create :id => 586006, :name => "Federally Administered Tribal Areas", :abbreviation => 'TA'
    country.create :id => 586007, :name => "Azad Rashmir", :abbreviation => 'JK'
    country.create :id => 586008, :name => "Northern Areas", :abbreviation => 'NA'
  end
  
  # Poland
  with_options(:country => Country['PL']) do |country|
    country.create :id => 616001, :name => "Dolnośląskie", :abbreviation => 'DS'
    country.create :id => 616002, :name => "Kujawsko-pomorskie", :abbreviation => 'KP'
    country.create :id => 616003, :name => "Lubelskie", :abbreviation => 'LU'
    country.create :id => 616004, :name => "Lubuskie", :abbreviation => 'LB'
    country.create :id => 616005, :name => "Łódzkie", :abbreviation => 'LD'
    country.create :id => 616006, :name => "Małopolskie", :abbreviation => 'MA'
    country.create :id => 616007, :name => "Mazowieckie", :abbreviation => 'MZ'
    country.create :id => 616008, :name => "Opolskie", :abbreviation => 'OP'
    country.create :id => 616009, :name => "Podkarpackie", :abbreviation => 'PK'
    country.create :id => 616010, :name => "Podlaskie", :abbreviation => 'PD'
    country.create :id => 616011, :name => "Pomorskie", :abbreviation => 'PM'
    country.create :id => 616012, :name => "Śląskie", :abbreviation => 'SL'
    country.create :id => 616013, :name => "Świętokrzyskie", :abbreviation => 'SK'
    country.create :id => 616014, :name => "Warmińsko-mazurskie", :abbreviation => 'WN'
    country.create :id => 616015, :name => "Wielkopolskie", :abbreviation => 'WP'
    country.create :id => 616016, :name => "Zachodniopomorskie", :abbreviation => 'ZP'
  end
  
  # Portugal
  with_options(:country => Country['PT']) do |country|
    country.create :id => 620001, :name => "Aveiro"
    country.create :id => 620002, :name => "Beja"
    country.create :id => 620003, :name => "Braga"
    country.create :id => 620004, :name => "Bragança"
    country.create :id => 620005, :name => "Castelo Branco"
    country.create :id => 620006, :name => "Coimbra"
    country.create :id => 620007, :name => "Évora"
    country.create :id => 620008, :name => "Faro"
    country.create :id => 620009, :name => "Guarda"
    country.create :id => 620010, :name => "Leiria"
    country.create :id => 620011, :name => "Lisboa"
    country.create :id => 620012, :name => "Portalegre"
    country.create :id => 620013, :name => "Porto"
    country.create :id => 620014, :name => "Santarém"
    country.create :id => 620015, :name => "Setúbal"
    country.create :id => 620016, :name => "Viana do Castelo"
    country.create :id => 620017, :name => "Vila Real"
    country.create :id => 620018, :name => "Viseu"
    country.create :id => 620020, :name => "Região Autónoma dos Açores"
    country.create :id => 620030, :name => "Região Autónoma da Madeira"
  end
  
  # Palau
  with_options(:country => Country['PW']) do |country|
    country.create :id => 585002, :name => "Aimeliik"
    country.create :id => 585004, :name => "Airai"
    country.create :id => 585010, :name => "Angaur"
    country.create :id => 585050, :name => "Hatobohei"
    country.create :id => 585100, :name => "Kayangel"
    country.create :id => 585150, :name => "Koror"
    country.create :id => 585212, :name => "Melekeok"
    country.create :id => 585214, :name => "Ngaraard"
    country.create :id => 585218, :name => "Ngarchelong"
    country.create :id => 585222, :name => "Ngardmau"
    country.create :id => 585224, :name => "Ngatpang"
    country.create :id => 585226, :name => "Ngchesar"
    country.create :id => 585227, :name => "Ngeremlengui"
    country.create :id => 585228, :name => "Ngiwal"
    country.create :id => 585350, :name => "Peleliu"
    country.create :id => 585370, :name => "Sonsorol"
  end
  
  # Paraguay
  with_options(:country => Country['PY']) do |country|
    # Department
    country.create :id => 600001, :name => "Concepción"
    country.create :id => 600010, :name => "Alto Paraná"
    country.create :id => 600011, :name => "Central"
    country.create :id => 600012, :name => "Ñeembucú"
    country.create :id => 600013, :name => "Amambay"
    country.create :id => 600014, :name => "Canindeyú"
    country.create :id => 600015, :name => "Presidente Hayes"
    country.create :id => 600016, :name => "Alto Paraguay"
    country.create :id => 600019, :name => "Boquerón"
    country.create :id => 600002, :name => "San Pedro"
    country.create :id => 600003, :name => "Cordillera"
    country.create :id => 600004, :name => "Guairá"
    country.create :id => 600005, :name => "Caaguazú"
    country.create :id => 600006, :name => "Caazapá"
    country.create :id => 600007, :name => "Itapúa"
    country.create :id => 600008, :name => "Misiones"
    country.create :id => 600009, :name => "Paraguarí"
    
    # Capital district
    country.create :id => 600100, :name => "Asunción", :abbreviation => 'ASU'
  end
  
  # Qatar
  with_options(:country => Country['QA']) do |country|
    country.create :id => 634001, :name => "Ad Dawhah", :abbreviation => 'DA'
    country.create :id => 634002, :name => "Al Ghuwayriyah", :abbreviation => 'GH'
    country.create :id => 634003, :name => "Al Jumayliyah", :abbreviation => 'JU'
    country.create :id => 634004, :name => "Al Khawr", :abbreviation => 'KH'
    country.create :id => 634005, :name => "Al Wakrah", :abbreviation => 'WA'
    country.create :id => 634006, :name => "Ar Rayyan", :abbreviation => 'RA'
    country.create :id => 634007, :name => "Jariyan al Batnah", :abbreviation => 'JB'
    country.create :id => 634008, :name => "Madinat ash Shamal", :abbreviation => 'MS'
    country.create :id => 634009, :name => "Umm Salal", :abbreviation => 'US'
  end
  
  # Romania
  with_options(:country => Country['RO']) do |country|
    # Department
    country.create :id => 642001, :name => "Alba", :abbreviation => 'AB'
    country.create :id => 642002, :name => "Arad", :abbreviation => 'AR'
    country.create :id => 642003, :name => "Argeş", :abbreviation => 'AG'
    country.create :id => 642004, :name => "Bacău", :abbreviation => 'BC'
    country.create :id => 642005, :name => "Bihor", :abbreviation => 'BH'
    country.create :id => 642006, :name => "Bistriţa-Năsăud", :abbreviation => 'BN'
    country.create :id => 642007, :name => "Botoşani", :abbreviation => 'BT'
    country.create :id => 642008, :name => "Braşov", :abbreviation => 'BV'
    country.create :id => 642009, :name => "Brăila", :abbreviation => 'BR'
    country.create :id => 642010, :name => "Buzău", :abbreviation => 'BZ'
    country.create :id => 642011, :name => "Caraş-Severin", :abbreviation => 'CS'
    country.create :id => 642012, :name => "Călăraşi", :abbreviation => 'CL'
    country.create :id => 642013, :name => "Cluj", :abbreviation => 'CJ'
    country.create :id => 642014, :name => "Constanţa", :abbreviation => 'CT'
    country.create :id => 642015, :name => "Covasna", :abbreviation => 'CV'
    country.create :id => 642016, :name => "Dâmboviţa", :abbreviation => 'DB'
    country.create :id => 642017, :name => "Dolj", :abbreviation => 'DJ'
    country.create :id => 642018, :name => "Galaţi", :abbreviation => 'GL'
    country.create :id => 642019, :name => "Giurgiu", :abbreviation => 'GR'
    country.create :id => 642020, :name => "Gorj", :abbreviation => 'GJ'
    country.create :id => 642021, :name => "Harghita", :abbreviation => 'HR'
    country.create :id => 642022, :name => "Hunedoara", :abbreviation => 'HD'
    country.create :id => 642023, :name => "Ialomiţa", :abbreviation => 'IL'
    country.create :id => 642024, :name => "Iaşi", :abbreviation => 'IS'
    country.create :id => 642025, :name => "Ilfov", :abbreviation => 'IF'
    country.create :id => 642026, :name => "Maramureş", :abbreviation => 'MM'
    country.create :id => 642027, :name => "Mehedinţi", :abbreviation => 'MH'
    country.create :id => 642028, :name => "Mureş", :abbreviation => 'MS'
    country.create :id => 642029, :name => "Neamţ", :abbreviation => 'NT'
    country.create :id => 642030, :name => "Olt", :abbreviation => 'OT'
    country.create :id => 642031, :name => "Prahova", :abbreviation => 'PH'
    country.create :id => 642032, :name => "Satu Mare", :abbreviation => 'SM'
    country.create :id => 642033, :name => "Sălaj", :abbreviation => 'SJ'
    country.create :id => 642034, :name => "Sibiu", :abbreviation => 'SB'
    country.create :id => 642035, :name => "Suceava", :abbreviation => 'SV'
    country.create :id => 642036, :name => "Teleorman", :abbreviation => 'TR'
    country.create :id => 642037, :name => "Timiş", :abbreviation => 'TM'
    country.create :id => 642038, :name => "Tulcea", :abbreviation => 'TL'
    country.create :id => 642039, :name => "Vaslui", :abbreviation => 'VS'
    country.create :id => 642040, :name => "Vâlcea", :abbreviation => 'VL'
    country.create :id => 642041, :name => "Vrancea", :abbreviation => 'VN'
    
    # Municipality
    country.create :id => 642042, :name => "Bucureşti", :abbreviation => 'B'
  end
  
  # Serbia
  with_options(:country => Country['RS']) do |country|
    # Beograd
    country.create :id => 688000, :name => "Beograd"
    
    # District
    country.create :id => 688001, :name => "Severna Bačka"
    country.create :id => 688002, :name => "Srednji Banat"
    country.create :id => 688003, :name => "Severni Banat"
    country.create :id => 688004, :name => "Južni Banat"
    country.create :id => 688005, :name => "Zapadna Bačka"
    country.create :id => 688006, :name => "Južna Bačka"
    country.create :id => 688007, :name => "Srem"
    country.create :id => 688008, :name => "Mačva"
    country.create :id => 688009, :name => "Kolubara"
    country.create :id => 688010, :name => "Podunavlje"
    country.create :id => 688011, :name => "Braničevo"
    country.create :id => 688012, :name => "Šumadija"
    country.create :id => 688013, :name => "Pomoravlje"
    country.create :id => 688014, :name => "Bor"
    country.create :id => 688015, :name => "Zaječar"
    country.create :id => 688016, :name => "Zlatibor"
    country.create :id => 688017, :name => "Moravica"
    country.create :id => 688018, :name => "Raška"
    country.create :id => 688019, :name => "Rasina"
    country.create :id => 688020, :name => "Nišava"
    country.create :id => 688021, :name => "Toplica"
    country.create :id => 688022, :name => "Pirot"
    country.create :id => 688023, :name => "Jablanica"
    country.create :id => 688024, :name => "Pčinja"
    country.create :id => 688025, :name => "Kosovo"
    country.create :id => 688026, :name => "Peć"
    country.create :id => 688027, :name => "Prizren"
    country.create :id => 688028, :name => "Kosovska Mitrovica"
    country.create :id => 688029, :name => "Kosovo-Pomoravlje"
  end
  
  # Russian Federation
  with_options(:country => Country['RU']) do |country|
    # Republic
    country.create :id => 643001, :name => "Adygeya", :abbreviation => 'AD'
    country.create :id => 643002, :name => "Altay", :abbreviation => 'AL'
    country.create :id => 643003, :name => "Bashkortostan", :abbreviation => 'BA'
    country.create :id => 643004, :name => "Buryatiya", :abbreviation => 'BU'
    country.create :id => 643005, :name => "Chechenskaya Respublika", :abbreviation => 'CE'
    country.create :id => 643006, :name => "Chuvashskaya Respublika", :abbreviation => 'CU'
    country.create :id => 643007, :name => "Dagestan", :abbreviation => 'DA'
    country.create :id => 643008, :name => "Respublika Ingushetiya", :abbreviation => 'IN'
    country.create :id => 643009, :name => "Kabardino-Balkarskaya", :abbreviation => 'KB'
    country.create :id => 643010, :name => "Kalmykiya", :abbreviation => 'KL'
    country.create :id => 643011, :name => "Karachayevo-Cherkesskaya", :abbreviation => 'KC'
    country.create :id => 643012, :name => "Kareliya", :abbreviation => 'KR'
    country.create :id => 643013, :name => "Khakasiya", :abbreviation => 'KK'
    country.create :id => 643014, :name => "Komi", :abbreviation => 'KO'
    country.create :id => 643015, :name => "Mariy El", :abbreviation => 'ME'
    country.create :id => 643016, :name => "Mordoviya", :abbreviation => 'MO'
    country.create :id => 643017, :name => "Sakha", :abbreviation => 'SA' # Yakutiya
    country.create :id => 643018, :name => "Severnaya Osetiya-Alaniya", :abbreviation => 'SE'
    country.create :id => 643019, :name => "Tatarstan", :abbreviation => 'TA'
    country.create :id => 643020, :name => "Tyva", :abbreviation => 'TY' # Tuva
    country.create :id => 643021, :name => "Udmurtskaya", :abbreviation => 'UD'
    
    # Territory
    country.create :id => 643022, :name => "Altayskiy", :abbreviation => 'ALT'
    country.create :id => 643023, :name => "Kamchatskiy", :abbreviation => 'KAM'
    country.create :id => 643024, :name => "Khabarovskiy", :abbreviation => 'KHA'
    country.create :id => 643025, :name => "Krasnodarskiy", :abbreviation => 'KDA'
    country.create :id => 643026, :name => "Krasnoyarskiy", :abbreviation => 'KYA'
    country.create :id => 643027, :name => "Permskiy", :abbreviation => 'PER'
    country.create :id => 643028, :name => "Primorskiy", :abbreviation => 'PRI'
    country.create :id => 643029, :name => "Stavropol'skiy", :abbreviation => 'STA'
    country.create :id => 643030, :name => "Amurskaya", :abbreviation => 'AMU'
    
    # Administrative region
    country.create :id => 643031, :name => "Arkhangel'skaya", :abbreviation => 'ARK'
    country.create :id => 643032, :name => "Astrakhanskaya", :abbreviation => 'AST'
    country.create :id => 643033, :name => "Belgorodskaya", :abbreviation => 'BEL'
    country.create :id => 643034, :name => "Bryanskaya", :abbreviation => 'BRY'
    country.create :id => 643035, :name => "Chelyabinskaya", :abbreviation => 'CHE'
    country.create :id => 643036, :name => "Chitinskaya", :abbreviation => 'CHI'
    country.create :id => 643037, :name => "Irkutiskaya", :abbreviation => 'IRK'
    country.create :id => 643038, :name => "Ivanovskaya", :abbreviation => 'IVA'
    country.create :id => 643039, :name => "Kaliningradskaya", :abbreviation => 'KGD'
    country.create :id => 643040, :name => "Kaluzhskaya", :abbreviation => 'KLU'
    country.create :id => 643041, :name => "Kemerovskaya", :abbreviation => 'KEM'
    country.create :id => 643042, :name => "Kirovskaya", :abbreviation => 'KIR'
    country.create :id => 643043, :name => "Kostromskaya", :abbreviation => 'KOS'
    country.create :id => 643044, :name => "Kurganskaya", :abbreviation => 'KGN'
    country.create :id => 643045, :name => "Kurskaya", :abbreviation => 'KRS'
    country.create :id => 643046, :name => "Leningradskaya", :abbreviation => 'LEN'
    country.create :id => 643047, :name => "Lipetskaya", :abbreviation => 'LIP'
    country.create :id => 643048, :name => "Magadanskaya", :abbreviation => 'MAG'
    country.create :id => 643049, :name => "Moskovskaya", :abbreviation => 'MOS'
    country.create :id => 643050, :name => "Murmanskaya", :abbreviation => 'MUR'
    country.create :id => 643051, :name => "Nizhegorodskaya", :abbreviation => 'NIZ'
    country.create :id => 643052, :name => "Novgorodskaya", :abbreviation => 'NGR'
    country.create :id => 643053, :name => "Novosibirskaya", :abbreviation => 'NVS'
    country.create :id => 643054, :name => "Omskaya", :abbreviation => 'OMS'
    country.create :id => 643055, :name => "Orenburgskaya", :abbreviation => 'ORE'
    country.create :id => 643056, :name => "Orlovskaya", :abbreviation => 'ORL'
    country.create :id => 643057, :name => "Penzenskaya", :abbreviation => 'PNZ'
    country.create :id => 643058, :name => "Pskovskaya", :abbreviation => 'PSK'
    country.create :id => 643059, :name => "Rostovskaya", :abbreviation => 'ROS'
    country.create :id => 643060, :name => "Ryazanskaya", :abbreviation => 'RYA'
    country.create :id => 643061, :name => "Sakhalinskaya", :abbreviation => 'SAK'
    country.create :id => 643062, :name => "Samaraskaya", :abbreviation => 'SAM'
    country.create :id => 643063, :name => "Saratovskaya", :abbreviation => 'SAR'
    country.create :id => 643064, :name => "Smolenskaya", :abbreviation => 'SMO'
    country.create :id => 643065, :name => "Sverdlovskaya", :abbreviation => 'SVE'
    country.create :id => 643066, :name => "Tambovskaya", :abbreviation => 'TAM'
    country.create :id => 643067, :name => "Tomskaya", :abbreviation => 'TOM'
    country.create :id => 643068, :name => "Tul'skaya", :abbreviation => 'TUL'
    country.create :id => 643069, :name => "Tverskaya", :abbreviation => 'TVE'
    country.create :id => 643070, :name => "Tyumenskaya", :abbreviation => 'TYU'
    country.create :id => 643071, :name => "Ul'yanovskaya", :abbreviation => 'ULY'
    country.create :id => 643072, :name => "Vladimirskaya", :abbreviation => 'VLA'
    country.create :id => 643073, :name => "Volgogradskaya", :abbreviation => 'VGG'
    country.create :id => 643074, :name => "Vologodskaya", :abbreviation => 'VLG'
    country.create :id => 643075, :name => "Voronezhskaya", :abbreviation => 'VOR'
    country.create :id => 643076, :name => "Yaroslavskaya", :abbreviation => 'YAR'
    country.create :id => 643077, :name => "Moskva", :abbreviation => 'MOW'
    country.create :id => 643078, :name => "Sankt-Peterburg", :abbreviation => 'SPE'
    
    # Autonomous city
    country.create :id => 643079, :name => "Yevreyskaya", :abbreviation => 'YEV'
    
    # Autonomous district
    country.create :id => 643080, :name => "Aginsky Buryatskiy", :abbreviation => 'AGB'
    country.create :id => 643081, :name => "Chukotskiy", :abbreviation => 'CHU'
    country.create :id => 643082, :name => "Khanty-Mansiysky", :abbreviation => 'KHM'
    country.create :id => 643083, :name => "Nenetskiy", :abbreviation => 'NEN'
    country.create :id => 643084, :name => "Ust'-Ordynskiy Buryatskiy", :abbreviation => 'UOB'
    country.create :id => 643085, :name => "Yamalo-Nenetskiy", :abbreviation => 'YAN'
  end
  
  # Rwanda
  with_options(:country => Country['RW']) do |country|
    # Town council
    country.create :id => 646001, :name => "Ville de Kigali"
    
    # Province
    country.create :id => 646002, :name => "Est"
    country.create :id => 646003, :name => "Nord"
    country.create :id => 646004, :name => "Ouest"
    country.create :id => 646005, :name => "Sud"
  end
  
  # Saudi Arabia
  with_options(:country => Country['SA']) do |country|
    country.create :id => 682001, :name => "Ar Riyāḍ"
    country.create :id => 682002, :name => "Makkah"
    country.create :id => 682003, :name => "Al Madīnah"
    country.create :id => 682004, :name => "Ash Sharqīyah"
    country.create :id => 682005, :name => "Al Qaşīm"
    country.create :id => 682006, :name => "Ḥā'il"
    country.create :id => 682007, :name => "Tabūk"
    country.create :id => 682008, :name => "Al Ḥudūd ash Shamāliyah"
    country.create :id => 682009, :name => "Jīzan"
    country.create :id => 682010, :name => "Najrān"
    country.create :id => 682011, :name => "Al Bāhah"
    country.create :id => 682012, :name => "Al Jawf"
    country.create :id => 682014, :name => "`Asīr"
  end
  
  # Solomon Islands
  with_options(:country => Country['SB']) do |country|
    # Capital territory
    country.create :id => 90001, :name => "Honiara", :abbreviation => 'CT'
    
    # Province
    country.create :id => 90002, :name => "Central", :abbreviation => 'CE'
    country.create :id => 90003, :name => "Choiseul", :abbreviation => 'CH'
    country.create :id => 90004, :name => "Guadalcanal", :abbreviation => 'GU'
    country.create :id => 90005, :name => "Isabel", :abbreviation => 'IS'
    country.create :id => 90006, :name => "Makira", :abbreviation => 'MK'
    country.create :id => 90007, :name => "Malaita", :abbreviation => 'ML'
    country.create :id => 90008, :name => "Rennell and Bellona", :abbreviation => 'RB'
    country.create :id => 90009, :name => "Temotu", :abbreviation => 'TE'
    country.create :id => 90010, :name => "Western", :abbreviation => 'WE'
  end
  
  # Seychelles
  with_options(:country => Country['SC']) do |country|
    country.create :id => 690001, :name => "Anse aux Pins"
    country.create :id => 690002, :name => "Anse Boileau"
    country.create :id => 690003, :name => "Anse Étoile"
    country.create :id => 690004, :name => "Anse Louis"
    country.create :id => 690005, :name => "Anse Royale"
    country.create :id => 690006, :name => "Baie Lazare"
    country.create :id => 690007, :name => "Baie Sainte Anne"
    country.create :id => 690008, :name => "Beau Vallon"
    country.create :id => 690009, :name => "Bel Air"
    country.create :id => 690010, :name => "Bel Ombre"
    country.create :id => 690011, :name => "Cascade"
    country.create :id => 690012, :name => "Glacis"
    country.create :id => 690013, :name => "Grand' Anse (Mahé)"
    country.create :id => 690014, :name => "Grand' Anse (Praslin)"
    country.create :id => 690015, :name => "La Digue"
    country.create :id => 690016, :name => "La Rivière Anglaise"
    country.create :id => 690017, :name => "Mont Buxton"
    country.create :id => 690018, :name => "Mont Fleuri"
    country.create :id => 690019, :name => "Plaisance"
    country.create :id => 690020, :name => "Pointe La Rue"
    country.create :id => 690021, :name => "Port Glaud"
    country.create :id => 690022, :name => "Saint Louis"
    country.create :id => 690023, :name => "Takamaka"
  end
  
  # Sudan
  with_options(:country => Country['SD']) do |country|
    country.create :id => 736001, :name => "Ash Shamālīyah"
    country.create :id => 736002, :name => "Shamāl Dārfūr"
    country.create :id => 736003, :name => "Al Kharţūm"
    country.create :id => 736004, :name => "An Nīl"
    country.create :id => 736005, :name => "Kassalā"
    country.create :id => 736006, :name => "Al Qaḑārif"
    country.create :id => 736007, :name => "Al Jazīrah"
    country.create :id => 736008, :name => "An Nīl al Abyaḑ"
    country.create :id => 736009, :name => "Shamāl Kurdufān"
    country.create :id => 736011, :name => "Janūb Dārfūr"
    country.create :id => 736012, :name => "Gharb Dārfūr"
    country.create :id => 736013, :name => "Janūb Kurdufān"
    country.create :id => 736014, :name => "Gharb Baḩr al Ghazāl"
    country.create :id => 736015, :name => "Shamāl Baḩr al Ghazāl"
    country.create :id => 736016, :name => "Gharb al Istiwā'īyah"
    country.create :id => 736017, :name => "Baḩr al Jabal"
    country.create :id => 736018, :name => "Al Buḩayrāt"
    country.create :id => 736019, :name => "Sharq al Istiwā'īyah"
    country.create :id => 736020, :name => "Jūnqalī"
    country.create :id => 736021, :name => "Wārāb"
    country.create :id => 736022, :name => "Al Waḩdah"
    country.create :id => 736023, :name => "A‘ālī an Nīl"
    country.create :id => 736024, :name => "An Nīl al Azraq"
    country.create :id => 736025, :name => "Sinnār"
    country.create :id => 736026, :name => "Al Baḩr al Aḩmar"
  end
  
  # Sweden
  with_options(:country => Country['SE']) do |country|
    country.create :id => 752001, :name => "Blekinge", :abbreviation => 'K'
    country.create :id => 752002, :name => "Dalarnas", :abbreviation => 'W'
    country.create :id => 752003, :name => "Gotlands", :abbreviation => 'I'
    country.create :id => 752004, :name => "Gävleborgs", :abbreviation => 'X'
    country.create :id => 752005, :name => "Hallands", :abbreviation => 'N'
    country.create :id => 752006, :name => "Jämtlande", :abbreviation => 'Z'
    country.create :id => 752007, :name => "Jönköpings", :abbreviation => 'F'
    country.create :id => 752008, :name => "Kalmar", :abbreviation => 'H'
    country.create :id => 752009, :name => "Kronobergs", :abbreviation => 'G'
    country.create :id => 752010, :name => "Norrbottens", :abbreviation => 'BD'
    country.create :id => 752011, :name => "Skåne", :abbreviation => 'M'
    country.create :id => 752012, :name => "Stockholms", :abbreviation => 'AB'
    country.create :id => 752013, :name => "Södermanlands", :abbreviation => 'D'
    country.create :id => 752014, :name => "Uppsala", :abbreviation => 'C'
    country.create :id => 752015, :name => "Värmlands", :abbreviation => 'S'
    country.create :id => 752016, :name => "Västerbottens", :abbreviation => 'AC'
    country.create :id => 752017, :name => "Västernorrlands", :abbreviation => 'Y'
    country.create :id => 752018, :name => "Västmanlands", :abbreviation => 'U'
    country.create :id => 752019, :name => "Västra Götalands", :abbreviation => 'Q'
    country.create :id => 752020, :name => "Örebro", :abbreviation => 'T'
    country.create :id => 752021, :name => "Östergötlands", :abbreviation => 'E'
  end
  
  # Singapore
  with_options(:country => Country['SG']) do |country|
    country.create :id => 702001, :name => "Central Singapore"
    country.create :id => 702002, :name => "North East"
    country.create :id => 702003, :name => "North West"
    country.create :id => 702004, :name => "South East"
    country.create :id => 702005, :name => "South West"
  end
  
  # St. Helena
  with_options(:country => Country['SH']) do |country|
    # Dependency
    country.create :id => 654001, :name => "Saint Helena", :abbreviation => 'SH'
    country.create :id => 654002, :name => "Tristan da Cunha", :abbreviation => 'TA'
    
    # Administrative area
    country.create :id => 654003, :name => "Ascension", :abbreviation => 'AC'
  end
  
  # Slovenia
  with_options(:country => Country['SI']) do |country|
    country.create :id => 705001, :name => "Ajdovščina"
    country.create :id => 705002, :name => "Beltinci"
    country.create :id => 705003, :name => "Bled"
    country.create :id => 705004, :name => "Bohinj"
    country.create :id => 705005, :name => "Borovnica"
    country.create :id => 705006, :name => "Bovec"
    country.create :id => 705007, :name => "Brda"
    country.create :id => 705008, :name => "Brezovica"
    country.create :id => 705009, :name => "Brežice"
    country.create :id => 705010, :name => "Tišina"
    country.create :id => 705011, :name => "Celje"
    country.create :id => 705012, :name => "Cerklje na Gorenjskem"
    country.create :id => 705013, :name => "Cerknica"
    country.create :id => 705014, :name => "Cerkno"
    country.create :id => 705015, :name => "Črenšovci"
    country.create :id => 705016, :name => "Črna na Koroškem"
    country.create :id => 705017, :name => "Črnomelj"
    country.create :id => 705018, :name => "Destrnik"
    country.create :id => 705019, :name => "Divača"
    country.create :id => 705020, :name => "Dobrepolje"
    country.create :id => 705021, :name => "Dobrova-Polhov Gradec"
    country.create :id => 705022, :name => "Dol pri Ljubljani"
    country.create :id => 705023, :name => "Domžale"
    country.create :id => 705024, :name => "Dornava"
    country.create :id => 705025, :name => "Dravograd"
    country.create :id => 705026, :name => "Duplek"
    country.create :id => 705027, :name => "Gorenja vas-Poljane"
    country.create :id => 705028, :name => "Gorišnica"
    country.create :id => 705029, :name => "Gornja Radgona"
    country.create :id => 705030, :name => "Gornji Grad"
    country.create :id => 705031, :name => "Gornji Petrovci"
    country.create :id => 705032, :name => "Grosuplje"
    country.create :id => 705033, :name => "Šalovci"
    country.create :id => 705034, :name => "Hrastnik"
    country.create :id => 705035, :name => "Hrpelje-Kozina"
    country.create :id => 705036, :name => "Idrija"
    country.create :id => 705037, :name => "Ig"
    country.create :id => 705038, :name => "Ilirska Bistrica"
    country.create :id => 705039, :name => "Ivančna Gorica"
    country.create :id => 705040, :name => "Izola/Isola"
    country.create :id => 705041, :name => "Jesenice"
    country.create :id => 705042, :name => "Juršinci"
    country.create :id => 705043, :name => "Kamnik"
    country.create :id => 705044, :name => "Kanal"
    country.create :id => 705045, :name => "Kidričevo"
    country.create :id => 705046, :name => "Kobarid"
    country.create :id => 705047, :name => "Kobilje"
    country.create :id => 705048, :name => "Kočevje"
    country.create :id => 705049, :name => "Komen"
    country.create :id => 705050, :name => "Koper/Capodistria"
    country.create :id => 705051, :name => "Kozje"
    country.create :id => 705052, :name => "Kranj"
    country.create :id => 705053, :name => "Kranjska Gora"
    country.create :id => 705054, :name => "Krško"
    country.create :id => 705055, :name => "Kungota"
    country.create :id => 705056, :name => "Kuzma"
    country.create :id => 705057, :name => "Laško"
    country.create :id => 705058, :name => "Lenart"
    country.create :id => 705059, :name => "Lendava/Lendva"
    country.create :id => 705060, :name => "Litija"
    country.create :id => 705061, :name => "Ljubljana"
    country.create :id => 705062, :name => "Ljubno"
    country.create :id => 705063, :name => "Ljutomer"
    country.create :id => 705064, :name => "Logatec"
    country.create :id => 705065, :name => "Loška dolina"
    country.create :id => 705066, :name => "Loški Potok"
    country.create :id => 705067, :name => "Luče"
    country.create :id => 705068, :name => "Lukovica"
    country.create :id => 705069, :name => "Majšperk"
    country.create :id => 705070, :name => "Maribor"
    country.create :id => 705071, :name => "Medvode"
    country.create :id => 705072, :name => "Mengeš"
    country.create :id => 705073, :name => "Metlika"
    country.create :id => 705074, :name => "Mežica"
    country.create :id => 705075, :name => "Miren-Kostanjevica"
    country.create :id => 705076, :name => "Mislinja"
    country.create :id => 705077, :name => "Moravče"
    country.create :id => 705078, :name => "Moravske Toplice"
    country.create :id => 705079, :name => "Mozirje"
    country.create :id => 705080, :name => "Murska Sobota"
    country.create :id => 705081, :name => "Muta"
    country.create :id => 705082, :name => "Naklo"
    country.create :id => 705083, :name => "Nazarje"
    country.create :id => 705084, :name => "Nova Gorica"
    country.create :id => 705085, :name => "Novo mesto"
    country.create :id => 705086, :name => "Odranci"
    country.create :id => 705087, :name => "Ormož"
    country.create :id => 705088, :name => "Osilnica"
    country.create :id => 705089, :name => "Pesnica"
    country.create :id => 705090, :name => "Piran/Pirano"
    country.create :id => 705091, :name => "Pivka"
    country.create :id => 705092, :name => "Podčetrtek"
    country.create :id => 705093, :name => "Podvelka"
    country.create :id => 705094, :name => "Postojna"
    country.create :id => 705095, :name => "Preddvor"
    country.create :id => 705096, :name => "Ptuj"
    country.create :id => 705097, :name => "Puconci"
    country.create :id => 705098, :name => "Rače-Fram"
    country.create :id => 705099, :name => "Radeče"
    country.create :id => 705100, :name => "Radenci"
    country.create :id => 705101, :name => "Radlje ob Dravi"
    country.create :id => 705102, :name => "Radovljica"
    country.create :id => 705103, :name => "Ravne na Koroškem"
    country.create :id => 705104, :name => "Ribnica"
    country.create :id => 705105, :name => "Rogašovci"
    country.create :id => 705106, :name => "Rogaška Slatina"
    country.create :id => 705107, :name => "Rogatec"
    country.create :id => 705108, :name => "Ruše"
    country.create :id => 705109, :name => "Semič"
    country.create :id => 705110, :name => "Sevnica"
    country.create :id => 705111, :name => "Sežana"
    country.create :id => 705112, :name => "Slovenj Gradec"
    country.create :id => 705113, :name => "Slovenska Bistrica"
    country.create :id => 705114, :name => "Slovenske Konjice"
    country.create :id => 705115, :name => "Starše"
    country.create :id => 705116, :name => "Sveti Jurij"
    country.create :id => 705117, :name => "Šenčur"
    country.create :id => 705118, :name => "Šentilj"
    country.create :id => 705119, :name => "Šentjernej"
    country.create :id => 705120, :name => "Šentjur pri Celju"
    country.create :id => 705121, :name => "Škocjan"
    country.create :id => 705122, :name => "Škofja Loka"
    country.create :id => 705123, :name => "Škofljica"
    country.create :id => 705124, :name => "Šmarje pri Jelšah"
    country.create :id => 705125, :name => "Šmartno ob Paki"
    country.create :id => 705126, :name => "Šoštanj"
    country.create :id => 705127, :name => "Štore"
    country.create :id => 705128, :name => "Tolmin"
    country.create :id => 705129, :name => "Trbovlje"
    country.create :id => 705130, :name => "Trebnje"
    country.create :id => 705131, :name => "Tržič"
    country.create :id => 705132, :name => "Turnišče"
    country.create :id => 705133, :name => "Velenje"
    country.create :id => 705134, :name => "Velike Lašče"
    country.create :id => 705135, :name => "Videm"
    country.create :id => 705136, :name => "Vipava"
    country.create :id => 705137, :name => "Vitanje"
    country.create :id => 705138, :name => "Vodice"
    country.create :id => 705139, :name => "Vojnik"
    country.create :id => 705140, :name => "Vrhnika"
    country.create :id => 705141, :name => "Vuzenica"
    country.create :id => 705142, :name => "Zagorje ob Savi"
    country.create :id => 705143, :name => "Zavrč"
    country.create :id => 705144, :name => "Zreče"
    country.create :id => 705146, :name => "Železniki"
    country.create :id => 705147, :name => "Žiri"
    country.create :id => 705148, :name => "Benedikt"
    country.create :id => 705149, :name => "Bistrica ob Sotli"
    country.create :id => 705150, :name => "Bloke"
    country.create :id => 705151, :name => "Braslovče"
    country.create :id => 705152, :name => "Cankova"
    country.create :id => 705153, :name => "Cerkvenjak"
    country.create :id => 705154, :name => "Dobje"
    country.create :id => 705155, :name => "Dobrna"
    country.create :id => 705156, :name => "Dobrovnik/Dobronak"
    country.create :id => 705157, :name => "Dolenjske Toplice"
    country.create :id => 705158, :name => "Grad"
    country.create :id => 705159, :name => "Hajdina"
    country.create :id => 705160, :name => "Hoče-Slivnica"
    country.create :id => 705161, :name => "Hodoš/Hodos"
    country.create :id => 705162, :name => "Horjul"
    country.create :id => 705163, :name => "Jezersko"
    country.create :id => 705164, :name => "Komenda"
    country.create :id => 705165, :name => "Kostel"
    country.create :id => 705166, :name => "Križevci"
    country.create :id => 705167, :name => "Lovrenc na Pohorju"
    country.create :id => 705168, :name => "Markovci"
    country.create :id => 705169, :name => "Miklavž na Dravskem polju"
    country.create :id => 705170, :name => "Mirna Peč"
    country.create :id => 705171, :name => "Oplotnica"
    country.create :id => 705172, :name => "Podlehnik"
    country.create :id => 705173, :name => "Polzela"
    country.create :id => 705174, :name => "Prebold"
    country.create :id => 705175, :name => "Prevalje"
    country.create :id => 705176, :name => "Razkrižje"
    country.create :id => 705177, :name => "Ribnica na Pohorju"
    country.create :id => 705178, :name => "Selnica ob Dravi"
    country.create :id => 705179, :name => "Sodražica"
    country.create :id => 705180, :name => "Solčava"
    country.create :id => 705181, :name => "Sveta Ana"
    country.create :id => 705182, :name => "Sveti Andraž v Slovenskih goricah"
    country.create :id => 705183, :name => "Šempeter-Vrtojba"
    country.create :id => 705184, :name => "Tabor"
    country.create :id => 705185, :name => "Trnovska vas"
    country.create :id => 705186, :name => "Trzin"
    country.create :id => 705187, :name => "Velika Polana"
    country.create :id => 705188, :name => "Veržej"
    country.create :id => 705189, :name => "Vransko"
    country.create :id => 705190, :name => "Žalec"
    country.create :id => 705191, :name => "Žetale"
    country.create :id => 705192, :name => "Žirovnica"
    country.create :id => 705193, :name => "Žužemberk"
    country.create :id => 705194, :name => "Šmartno pri Litiji"
  end
  
  # Slovakia
  with_options(:country => Country['SK']) do |country|
    country.create :id => 703001, :name => "Banskobystrický", :abbreviation => 'BC'
    country.create :id => 703002, :name => "Bratislavský", :abbreviation => 'BL'
    country.create :id => 703003, :name => "Košický", :abbreviation => 'KI'
    country.create :id => 703004, :name => "Nitriansky", :abbreviation => 'NJ'
    country.create :id => 703005, :name => "Prešovský", :abbreviation => 'PV'
    country.create :id => 703006, :name => "Trenčiansky", :abbreviation => 'TC'
    country.create :id => 703007, :name => "Trnavský", :abbreviation => 'TA'
    country.create :id => 703008, :name => "Žilinský", :abbreviation => 'ZI'
  end
  
  # Sierra Leone
  with_options(:country => Country['SL']) do |country|
    # Area
    country.create :id => 694001, :name => "Western Area (Freetown)", :abbreviation => 'W'
    
    # Province
    country.create :id => 694002, :name => "Eastern", :abbreviation => 'E'
    country.create :id => 694003, :name => "Northern", :abbreviation => 'N'
    country.create :id => 694004, :name => "Southern (Sierra Leone)", :abbreviation => 'S'
  end
  
  # San Marino
  with_options(:country => Country['SM']) do |country|
    country.create :id => 674001, :name => "Acquaviva"
    country.create :id => 674002, :name => "Chiesanuova"
    country.create :id => 674003, :name => "Domagnano"
    country.create :id => 674004, :name => "Faetano"
    country.create :id => 674005, :name => "Fiorentino"
    country.create :id => 674006, :name => "Borgo Maggiore"
    country.create :id => 674007, :name => "San Marino"
    country.create :id => 674008, :name => "Montegiardino"
    country.create :id => 674009, :name => "Serravalle"
  end
  
  # Senegal
  with_options(:country => Country['SN']) do |country|
    country.create :id => 686001, :name => "Dakar", :abbreviation => 'DK'
    country.create :id => 686002, :name => "Diourbel", :abbreviation => 'DB'
    country.create :id => 686003, :name => "Fatick", :abbreviation => 'FK'
    country.create :id => 686004, :name => "Kaolack", :abbreviation => 'KL'
    country.create :id => 686005, :name => "Kolda", :abbreviation => 'KD'
    country.create :id => 686006, :name => "Louga", :abbreviation => 'LG'
    country.create :id => 686007, :name => "Matam", :abbreviation => 'MT'
    country.create :id => 686008, :name => "Saint-Louis", :abbreviation => 'SL'
    country.create :id => 686009, :name => "Tambacounda", :abbreviation => 'TC'
    country.create :id => 686010, :name => "Thiès", :abbreviation => 'TH'
    country.create :id => 686011, :name => "Ziguinchor", :abbreviation => 'ZG'
  end
  
  # Somalia
  with_options(:country => Country['SO']) do |country|
    country.create :id => 706001, :name => "Awdal", :abbreviation => 'AW'
    country.create :id => 706002, :name => "Bakool", :abbreviation => 'BK'
    country.create :id => 706003, :name => "Banaadir", :abbreviation => 'BN'
    country.create :id => 706004, :name => "Bari", :abbreviation => 'BR'
    country.create :id => 706005, :name => "Bay", :abbreviation => 'BY'
    country.create :id => 706006, :name => "Galguduud", :abbreviation => 'GA'
    country.create :id => 706007, :name => "Gedo", :abbreviation => 'GE'
    country.create :id => 706008, :name => "Hiirsan", :abbreviation => 'HI'
    country.create :id => 706009, :name => "Jubbada Dhexe", :abbreviation => 'JD'
    country.create :id => 706010, :name => "Jubbada Hoose", :abbreviation => 'JH'
    country.create :id => 706011, :name => "Mudug", :abbreviation => 'MU'
    country.create :id => 706012, :name => "Nugaal", :abbreviation => 'NU'
    country.create :id => 706013, :name => "Saneag", :abbreviation => 'SA'
    country.create :id => 706014, :name => "Shabeellaha Dhexe", :abbreviation => 'SD'
    country.create :id => 706015, :name => "Shabeellaha Hoose", :abbreviation => 'SH'
    country.create :id => 706016, :name => "Sool", :abbreviation => 'SO'
    country.create :id => 706017, :name => "Togdheer", :abbreviation => 'TO'
    country.create :id => 706018, :name => "Woqooyi Galbeed", :abbreviation => 'WO'
  end
  
  # Suriname
  with_options(:country => Country['SR']) do |country|
    country.create :id => 740001, :name => "Brokopondo", :abbreviation => 'BR'
    country.create :id => 740002, :name => "Commewijne", :abbreviation => 'CM'
    country.create :id => 740003, :name => "Coronie", :abbreviation => 'CR'
    country.create :id => 740004, :name => "Marowijne", :abbreviation => 'MA'
    country.create :id => 740005, :name => "Nickerie", :abbreviation => 'NI'
    country.create :id => 740006, :name => "Para", :abbreviation => 'PR'
    country.create :id => 740007, :name => "Paramaribo", :abbreviation => 'PM'
    country.create :id => 740008, :name => "Saramacca", :abbreviation => 'SA'
    country.create :id => 740009, :name => "Sipaliwini", :abbreviation => 'SI'
    country.create :id => 740010, :name => "Wanica", :abbreviation => 'WA'
  end
  
  # Sao Tome and Principe
  with_options(:country => Country['ST']) do |country|
    country.create :id => 678001, :name => "Príncipe", :abbreviation => 'P'
    country.create :id => 678002, :name => "São Tomé", :abbreviation => 'S'
  end
  
  # El Salvador
  with_options(:country => Country['SV']) do |country|
    country.create :id => 222001, :name => "Ahuachapán", :abbreviation => 'AH'
    country.create :id => 222002, :name => "Cabañas", :abbreviation => 'CA'
    country.create :id => 222003, :name => "Cuscatlán", :abbreviation => 'CU'
    country.create :id => 222004, :name => "Chalatenango", :abbreviation => 'CH'
    country.create :id => 222005, :name => "La Libertad", :abbreviation => 'LI'
    country.create :id => 222006, :name => "La Paz", :abbreviation => 'PA'
    country.create :id => 222007, :name => "La Unión", :abbreviation => 'UN'
    country.create :id => 222008, :name => "Morazán", :abbreviation => 'MO'
    country.create :id => 222009, :name => "San Miguel", :abbreviation => 'SM'
    country.create :id => 222010, :name => "San Salvador", :abbreviation => 'SS'
    country.create :id => 222011, :name => "Santa Ana", :abbreviation => 'SA'
    country.create :id => 222012, :name => "San Vicente", :abbreviation => 'SV'
    country.create :id => 222013, :name => "Sonsonate", :abbreviation => 'SO'
    country.create :id => 222014, :name => "Usulután", :abbreviation => 'US'
  end
  
  # Syrian Arab Republic
  with_options(:country => Country['SY']) do |country|
    country.create :id => 760001, :name => "Al Hasakah", :abbreviation => 'HA'
    country.create :id => 760002, :name => "Al Ladhiqiyah", :abbreviation => 'LA'
    country.create :id => 760003, :name => "Al Qunaytirah", :abbreviation => 'QU'
    country.create :id => 760004, :name => "Ar Raqqah", :abbreviation => 'RA'
    country.create :id => 760005, :name => "As Suwayda'", :abbreviation => 'SU'
    country.create :id => 760006, :name => "Dar'a", :abbreviation => 'DR'
    country.create :id => 760007, :name => "Dayr az Zawr", :abbreviation => 'DY'
    country.create :id => 760008, :name => "Dimashq", :abbreviation => 'DI'
    country.create :id => 760009, :name => "Halab", :abbreviation => 'HL'
    country.create :id => 760010, :name => "Hamah", :abbreviation => 'HM'
    country.create :id => 760011, :name => "Homs", :abbreviation => 'HI'
    country.create :id => 760012, :name => "Idlib", :abbreviation => 'ID'
    country.create :id => 760013, :name => "Rif Dimashq", :abbreviation => 'RD'
    country.create :id => 760014, :name => "Tartus", :abbreviation => 'TA'
  end
  
  # Swaziland
  with_options(:country => Country['SZ']) do |country|
    country.create :id => 748001, :name => "Hhohho", :abbreviation => 'HH'
    country.create :id => 748002, :name => "Lubombo", :abbreviation => 'LU'
    country.create :id => 748003, :name => "Manzini", :abbreviation => 'MA'
    country.create :id => 748004, :name => "Shiselweni", :abbreviation => 'SH'
  end
  
  # Chad
  with_options(:country => Country['TD']) do |country|
    country.create :id => 148001, :name => "Batha", :abbreviation => 'BA'
    country.create :id => 148002, :name => "Borkou-Ennedi-Tibesti", :abbreviation => 'BET'
    country.create :id => 148003, :name => "Chari-Baguirmi", :abbreviation => 'CB'
    country.create :id => 148004, :name => "Guéra", :abbreviation => 'GR'
    country.create :id => 148005, :name => "Hadjer Lamis", :abbreviation => 'HL'
    country.create :id => 148006, :name => "Kanem", :abbreviation => 'KA'
    country.create :id => 148007, :name => "Lac", :abbreviation => 'LC'
    country.create :id => 148008, :name => "Logone-Occidental", :abbreviation => 'LO'
    country.create :id => 148009, :name => "Logone-Oriental", :abbreviation => 'LR'
    country.create :id => 148010, :name => "Mandoul", :abbreviation => 'MA'
    country.create :id => 148011, :name => "Mayo-Kébbi-Est", :abbreviation => 'ME'
    country.create :id => 148012, :name => "Mayo-Kébbi-Ouest", :abbreviation => 'MO'
    country.create :id => 148013, :name => "Moyen-Chari", :abbreviation => 'MC'
    country.create :id => 148014, :name => "Ndjamena", :abbreviation => 'ND'
    country.create :id => 148015, :name => "Ouaddaï", :abbreviation => 'OD'
    country.create :id => 148016, :name => "Salamat", :abbreviation => 'SA'
    country.create :id => 148017, :name => "Tandjilé", :abbreviation => 'TA'
    country.create :id => 148018, :name => "Wadi Fira", :abbreviation => 'WF'
  end
  
  # Togo
  with_options(:country => Country['TG']) do |country|
    country.create :id => 768001, :name => "Centre", :abbreviation => 'C'
    country.create :id => 768002, :name => "Kara", :abbreviation => 'K'
    country.create :id => 768003, :name => "Maritime", :abbreviation => 'M'
    country.create :id => 768004, :name => "Plateaux", :abbreviation => 'P'
    country.create :id => 768005, :name => "Savannes", :abbreviation => 'S'
  end
  
  # Thailand
  with_options(:country => Country['TH']) do |country|
    # Municipality
    country.create :id => 764010, :name => "Krung Thep Maha Nakhon Bangkok"
    
    # Province
    country.create :id => 764011, :name => "Samut Prakan"
    country.create :id => 764012, :name => "Nonthaburi"
    country.create :id => 764013, :name => "Pathum Thani"
    country.create :id => 764014, :name => "Phra Nakhon Si Ayutthaya"
    country.create :id => 764015, :name => "Ang Thong"
    country.create :id => 764016, :name => "Lop Buri"
    country.create :id => 764017, :name => "Sing Buri"
    country.create :id => 764018, :name => "Chai Nat"
    country.create :id => 764019, :name => "Saraburi"
    country.create :id => 764020, :name => "Chon Buri"
    country.create :id => 764021, :name => "Rayong"
    country.create :id => 764022, :name => "Chanthaburi"
    country.create :id => 764023, :name => "Trat"
    country.create :id => 764024, :name => "Chachoengsao"
    country.create :id => 764025, :name => "Prachin Buri"
    country.create :id => 764026, :name => "Nakhon Nayok"
    country.create :id => 764027, :name => "Sa Kaeo"
    country.create :id => 764030, :name => "Nakhon Ratchasima"
    country.create :id => 764031, :name => "Buri Ram"
    country.create :id => 764032, :name => "Surin"
    country.create :id => 764033, :name => "Si Sa Ket"
    country.create :id => 764034, :name => "Ubon Ratchathani"
    country.create :id => 764035, :name => "Yasothon"
    country.create :id => 764036, :name => "Chaiyaphum"
    country.create :id => 764037, :name => "Amnat Charoen"
    country.create :id => 764039, :name => "Nong Bua Lam Phu"
    country.create :id => 764040, :name => "Khon Kaen"
    country.create :id => 764041, :name => "Udon Thani"
    country.create :id => 764042, :name => "Loei"
    country.create :id => 764043, :name => "Nong Khai"
    country.create :id => 764044, :name => "Maha Sarakham"
    country.create :id => 764045, :name => "Roi Et"
    country.create :id => 764046, :name => "Kalasin"
    country.create :id => 764047, :name => "Sakon Nakhon"
    country.create :id => 764048, :name => "Nakhon Phanom"
    country.create :id => 764049, :name => "Mukdahan"
    country.create :id => 764050, :name => "Chiang Mai"
    country.create :id => 764051, :name => "Lamphun"
    country.create :id => 764052, :name => "Lampang"
    country.create :id => 764053, :name => "Uttaradit"
    country.create :id => 764054, :name => "Phrae"
    country.create :id => 764055, :name => "Nan"
    country.create :id => 764056, :name => "Phayao"
    country.create :id => 764057, :name => "Chiang Rai"
    country.create :id => 764058, :name => "Mae Hong Son"
    country.create :id => 764060, :name => "Nakhon Sawan"
    country.create :id => 764061, :name => "Uthai Thani"
    country.create :id => 764062, :name => "Kamphaeng Phet"
    country.create :id => 764063, :name => "Tak"
    country.create :id => 764064, :name => "Sukhothai"
    country.create :id => 764065, :name => "Phitsanulok"
    country.create :id => 764066, :name => "Phichit"
    country.create :id => 764067, :name => "Phetchabun"
    country.create :id => 764070, :name => "Ratchaburi"
    country.create :id => 764071, :name => "Kanchanaburi"
    country.create :id => 764072, :name => "Suphan Buri"
    country.create :id => 764073, :name => "Nakhon Pathom"
    country.create :id => 764074, :name => "Samut Sakhon"
    country.create :id => 764075, :name => "Samut Songkhram"
    country.create :id => 764076, :name => "Phetchaburi"
    country.create :id => 764077, :name => "Prachuap Khiri Khan"
    country.create :id => 764080, :name => "Nakhon Si Thammarat"
    country.create :id => 764081, :name => "Krabi"
    country.create :id => 764082, :name => "Phangnga"
    country.create :id => 764083, :name => "Phuket"
    country.create :id => 764084, :name => "Surat Thani"
    country.create :id => 764085, :name => "Ranong"
    country.create :id => 764086, :name => "Chumphon"
    country.create :id => 764090, :name => "Songkhla"
    country.create :id => 764091, :name => "Satun"
    country.create :id => 764092, :name => "Trang"
    country.create :id => 764093, :name => "Phatthalung"
    country.create :id => 764094, :name => "Pattani"
    country.create :id => 764095, :name => "Yala"
    country.create :id => 764096, :name => "Narathiwat"
    
    # Non-numeric province
    country.create :id => 764101, :name => "Phatthaya", :abbreviation => 'S'
  end
  
  # Tajikistan
  with_options(:country => Country['TJ']) do |country|
    # Autonomous region
    country.create :id => 762001, :name => "Gorno-Badakhshan", :abbreviation => 'GB'
    
    # Region
    country.create :id => 762002, :name => "Khatlon", :abbreviation => 'KT'
    country.create :id => 762003, :name => "Sughd", :abbreviation => 'SU'
  end
  
  # Timor-Leste
  with_options(:country => Country['TL']) do |country|
    country.create :id => 626001, :name => "Aileu", :abbreviation => 'AL'
    country.create :id => 626002, :name => "Ainaro", :abbreviation => 'AN'
    country.create :id => 626003, :name => "Baucau", :abbreviation => 'BA'
    country.create :id => 626004, :name => "Bobonaro", :abbreviation => 'BO'
    country.create :id => 626005, :name => "Cova Lima", :abbreviation => 'CO'
    country.create :id => 626006, :name => "Dili", :abbreviation => 'DI'
    country.create :id => 626007, :name => "Ermera", :abbreviation => 'ER'
    country.create :id => 626008, :name => "Lautem", :abbreviation => 'LA'
    country.create :id => 626009, :name => "Liquiça", :abbreviation => 'LI'
    country.create :id => 626010, :name => "Manatuto", :abbreviation => 'MT'
    country.create :id => 626011, :name => "Manufahi", :abbreviation => 'MF'
    country.create :id => 626012, :name => "Oecussi", :abbreviation => 'OE'
    country.create :id => 626013, :name => "Viqueque", :abbreviation => 'VI'
  end
  
  # Turkmenistan
  with_options(:country => Country['TM']) do |country|
    country.create :id => 795001, :name => "Ahal", :abbreviation => 'A'
    country.create :id => 795002, :name => "Balkan", :abbreviation => 'B'
    country.create :id => 795003, :name => "Daşoguz", :abbreviation => 'D'
    country.create :id => 795004, :name => "Lebap", :abbreviation => 'L'
    country.create :id => 795005, :name => "Mary", :abbreviation => 'M'
  end
  
  # Tunisia
  with_options(:country => Country['TN']) do |country|
    country.create :id => 788011, :name => "Tunis"
    country.create :id => 788012, :name => "L'Ariana"
    country.create :id => 788013, :name => "Ben Arous"
    country.create :id => 788014, :name => "La Manouba"
    country.create :id => 788021, :name => "Nabeul"
    country.create :id => 788022, :name => "Zaghouan"
    country.create :id => 788023, :name => "Bizerte"
    country.create :id => 788031, :name => "Béja"
    country.create :id => 788032, :name => "Jendouba"
    country.create :id => 788033, :name => "Le Kef"
    country.create :id => 788034, :name => "Siliana"
    country.create :id => 788041, :name => "Kairouan"
    country.create :id => 788042, :name => "Kasserine"
    country.create :id => 788043, :name => "Sidi Bouzid"
    country.create :id => 788051, :name => "Sousse"
    country.create :id => 788052, :name => "Monastir"
    country.create :id => 788053, :name => "Mahdia"
    country.create :id => 788061, :name => "Sfax"
    country.create :id => 788071, :name => "Gafsa"
    country.create :id => 788072, :name => "Tozeur"
    country.create :id => 788073, :name => "Kebili"
    country.create :id => 788081, :name => "Gabès"
    country.create :id => 788082, :name => "Medenine"
    country.create :id => 788083, :name => "Tataouine"
  end
  
  # Tonga
  with_options(:country => Country['TO']) do |country|
    country.create :id => 776001, :name => "'Eua"
    country.create :id => 776002, :name => "Ha'apai"
    country.create :id => 776003, :name => "Niuas"
    country.create :id => 776004, :name => "Tongatapu"
    country.create :id => 776005, :name => "Vava'u"
  end
  
  # Turkey
  with_options(:country => Country['TR']) do |country|
    country.create :id => 792001, :name => "Adana"
    country.create :id => 792002, :name => "Adıyaman"
    country.create :id => 792003, :name => "Afyon"
    country.create :id => 792004, :name => "Ağrı"
    country.create :id => 792005, :name => "Amasya"
    country.create :id => 792006, :name => "Ankara"
    country.create :id => 792007, :name => "Antalya"
    country.create :id => 792008, :name => "Artvin"
    country.create :id => 792009, :name => "Aydın"
    country.create :id => 792010, :name => "Balıkesir"
    country.create :id => 792011, :name => "Bilecik"
    country.create :id => 792012, :name => "Bingöl"
    country.create :id => 792013, :name => "Bitlis"
    country.create :id => 792014, :name => "Bolu"
    country.create :id => 792015, :name => "Burdur"
    country.create :id => 792016, :name => "Bursa"
    country.create :id => 792017, :name => "Çanakkale"
    country.create :id => 792018, :name => "Çankırı"
    country.create :id => 792019, :name => "Çorum"
    country.create :id => 792020, :name => "Denizli"
    country.create :id => 792021, :name => "Diyarbakır"
    country.create :id => 792022, :name => "Edirne"
    country.create :id => 792023, :name => "Elazığ"
    country.create :id => 792024, :name => "Erzincan"
    country.create :id => 792025, :name => "Erzurum"
    country.create :id => 792026, :name => "Eskişehir"
    country.create :id => 792027, :name => "Gaziantep"
    country.create :id => 792028, :name => "Giresun"
    country.create :id => 792029, :name => "Gümüşhane"
    country.create :id => 792030, :name => "Hakkâri"
    country.create :id => 792031, :name => "Hatay"
    country.create :id => 792032, :name => "Isparta"
    country.create :id => 792033, :name => "İçel"
    country.create :id => 792034, :name => "İstanbul"
    country.create :id => 792035, :name => "İzmir"
    country.create :id => 792036, :name => "Kars"
    country.create :id => 792037, :name => "Kastamonu"
    country.create :id => 792038, :name => "Kayseri"
    country.create :id => 792039, :name => "Kırklareli"
    country.create :id => 792040, :name => "Kırşehir"
    country.create :id => 792041, :name => "Kocaeli"
    country.create :id => 792042, :name => "Konya"
    country.create :id => 792043, :name => "Kütahya"
    country.create :id => 792044, :name => "Malatya"
    country.create :id => 792045, :name => "Manisa"
    country.create :id => 792046, :name => "Kahramanmaraş"
    country.create :id => 792047, :name => "Mardin"
    country.create :id => 792048, :name => "Muğla"
    country.create :id => 792049, :name => "Muş"
    country.create :id => 792050, :name => "Nevşehir"
    country.create :id => 792051, :name => "Niğde"
    country.create :id => 792052, :name => "Ordu"
    country.create :id => 792053, :name => "Rize"
    country.create :id => 792054, :name => "Sakarya"
    country.create :id => 792055, :name => "Samsun"
    country.create :id => 792056, :name => "Siirt"
    country.create :id => 792057, :name => "Sinop"
    country.create :id => 792058, :name => "Sivas"
    country.create :id => 792059, :name => "Tekirdağ"
    country.create :id => 792060, :name => "Tokat"
    country.create :id => 792061, :name => "Trabzon"
    country.create :id => 792062, :name => "Tunceli"
    country.create :id => 792063, :name => "Şanlıurfa"
    country.create :id => 792064, :name => "Uşak"
    country.create :id => 792065, :name => "Van"
    country.create :id => 792066, :name => "Yozgat"
    country.create :id => 792067, :name => "Zonguldak"
    country.create :id => 792068, :name => "Aksaray"
    country.create :id => 792069, :name => "Bayburt"
    country.create :id => 792070, :name => "Karaman"
    country.create :id => 792071, :name => "Kırıkkale"
    country.create :id => 792072, :name => "Batman"
    country.create :id => 792073, :name => "Şırnak"
    country.create :id => 792074, :name => "Bartın"
    country.create :id => 792075, :name => "Ardahan"
    country.create :id => 792076, :name => "Iğdır"
    country.create :id => 792077, :name => "Yalova"
    country.create :id => 792078, :name => "Karabük"
    country.create :id => 792079, :name => "Kilis"
    country.create :id => 792080, :name => "Osmaniye"
    country.create :id => 792081, :name => "Düzce"
  end
  
  # Trinidad and Tobago
  with_options(:country => Country['TT']) do |country|
    # Region
    country.create :id => 780001, :name => "Couva-Tabaquite-Talparo", :abbreviation => 'CTT'
    country.create :id => 780002, :name => "Diego Martin", :abbreviation => 'DMN'
    country.create :id => 780003, :name => "Eastern Tobago", :abbreviation => 'ETO'
    country.create :id => 780004, :name => "Penal-Debe", :abbreviation => 'PED'
    country.create :id => 780005, :name => "Princes Town", :abbreviation => 'PRT'
    country.create :id => 780006, :name => "Rio Claro-Mayaro", :abbreviation => 'RCM'
    country.create :id => 780007, :name => "Sangre Grande", :abbreviation => 'SGE'
    country.create :id => 780008, :name => "San Juan-Laventille", :abbreviation => 'SJL'
    country.create :id => 780009, :name => "Siparia", :abbreviation => 'SIP'
    country.create :id => 780010, :name => "Tunapuna-Piarco", :abbreviation => 'TUP'
    country.create :id => 780011, :name => "Western Tobago", :abbreviation => 'WTO'
    
    # Borough
    country.create :id => 780012, :name => "Arima", :abbreviation => 'ARI'
    country.create :id => 780013, :name => "Chaguanas", :abbreviation => 'CHA'
    country.create :id => 780014, :name => "Point Fortin", :abbreviation => 'PTF'
    
    # City
    country.create :id => 780015, :name => "Port of Spain", :abbreviation => 'POS'
    country.create :id => 780016, :name => "San Fernando", :abbreviation => 'SFO'
  end
  
  # Tuvalu
  with_options(:country => Country['TV']) do |country|
    # Town council
    country.create :id => 798001, :name => "Funafuti", :abbreviation => 'FUN'
    
    # Island council
    country.create :id => 798002, :name => "Nanumanga", :abbreviation => 'NMG'
    country.create :id => 798003, :name => "Nanumea", :abbreviation => 'NMA'
    country.create :id => 798004, :name => "Niutao", :abbreviation => 'NIT'
    country.create :id => 798005, :name => "Nui", :abbreviation => 'NIU'
    country.create :id => 798006, :name => "Nukufetau", :abbreviation => 'NKF'
    country.create :id => 798007, :name => "Nukulaelae", :abbreviation => 'NKL'
    country.create :id => 798008, :name => "Vaitupu", :abbreviation => 'VAI'
  end
  
  # Taiwan
  with_options(:country => Country['TW']) do |country|
    # District
    country.create :id => 158001, :name => "Changhua", :abbreviation => 'CHA'
    country.create :id => 158002, :name => "Chiayi", :abbreviation => 'CYQ'
    country.create :id => 158003, :name => "Hsinchu", :abbreviation => 'HSQ'
    country.create :id => 158004, :name => "Hualien", :abbreviation => 'HUA'
    country.create :id => 158005, :name => "Ilan", :abbreviation => 'ILA'
    country.create :id => 158006, :name => "Kaohsiung", :abbreviation => 'KHQ'
    country.create :id => 158007, :name => "Miaoli", :abbreviation => 'MIA'
    country.create :id => 158008, :name => "Nantou", :abbreviation => 'NAN'
    country.create :id => 158009, :name => "Penghu", :abbreviation => 'PEN'
    country.create :id => 158010, :name => "Pingtung", :abbreviation => 'PIF'
    country.create :id => 158011, :name => "Taichung", :abbreviation => 'TXQ'
    country.create :id => 158012, :name => "Tainan", :abbreviation => 'TNQ'
    country.create :id => 158013, :name => "Taipei", :abbreviation => 'TPQ'
    country.create :id => 158014, :name => "Taitung", :abbreviation => 'TTT'
    country.create :id => 158015, :name => "Taoyuan", :abbreviation => 'TAO'
    country.create :id => 158016, :name => "Yunlin", :abbreviation => 'YUN'
    
    # Municipality
    country.create :id => 158017, :name => "Chiay City", :abbreviation => 'CYI'
    country.create :id => 158018, :name => "Hsinchui City", :abbreviation => 'HSZ'
    country.create :id => 158019, :name => "Keelung City", :abbreviation => 'KEE'
    country.create :id => 158020, :name => "Taichung City", :abbreviation => 'TXG'
    country.create :id => 158021, :name => "Tainan City", :abbreviation => 'TNN'
    
    # Special municipality
    country.create :id => 158022, :name => "Kaohsiung City", :abbreviation => 'KHH'
    country.create :id => 158023, :name => "Taipei City", :abbreviation => 'TPE'
  end
  
  # Tanzania
  with_options(:country => Country['TZ']) do |country|
    country.create :id => 834001, :name => "Arusha"
    country.create :id => 834002, :name => "Dar-es-Salaam"
    country.create :id => 834003, :name => "Dodoma"
    country.create :id => 834004, :name => "Iringa"
    country.create :id => 834005, :name => "Kagera"
    country.create :id => 834006, :name => "Kaskazini Pemba"
    country.create :id => 834007, :name => "Kaskazini Unguja"
    country.create :id => 834008, :name => "Kigoma"
    country.create :id => 834009, :name => "Kilimanjaro"
    country.create :id => 834010, :name => "Kusini Pemba"
    country.create :id => 834011, :name => "Kusini Unguja"
    country.create :id => 834012, :name => "Lindi"
    country.create :id => 834013, :name => "Mara"
    country.create :id => 834014, :name => "Mbeya"
    country.create :id => 834015, :name => "Mjini Magharibi"
    country.create :id => 834016, :name => "Morogoro"
    country.create :id => 834017, :name => "Mtwara"
    country.create :id => 834018, :name => "Mwanza"
    country.create :id => 834019, :name => "Pwani"
    country.create :id => 834020, :name => "Rukwa"
    country.create :id => 834021, :name => "Ruvuma"
    country.create :id => 834022, :name => "Shinyanga"
    country.create :id => 834023, :name => "Singida"
    country.create :id => 834024, :name => "Tabora"
    country.create :id => 834025, :name => "Tanga"
    country.create :id => 834026, :name => "Manyara"
  end
  
  # Ukraine
  with_options(:country => Country['UA']) do |country|
    country.create :id => 804005, :name => "Vinnytska oblast"
    country.create :id => 804007, :name => "Volynska oblast"
    country.create :id => 804009, :name => "Luhanska oblast"
    country.create :id => 804012, :name => "Dnipropetrovska oblast"
    country.create :id => 804014, :name => "Donetska oblast"
    country.create :id => 804018, :name => "Zhytomyrska oblast"
    country.create :id => 804021, :name => "Zakarpatska oblast"
    country.create :id => 804023, :name => "Zaporizka oblast"
    country.create :id => 804026, :name => "Ivano-Frankivska oblast"
    country.create :id => 804030, :name => "Kyïvska miska rada"
    country.create :id => 804032, :name => "Kyïvska oblast"
    country.create :id => 804035, :name => "Kirovohradska oblast"
    country.create :id => 804040, :name => "Sevastopol"
    country.create :id => 804043, :name => "Respublika Krym"
    country.create :id => 804046, :name => "L'vivska oblast"
    country.create :id => 804048, :name => "Mykolaïvska oblast"
    country.create :id => 804051, :name => "Odeska oblast"
    country.create :id => 804053, :name => "Poltavska oblast"
    country.create :id => 804056, :name => "Rivnenska oblast"
    country.create :id => 804059, :name => "Sumska oblast"
    country.create :id => 804061, :name => "Ternopilska oblast"
    country.create :id => 804063, :name => "Kharkivska oblast"
    country.create :id => 804065, :name => "Khersonska oblast"
    country.create :id => 804068, :name => "Khmelnytska oblast"
    country.create :id => 804071, :name => "Cherkaska oblast"
    country.create :id => 804074, :name => "Chernihivska oblast"
    country.create :id => 804077, :name => "Chernivetska oblast"
  end
  
  # Uganda
  with_options(:country => Country['UG']) do |country|
    country.create :id => 800101, :name => "Kalangala"
    country.create :id => 800102, :name => "Kampala"
    country.create :id => 800103, :name => "Kiboga"
    country.create :id => 800104, :name => "Luwero"
    country.create :id => 800105, :name => "Masaka"
    country.create :id => 800106, :name => "Mpigi"
    country.create :id => 800107, :name => "Mubende"
    country.create :id => 800108, :name => "Mukono"
    country.create :id => 800109, :name => "Nakasongola"
    country.create :id => 800110, :name => "Rakai"
    country.create :id => 800111, :name => "Sembabule"
    country.create :id => 800112, :name => "Kayunga"
    country.create :id => 800113, :name => "Wakiso"
    country.create :id => 800114, :name => "Mityana"
    country.create :id => 800115, :name => "Nakaseke"
    country.create :id => 800201, :name => "Bugiri"
    country.create :id => 800202, :name => "Busia"
    country.create :id => 800203, :name => "Iganga"
    country.create :id => 800204, :name => "Jinja"
    country.create :id => 800205, :name => "Kamuli"
    country.create :id => 800206, :name => "Kapchorwa"
    country.create :id => 800207, :name => "Katakwi"
    country.create :id => 800208, :name => "Kumi"
    country.create :id => 800209, :name => "Mbale"
    country.create :id => 800210, :name => "Pallisa"
    country.create :id => 800211, :name => "Soroti"
    country.create :id => 800212, :name => "Tororo"
    country.create :id => 800213, :name => "Kaberamaido"
    country.create :id => 800214, :name => "Mayuge"
    country.create :id => 800215, :name => "Sironko"
    country.create :id => 800216, :name => "Amuria"
    country.create :id => 800217, :name => "Budaka"
    country.create :id => 800218, :name => "Bukwa"
    country.create :id => 800219, :name => "Butaleja"
    country.create :id => 800220, :name => "Kaliro"
    country.create :id => 800221, :name => "Manafwa"
    country.create :id => 800222, :name => "Namutumba"
    country.create :id => 800301, :name => "Adjumani"
    country.create :id => 800302, :name => "Apac"
    country.create :id => 800303, :name => "Arua"
    country.create :id => 800304, :name => "Gulu"
    country.create :id => 800305, :name => "Kitgum"
    country.create :id => 800306, :name => "Kotido"
    country.create :id => 800307, :name => "Lira"
    country.create :id => 800308, :name => "Moroto"
    country.create :id => 800309, :name => "Moyo"
    country.create :id => 800310, :name => "Nebbi"
    country.create :id => 800311, :name => "Nakapiripirit"
    country.create :id => 800312, :name => "Pader"
    country.create :id => 800313, :name => "Yumbe"
    country.create :id => 800314, :name => "Amolatar"
    country.create :id => 800315, :name => "Kaabong"
    country.create :id => 800316, :name => "Koboko"
    country.create :id => 800317, :name => "Abim"
    country.create :id => 800318, :name => "Dokolo"
    country.create :id => 800319, :name => "Amuru"
    country.create :id => 800320, :name => "Maracha"
    country.create :id => 800321, :name => "Oyam"
    country.create :id => 800401, :name => "Bundibugyo"
    country.create :id => 800402, :name => "Bushenyi"
    country.create :id => 800403, :name => "Hoima"
    country.create :id => 800404, :name => "Kabale"
    country.create :id => 800405, :name => "Kabarole"
    country.create :id => 800406, :name => "Kasese"
    country.create :id => 800407, :name => "Kibaale"
    country.create :id => 800408, :name => "Kisoro"
    country.create :id => 800409, :name => "Masindi"
    country.create :id => 800410, :name => "Mbarara"
    country.create :id => 800411, :name => "Ntungamo"
    country.create :id => 800412, :name => "Rukungiri"
    country.create :id => 800413, :name => "Kamwenge"
    country.create :id => 800414, :name => "Kanungu"
    country.create :id => 800415, :name => "Kyenjojo"
    country.create :id => 800416, :name => "Ibanda"
    country.create :id => 800417, :name => "Isingiro"
    country.create :id => 800418, :name => "Kiruhura"
    country.create :id => 800419, :name => "Bulisa"
  end
  
  # U.S. Minor Outlying Islands
  with_options(:country => Country['UM']) do |country|
    country.create :id => 581067, :name => "Johnston Atoll"
    country.create :id => 581071, :name => "Midway Islands"
    country.create :id => 581076, :name => "Navassa Island"
    country.create :id => 581079, :name => "Wake Island"
    country.create :id => 581081, :name => "Baker Island"
    country.create :id => 581084, :name => "Howland Island"
    country.create :id => 581086, :name => "Jarvis Island"
    country.create :id => 581089, :name => "Kingman Reef"
    country.create :id => 581095, :name => "Palmyra Atoll"
  end
  
  # United States
  with_options(:country => Country['US']) do |country|
    country.create :id => 840001, :name => "Alabama", :abbreviation => 'AL'
    country.create :id => 840002, :name => "Alaska", :abbreviation => 'AK'
    country.create :id => 840003, :name => "Arizona", :abbreviation => 'AZ'
    country.create :id => 840004, :name => "Arkansas", :abbreviation => 'AR'
    country.create :id => 840005, :name => "California", :abbreviation => 'CA'
    country.create :id => 840006, :name => "Colorado", :abbreviation => 'CO'
    country.create :id => 840007, :name => "Connecticut", :abbreviation => 'CT'
    country.create :id => 840008, :name => "Delaware", :abbreviation => 'DE'
    country.create :id => 840009, :name => "Florida", :abbreviation => 'FL'
    country.create :id => 840010, :name => "Georgia", :abbreviation => 'GA'
    country.create :id => 840011, :name => "Hawaii", :abbreviation => 'HI'
    country.create :id => 840012, :name => "Idaho", :abbreviation => 'ID'
    country.create :id => 840013, :name => "Illinois", :abbreviation => 'IL'
    country.create :id => 840014, :name => "Indiana", :abbreviation => 'IN'
    country.create :id => 840015, :name => "Iowa", :abbreviation => 'IA'
    country.create :id => 840016, :name => "Kansas", :abbreviation => 'KS'
    country.create :id => 840017, :name => "Kentucky", :abbreviation => 'KY'
    country.create :id => 840018, :name => "Louisiana", :abbreviation => 'LA'
    country.create :id => 840019, :name => "Maine", :abbreviation => 'ME'
    country.create :id => 840020, :name => "Maryland", :abbreviation => 'MD'
    country.create :id => 840021, :name => "Massachusetts", :abbreviation => 'MA'
    country.create :id => 840022, :name => "Michigan", :abbreviation => 'MI'
    country.create :id => 840023, :name => "Minnesota", :abbreviation => 'MN'
    country.create :id => 840024, :name => "Mississippi", :abbreviation => 'MS'
    country.create :id => 840025, :name => "Missouri", :abbreviation => 'MO'
    country.create :id => 840026, :name => "Montana", :abbreviation => 'MT'
    country.create :id => 840027, :name => "Nebraska", :abbreviation => 'NE'
    country.create :id => 840028, :name => "Nevada", :abbreviation => 'NV'
    country.create :id => 840029, :name => "New Hampshire", :abbreviation => 'NH'
    country.create :id => 840030, :name => "New Jersey", :abbreviation => 'NJ'
    country.create :id => 840031, :name => "New Mexico", :abbreviation => 'NM'
    country.create :id => 840032, :name => "New York", :abbreviation => 'NY'
    country.create :id => 840033, :name => "North Carolina", :abbreviation => 'NC'
    country.create :id => 840034, :name => "North Dakota", :abbreviation => 'ND'
    country.create :id => 840035, :name => "Ohio", :abbreviation => 'OH'
    country.create :id => 840036, :name => "Oklahoma", :abbreviation => 'OK'
    country.create :id => 840037, :name => "Oregon", :abbreviation => 'OR'
    country.create :id => 840038, :name => "Pennsylvania", :abbreviation => 'PA'
    country.create :id => 840039, :name => "Rhode Island", :abbreviation => 'RI'
    country.create :id => 840040, :name => "South Carolina", :abbreviation => 'SC'
    country.create :id => 840041, :name => "South Dakota", :abbreviation => 'SD'
    country.create :id => 840042, :name => "Tennessee", :abbreviation => 'TN'
    country.create :id => 840043, :name => "Texas", :abbreviation => 'TX'
    country.create :id => 840044, :name => "Utah", :abbreviation => 'UT'
    country.create :id => 840045, :name => "Vermont", :abbreviation => 'VT'
    country.create :id => 840046, :name => "Virginia", :abbreviation => 'VA'
    country.create :id => 840047, :name => "Washington", :abbreviation => 'WA'
    country.create :id => 840048, :name => "West Virginia", :abbreviation => 'WV'
    country.create :id => 840049, :name => "Wisconsin", :abbreviation => 'WI'
    country.create :id => 840050, :name => "Wyoming", :abbreviation => 'WY'
    
    # District
    country.create :id => 840051, :name => "District of Columbia", :abbreviation => 'DC'
    
    # Outlying area
    country.create :id => 840052, :name => "American Samoa", :abbreviation => 'AS'
    country.create :id => 840053, :name => "Guam", :abbreviation => 'GU'
    country.create :id => 840054, :name => "Northern Mariana Islands", :abbreviation => 'MP'
    country.create :id => 840055, :name => "Puerto Rico", :abbreviation => 'PR'
    country.create :id => 840056, :name => "United States Minor Outlying Islands", :abbreviation => 'UM'
    country.create :id => 840057, :name => "Virgin Islands", :abbreviation => 'VI'
  end
  
  # Uruguay
  with_options(:country => Country['UY']) do |country|
    country.create :id => 858001, :name => "Artigas", :abbreviation => 'AR'
    country.create :id => 858002, :name => "Canelones", :abbreviation => 'CA'
    country.create :id => 858003, :name => "Cerro Largo", :abbreviation => 'CL'
    country.create :id => 858004, :name => "Colonia", :abbreviation => 'CO'
    country.create :id => 858005, :name => "Durazno", :abbreviation => 'DU'
    country.create :id => 858006, :name => "Flores", :abbreviation => 'FS'
    country.create :id => 858007, :name => "Florida", :abbreviation => 'FD'
    country.create :id => 858008, :name => "Lavalleja", :abbreviation => 'LA'
    country.create :id => 858009, :name => "Maldonado", :abbreviation => 'MA'
    country.create :id => 858010, :name => "Montevideo", :abbreviation => 'MO'
    country.create :id => 858011, :name => "Paysandú", :abbreviation => 'PA'
    country.create :id => 858012, :name => "Río Negro", :abbreviation => 'RN'
    country.create :id => 858013, :name => "Rivera", :abbreviation => 'RV'
    country.create :id => 858014, :name => "Rocha", :abbreviation => 'RO'
    country.create :id => 858015, :name => "Salto", :abbreviation => 'SA'
    country.create :id => 858016, :name => "San José", :abbreviation => 'SJ'
    country.create :id => 858017, :name => "Soriano", :abbreviation => 'SO'
    country.create :id => 858018, :name => "Tacuarembó", :abbreviation => 'TA'
    country.create :id => 858019, :name => "Treinta y Tres", :abbreviation => 'TT'
  end
  
  # Uzbekistan
  with_options(:country => Country['UZ']) do |country|
    # City
    country.create :id => 860001, :name => "Toshkent", :abbreviation => 'TK'
    
    # Region
    country.create :id => 860002, :name => "Andijon", :abbreviation => 'AN'
    country.create :id => 860003, :name => "Buxoro", :abbreviation => 'BU'
    country.create :id => 860004, :name => "Farg'ona", :abbreviation => 'FA'
    country.create :id => 860005, :name => "Jizzax", :abbreviation => 'JI'
    country.create :id => 860006, :name => "Namangan", :abbreviation => 'NG'
    country.create :id => 860007, :name => "Navoiy", :abbreviation => 'NW'
    country.create :id => 860008, :name => "Qashqadaryo", :abbreviation => 'QA'
    country.create :id => 860009, :name => "Samarqand", :abbreviation => 'SA'
    country.create :id => 860010, :name => "Sirdaryo", :abbreviation => 'SI'
    country.create :id => 860011, :name => "Surxondaryo", :abbreviation => 'SU'
    country.create :id => 860012, :name => "Toshkent", :abbreviation => 'TO'
    country.create :id => 860013, :name => "Xorazm", :abbreviation => 'XO'
    
    # Republic
    country.create :id => 860014, :name => "Qoraqalpog'iston", :abbreviation => 'QR'
  end
  
  # St. Vincent and the Grenadines
  with_options(:country => Country['VC']) do |country|
    country.create :id => 670001, :name => "Charlotte"
    country.create :id => 670002, :name => "Saint Andrew"
    country.create :id => 670003, :name => "Saint David"
    country.create :id => 670004, :name => "Saint George"
    country.create :id => 670005, :name => "Saint Patrick"
    country.create :id => 670006, :name => "Grenadines"
  end
  
  # Venezuela
  with_options(:country => Country['VE']) do |country|
    # Federal dependency
    country.create :id => 862001, :name => "Dependencias Federales", :abbreviation => 'W'
    
    # Federal district
    country.create :id => 862002, :name => "Distrito Federal", :abbreviation => 'A'
    
    # State
    country.create :id => 862003, :name => "Amazonas", :abbreviation => 'Z'
    country.create :id => 862004, :name => "Anzoátegui", :abbreviation => 'B'
    country.create :id => 862005, :name => "Apure", :abbreviation => 'C'
    country.create :id => 862006, :name => "Aragua", :abbreviation => 'D'
    country.create :id => 862007, :name => "Barinas", :abbreviation => 'E'
    country.create :id => 862008, :name => "Bolívar", :abbreviation => 'F'
    country.create :id => 862009, :name => "Carabobo", :abbreviation => 'G'
    country.create :id => 862010, :name => "Cojedes", :abbreviation => 'H'
    country.create :id => 862011, :name => "Delta Amacuro", :abbreviation => 'Y'
    country.create :id => 862012, :name => "Falcón", :abbreviation => 'I'
    country.create :id => 862013, :name => "Guárico", :abbreviation => 'J'
    country.create :id => 862014, :name => "Lara", :abbreviation => 'K'
    country.create :id => 862015, :name => "Mérida", :abbreviation => 'L'
    country.create :id => 862016, :name => "Miranda", :abbreviation => 'M'
    country.create :id => 862017, :name => "Monagas", :abbreviation => 'N'
    country.create :id => 862018, :name => "Nueva Esparta", :abbreviation => 'O'
    country.create :id => 862019, :name => "Portuguesa", :abbreviation => 'P'
    country.create :id => 862020, :name => "Sucre", :abbreviation => 'R'
    country.create :id => 862021, :name => "Táchira", :abbreviation => 'S'
    country.create :id => 862022, :name => "Trujillo", :abbreviation => 'T'
    country.create :id => 862023, :name => "Vargas", :abbreviation => 'X'
    country.create :id => 862024, :name => "Yaracuy", :abbreviation => 'U'
    country.create :id => 862025, :name => "Zulia", :abbreviation => 'V'
  end
  
  # Viet Nam
  with_options(:country => Country['VN']) do |country|
    country.create :id => 704001, :name => "Lai Châu"
    country.create :id => 704002, :name => "Lào Cai"
    country.create :id => 704003, :name => "Hà Giang"
    country.create :id => 704004, :name => "Cao Bằng"
    country.create :id => 704005, :name => "Sơn La"
    country.create :id => 704006, :name => "Yên Bái"
    country.create :id => 704007, :name => "Tuyên Quang"
    country.create :id => 704009, :name => "Lạng Sơn"
    country.create :id => 704013, :name => "Quảng Ninh"
    country.create :id => 704014, :name => "Hoà Bình"
    country.create :id => 704015, :name => "Hà Tây"
    country.create :id => 704018, :name => "Ninh Bình"
    country.create :id => 704020, :name => "Thái Bình"
    country.create :id => 704021, :name => "Thanh Hóa"
    country.create :id => 704022, :name => "Nghệ An"
    country.create :id => 704023, :name => "Hà Tỉnh"
    country.create :id => 704024, :name => "Quảng Bình"
    country.create :id => 704025, :name => "Quảng Trị"
    country.create :id => 704026, :name => "Thừa Thiên-Huế"
    country.create :id => 704027, :name => "Quảng Nam"
    country.create :id => 704028, :name => "Kon Tum"
    country.create :id => 704029, :name => "Quảng Ngãi"
    country.create :id => 704030, :name => "Gia Lai"
    country.create :id => 704031, :name => "Bình Định"
    country.create :id => 704032, :name => "Phú Yên"
    country.create :id => 704033, :name => "Đắc Lắk"
    country.create :id => 704034, :name => "Khánh Hòa"
    country.create :id => 704035, :name => "Lâm Đồng"
    country.create :id => 704036, :name => "Ninh Thuận"
    country.create :id => 704037, :name => "Tây Ninh"
    country.create :id => 704039, :name => "Đồng Nai"
    country.create :id => 704040, :name => "Bình Thuận"
    country.create :id => 704041, :name => "Long An"
    country.create :id => 704043, :name => "Bà Rịa - Vũng Tàu"
    country.create :id => 704044, :name => "An Giang"
    country.create :id => 704045, :name => "Đồng Tháp"
    country.create :id => 704046, :name => "Tiền Giang"
    country.create :id => 704047, :name => "Kiên Giang"
    country.create :id => 704048, :name => "Cần Thơ"
    country.create :id => 704049, :name => "Vĩnh Long"
    country.create :id => 704050, :name => "Bến Tre"
    country.create :id => 704051, :name => "Trà Vinh"
    country.create :id => 704052, :name => "Sóc Trăng"
    country.create :id => 704053, :name => "Bắc Kạn"
    country.create :id => 704054, :name => "Bắc Giang"
    country.create :id => 704055, :name => "Bạc Liêu"
    country.create :id => 704056, :name => "Bắc Ninh"
    country.create :id => 704057, :name => "Bình Dương"
    country.create :id => 704058, :name => "Bình Phước"
    country.create :id => 704059, :name => "Cà Mau"
    country.create :id => 704060, :name => "Đà Nẵng, thành phố"
    country.create :id => 704061, :name => "Hải Duong"
    country.create :id => 704062, :name => "Hải Phòng, thành phố"
    country.create :id => 704063, :name => "Hà Nam"
    country.create :id => 704064, :name => "Hà Nội, thủ đô"
    country.create :id => 704065, :name => "Hồ Chí Minh, thành phố" # Sài Gòn
    country.create :id => 704066, :name => "Hưng Yên"
    country.create :id => 704067, :name => "Nam Định"
    country.create :id => 704068, :name => "Phú Thọ"
    country.create :id => 704069, :name => "Thái Nguyên"
    country.create :id => 704070, :name => "Vĩnh Phúc"
    country.create :id => 704071, :name => "Điện Biên"
    country.create :id => 704072, :name => "Đắk Nông"
    country.create :id => 704073, :name => "Hậu Giang"
  end
  
  # Vanuatu
  with_options(:country => Country['VU']) do |country|
    country.create :id => 548001, :name => "Malampa", :abbreviation => 'MAP'
    country.create :id => 548002, :name => "Pénama", :abbreviation => 'PAM'
    country.create :id => 548003, :name => "Sanma", :abbreviation => 'SAM'
    country.create :id => 548004, :name => "Shéfa", :abbreviation => 'SEE'
    country.create :id => 548005, :name => "Taféa", :abbreviation => 'TAE'
    country.create :id => 548006, :name => "Torba", :abbreviation => 'TOB'
  end
  
  # Samoa
  with_options(:country => Country['WS']) do |country|
    country.create :id => 882001, :name => "A'ana", :abbreviation => 'AA'
    country.create :id => 882002, :name => "Aiga-i-le-Tai", :abbreviation => 'AL'
    country.create :id => 882003, :name => "Atua", :abbreviation => 'AT'
    country.create :id => 882004, :name => "Fa'asaleleaga", :abbreviation => 'FA'
    country.create :id => 882005, :name => "Gaga'emauga", :abbreviation => 'GE'
    country.create :id => 882006, :name => "Gagaifomauga", :abbreviation => 'GI'
    country.create :id => 882007, :name => "Palauli", :abbreviation => 'PA'
    country.create :id => 882008, :name => "Satupa'itea", :abbreviation => 'SA'
    country.create :id => 882009, :name => "Tuamasaga", :abbreviation => 'TU'
    country.create :id => 882010, :name => "Va'a-o-Fonoti", :abbreviation => 'VF'
    country.create :id => 882011, :name => "Vaisigano", :abbreviation => 'VS'
  end
  
  # Yemen
  with_options(:country => Country['YE']) do |country|
    country.create :id => 887001, :name => "Abyān", :abbreviation => 'AB'
    country.create :id => 887002, :name => "'Adan", :abbreviation => 'AD'
    country.create :id => 887003, :name => "Aḑ Ḑāli'", :abbreviation => 'DA'
    country.create :id => 887004, :name => "Al Bayḑā'", :abbreviation => 'BA'
    country.create :id => 887005, :name => "Al Ḩudaydah", :abbreviation => 'MU'
    country.create :id => 887006, :name => "Al Jawf", :abbreviation => 'JA'
    country.create :id => 887007, :name => "Al Mahrah", :abbreviation => 'MR'
    country.create :id => 887008, :name => "Al Maḩwīt", :abbreviation => 'MW'
    country.create :id => 887009, :name => "'Amrān", :abbreviation => 'AM'
    country.create :id => 887010, :name => "Dhamār", :abbreviation => 'DH'
    country.create :id => 887011, :name => "Ḩaḑramawt", :abbreviation => 'HD'
    country.create :id => 887012, :name => "Ḩajjah", :abbreviation => 'HJ'
    country.create :id => 887013, :name => "Ibb", :abbreviation => 'IB'
    country.create :id => 887014, :name => "Laḩij", :abbreviation => 'LA'
    country.create :id => 887015, :name => "Ma'rib", :abbreviation => 'MA'
    country.create :id => 887016, :name => "Şa'dah", :abbreviation => 'SD'
    country.create :id => 887017, :name => "Şan'ā'", :abbreviation => 'SN'
    country.create :id => 887018, :name => "Shabwah", :abbreviation => 'SH'
    country.create :id => 887019, :name => "Tā'izz", :abbreviation => 'TA'
  end
  
  # South Africa
  with_options(:country => Country['ZA']) do |country|
    country.create :id => 710001, :name => "Eastern Cape", :abbreviation => 'EC'
    country.create :id => 710002, :name => "Free State", :abbreviation => 'FS'
    country.create :id => 710003, :name => "Gauteng", :abbreviation => 'GT'
    country.create :id => 710004, :name => "Kwazulu-Natal", :abbreviation => 'NL'
    country.create :id => 710005, :name => "Limpopo", :abbreviation => 'LP'
    country.create :id => 710006, :name => "Mpumalanga", :abbreviation => 'MP'
    country.create :id => 710007, :name => "Northern Cape", :abbreviation => 'NC'
    country.create :id => 710008, :name => "North-West", :abbreviation => 'NW'
    country.create :id => 710009, :name => "Western Cape", :abbreviation => 'WC'
  end
  
  # Zambia
  with_options(:country => Country['ZM']) do |country|
    country.create :id => 894001, :name => "Western"
    country.create :id => 894002, :name => "Central"
    country.create :id => 894003, :name => "Eastern"
    country.create :id => 894004, :name => "Luapula"
    country.create :id => 894005, :name => "Northern"
    country.create :id => 894006, :name => "North-Western"
    country.create :id => 894007, :name => "Southern"
    country.create :id => 894008, :name => "Copperbelt"
    country.create :id => 894009, :name => "Lusaka"
  end
  
  # Zimbabwe
  with_options(:country => Country['ZW']) do |country|
    # City
    country.create :id => 716001, :name => "Bulawayo", :abbreviation => 'BU'
    country.create :id => 716002, :name => "Harare", :abbreviation => 'HA'
    
    # Province
    country.create :id => 716003, :name => "Manicaland", :abbreviation => 'MA'
    country.create :id => 716004, :name => "Mashonaland Central", :abbreviation => 'MC'
    country.create :id => 716005, :name => "Mashonaland East", :abbreviation => 'ME'
    country.create :id => 716006, :name => "Mashonaland West", :abbreviation => 'MW'
    country.create :id => 716007, :name => "Masvingo", :abbreviation => 'MV'
    country.create :id => 716008, :name => "Matabeleland North", :abbreviation => 'MN'
    country.create :id => 716009, :name => "Matabeleland South", :abbreviation => 'MS'
    country.create :id => 716010, :name => "Midlands", :abbreviation => 'MI'
  end
end
