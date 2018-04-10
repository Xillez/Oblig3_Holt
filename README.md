## Invoke-ScriptAnalyzer ##

Invoke-ScriptAnalyzer can be install by running "Install-Module -Name PSScriptAnalyzer" from a Admin Powershell terminal and answering "y" for any quaestions that comes up. 

It's a script analyzer from microsoft. It uses a db of all good/bad powershell coding practises and runs them agains the script given after "-Path".

#### Commands I ran: ####

- Invoke-ScriptAnalyzer -Path .\Task2\procmi.ps1
- Invoke-ScriptAnalyzer -Path .\Task3\countthread.ps1
- Invoke-ScriptAnalyzer -Path .\Task1\myprocinfo.ps1



#### Results:  ####

- myprocinfo.ps1:

  | Severity | ScriptName Line | Message                                           |
  | -------- | --------------- | ------------------------------------------------- |
  | Warning  | myprocinfo: 54  | The variable 'USER' is assigned but never used.   |
  | Warning  | myprocinfo: 55  | The variable 'KERNEL' is assigned but never used. |

  - Not etirely sure why there warnings comes, but I would guess that the analyzer thinks the code in the ForEach-Objects body is in a different "context" (or the equivalent) than the rest of the code outside, so it thinks they're new, and tell's me they're not used within that context. 