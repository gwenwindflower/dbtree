# 🌲🌳 dbtree 🚃🌉

> This project is forked from the great [Simon Willison](https://github.com/simonw)'s git scraping project [sf-tree-history](https://github.com/simonw/sf-tree-history). The original project is a demonstration of how to use GitHub Actions to run a Python script that scrapes data from a website and commits the data to the repository, using Simon's `csv-diff` project to generate human readable commits on changes to the data. Git itself then acts as a versioned database for the data.

This project takes the original and builds a complete data stack on top of it. It uses a combination of `dbt`, `DuckDB` and `Evidence` to model and visualize the data.

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

```

## More soon

I like to write pretty extensive and beginner-friendly docs for my projects. This one will be no exception. More documentation is coming soon.
```
