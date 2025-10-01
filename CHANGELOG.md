# Changelog

All notable changes to the Terrateam Helm Chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2024-09-24

### Fixed
- Fixed default `.Values.terrateam.config.uiBase` missing `https://` prefix
- Correctly reference `terrateam.config.webBaseUrl` instead of incorrect variable
- Updated pre-commit hook configuration

### Added
- Added default `terrateam.config.webBaseUrl` value

## [1.2.0] - 2024-09-24

### Added
- Optional cloud-pricing-api service for infrastructure cost estimation
- Support for getting/setting Infracost API key from Kubernetes secrets
- Documentation for regenerating README.md

### Changed
- Restored default values configuration
- Updated docs URL in README
- Fixed mergeOverwrite ordering in templates

## [1.1.0] - 2024-09-03

### Added
- Missing server configuration options:
  - `terrateam.config.apiEndpoint` - Custom API endpoint URL override
  - `terrateam.config.webBaseUrl` - Public-facing web base URL
  - `terrateam.config.uiBase` - Public-facing UI base URL

### Changed
- Bumped Helm chart version
- Updated documentation

## [1.0.0] - 2024-08-26

### Breaking Changes
- **Major refactor of Helm chart structure and configuration**
- Changed from basic deployment to full Kubernetes-native implementation
- Restructured values.yaml with new hierarchy and naming conventions

### Added
- **ServiceAccount, Roles, and RoleBindings** for proper RBAC
- **GitLab support** in addition to GitHub
- **Horizontal Pod Autoscaler (HPA)** for terrateam deployment
- **Tuned liveness and readiness probes** for both terrateam and database
- **Namespace support** with `.Values.namespaceOverride`
- **Revision history limit** configuration (`terrateam.revisionHistoryLimit` and `db.revisionHistoryLimit`)
- Templated labels and selector labels for better resource management
- `terrateam.config.apiEndpoint` configuration option
- Image pull policy configuration

### Changed
- **Ingress disabled by default** (was enabled in 0.x)
- Improved ingress configuration with proper service name references
- Fixed service selector labels to use correct templating
- Database and terrateam services now use proper label selectors
- Updated default FQDN for consistency with documentation
- Consistent property naming across values.yaml
- Environment variable formatting improvements
- Certificate configuration moved to `.Values.ingress`

### Fixed
- Fixed ingress backend name quotation
- Fixed labels.app mismatch issues
- Fixed service port references (terrateam-service now correctly references `Values.terrateam.service.port`)
- Database volume now correctly references full PVC name
- Fixed missing `application.name` references in multiple resources
- Fixed deployment spec.template.metadata.labels

## [0.1.9] - 2024-06-28

### Changed
- Changed database deployment strategy to `Recreate` to prevent PVC multi-attach issues

## [0.1.8] - 2024-06-11

### Changed
- Refactored to use SCRAM authentication by default for PostgreSQL

## [0.1.7] - 2024-05-15

### Added
- Added `web_base_url` value to set `TERRAT_WEB_BASE_URL` environment variable

## [0.1.6] - 2024-04-22

### Changed
- Added more customization options for service resources and ingress configuration
- Bumped chart version

## [0.1.5] - 2024-04-15

### Fixed
- Fixed Helm chart to pull correct Docker image tag

### Changed
- Updated documentation link and removed badge

## [0.1.4] - 2024-04-08

### Added
- Added `TERRAT_WEB_BASE_URL` environment variable using DNS name for terrateam web base URL

## [0.1.3] - 2024-04-05

### Added
- Added the `TERRAT_WEB_BASE_URL` environment variable

## [0.1.2] - 2024-04-03

### Changed
- Updated version bump

## [0.1.1] - 2024-04-02

### Added
- Exposed more environment variables for configuration
- Made the database optional (can use external database)

### Changed
- Renamed database volume for clarity
- Updated README version

## [0.1.0] - 2024-03-28

### Added
- Initial release of Terrateam Helm chart
- Basic Terrateam deployment with PostgreSQL database
- Ingress support for external access
- Configurable resource limits and requests
- Environment variable configuration for GitHub/GitLab integration

[1.3.0]: https://github.com/terrateamio/helm-charts/compare/terrateam-1.2.0...terrateam-1.3.0
[1.2.0]: https://github.com/terrateamio/helm-charts/compare/terrateam-1.1.0...terrateam-1.2.0
[1.1.0]: https://github.com/terrateamio/helm-charts/compare/terrateam-1.0.0...terrateam-1.1.0
[1.0.0]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.9...terrateam-1.0.0
[0.1.9]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.8...terrateam-0.1.9
[0.1.8]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.7...terrateam-0.1.8
[0.1.7]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.6...terrateam-0.1.7
[0.1.6]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.5...terrateam-0.1.6
[0.1.5]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.4...terrateam-0.1.5
[0.1.4]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.3...terrateam-0.1.4
[0.1.3]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.2...terrateam-0.1.3
[0.1.2]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.1...terrateam-0.1.2
[0.1.1]: https://github.com/terrateamio/helm-charts/compare/terrateam-0.1.0...terrateam-0.1.1
[0.1.0]: https://github.com/terrateamio/helm-charts/releases/tag/terrateam-0.1.0
