RegisterCommand('anim', function(source, args)
    if #args < 2 then
        print('Usage: /anim [animDict] [animName]')
        return
    end

    local animDict = args[1]
    local animName = args[2]
    local playerPed = PlayerPedId()

    -- Load the animation dictionary
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end

    -- Play the animation
    TaskPlayAnim(playerPed, animDict, animName, 8.0, 8.0, -1, 49, 0, false, false, false)

    print('Animation started: ' .. animDict .. ' ' .. animName)

    -- Handle stopping the animation with the Backspace key
    Citizen.CreateThread(function()
        while IsEntityPlayingAnim(playerPed, animDict, animName, 3) do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 177) then 
                ClearPedTasks(playerPed)
                print('Animation stopped.')
                break
            end
        end
    end)
end)
