# Importeer Adafruit DHT bibliotheek.
import Adafruit_DHT

humidity, temperature = Adafruit_DHT.read_retry(Adafruit_DHT.DHT11, 4)

humidity = round(humidity, 2)
temperature = round(temperature, 2)

file = open("data/data.txt","w")

if humidity is not None and temperature is not None:
  file.write('{0:0.1f}*C|{1:0.1f}%'.format(temperature, humidity))

file.close()


