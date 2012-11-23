# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
				$('#revisions').accordion
					collapsible: true
					active: false
					heightStyle: "content"
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
					$("#revision_#{id}").dataTable
						sPaginationType: "full_numbers"
						bJQueryUI: true
jQuery ->
				for i, id of gon.data_table_ids
					$("##{id}").dataTable
						sPaginationType: "full_numbers"
						bJQueryUI: true
