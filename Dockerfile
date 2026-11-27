FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY src/CompileCare.site/CompileCare.site.csproj src/CompileCare.site/
RUN dotnet restore src/CompileCare.site/CompileCare.site.csproj

COPY . .
RUN dotnet publish src/CompileCare.site/CompileCare.site.csproj \
    --configuration Release \
    --no-restore \
    --output /app/publish \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

COPY --from=build /app/publish .
USER $APP_UID

ENTRYPOINT ["dotnet", "CompileCare.site.dll"]
