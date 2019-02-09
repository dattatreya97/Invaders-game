function love.load( )
	player={}
	player.x=0
	player.bullets={}
	player.speed = 10
	player.cooldown=20
	player.fire = function ( ... )
		if player.cooldown<=0 then
			bullet={}
			player.cooldown=20
			bullet.x = player.x+40
			bullet.y=550
			table.insert(player.bullets,bullet)
		end
	end
end

function love.update( dt )
	player.cooldown = player.cooldown-1
	if love.keyboard.isDown("right") and player.x<710  then
		player.x=player.x+player.speed
	elseif love.keyboard.isDown("left") and player.x>10 then
		player.x=player.x-player.speed
	end

	if love.keyboard.isDown("space") then
		player.fire()
	end

	for index,shot in pairs(player.bullets) do
		if shot.y<30 then
			table.remove(player.bullets,index)
		end	
		shot.y=shot.y-10
	end

end

function love.draw( )
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill",player.x,570,80,20)
	love.graphics.setColor(255,255,255)
	for _,shot in pairs(player.bullets) do
		love.graphics.rectangle("fill",shot.x,shot.y,5,5)
	end
end