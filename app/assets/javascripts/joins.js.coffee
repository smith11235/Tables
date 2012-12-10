# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.setJoinDisplay = setJoinDisplay = ( table ) ->
	$('#join_display').dataTable
		bDestroy: true,
		sPaginationType: "full_numbers",
		bJQueryUI: true,
		aaData: table.records,
		aoColumns: table.columns

# use this method to do the initial load
jQuery ->
	setJoinDisplay( gon.table )
