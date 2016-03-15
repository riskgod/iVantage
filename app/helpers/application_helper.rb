module ApplicationHelper

	def sendMessage(msg)
		EM::Hiredis.connect.publish('ws', message)
	end

end
