CreateConVar("ttt2_thief_is_public", 0, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_thief_announce", 1, {FCVAR_NOTIFY, FCVAR_ARCHIVE})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_leech_convars", function(tbl)
  tbl[ROLE_THIEF] = tbl[ROLE_THIEF] or {}

  table.insert(tbl[ROLE_THIEF], {
      cvar = "ttt2_thief_is_public",
      checkbox = true,
      desc = "ttt2_thief_is_public (def. 0)"
  })

  table.insert(tbl[ROLE_THIEF], {
      cvar = "ttt2_thief_announce",
      checkbox = true,
      desc = "ttt2_thief_announce (def. 1)"
  })
end)
