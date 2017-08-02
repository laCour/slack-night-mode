# Contributing
I welcome pull requests from anyone. This guide will prepare you for making your first pull request, and will get you set up for making changes.

Knowledge of [SCSS](http://sass-lang.com/documentation/) is required for changing styles. Reporting any issue is encouraged.

Changes should not be made directly to any file within the `css` directory since these are generated files.

**Sections:**

<!-- TOC depthFrom:2 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Build Requirements](#build-requirements)
	- [Installing SassC](#installing-sassc)
	- [Installing SCSS-Lint](#installing-scss-lint)
- [Building Themes](#building-themes)
- [Making Changes](#making-changes)
	- [Project Structure](#project-structure)
	- [Finding Changes](#finding-changes)
	- [Styling](#styling)
- [Testing Themes](#testing-themes)
- [Making Custom Themes](#making-custom-themes)
	- [Syncing with Upstream](#syncing-with-upstream)

<!-- /TOC -->

## Build Requirements
[SassC](http://sass-lang.com/libsass#sassc) is used for Sass compilation. It's _much_ faster than alternatives (compiling all themes should take <0.5s) since it is written in C.

[SCSS-Lint](https://github.com/brigade/scss-lint/) is used to ensure all SCSS follows the project's style preferences.

### Installing SassC

Depending on your OS (incl. most Linux distributions, Windows), SassC may need to be [built from source](https://github.com/sass/sassc#documentation).

* **Arch:** `sudo pacman -S sassc`
* **Mac OS X:** `brew install sassc`

### Installing SCSS-Lint

SCSS-Lint requires Ruby. If you don't use Ruby, this isn't entirely necessary to install. [Hound](https://houndci.com/repos) already monitors pull requests for style errors, so changes can be made at a later stage.

Install SCSS-Lint by running `gem install scss_lint`.

## Building Themes

Once the required dependencies are installed, run `make` to compile all the themes.

Lint the project by running `scss-lint` in the project root. I recommend using a plugin with your favorite editor (e.g. `linter-scss-lint` for Atom), so that this runs while you make changes.

## Making Changes

### Project Structure

* _scss/_
  * _helpers/_ - SCSS functions, mixins, and variables
  * _layout/_ - Styles that occur throughout the Slack layout (i.e. shared styles)
  * _modules/_ - Styles for specific parts of Slack, organized in parent directories
  * _themes/_ - Theme files that override the default theme's variables
    * _build-variants/_ - Each file here is compiled as a theme, allowing for theme extensions
      * _theme--main.scss_ - Extension wrapped for use on slack.com; compiles to _css/variants/_
      * _theme--styles.scss_ - Extension; compiles to _css/raw/variants/_
  * _main.scss_ - Includes all of the SCSS files, wrapped for use on slack.com; compiles to _css/_
  * _styles.scss_ - Includes all of the SCSS files; compiles to _css/raw/_

### Finding Changes
Changes require a bit of searching using your browser's developer tools. It's recommended that you base styles off of Slack's own styles, using their selectors. Find the original CSS declaration in their CSS files and proceed to the next section.

**Note:** Always check if a selector doesn't already exist in the project by recursively searching the `scss` folder.

### Styling
Use a tool such as [CSS 2 SCSS](http://css2sass.herokuapp.com/) to easily convert the CSS to SCSS syntax. Strip all non-styling properties from the SCSS. Some extra organization may be needed, CSS 2 SCSS often doesn't understand how to properly nest/merge selectors.

Put the styles in the appropriate Slack night mode theme file. If an appropriate theme file does not exist (typically only necessary for new features or restructuring), create a new file and import it in `main.scss`.

Now it's just a matter of swapping out Slack's style definitions with theme variables.

## Testing Themes

You must manually copy and paste themes into the Stylish manager to test changes. To quickly test themes, I recommend running `make`, then using a command-line tool to copy the compiled CSS into your clipboard:

* **X systems:** `make && xclip -sel clip < css/black.css`
* **Mac OS X:** `make && pbcopy < css/black.css`

On Chromium-based browsers, when editing a Stylish theme, you must import a compiled CSS file because of the Mozilla specific domain-restriction syntax. If `xclip` is available, use `./bin/copy_raw.sh css/black.css`.

## Making Custom Themes
If you decide to make your own theme, make a fork and create a new theme file (under `scss/themes/`). Adding a screenshot and customizing the README to be specific to your theme helps others find and use your theme.

### Syncing with Upstream
Slack night mode is frequently updated. Keeping a theme fork up-to-date is fairly trivial. Remove the `css` folder to prevent conflicts, then [sync with upstream](https://help.github.com/articles/syncing-a-fork/). Once you rebuild the theme using `make`, your theme is updated.
