# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
        $('#data_sets_table').dataTable
          sPaginationType: "full_numbers"
          bJQueryUI: true
jQuery ->
        $('#data_set_records').dataTable
          sPaginationType: "full_numbers"
          bJQueryUI: true
jQuery ->
				for i, id of gon.revision_ids
					console.log id
					$("#revision_#{id}").dataTable
						sPaginationType: "full_numbers"
						bJQueryUI: true
