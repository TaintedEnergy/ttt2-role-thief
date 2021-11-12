L = LANG.GetLanguageTableReference("en")

L[THIEF.name] = "Thief"
L["thiefs"] = "Thieves"
L["hilite_win_thiefs"] = "THE WIN WAS STOLEN"
L["win_thiefs"] = "The Thief has won!"
L["info_popup_" .. THIEF.name] = [[You are a Thief! You must survive until another team wins the round, and then steal the win for yourself!]]
L["body_found_" .. THIEF.abbr] = "They were a Thief!"
L["search_role_" .. THIEF.abbr] = "This person was a Thief!"
L["target_" .. THIEF.name] = "Thief"
L["ttt2_desc_" .. THIEF.name] = [[Thief is a neutral role that will steal the win from another team that would have otherwise won.]]