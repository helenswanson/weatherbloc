$(document).ready(function() {

$("#submit-button").on('click', function() {
  event.preventDefault();

  var apiKey = '0f25aa640071732b57e7b3f3fb9b360c';
  var url = 'https://api.forecast.io/forecast/';
  var latitude = 42.35168;  //Launch: 42.35168
  var longitude = -71.061431; //Launch: -71.061431
  var data;

  $.getJSON(url + apiKey + "/" + latitude + "," + longitude + "?callback=?", function(data) {
   //console.log(data);
   // $('#weather').html('and the current precipitation intensity is: ' + data.currently.precipIntensity);
    console.log(data.currently.precipIntensity);
    var HelenIsAwesome = data.currently.precipIntensity;
    // var HelenIsAwesome = 2

   // Determine which classes we add to our sexy body
    if ( HelenIsAwesome >= 0.039 ) {
      $('body').addClass('open weather-sucks precip-' + HelenIsAwesome);
    } else {
      $('body').addClass('open weather-rocks precip-' + HelenIsAwesome);
    }

  });

});

});
