# #Build section
# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# WORKDIR /app
# COPY . .

# RUN dotnet restore
# RUN dotnet publish --no-restore -o out -c Release


# #Run section
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
# WORKDIR /app
# COPY --from=build /app/out .
# ENTRYPOINT ["dotnet","WhatsAppBotTest.dll","--environment=Production"]


FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything and publish
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# --- Runtime stage ---
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published output from build container
COPY --from=build /app/publish .

# Set entrypoint to the compiled DLL
ENTRYPOINT ["dotnet", "WhatsAppBotTest.dll"]