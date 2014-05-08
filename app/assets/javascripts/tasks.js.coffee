$ ->
  $(document).on "submit", "#new_task", ->
    $("#task-errors").html("")
    $.ajax
      method: "post"
      url: $(@).attr("action")
      data:
        task:
          title: $("#task_title").val()
      error: ->
        alert("Task didn't create. Please reload page.")
      success: (data) ->
        if data.status == "success"
          $("#task_title").val("")
          template = $("#task-template").html()
          rendered = Mustache.render(template, {title: data.title, url: data.url})
          $("#pending-tasks").append(rendered)
        else
          $("#task-errors").hide()
          $("#task-errors").html(data.errors)
          $("#task-errors").fadeIn(1500)

    false

  $(".draggable").draggable
    appendTo: ".droppable"

  $(".droppable").droppable
    hoverClass: "alert-info"
    drop: (event, ui) ->
      $(ui.draggable).css("left", 0)
      $(ui.draggable).css("top", 0)
      $(@).prepend($(ui.draggable))
      if $(@).attr("id") == "completed-tasks" 
        completed = true
      else
        completed = false
      update_task_status $(ui.draggable).data("url"),
                         completed

update_task_status= (url, status) ->
  $.ajax
    method: "patch"
    url: url
    data:
      task:
        completed: status
    error: ->
      alert("something went wrong please refresh page")
    success: (data) ->
      unless data.status == "success"
        alert("Something went wrong please refresh")





