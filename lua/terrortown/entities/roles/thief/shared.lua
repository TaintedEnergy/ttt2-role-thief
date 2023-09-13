if SERVER then
  AddCSLuaFile()
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_thief.vmt")
  util.AddNetworkString("ttt2_thief_message")
end

roles.InitCustomTeam(ROLE.name, {
	icon = "vgui/ttt/dynamic/roles/icon_thief",
	color = Color(55, 35, 0, 255)
})

function ROLE:PreInitialize()
  self.color = Color(55, 35, 0, 255)

  self.abbr = "thief"
  self.surviveBonus = 0
  self.scoreKillsMultiplier = 5
  self.scoreTeamKillsMultiplier = -16

  self.defaultEquipment = SPECIAL_EQUIPMENT
  self.defaultTeam = TEAM_NONE

  self.conVarData = {
    pct = 0.17,
    maximum = 1,
    minPlayers = 6,
    togglable = true
  }
end

if SERVER then
  function ROLE:GiveRoleLoadout(ply, isRoleChange)
    if GetConVar("ttt2_thief_announce"):GetBool() then
      timer.Simple(1, function()
        net.Start("ttt2_thief_message")
        net.Broadcast()
      end)
    end
    ply:GetSubRoleData().isPublicRole = GetConVar("ttt2_thief_is_public"):GetBool()
  end

  hook.Add("TTT2ModifyWinningAlives", "ThiefCheckWinSteal", function(alives)
    local winningTeam = ""

    if alives == nil then return end

    for i in pairs(alives) do
      local t = alives[i]
      if winningTeam != "" and winningTeam != t then return end
      winningTeam = t
    end

    if winningTeam == "" then return end

    for _, ply in ipairs(player.GetAll()) do
      if not IsValid(ply) or not ply:Alive() then continue end
        if SpecDM and (ply.IsGhost and ply:IsGhost()) then continue end

        if ply:GetSubRole() == ROLE_THIEF then
          ply:UpdateTeam(TEAM_THIEF, false)
          if not THIEF.shouldStealWin then
            THIEF.shouldStealWin = true
          end
      end
    end
    if THIEF.shouldStealWin then
      table.insert(alives, "thiefs")
    end
  end)

	hook.Add("TTT2PreWinChecker", "ThiefWin", function()
		if THIEF.shouldStealWin then
			THIEF.shouldStealWin = false
			return TEAM_THIEF
		end
	end)

  hook.Add("TTTEndRound", "ThiefEndRound", function()
    THIEF.shouldStealWin = false
  end)
end

if CLIENT then
  net.Receive("ttt2_thief_message", function()
    EPOP:AddMessage({text = "Watch ya pockets!", color = Color(55, 35, 0, 255)}, {
			  text = "A thief is in the game!", color = Color(255, 255, 255, 255)}, 5)
  end)
end
