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
		bDestroy: true,
		sPaginationType: "full_numbers",
		bJQueryUI: true,
		aaData: table.records,
		aoColumns: table.columns

# use this method to do the initial load
jQuery ->
	setMainDisplay( gon.table )

