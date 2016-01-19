$(document).ready(function() {
  fetchEvents()
})

function fetchEvents() {
  $.ajax({
    type: 'GET',
    crossDomain: true,
    dataType: "jsonp",
    url: 'http://api.bandsintown.com/events/search.json?location=Denver,%20CO&app_id=KONCERT',
    success: function(events) {
      $.each(events, function(index, event) {
        $('#latest-events').append(
          '<li class="collection-item avatar trans-card white-text"><div class="row"><div class="col s7">' +
          'Venue: ' + event.venue.name + ' ' +
          'Date: ' + event.datetime +
          'City: ' + event.venue.city + ', ' +
           event.venue.region + '</li>'
        )
      })
    },
    error:  function(xhr) {
      console.log(xhr.responseText)
    }
  })
}
