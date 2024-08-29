#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["src/BrpHistorieStub/BrpHistorieStub.csproj", "src/BrpHistorieStub/"]
RUN dotnet restore "src/BrpHistorieStub/BrpHistorieStub.csproj"
COPY . .
WORKDIR "/src/src/BrpHistorieStub"
RUN dotnet build "BrpHistorieStub.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BrpHistorieStub.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HaalCentraal.BrpHistorieStub.dll"]