myTimer = (selector) ->
  seconds = 0
  btn = $(selector).val()
  interval = setInterval((-> 
    seconds++
    $(selector).val("#{btn} - #{seconds}")
    $('.btn').click ->
      seconds = 0
      time = $('#check_card').val().match(/\d+$/).pop()
      $('#check_time').val(time)
  ), 1000)
  

$(document).ready ->
  $('#check_check_translate').focus()
  myTimer('#check_card')