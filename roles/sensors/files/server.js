var sensorLib = require('node-dht-sensor');
var request = require('request');

var privateKey = "Put here you sparkfun private key";
var publicKey = "Put here you sparkfun public key"
var url = 'https://data.sparkfun.com/input/' + publicKey + '?private_key=' + privateKey;
var lastTemp, lastHumidity;

var sensor = {
    initialize: function () {
        return sensorLib.initialize(11, 4);
    },
    read: function () {
        var readout = sensorLib.read();

        // toFixed specifies how many decimals after the point
        var temp = readout.temperature.toFixed(0);
        var humidity = readout.humidity.toFixed(0);

        if (temp != lastTemp || humidity != lastHumidity) {
          lastTemp = temp;
          lastHumidity = humidity;

          request(url + '&humidity=' + humidity + '&temp=' + temp, function(err, res, body) {
            if (!err && res.statusCode == 200)
                console.log('Data sent successfully! (' + temp + '°C, ' + humidity + '%)');
            else
                console.log('Error while sending data!');
          });
        }

        setTimeout(function () {
            sensor.read();
        }, 2000);
    }
};

if (sensor.initialize()) {
    sensor.read();
} else {
    console.warn('Failed to initialize sensor');
}
