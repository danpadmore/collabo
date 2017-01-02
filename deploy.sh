dotnet restore
dotnet build src/collabo.web/

if [ -d artifacts ]; then
  rmdir artifacts/ --ignore-fail-on-non-empty 
fi

dotnet publish src/collabo.web/ --configuration release --output artifacts

# Restore web.config from source, because dotnet publish creates new web.config with
# aspNetCore node defaults that don't work on Azure App Service
cp -f src/collabo.web/web.config artifacts/web.config

lftp -e "mirror -eRv artifacts /site/wwwroot" -u $AZURE_COLLABO_FTP_USER,$AZURE_COLLABO_FTP_PASSWORD $AZURE_COLLABO_FTP
