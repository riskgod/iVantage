class ApplicationController < ActionController::Base
  	protect_from_forgery

  	# $serverURL = "67.58.41.121"  # app assumes app is running on port 3000 and websockets on port 5555
  	# $serverURL = "10.1.1.43"  # app assumes app is running on port 3000 and websockets on port 5555
  	$serverURL = "127.0.0.1"  # app assumes app is running on port 3000 and websockets on port 5555
  	# $serverURL = "192.168.6.109"  # app assumes app is running on port 3000 and websockets on port 5555

  	@@three_digit_zips = Map_Region_Three_Digits::THREE_DIGIT_ZIPS.symbolize_keys

  	$current_zip_scores = {}
  	@zips = Variable3Zip.select("zip")
  	@zips.each do |zip|
  		temp = {}
  		temp["cat1_score"] = 0.00
  		temp["cat2_score"] = 0.00
  		temp["cat3_score"] = 0.00
  		temp["cat4_score"] = 0.00
  		temp["agg_score"] = 0.00
  		$current_zip_scores[zip.zip] = temp
  	end

	EM.epoll
	EventMachine.run do
		@channel = EventMachine::Channel.new

		WebSocket::EventMachine::Server.start(:host => '0.0.0.0', :port => 5555) do |ws| # <-- Added |ws|
			# Websocket code here
			ws.onopen {
				sid = @channel.subscribe { |msg|  ws.send msg }
				message = {"origin" => "server", "method" => "statusMessage", "data" => "Congrats, you are rockin with sockets! Your subscriber ID is #{sid}."}
				ws.send(message.to_json)

				ws.onmessage { |message|
					@channel.push(message)
				}

				ws.onclose {
					@channel.unsubscribe(sid)
					message = {"origin" => "server", "method" => "statusMessage", "data" => "#{sid} disconnected!"}
					@channel.push(message.to_json)
				}
			}
		end
	end

end
