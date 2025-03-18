ESX = exports['es_extended']:getSharedObject()

print('BRAD WIPE | Script crée par Brad ✅')

RegisterCommand("wipe", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    if source == 0 or (xPlayer and (xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin")) then
        local targetId = tonumber(args[1])

        if not targetId or not GetPlayerName(targetId) then
            TriggerClientEvent('chat:addMessage', source, { args = { "[^1ERREUR^0]", "ID du joueur invalide ou joueur non connecté." } })
            return
        end

        local targetPlayer = ESX.GetPlayerFromId(targetId)
        if not targetPlayer then
            TriggerClientEvent('chat:addMessage', source, { args = { "[^1ERREUR^0]", "Joueur introuvable." } })
            return
        end

        local targetIdentifier = targetPlayer.identifier

        local queries = {
            "DELETE FROM user_licenses WHERE owner = @identifier",
            "DELETE FROM users WHERE identifier = @identifier",
            "DELETE FROM owned_vehicles WHERE owner = @identifier",
            "DELETE FROM datastore_data WHERE owner = @identifier",
            "DELETE FROM brutal_pets WHERE identifier = @identifier",
            "DELETE FROM brutal_pets_business WHERE owner = @identifier",
            "DELETE FROM player_documents WHERE owner = @identifier",
            "DELETE FROM stevo_drugsell_rep WHERE owner = @identifier",
            "DELETE FROM stevo_drugsell_rep WHERE owner = @identifier",
            "DELETE FROM 58_freeitems WHERE identifier = @identifier",
            "DELETE FROM phone_medata WHERE identifier = @identifier",
        }

        for _, query in ipairs(queries) do
            MySQL.Async.execute(query, {["@identifier"] = targetIdentifier}, function(affectedRows)
                print("[WIPE] Exécuté: " .. query .. " pour " .. targetIdentifier)
            end)
        end

        DropPlayer(targetId, "Vous avez été wipe du serveur.")

        TriggerClientEvent('chat:addMessage', source, { args = { "[^2SUCCESS^0]", "Le joueur ID " .. targetId .. " a été wipe et kick du serveur." } })
    else
        TriggerClientEvent('chat:addMessage', source, { args = { "[^1ERREUR^0]", "Vous n'avez pas la permission d'utiliser cette commande." } })
    end
end, false)
