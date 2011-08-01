module PagesHelper
  
  def getPlaces(lat,long)
    SimpleGeo::Client.set_credentials('Prhfx4xKNBYnxLnaersACEKEtusVZNmp', 'hMu2vMCcGC4Z67QEwq8DpgMm5fEDLcvq')
    SimpleGeo::Client.get_places(lat, long)
  end
end
