# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["MyMicroservice.csproj", "./"]
RUN dotnet restore "MyMicroservice.csproj"
COPY . .
RUN dotnet build "MyMicroservice.csproj" -c Release -o /app/build

# Etapa de publicación
FROM build AS publish
RUN dotnet publish "MyMicroservice.csproj" -c Release -o /app/publish

# Etapa final: construir la imagen del contenedor
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "MyMicroservice.dll"]
