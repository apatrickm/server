-----------------------------------
-- func: !npc
-- desc: Test dynamic entity before its placed into a module for testing.
-- note: Will spawn after you move from your current position
-----------------------------------
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)
    local zone = player:getZone()
    local npc = zone:insertDynamicEntity({
    objtype = xi.objType.NPC,
    name = "Helping Hand",
	look = 3106,
    x = player:getXPos(),
    y = player:getYPos(),
    z = player:getZPos(),
    rotation = player:getRotPos(),

        onTrigger = function(player, npc)
			 local menu =
        {
            title = "Regen and Resfresh",
            onStart = function(playerArg)
                -- NOTE: This could be used to lock the player in place
                playerArg:PrintToPlayer("Would you like to have a boost?", xi.msg.channel.NS_SAY)
            end,
            options =
            {
                {
                    "Yes",
                    function(playerArg)
						playerArg:PrintToPlayer("Enjoy your new buff's!", xi.msg.channel.NS_SAY)
						player:addStatusEffect(xi.effect.REGAIN, 5, 0, 7200)
                        player:addStatusEffect(xi.effect.REGEN, 15, 0, 7200)
                        player:addStatusEffect(xi.effect.REFRESH, 10, 0, 7200)
						
					end,
				},
                {
                    "No",
                    function(playerArg)
                    playerArg:PrintToPlayer("You can always come back if you need a little boost!", xi.msg.channel.NS_SAY)
                    end,
                },
            },
            onCancelled = function(playerArg)
            end,
            onEnd = function(playerArg)
			end,
        }
          player:customMenu(menu)
		end,
    })
    player:PrintToPlayer(string.format("Please move to spawn (%s)", npc:getPacketName()))
end