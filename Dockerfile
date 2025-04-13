# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

# Copy all source files
COPY . ./

# Build the app
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/out .

# Expose default ASP.NET ports
EXPOSE 80
EXPOSE 443

# Run the app
ENTRYPOINT ["dotnet", "TaskManager.dll"]
