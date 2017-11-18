FROM microsoft/dotnet:2.0.0-sdk AS build
WORKDIR /code
COPY . .
RUN dotnet restore
RUN dotnet publish --output /output --configuration Release



FROM microsoft/dotnet:2.0.0-sdk
COPY --from=build /output /app
WORKDIR /app
EXPOSE 5000/tcp
EXPOSE 80/tcp
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT [ "dotnet", "webtest.dll" ]