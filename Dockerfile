FROM mcr.microsoft.com/dotnet/core/sdk:3.1.100 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY src/In.ProjectEKA.OtpService/In.ProjectEKA.OtpService.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY src/In.ProjectEKA.OtpService ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1.2
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "In.ProjectEKA.OtpService.dll"]
EXPOSE 80