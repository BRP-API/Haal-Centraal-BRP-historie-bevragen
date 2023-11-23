#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["src/BrpHistorieProxy/BrpHistorieProxy.csproj", "src/BrpHistorieProxy/"]
RUN dotnet restore "src/BrpHistorieProxy/BrpHistorieProxy.csproj"
COPY . .
WORKDIR "/src/src/BrpHistorieProxy"
RUN dotnet build "BrpHistorieProxy.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BrpHistorieProxy.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BrpHistorieProxy.dll"]