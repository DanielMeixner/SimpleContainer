FROM microsoft/aspnetcore-build:2.0.3 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0.3
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SimpleDocker.dll"]

# Build runtime image
# FROM microsoft/aspnetcore:2.0.3
# WORKDIR /app
# COPY bin/Debug/netcoreapp2.0/publish  .
# ENTRYPOINT ["dotnet", "SimpleDocker.dll"]