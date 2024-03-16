# 🌲🌳 dbtree 🚃🌉

> This project is forked from the great [Simon Willison](https://github.com/simonw)'s git scraping project [sf-tree-history](https://github.com/simonw/sf-tree-history). The original project is a demonstration of how to use GitHub Actions to run a Python script that scrapes data from a website and commits the data to the repository, using Simon's `csv-diff` project to generate human readable commits on changes to the data. Git itself then acts as a versioned database for the data.

This project takes the original and builds a complete data stack on top of it. It uses a combination of `dbt`, `DuckDB` and `Evidence` to model and visualize the data.

## Setup

The easiest way to get started is with `task`. `task` is like `make`, but simpler and configured with nice, readable YAML (check out the Taskfile.yml to see what it looks like). You can read the detailed [installation instructions](https://taskfile.dev/#/installation), but for most systems it's as simple as:

```bash
brew install go-task
scoop install task
yay -S go-task-bin
# etc
```

From there, as long as you're in the root of the project you can:

```bash
task setup # or task s -- setup the project, install dependencies in a virtual environment
task build # or task b -- build the dbt project
task test # or task t -- run the dbt tests
task bi # build and serve the Evidence BI site locally
```

You don't need to be in an active virtual environment, these commands will take care of that. If you want to run commands directly once you get a handle on the project, you will need to activate the venv first.

## More soon

I like to write pretty extensive and beginner-friendly docs for my projects. This one will be no exception. More documentation is coming soon.
