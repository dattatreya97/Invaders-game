--globals
enemy={}
enemiesController={}
enemiesController.enemies={}
enemiesController.image = love.graphics.newImage('enemy.png')


function love.load( )
	player={}
	player.x=0
	player.bullets={}
	player.width = 5
	player.height = 5
	player.speed = 10
	player.y = 560
	player.cooldown=20
	player.image = love.graphics.newImage('player.png')
	player.sound = love.audio.newSource('sound.wav','static')
	player.fire = function ( ... )
		if player.cooldown<=0 then
			bullet={}	
			
			player.cooldown=20
			bullet.x = player.x+40
			love.audio.play(player.sound)
			bullet.y=550
			table.insert(player.bullets,bullet)
		end
	end
	enemiesController:spawnEnemy(40,20)
	enemiesController:spawnEnemy(80,20)
	enemiesController:spawnEnemy(130,20)
	enemiesController:spawnEnemy(180,20)
	enemiesController:spawnEnemy(250,20)
	enemiesController:spawnEnemy(330,20)
	enemiesController:spawnEnemy(400,20)
	enemiesController:spawnEnemy(450,20)
	enemiesController:spawnEnemy(470,20)
	love.graphics.setDefaultFilter('nearest','nearest')
	math.randomseed(3)
end

function enemiesController:spawnEnemy(x,y)
	enemy={}
	enemy.x=x
	enemy.y=y
	enemy.height = 5
	enemy.width = 5
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

--[[
	collision if
	enemy reaches the base line
		if enemy.y>=player.y 
	it can collide with the player head to head
		if enemy.y+enemy.height

]]--

function check_if_player_dead( enemies,player )
	-- body
	for _,e in pairs(enemies) do
		--[[if e.y+e.height==player.height and e.x>=player.x and e.x+e.width<=player.x+player.width then
			player.x = 800
			return 
		end
		]]--
		
		
		if e.y>=player.y then
			love.graphics.print("GAME OVER")
		end
		
	end
end


function check_if_bullet_hit( enemies,bullets )
	-- body
	for e_index,e in pairs(enemies) do
		for b_index,b in pairs(bullets) do
			if b.x>=e.x and b.x<e.x+e.width and e.y+e.height>=b.y then
				table.remove(enemies,e_index)
				table.remove(bullets,b_index)	
			end
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

	for index,e in pairs(enemiesController.enemies) do
		--adding new enemies
		if e.y>570 then
			enemiesController:spawnEnemy(e.x,10)
			table.remove(enemiesController.enemies,index)
		end

		local increment = math.random(0,6)
		e.y= e.y+increment	

	end

	for index,shot in pairs(player.bullets) do
		if shot.y<30 then
			table.remove(player.bullets,index)
		end	
		shot.y=shot.y-10
	end
	check_if_player_dead(enemiesController.enemies,player)
	check_if_bullet_hit(enemiesController.enemies,player.bullets)
end

function love.draw( )
	--player
	love.graphics.setColor(255,255,255)
	love.graphics.draw(player.image,player.x,560,0,0.55)

	--enemies
	love.graphics.setColor(255,255,255)
	for _,e in pairs(enemiesController.enemies) do
		love.graphics.draw(enemiesController.image,e.x+50,e.y+50,0,0.55)
	end

	--bullets
	love.graphics.setColor(255,255,255)
	for _,shot in pairs(player.bullets) do
		love.graphics.rectangle("fill",shot.x,shot.y,5,5)
	end
end