class InitHelper

	def initialize( gon )
		@gon = gon
		@gon.jquery_uis = Hash.new
	end

	def set_id( id, type, settings = {} )
		@gon.jquery_uis[ type ] ||= Hash.new
		case type
		when :tabs
			settings.reverse_merge! 'collapsible' => true, 'heightStyle' => "content", 'active' => false
		when :accordion
			settings.reverse_merge!	'collapsible' => true, 'heightStyle' => 'content', 'active' => false
		when :data_table
			settings.reverse_merge!	'sPaginationType' => 'full_numbers',  'bJQueryUI' => true,  'bDeferRender' => true
		end

		@gon.jquery_uis[ type ][ id ] = settings 
		return "id=#{id}"
	end
end
