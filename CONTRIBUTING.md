# Contributing
I welcome pull requests from anyone. This guide will prepare you for making your first pull request, and will get you set up for making changes.

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
[SassC](http://sass-lang.com/libsass#sassc) is used for Sass compilation. It's _much_ faster than alternatives (compiling all themes should take <0.5s) since it uses C rather than Ruby.

[SCSS-Lint](https://github.com/brigade/scss-lint/) is used for ensuring all Sass follows the project's style preferences.

### Installing SassC

Depending on your OS (incl. most Linux distributions, Windows), SassC may need to be [built from source](https://github.com/sass/sassc#documentation).

* **Arch:** `sudo pacman -S sassc`
* **Mac OS X:** `brew install sassc`

### Installing SCSS-Lint

SCSS-Lint requires Ruby. If you don't use Ruby, this isn't entirely necessary to install. [Hound](https://houndci.com/repos) already monitors pull requests for style errors, so as long as you try to keep with similar formatting seen throughout the project, you're good to go.

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
  * _pages/_ - Styles that occur on a single page
  * _themes/_ - Theme files that override the default theme's variables
    * _build-variants/_ - Each file here is compiled as a theme, allowing for theme extensions
  * _main.css_ - Includes all of the SCSS files

### Finding Changes
When Slack adds a new feature to their application which requires styles, they temporarily output a CSS file for that feature. These are output under an HTML comment `output_css "regular"`.

Other changes require a bit of searching, it's recommended that you base styles off of Slack's own styles, using their selectors. Find the original CSS declaration in their CSS files. Once located, determine if nearby properties will need to be added or updated as well.

Always check if a selector doesn't already exist in the project by searching the `scss` folder recursively.

### Styling
Once you've found the changes you want to implement, I recommend using [CSS 2 SCSS](http://css2sass.herokuapp.com/). Strip all non-styling properties from your SCSS. Some extra organization may be needed, CSS 2 SCSS often doesn't understand how to properly nest/merge selectors.

After, put the styles in the appropriate theme file. If an appropriate theme file does not exist, create it and import it in `main.scss`.

Now it's just a matter of swapping out Slack's style definitions with the theme's variables.

## Testing Themes

Stylish doesn't have any way to continuously integrate, so you must manually copy and paste themes into the Stylish manager*. To quickly test themes, I recommend running `make`, then using a command-line tool to copy the compiled CSS into your clipboard:

* **X systems:** `make && xclip -sel clip < css/black.css`
* **Mac OS X:** `make && pbcopy < css/black.css`

\* On Chromium-based browsers, when editing a Stylish theme, you must import a compiled CSS file because of the Mozilla specific domain-restriction syntax.

## Making Custom Themes
If you decide to make your own theme, make a fork and create a new theme file (under `scss/themes/`). Adding a screenshot and customizing the README to be specific to your theme helps others find and use your theme.

### Syncing with Upstream
Slack night mode is frequently updated. Thanks to the project layout, keeping a theme fork up-to-date is fairly trivial. Remove the `css` folder to prevent conflicts, then [sync with upstream](https://help.github.com/articles/syncing-a-fork/). Once you build, your theme is updated.
