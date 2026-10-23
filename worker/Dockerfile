
# Build stage
FROM --platform=${BUILDPLATFORM} mcr.microsoft.com/dotnet/sdk:7.0 AS build

ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

RUN echo "Building on $BUILDPLATFORM for $TARGETPLATFORM"

WORKDIR /source

COPY *.csproj ./
RUN dotnet restore -a $TARGETARCH

COPY . .
RUN dotnet publish -c Release -o /app -a $TARGETARCH --self-contained false --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:7.0

# Create a dedicated non-root user and group
RUN groupadd --gid 10001 appgroup && \
    useradd --uid 10001 --gid appgroup --create-home appuser

WORKDIR /app

COPY --from=build --chown=appuser:appgroup /app .

# Run the Worker without root privileges
USER 10001:10001

ENTRYPOINT ["dotnet", "Worker.dll"]
