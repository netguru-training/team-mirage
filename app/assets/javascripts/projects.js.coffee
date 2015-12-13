# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#comment').click ->
    $(this).text (i, old) ->
      if old == 'Hide comments' then 'Show comments' else 'Hide comments'
  $('#payment').click ->
    $(this).text (i, old) ->
      if old == 'Hide payments' then 'Show payments' else 'Hide payments'

  data = {
    labels : labelArray,
    datasets : [
      {
        label : 'Total contributions'
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : dataArrayAll
      },
      {
        label : 'Daily contributions',
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(151,187,205,1)",
        pointColor : "rgba(151,187,205,1)",
        pointStrokeColor : "#fff",
        data : dataArray
      },
      {
        label : 'Project goal',
        fillColor : "rgba(255,255,255,0.1)",
        strokeColor : "rgba(255,0,0,1)",
        pointColor : "rgba(255,0,0,1)",
        pointStrokeColor : "#fff",
        data : limit
      }
    ]
  }

  options = {
  legendTemplate : 'aasdfa',
  scaleLabel : "<%= Number(value) + ' $'%>",
  multiTooltipTemplate : "<%= datasetLabel + ' ' + Number(value) + ' $'%>"
  }

  myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data, options)
