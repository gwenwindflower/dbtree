# 🌲🌳 dbtree 🚃🌉

> This project is forked from the great [Simon Willison](https://github.com/simonw)'s git scraping project [sf-tree-history](https://github.com/simonw/sf-tree-history). The original project is a demonstration of how to use GitHub Actions to run a Python script that scrapes data from a website and commits the data to the repository, using Simon's `csv-diff` project to generate human readable commits on changes to the data. Git itself then acts as a versioned database for the data.

This project takes the original and builds a complete data stack on top of it. It uses a combination of `dbt`, `DuckDB` and `Evidence` to model and visualize the data.

## Table of contents

1. [Setup](#setup)
2. [Areas to explore](#areas-to-explore)
3. [Tips](#tips)
  1. [Python dependencies with `uv`](#python-dependencies-with-uv)
  2. [Learning resources](#learning-resources)
  3. [Improving the command line experience](#improving-the-command-line-experience)

## Setup

The easiest way to get started is with `task`. `task` is like `make`, but simpler and configured with nice, readable YAML (check out the Taskfile.yml to see what it looks like). You can read the detailed [installation instructions](https://taskfile.dev/#/installation), but for most systems it's as simple as:

```bash
brew install go-task
scoop install task
yay -S go-task-bin
# etc...
# consider aliasing task to t in your .zshrc or .bashrc
# if you like it
# and that alias is free
```

From there, as long as you're _in the root of the project_ you can:

```bash
# or task s -- setup the project, install dependencies in a virtual environment
# probably only needs to be run once, or when you want to reset the project
task setup
# or task b -- build the dbt project
task build
 # or task t -- run the dbt tests
task test
# build and serve the Evidence BI site locally
task bi
# the primary dev command, refresh the dbt build, then build and serve Evidence
task bbi
# if you aliased task to t, you can run commands really quickly like this
t bbi
# I also recommend Amazon CodeWhisperer which will provide auto-completion
# for the available task commands it finds in the Taskfile.yml
# https://docs.aws.amazon.com/codewhisperer/latest/userguide/command-line.html
```

You **don't** need to be in an active virtual environment, these commands will take care of that (they'll work just fine if you are though too). If you want to run commands directly once you get a handle on the project, you will need to activate the venv first.

```bash
source .venv/bin/activate
# another command i highly recommend aliasing to something like `va`
# deactivate a virtual environment with:
deactivate
# i like aliasing this to `da`

# Important commands if you're running things directly:
# Once in the virtual environment, install the dependencies
python3 -m pip install --upgrage pip && python3 -m pip install -r requirements.txt
# Note you'll need to *reactivate* the virtual environment to pick up the newly installed dependencies
# Build the dbt project
dbt build
# Run the dbt tests
dbt test
# Build and serve Evidence
npm --prefix ./reports run sources && npm --prefix ./reports run dev
```

## Production and CI setup

The production version of this project is hosted on Netlify.

## Updating the data

The data updates via a [`curl`](https://tldr.inbrowser.app/pages/common/curl) command and some subsequent processing in a [`cron`](https://tldr.inbrowser.app/pages/common/cron)-schedule-triggered GitHub Action. Check out `.github/workflows/update.yml` to see what's happening. To get more details I highly recommend checking out Simon's blog post on [git scraping](https://simonwillison.net/2020/Oct/9/git-scraping/).

## Areas to explore

- [x] Model species counts
- [x] Heatmap of historical tree planting
- [ ] Model neighborhoods join (currently we just have the index numbers of neighborhoods, and a list of the names but no way to join them)
- [ ] Map of tree locations, we have the latitude and longitude data and geospatial data of the neighborhoods if we can join them
- [ ] Dynamic information on species via Wikipedia or other sources
- [ ] Do something fun with LLMs
- [ ] Anything else that seems interesting -- very open to ideas!

## Tips

### Python dependencies with `uv`

- This project supports using `uv` instead of `pip` for a much faster and more powerful experience (`task suv` will run the setup with `uv`). You can find the installation instructions in the [ `uv` documentation ](https://github.com/astral-sh/uv).

- Thanks to `uv`'s native support of `pip-tools`' `pip compile` functionality, this project uses a more readable `requirements.in` file to define top-level dependencies, which then compiles that to a highly detailed `requirements.txt` file which maps all sub-dependencies to the top-level packages they are required by. This makes it much easier to deal with versions and upgrading. Also `uv `is wildly fast. Take a peek at these files to get the gist, and check out [`uv`'s documentation](https://github.com/astral-sh/uv) to learn more.

- Always make sure you're installing Python packages in a virtual environment to avoid dependency conflicts (or using `pipx` if it really is supposed to be global). Not to be a broken record, but _yet another_ cool thing `uv` does is always install your packages into a virtual environment by default, even if it's not activated (unlike `pip`), and it will prompt you to create one if one doesn't exist yet. This comes in _super_ handy to save you from accidentally installing a project's dependencies globally.

  - If you need to update any dependencies you can change the version(s) in the `requirements.in` file and run `uv pip compile requirements.in -o requirements.txt` to compile an updated `requirements.txt` file. Then run `uv pip install -r requirements.txt` to install the updated dependencies.

### Learning resources

If you're new to dbt, SQL, or Jinja, I highly recommend the following learning resources:

- [dbt Learn](https://learn.getdbt.com/) - dbt Labs' official learning platform, with a bunch of great free courses to get you started
- [Mode's SQL Tutorial](https://mode.com/sql-tutorial) - IMO the best free resource to learn SQL from the ground up
- [Jinja's official documentation](https://jinja.palletsprojects.com/en/3.0.x/templates/) - specifically the Template Designer Docs in the link. Jinja is a really powerful templating language that dbt and many other projects use (including `copier` i.e. this repo!). Once you get the basics of dbt and SQL down, learning Jinja will take your dbt projects to the next level.
- [dbt Labs' **How we structure our dbt projects** guide](https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview) - the standard resource covering the best way to structure your dbt projects and why.

### Improving the command line experience

There are some really useful command line tools for folks developing dbt projects locally (meaning they're using SQL, Jinja, Python, and the command line a lot). Here are a few I recommend:

- [`zoxide`](https://github.com/ajeetdsouza/zoxide) - a faster, easier-to-use, and more flexible replacement for the `cd` command that learns your habits and saves you a lot of typing with a combination of fuzzy search and frecency (frequency + recency) sorting of your directory changing history
- [`rip`](https://github.com/nivekuil/rip) - a safer and easier-to-use replacement for the `rm` command that moves files to the trash instead of deleting them and lets you recover them if you make a mistake
- [`fzf`](https://github.com/junegunn/fzf) - a fuzzy finder that makes it easy to search through your command history, files, and directories super fast
- [`bat`](https://github.com/sharkdp/bat) - a `cat` replacement that adds syntax highlighting and line numbers, alias it to `cat` and never look back
- [`eza`](https://github.com/eza-community/eza) - a faster and more powerful replacement for the `ls` command
- [`fd`](https://github.com/sharkdp/fd) - a faster and easier-to-use replacement for the `find` command
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) - a much faster and more powerful replacement for the `grep` command
- [`atuin`](https://github.com/atuinsh/atuin) - a more powerful and magical shell history tool, with fuzzy search and a lot of other cool features
- [`starship`](https://starship.rs/) - a really cool and fast shell prompt that's highly customizable (using TOML so it's very easy and readable) and has a lot of cool features, and the default settings are great if you don't want to bother customizing it
- [`kitty`](https://sw.kovidgoyal.net/kitty/) - a fast, feature-rich (great font, image, and mouse support, for example), and highly customizable terminal emulator that's a joy to use

Typing long commands is a bummer, if you plan on doing a lot of Python and dbt development, I highly recommend setting up _*aliases*_ for common commands in your shell configuration (`~/.bashrc`, `~/.zshrc`, etc.). For example, you could add the following to your shell configuration to make running dbt and python commands easier (just make sure they don't conflict with existing aliases or commands, customize to your liking!):

```bash
export EDITOR=<your favorite text editor>
# dbt alias suggestions
alias dbtp="$EDITOR ~/.dbt/profiles.yml"
alias db="dbt build"
alias dbs="dbt build -s"
alias dt="dbt test"
alias dts="dbt test -s"
alias dr="dbt run"
alias drs="dbt run -s"
alias dp="dbt parse"
alias dmv="dbt parse && mf validate-configs"
# Python alias suggestions
alias python="python3"
alias venv="uv venv .venv"
alias va="source .venv/bin/activate"
alias venva="venv && va"
alias pi="uv pip"
alias pir="uv pip install -r"
alias pirr="uv pip install -r requirements.txt"
alias pc="uv pip compile requirements.in -o requirements.txt"
alias piup="uv pip install --upgrade pip"
alias vpi="venva && piup && pirr"
alias vpci="venva && piup && pc && pirr"
# Go to your project, activate the virtual environment, and open it in your text editor
alias <something short and memorable>="cd <path/to/project> && venva && $EDITOR ."
alias t="task"
```

- Notice we can use previously defined aliases in new aliases. For example, `vpci` uses `venva` and `pirr` to update the project's dependencies and install them.

## More soon

I like to write pretty extensive and beginner-friendly docs for my projects. This one will be no exception. More documentation is coming soon.

![Treebeard is bummed](https://github.com/gwenwindflower/dbtree/assets/91998347/2e30ad90-9222-438a-94f7-c645c0af0725)
