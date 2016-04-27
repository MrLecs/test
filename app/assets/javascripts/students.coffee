# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

root.generate_passwords = ->
  names = $('input:checked').map ->
    $(this).data('id')
  
  ids = names.toArray()
  url = generate_passwords_master_students_path + '?ids=' + ids.join(',')
  
  window.open url, '_blank'

  return
