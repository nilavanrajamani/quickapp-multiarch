# Build Stage

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env

RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs

WORKDIR /api

COPY . .

RUN dotnet restore

RUN dotnet publish -o /publish

# Run time stage

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

WORKDIR /publish

COPY --from=build-env /publish .

ENTRYPOINT ["dotnet", "QuickApp.dll", "--urls", "http://0.0.0.0:5000"]