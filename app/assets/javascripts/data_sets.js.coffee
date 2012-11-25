# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
				for ui_type, instances of gon.jquery_uis
					switch ui_type
						when 'tabs'
							for i, id of instances
								$("##{id}" ).tabs
									collapsible: true
									heightStyle: "content"
						when 'accordion'
							for i, id of instances
								$("##{id}" ).accordion
									collapsible: true
									heightStyle: "content"
									active: false
						when 'data_table'
							for i, id of instances
        				$("##{id}").dataTable
          				sPaginationType: "full_numbers"
          				bJQueryUI: true
