# Run the snippet from command line under the folder that contains the .sln file.

get-childitem . -recurse | where {$_.extension -eq ".csproj"} | % { dotnet sln add $_.FullName }
