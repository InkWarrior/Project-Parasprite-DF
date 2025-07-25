require "/scripts/vec2.lua"

function init()
  if status.resourceMax("health") < config.getParameter("minMaxHealth", 0) then
    effect.expire()
  end

  self.blinkTimer = 0
end

function update(dt)
  self.blinkTimer = self.blinkTimer - dt
  if self.blinkTimer <= 0 then self.blinkTimer = 0.5 end

  if self.blinkTimer < 0.2 then
    effect.setParentDirectives(config.getParameter("flashDirectives", ""))
  else
    effect.setParentDirectives("")
  end

  if not status.resourcePositive("health") and status.resourceMax("health") >= config.getParameter("minMaxHealth", 0) then
    explode()
  end
end

function uninit()
  
end

function explode()
  if not self.exploded then
    local sourceEntityId = effect.sourceEntity() or entity.id()
    local sourceDamageTeam = world.entityDamageTeam(sourceEntityId)
    local level = world.threatLevel()
    world.spawnMonster("iwpp_verminteye", vec2.add(mcontroller.position(), config.getParameter("SpawnOffset")), { aggressive = true })
    world.spawnMonster("iwpp_verminteye", vec2.add(mcontroller.position(), config.getParameter("SpawnOffset")), { aggressive = true })
    world.spawnMonster("iwpp_prion", vec2.add(mcontroller.position(), config.getParameter("SpawnOffset")), { aggressive = true })
    self.exploded = true
  end
end
