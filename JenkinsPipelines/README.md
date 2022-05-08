### Jenkins Pipelines

Scripts utilizados para os jobs de deploy de aplicações no Jenkins do Fitbank.

Scripts e parâmetros aplicações Web e Api:

1. ```create-folders.ps1``` \$WORKSPACE
2. ```backup-files.ps1``` \$SERVER, \$USER, \$PASS, \$APP, \$TO, \$FROM
3. ```nuget-restore.ps1``` \$PATH
4. ```build-with-msbuild.ps1``` \$MSBUILD, \$PROJECT, \$WORKSPACE
5. ```compress-files.ps1``` \$PROJECT, \$WORKSPACE
6. ```copy-item.ps1``` \$PROJECT, \$WORKSPACE, \$SERVER
7. ```unzip-files.ps1``` \$USER, \$PASS, \$SERVER, \$PROJECT, \$APP, \$TO
8. ```restart-iis.ps1``` \$USER, \$PASS, \$SERVER, \$APP
8. ```restore-files.ps1``` \$USER, \$PASS, \$SERVER, \$APP, \$FROM, \$TO
