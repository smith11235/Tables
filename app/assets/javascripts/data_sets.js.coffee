# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
				for ui_type, instances of gon.jquery_uis
					switch ui_type
						when 'tabs'
							for id,settings of instances
								$("##{id}" ).tabs( settings )
						when 'accordion'
							for id,settings of instances
								$("##{id}" ).accordion( settings )
						when 'data_table'
							for id,settings of instances
        				$("##{id}").dataTable( settings )

this.resetJQueryUI = resetJQueryUI = ( ui_type, id ) ->
	settings = gon.jquery_uis[ui_type][id]
	switch ui_type
		when 'tabs'
			$("##{id}" ).tabs('destroy').tabs( settings )
		when 'accordion'
			$("##{id}" ).accordion('destroy').accordion( settings )


this.setMainDisplay = setMainDisplay = ( table ) ->
	$('#main_display').dataTable
		bDestroy: true
		sPaginationType: "full_numbers"
		bJQueryUI: true
		aaData: table.records
		aoColumns: table.columns
	$('#main_display_title').html("<h1>#{table.title}</h1>")

# use this method to do the initial load
jQuery ->
	setMainDisplay( gon.table )

this.newConditionSuccess = newConditionSuccess = ( data ) ->
  info = JSON.parse(data.responseText)
  $("#key_#{info.key_id}_conditions").prepend( info.html )
  $("#key_#{info.key_id}_tabs").tabs('select',1)
  setMainDisplay( info.table ) 

$('.new_condition_success').bind('ajax:success',(event, data, status, xhr) -> 
	  newConditionSuccess( data ) 
	)

jQuery ->
	$('.new_key_success').bind 'ajax:success',(event, xhr, status, data) ->
		key_info = JSON.parse( data.responseText )
		$("#current_keys").prepend( key_info.html )
		resetJQueryUI('accordion','current_keys')
		$("#key_#{key_info.key_id}_tabs").tabs()
		$("#key_tabs").tabs('select',0)
		$("#current_keys").accordion('option','active',0)
		setMainDisplay(key_info.table)


