enemy={}
enemiesController={}
enemiesController.enemies={}
enemiesController.image = love.graphics.newImage('enemy.png')
function love.load( )
	player={}
	player.x=0
	player.bullets={}
	player.speed = 10
	player.cooldown=20
	player.image = love.graphics.newImage('player.png')
	player.fire = function ( ... )
		if player.cooldown<=0 then
			bullet={}
			player.cooldown=20
			bullet.x = player.x+40
			bullet.y=550
			table.insert(player.bullets,bullet)
		end
	end
	enemiesController:spawnEnemy(0,20)
	enemiesController:spawnEnemy(30,20)
end

function enemiesController:spawnEnemy(x,y)
	enemy={}
	enemy.x=x
	enemy.y=y
	enemy.bullets={}
	enemy.speed = 10
	enemy.cooldown=20
	table.insert(self.enemies,enemy)
end

function enemy:fire()
	if self.cooldown<=0 then
		bullet={}
		self.cooldown=20
		bullet.x = self.x+40
		bullet.y=self.y
		table.insert(self.bullets,bullet)
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
	--player
	love.graphics.setColor(255,255,255)
	love.graphics.draw(player.image,player.x,560,0,0.5)

	--enemies
	love.graphics.setColor(255,255,255)
	for _,e in pairs(enemiesController.enemies) do
		love.graphics.draw(enemiesController.image,e.x+50,e.y+50,0,0.5)
	end

	--bullets
	love.graphics.setColor(255,255,255)
	for _,shot in pairs(player.bullets) do
		love.graphics.rectangle("fill",shot.x,shot.y,5,5)
	end
end