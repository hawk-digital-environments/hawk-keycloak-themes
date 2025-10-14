# HAWK Keycloak Themes

This repository contains the themes used by HAWK Keycloak. The themes are designed to provide a consistent look and feel across the Keycloak login pages.

## Usage

To use these themes, simply download the latest version from the GitHub releases page
and extract the contents into the `themes` directory of your Keycloak installation.
Each tarball contains a directory with the name of the theme, which should be placed directly in the `themes` directory.

If you are using a docker container, the themes directory is located at `/opt/keycloak/themes`

After placing the themes in the correct directory, you may need to restart Keycloak for the changes to take effect.
Then, you can select the theme in the Keycloak admin console under the "Realm Settings" -> "Themes" tab.

## Building

Because the themes are fairly similar and share a lot of code, they are built using a common set of templates and styles.
To build the themes, simply run the following command in the root of the repository:

```bash
./build.sh
```

This will populate the theme directories with the necessary files.

### Structure

- **_shared/** contains common templates, styles, and assets used by all themes. This helps avoid duplication and ensures consistency across different theme variants.
- **_shared/package.json** defines dependencies required for building and maintaining the shared theme resources. The key dependency, `@hawk-hhg/svelte-components`, provides reusable Svelte UI components that are integrated into the theme templates for a consistent user experience.
- **handson/** and **hawk/** are individual theme directories. Each contains overrides and customizations specific to that theme, such as unique templates, styles, and images. These directories inherit shared resources from _shared but can provide their own versions of files as needed.
- **build.sh** is a build script that assembles the final theme directories. It combines the shared partials from _shared with theme-specific files, then packages each theme into a .tar.gz archive for easy distribution and deployment to Keycloak.
