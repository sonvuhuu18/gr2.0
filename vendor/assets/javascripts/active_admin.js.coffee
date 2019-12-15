#= require active_admin/base
#= require holderjs
#= require Chart.bundle
#= require chartkick

$(document).on 'change', '#user_avatar', ->
  input = document.getElementById('user_avatar')
  item = document.getElementById('image_preview')
  if input.files and input.files[0]
    item.src = URL.createObjectURL(input.files[0])
  else
    item.src = ''
    Holder.run item: item
  return

$(document).on 'change', '#course_image', ->
  input = document.getElementById('course_image')
  item = document.getElementById('image_preview')
  if input.files and input.files[0]
    item.src = URL.createObjectURL(input.files[0])
  else
    item.src = ''
    Holder.run item: item
  return

$(document).on 'change', '#subject_image', ->
  input = document.getElementById('subject_image')
  item = document.getElementById('image_preview')
  if input.files and input.files[0]
    item.src = URL.createObjectURL(input.files[0])
  else
    item.src = ''
    Holder.run item: item
  return
