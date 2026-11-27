# HeapCare Site

> **HeapCare migration status:** The public Site project/solution paths, assembly name, namespaces, UI styles, metadata, logo and container build have been migrated in this branch. The GitHub repository slug and support email remain unchanged until their administrative/external identity transitions are configured.

Public-facing HeapCare product and engineering information website.

This is separate from the authenticated hospital workspace in HeapCare.Web. It describes the hospital platform vision, implemented foundations, planned modules, architecture and repository-derived technology stack. Capabilities are labelled by delivery status; planned features are not represented as released functionality.

## Technology

- .NET 8 / ASP.NET Core
- Blazor Server and Razor components
- MudBlazor 8.14.0
- Bootstrap 5.3.3 (public host stylesheet)
- Custom responsive CSS design system

## Public information architecture

- `/` — platform overview, product principles and architecture summary.
- `/features` — complete hospital module catalogue with implementation/planned status labels.
- `/technology` — technologies, frameworks, libraries, infrastructure, DevOps, observability and test tooling used across the HeapCare repositories.
- `/about` — product vision and engineering principles.
- `/contact` — product and technical inquiry information.

## Run locally

Requires the .NET 8 SDK.

Restore and run `src/HeapCare.Site/HeapCare.Site.csproj` with `dotnet restore` and `dotnet run --project src/HeapCare.Site/HeapCare.Site.csproj`.

The public site is informational; it does not authenticate hospital users or expose patient data. The authenticated workspace is deployed and configured separately.

## Container deployment

A multi-stage Dockerfile publishes the .NET 8 application into the ASP.NET Core runtime image, runs as the non-root `app` user and listens on port 8080. The `/health` endpoint provides a basic process-level HTTP health probe.

Build and run locally:

- `docker build -t heapcare-site .`
- `docker run --rm -p 8080:8080 heapcare-site`
- Open `http://localhost:8080`

The container is provider-neutral. Configure the chosen hosting provider, HTTPS termination, custom domain, WebSocket support for Blazor Server, health check path `/health`, secrets/configuration and deployment policy in that provider. No provider-specific deployment is assumed by this repository.

## Validation

The GitHub Actions workflow restores and builds the .NET 8 website and builds the deployment container on pull requests.
