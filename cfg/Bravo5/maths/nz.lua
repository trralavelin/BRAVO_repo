function nz( MainSheet, JibSheet, E0, E1, E2, E3, E4, R_Stb, R_Port, Out_Stb, Out_Port )

local ReturnValue = MainSheet
ReturnValue = ReturnValue + JibSheet
ReturnValue = ReturnValue + ( E0 * 0.91 )
ReturnValue = ReturnValue + ( E1 * 0.91 )
ReturnValue = ReturnValue + ( E2 * 0.94 )
ReturnValue = ReturnValue + ( E3 * 0.95 )
ReturnValue = ReturnValue + ( E4 * 0.92 )
ReturnValue = ReturnValue + ( R_Stb * 0.95 )
ReturnValue = ReturnValue + ( R_Port * 0.95 )
ReturnValue = ReturnValue + ( Out_Stb * 0.375 )
ReturnValue = ReturnValue + ( Out_Port * 0.375 )

return ReturnValue
end
