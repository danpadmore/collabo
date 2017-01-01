cd src/collabo.web
dotnet restore
dotnet build
dotnet publish --configuration Release --output "D:\local\temp\publish"
xcopy "D:\local\temp\publish" "D:\home\site\wwwroot" /s /y