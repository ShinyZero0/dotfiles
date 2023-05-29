$POWERSHELL_UPDATECHECK = "Off"
$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition $commandAst.ToString() |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock
Set-PsReadLineKeyHandler -Chord 'Control-LeftArrow' -Function 'BackwardWord'
Set-PsReadLineKeyHandler -Chord 'Control-RightArrow' -Function 'ForwardWord'
